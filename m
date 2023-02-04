Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0B668AC42
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 21:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjBDU0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 15:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBDU0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 15:26:07 -0500
Received: from mx.treblig.org (mx.treblig.org [46.43.15.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A36E2885F
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 12:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=1oAfu/SOsAux7HPahvBnZKGF5xOl4eordA1YvytBOis=; b=EDjVFs1o/tyF4WjFmK6FY1touD
        SFV1NgXcpkuah8uH3HIkqCSqBBSEZAb+cqYrpcHCiPFxh0/vCsSv5NiT45P44c4h0ZyEJxL0w2hyK
        gnWi9TgVoBHgSPeyO/ux2VzXxiQUSMzezY7igUeqRG8aRlDLIk4LKycQAy9xuCdccOddlimc4Xyxo
        qk8aGr5Y/Q+qCuBL4x5BUam2f3CFreLxyHN57uXZ6d5SlDsA8HapnQANzRtTmKh1wHW81M5TYoFXN
        bUKDEkBwdXBFbe4GjN3nD/q0sx9va/h2qlipR9XqTsD9AuQ0NwBb43uU94VxXGp3W2cJxzrOMsS0/
        K6NexaNQ==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1pOP6X-003ROY-Tx; Sat, 04 Feb 2023 20:25:45 +0000
Date:   Sat, 4 Feb 2023 20:25:45 +0000
From:   "Dr. David Alan Gilbert" <linux@treblig.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Dave Kleikamp <shaggy@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] jfs: Use unsigned variable for length calculations
Message-ID: <Y96/SUlPUl7xH1NO@gallifrey>
References: <20230204183355.never.877-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20230204183355.never.877-kees@kernel.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-12-amd64 (x86_64)
X-Uptime: 20:25:10 up 330 days,  6:50,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Kees Cook (keescook@chromium.org) wrote:
> To avoid confusing the compiler about possible negative sizes, switch
> "ssize" which can never be negative from int to u32.  Seen with GCC 13:
> 
> ../fs/jfs/namei.c: In function 'jfs_symlink': ../include/linux/fortify-string.h:57:33: warning: '__builtin_memcpy' pointer overflow between offset 0 and size [-2147483648, -1]
> [-Warray-bounds=]
>    57 | #define __underlying_memcpy     __builtin_memcpy
>       |                                 ^
> ...
> ../fs/jfs/namei.c:950:17: note: in expansion of macro 'memcpy'
>   950 |                 memcpy(ip->i_link, name, ssize);
>       |                 ^~~~~~
> 
> Cc: Dave Kleikamp <shaggy@kernel.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Dave Chinner <dchinner@redhat.com>
> Cc: jfs-discussion@lists.sourceforge.net
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/jfs/namei.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
> index b29d68b5eec5..494b9f4043cf 100644
> --- a/fs/jfs/namei.c
> +++ b/fs/jfs/namei.c
> @@ -876,7 +876,7 @@ static int jfs_symlink(struct mnt_idmap *idmap, struct inode *dip,
>  	tid_t tid;
>  	ino_t ino = 0;
>  	struct component_name dname;
> -	int ssize;		/* source pathname size */
> +	u32 ssize;		/* source pathname size */

Had you considered using size_t - this is set from a strlen and used by a memcpy
that both talk size_t.

Dave

>  	struct btstack btstack;
>  	struct inode *ip = d_inode(dentry);
>  	s64 xlen = 0;
> @@ -957,7 +957,7 @@ static int jfs_symlink(struct mnt_idmap *idmap, struct inode *dip,
>  		if (ssize > sizeof (JFS_IP(ip)->i_inline))
>  			JFS_IP(ip)->mode2 &= ~INLINEEA;
>  
> -		jfs_info("jfs_symlink: fast symlink added  ssize:%d name:%s ",
> +		jfs_info("jfs_symlink: fast symlink added  ssize:%u name:%s ",
>  			 ssize, name);
>  	}
>  	/*
> @@ -987,7 +987,7 @@ static int jfs_symlink(struct mnt_idmap *idmap, struct inode *dip,
>  		ip->i_size = ssize - 1;
>  		while (ssize) {
>  			/* This is kind of silly since PATH_MAX == 4K */
> -			int copy_size = min(ssize, PSIZE);
> +			u32 copy_size = min_t(u32, ssize, PSIZE);
>  
>  			mp = get_metapage(ip, xaddr, PSIZE, 1);
>  
> -- 
> 2.34.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
