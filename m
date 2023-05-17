Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D057067D3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjEQMRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjEQMRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:17:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A8FD9
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 05:17:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71B7164645
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:17:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860CFC433EF;
        Wed, 17 May 2023 12:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684325836;
        bh=N2KFito5uHEYmSC5IAgx0LC8eoo0urFaqerboWW1hbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WULkEKcvKfvIyY7nsTA0fGcxrUIXrjHiCWNNAECNm44pug8sYF0C7xzv8uPp17yq8
         w4RX1n6g2Uk67Gzkg/AXKBVQre3RDmXU2P4uxroMRMeZr5Glp88dGVKA5BZELiOBTr
         ydrK1JD5P58jMQJ/OWki6yw3F29rWt0AhvBkEqu0=
Date:   Wed, 17 May 2023 14:17:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xia Fukun <xiafukun@huawei.com>
Cc:     prajnoha@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] kobject: Fix global-out-of-bounds in
 kobject_action_type()
Message-ID: <2023051739-shrunk-reopen-b968@gregkh>
References: <20230517101957.14655-1-xiafukun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517101957.14655-1-xiafukun@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 06:19:57PM +0800, Xia Fukun wrote:
> The following c language code can trigger KASAN's global variable
> out-of-bounds access error in kobject_action_type():
> 
> int main() {
>     int fd;
>     char *filename = "/sys/block/ram12/uevent";
>     char str[86] = "offline";
>     int len = 86;
> 
>     fd = open(filename, O_WRONLY);
>     if (fd == -1) {
>         printf("open");
>         exit(1);
>     }
> 
>     if (write(fd, str, len) == -1) {
>         printf("write");
>         exit(1);
>     }
> 
>     close(fd);
>     return 0;
> }
> 
> Function kobject_action_type() receives the input parameters buf and count,
> where count is the length of the string buf.
> 
> In the use case we provided, count is 86, the count_first is 85.
> Buf points to a string with a length of 86, and its first seven
> characters are "offline".
> In line 87 of the code, kobject_actions[action] is the string "offline"
> with the length of 7,an out-of-boundary access will appear:
> 
> kobject_actions[action][85].
> 
> Use sysfs_match_string() to replace the fragile and convoluted loop.
> This function is well-tested for parsing sysfs inputs. Moreover, this
> modification will not cause any functional changes.
> 
> Fixes: f36776fafbaa ("kobject: support passing in variables for synthetic uevents")
> Signed-off-by: Xia Fukun <xiafukun@huawei.com>
> ---
> v5 -> v6:
> - Ensure that the following extensions remain effective:
> https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-uevent
> 
> v4 -> v5:
> - Fixed build errors and warnings, and retested the patch.
> 
> v3 -> v4:
> - Refactor the function to be more obviously correct and readable.
> ---
>  include/linux/kobject.h |  3 +++
>  lib/kobject_uevent.c    | 30 +++++++++++++++++-------------
>  2 files changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/kobject.h b/include/linux/kobject.h
> index c392c811d9ad..9d3ecce3c4f6 100644
> --- a/include/linux/kobject.h
> +++ b/include/linux/kobject.h
> @@ -32,6 +32,9 @@
>  #define UEVENT_NUM_ENVP			64	/* number of env pointers */
>  #define UEVENT_BUFFER_SIZE		2048	/* buffer for the variables */
>  
> +/* the maximum length of the string contained in kobject_actions[] */
> +#define UEVENT_KACT_STRSIZE		16

Why does this value need to be in a global .h file when it is only used
in one .c file?

And how are you going to keep it in sync with kobject_actions if it
changes in the future?  And that variable isn't even in this file, how
would anyone know to modify this if the structure changes in a .c file?

> +
>  #ifdef CONFIG_UEVENT_HELPER
>  /* path to the userspace helper executed on an event */
>  extern char uevent_helper[];
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index 7c44b7ae4c5c..4030a928e9c6 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
> @@ -66,7 +66,8 @@ static int kobject_action_type(const char *buf, size_t count,
>  	enum kobject_action action;
>  	size_t count_first;
>  	const char *args_start;
> -	int ret = -EINVAL;
> +	int i, ret = -EINVAL;
> +	char kobj_act_buf[UEVENT_KACT_STRSIZE] = "";

Why does this need to be initialized?

And are you sure the size is correct?  If so, how?

And how was any of this tested?  Based on your prior submissions, we are
going to require some sort of proof.  What would you do if you were in
my position?

thanks,

greg k-h
