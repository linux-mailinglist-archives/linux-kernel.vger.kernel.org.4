Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9926AE7C9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjCGRBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjCGRAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:00:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB158A5A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:56:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBBF6614B9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 16:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25F2C433EF;
        Tue,  7 Mar 2023 16:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678208203;
        bh=TuXel2WORz8SHfIp9RqU6IMP+LOT5x9t44WxAy9cXL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J94VNUfS5ox9PpFRPlkmiYlNKl7N/rTovgvo6WCg761NvXMWlZZFaAqDealzQe+eh
         ZD2rUGRNB0ypO9bEqnXMyePxzWwZi1l95UrU8iSFUAMemRICj2E5aMlfetoTJx0/Ui
         fRDczCTuneNqjEIGREgITG3JbGfXyHziQLvBrE8g=
Date:   Tue, 7 Mar 2023 17:56:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xia Fukun <xiafukun@huawei.com>
Cc:     prajnoha@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kobject: Fix global-out-of-bounds in
 kobject_action_type()
Message-ID: <ZAdsyMZWY7OUNSDr@kroah.com>
References: <20230307131955.90524-1-xiafukun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307131955.90524-1-xiafukun@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 09:19:55PM +0800, Xia Fukun wrote:
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
> Modify the judgment logic in line 87. If the length of the string
> kobject_actions[action] is greater than count_first(e.g. buf is "off",
> count is 3), continue the loop.
> Otherwise, the match is considered successful.
> 
> This change means that our test case will be successfully parsed as an
> offline event and no out-of-bounds access error will occur.
> 
> Fixes: f36776fafbaa ("kobject: support passing in variables for synthetic uevents")
> Signed-off-by: Xia Fukun <xiafukun@huawei.com>
> ---
>  lib/kobject_uevent.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index 7c44b7ae4c5c..474f996895c7 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
> @@ -84,7 +84,7 @@ static int kobject_action_type(const char *buf, size_t count,
>  	for (action = 0; action < ARRAY_SIZE(kobject_actions); action++) {
>  		if (strncmp(kobject_actions[action], buf, count_first) != 0)
>  			continue;
> -		if (kobject_actions[action][count_first] != '\0')
> +		if (strlen(kobject_actions[action]) > count_first)
>  			continue;
>  		if (args)
>  			*args = args_start;
> -- 
> 2.17.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
