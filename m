Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF996AD8FE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjCGIQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjCGIQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:16:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E22509B0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 00:16:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 766E261257
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FD6C433EF;
        Tue,  7 Mar 2023 08:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678176990;
        bh=AauKCHNKMyh3w9C6Q2qax7PgLkqZG7sWryx4/O/9qJg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VU9JQWg8I3cT9mwIatvZ9B/jpUEVL5NmBheOhYc/a4WBNojLr7w4nYML0BMSHhoOC
         oAkXGmXcwkEl3bqJ+w4tOivz7LAPJrq8+d5tkD5RKHnwPuU43cbDvGqkLf6b0Gkcf2
         NHl03OaHGqEZCQsKpH3gHzvkf0GPtSInJtjgtxAc=
Date:   Tue, 7 Mar 2023 09:16:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xia Fukun <xiafukun@huawei.com>
Cc:     prajnoha@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kobject: Fix global-out-of-bounds in
 kobject_action_type()
Message-ID: <ZAby1q1kA71S2WCv@kroah.com>
References: <20230307063757.247430-1-xiafukun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307063757.247430-1-xiafukun@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 02:37:57PM +0800, Xia Fukun wrote:
> The following c language code can trigger KASAN's global variable
> out-of-bounds access error in kobject_action_type():
> 
> int main() {
>     int fd;
>     char *filename = "/sys/block/ram12/uevent";
>     char str[86] = "offline";
>     int len = 0x56;

Nit, set len to 86 so we don't have to do a hex-to-decimal conversion in
our heads (or calculator) to figure out what you are trying to do here :)

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
> Modify the comparison logic to determine whether count_first is equal to
> the length of string kobject_actions[action]. This can fix the problem.
> 
> Fixes: f36776fafbaa ("kobject: support passing in variables for synthetic uevents")
> Signed-off-by: Xia Fukun <xiafukun@huawei.com>
> ---
>  lib/kobject_uevent.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index 7c44b7ae4c5c..668346bd28fa 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
> @@ -84,7 +84,7 @@ static int kobject_action_type(const char *buf, size_t count,
>  	for (action = 0; action < ARRAY_SIZE(kobject_actions); action++) {
>  		if (strncmp(kobject_actions[action], buf, count_first) != 0)
>  			continue;
> -		if (kobject_actions[action][count_first] != '\0')
> +		if (strlen(kobject_actions[action]) != count_first)
>  			continue;
>  		if (args)
>  			*args = args_start;

Yes, this will stop us from reading a read-only location somewhere in
the kernel outside of the string array, but is it still doing the same
functional logic here?

In your change, this call to strlen will cause the length check to fail,
so the loop will continue on, and the type will never be set properly.
Is that correct in your testing?  You just prevented a string of
"offline\0\0\0\0\0\0\0\0\0\0" from properly being parsed as an offline
event, which I don't think is what you meant to do, right?

Or am I reading this code incorrectly?  It really could be cleaned up,
it's not obvious at all.  Parsing strings in C is a mess...

thanks,

greg k-h


> -- 
> 2.17.1
> 
