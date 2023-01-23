Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF596774B5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 05:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjAWEsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 23:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjAWEr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 23:47:58 -0500
X-Greylist: delayed 165 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 22 Jan 2023 20:47:54 PST
Received: from p3plwbeout22-04.prod.phx3.secureserver.net (p3plsmtp22-04-2.prod.phx3.secureserver.net [68.178.252.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A74A113F9
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 20:47:54 -0800 (PST)
Received: from mailex.mailcore.me ([94.136.40.143])
        by :WBEOUT: with ESMTP
        id JohfpsT2sGmD8JohgpceGa; Sun, 22 Jan 2023 21:45:08 -0700
X-CMAE-Analysis: v=2.4 cv=SdUyytdu c=1 sm=1 tr=0 ts=63ce10d4
 a=EhJYbXVJKsomWlz4CTV+qA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=RvmDmJFTN0MA:10 a=1RTuLK3dAAAA:8
 a=07d9gI8wAAAA:8 a=OVIqzpK4FF8QeQ2kMcwA:9 a=QEXdDO2ut3YA:10
 a=kRpfLKi8w9umh8uBmg1i:22 a=e2CUPOnPG4QKp8I52DXD:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  JohfpsT2sGmD8
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp03.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1pJohb-0001kd-HF; Mon, 23 Jan 2023 04:45:04 +0000
Message-ID: <47e9f2c3-aeea-4d3a-f27f-8ace15cb9a21@squashfs.org.uk>
Date:   Mon, 23 Jan 2023 04:45:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH linux-next] Squashfs: use strscpy() to instead of
 strncpy()
To:     yang.yang29@zte.com.cn
Cc:     linux-kernel@vger.kernel.org, xu.panda@zte.com.cn
References: <202301091937558399800@zte.com.cn>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <202301091937558399800@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfNOMadNzTuGi4rn76f82q47chcIviOpnmzRcD6/78WhT4rJ1oq83PtFYTPACHapK4R242DHCY5AaGmJC9vAK3LDuXdwg7se8NFhxDH2a3N7neA2EEbuV
 aPYViL09knAA4yJ8hr+cAaqdhZbzxh+sjgxOW5C+DnF4JT+I2nWURvNBZ/zmP84ZGVj0vpS2A9Lr/RDykiZ2+JYjTRSmC6FedII=
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2023 11:37, yang.yang29@zte.com.cn wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
> 
> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL-terminated strings.
> 

NACK.

I have spent quite some time reviewing this patch, and the reasons
are below.

The source name (from the dentry) is passed as pointer and length,
and the code should not assume it is NUL terminated.

Strscpy() will always access len + 1 bytes from the source string,
to check for the NUL terminator and return either the number of
characters copied or -E2BIG if no NUL terminator was found at
name[len].

This means Strscpy() will perform an out of bounds access on the
source string if it is not NUL terminated.  This is incorrect in
itself, and there are no guarantees it won't fail, for example
it might cross a page boundary and the next page may not be
mapped.

The current code is actually a lot safer because it does not assume
the string is NUL terminated.

See the LWN article "strscpy() and the hazards of improved interfaces"
for a discussion of the dangers of conversion patches.

https://lwn.net/Articles/659214/

In particular a quote from Linus Torvalds.

"So why did I waffle about this for so long?

Every time we introduce a new-and-improved interface, people start doing 
these interminable series of trivial conversion patches.

And every time that happens, somebody does some silly mistake, and the 
conversion patch to the improved interface actually makes things worse. 
Because the patch is mindnumbing and trivial, nobody has the attention 
span to look at it carefully, and it's usually done over large swatches 
of source code which means that not every conversion gets tested."

and to quote from the article itself

"It is there to be used with new code, but existing code should not be 
converted without some compelling reason to do so — or without a high 
level of attention to the possible implications of the change."

Which is why I'm wary of these apparently trivial changes, and I have 
spent quite some time reviewing this patch.

Phillip

> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> ---
>   fs/squashfs/namei.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/squashfs/namei.c b/fs/squashfs/namei.c
> index 11e4539b9eae..6c4704ba8f42 100644
> --- a/fs/squashfs/namei.c
> +++ b/fs/squashfs/namei.c
> @@ -80,8 +80,7 @@ static int get_dir_index_using_name(struct super_block *sb,
>   	}
> 
>   	str = &index->name[SQUASHFS_NAME_LEN + 1];
> -	strncpy(str, name, len);
> -	str[len] = '\0';
> +	strscpy(str, name, len + 1);
> 
>   	for (i = 0; i < i_count; i++) {
>   		err = squashfs_read_metadata(sb, index, &index_start,

