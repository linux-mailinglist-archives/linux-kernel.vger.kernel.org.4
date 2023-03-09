Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B686B2451
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 13:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjCIMkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 07:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCIMkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 07:40:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2678EE34BA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 04:40:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7ED8361B41
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 12:40:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889B3C433D2;
        Thu,  9 Mar 2023 12:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678365639;
        bh=DXi9db8w0BaYZ7TH80dNzSmByHdK/0hqiRZXr4I6vWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BDwK6xmkGQzS5HVZrZuPawtD9+Sw2kCndnX/qKCJ9Anq/Ku1WARy5MRZDsEYILelm
         7bnTs6lRfdTJvt67ny5+QokKBsHjbbZFsBgpK9XxWLsr+sGinntf9Vric3l+229mbg
         thLdlneONF7xUm8nDHEQGVEvTFnJ6V3XglmUOCCA=
Date:   Thu, 9 Mar 2023 13:40:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xia Fukun <xiafukun@huawei.com>
Cc:     prajnoha@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kobject: Fix global-out-of-bounds in
 kobject_action_type()
Message-ID: <ZAnTxeyk3PhPFAww@kroah.com>
References: <20230309114919.63973-1-xiafukun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309114919.63973-1-xiafukun@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 07:49:19PM +0800, Xia Fukun wrote:
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

Yes, but what other test cases did you run on this to verify it works?
Given that your previous version broke previously working inputs I need
a lot of validation and proof that this change will also not break
anything.


> 
> Fixes: f36776fafbaa ("kobject: support passing in variables for synthetic uevents")
> Signed-off-by: Xia Fukun <xiafukun@huawei.com>
> ---
> v2 -> v3:
> - only declare that it is the latest version of the patch, no change
> 
> v1 -> v2:
> - modify the matching logic
> 
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

I'm sorry, but as I said before, I'm still not convinced that this is
correct.  Why does this solve the problem?  Shouldn't the length check
come before we try to compare the string so that strncmp() doesn't have
to give a false-positive if the string is too small?

And really, this whole function is very hard to follow, is there any
chance you can refactor it to be more obviously correct and readable?
What about taking advantage of the well-tested string functions we
already have for parsing sysfs inputs, like sysfs_match_string()?

thanks,

greg k-h
