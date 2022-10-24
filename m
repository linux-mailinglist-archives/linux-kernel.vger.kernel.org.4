Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABD360B629
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbiJXSt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbiJXSs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:48:57 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C31719C26
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:29:41 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id io19so4076844plb.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i2byGtEXgZJqwC1xhUiJg77blmnFurI60zGNAGyGmaU=;
        b=TmzigJCgTBapdK0xkoXEz8vHuz4MX1KCMk1WsbpTta1fdAJMYtolT8c+MbBUUY66gh
         HhR4QOE6ff5VSgCKNs68HnkcILYqkh0alXR+pdd6xa59lIxg92vARF6jPTAKv45aSoX7
         UYpW407tNV89sAg+DBOdyGkt/wLS8h68jzqIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2byGtEXgZJqwC1xhUiJg77blmnFurI60zGNAGyGmaU=;
        b=hI8qA72Kbpd+jYAXpcLyBVQv0UbDmpytp2SwcTXJwLTuwtsxQQYBoDyk/bqFmY0k2g
         68FBoRwbbxb16sYwdPv3XORyB85j4qkUpwExYgUKySz7hIv8Oo/Jis34kViRnONSv+Ro
         2wp8jcrhMDiK5vYSuc/I9jKNmNDRmjhU8MdqEodfR/qHDmEF/ES6ey1agibVCmJR+e1l
         LnjW5ssYr9TxXp16W7oysn+xOlfmI+y4eteT51yHB5t+QlofPT4KXQmh+t9PMGWbPcDx
         /11bBzaTSXeeKbfRrFxHskjPRDCFbsc3VbLcW0C0f9NDouop2Mm5RTbbaH+XFv7fQvQE
         XX2A==
X-Gm-Message-State: ACrzQf1Ru0EZvOvk4v4PQgFGtkray4tPUODlxiQ1IG79Q4NrasX/+kCQ
        gPvw4ZckKw2jSZGfU2dcC3ruUsf2uljc9Q==
X-Google-Smtp-Source: AMsMyM5jpYkGLl4OBfSCMdyvabVZ9M6UzPL366jLswkI52JXS24uvkzZDH1iQ/9WXBipLDQHLijhfg==
X-Received: by 2002:a17:90b:1e49:b0:20b:36a3:aba6 with SMTP id pi9-20020a17090b1e4900b0020b36a3aba6mr77169003pjb.2.1666632509281;
        Mon, 24 Oct 2022 10:28:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902654800b001788ccecbf5sm30958pln.31.2022.10.24.10.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 10:28:28 -0700 (PDT)
Date:   Mon, 24 Oct 2022 10:28:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     linux@treblig.org
Cc:     shaggy@kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        syzbot+5fc38b2ddbbca7f5c680@syzkaller.appspotmail.com
Subject: Re: [PATCH] jfs: Fix fortify moan in symlink
Message-ID: <202210241021.6E9E1EF65@keescook>
References: <20221022203913.264855-1-linux@treblig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221022203913.264855-1-linux@treblig.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 09:39:14PM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> JFS has in jfs_incore.h:
> 
>       /* _inline may overflow into _inline_ea when needed */
>       /* _inline_ea may overlay the last part of
>        * file._xtroot if maxentry = XTROOTINITSLOT
>        */
>       union {
>         struct {
>           /* 128: inline symlink */
>           unchar _inline[128];
>           /* 128: inline extended attr */
>           unchar _inline_ea[128];
>         };
>         unchar _inline_all[256];
> 
> and currently the symlink code copies into _inline;
> if this is larger than 128 bytes it triggers a fortify warning of the
> form:
> 
>   memcpy: detected field-spanning write (size 132) of single field
>      "ip->i_link" at fs/jfs/namei.c:950 (size 18446744073709551615)

Which compiler are you using for this build? This size report (SIZE_MAX)
should be impossible to reach. But also, the size is just wrong --
i_inline is 128 bytes, not SIZE_MAX. So, the detection is working
(132 > 128), but the report is broken, and I can't see how...

> 
> when it's actually OK.
> 
> Copy it into _inline_all instead.
> 
> Reported-by: syzbot+5fc38b2ddbbca7f5c680@syzkaller.appspotmail.com
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  fs/jfs/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
> index 9db4f5789c0ec..4fbbf88435e69 100644
> --- a/fs/jfs/namei.c
> +++ b/fs/jfs/namei.c
> @@ -946,7 +946,7 @@ static int jfs_symlink(struct user_namespace *mnt_userns, struct inode *dip,
>  	if (ssize <= IDATASIZE) {
>  		ip->i_op = &jfs_fast_symlink_inode_operations;
>  
> -		ip->i_link = JFS_IP(ip)->i_inline;
> +		ip->i_link = JFS_IP(ip)->i_inline_all;
>  		memcpy(ip->i_link, name, ssize);
>  		ip->i_size = ssize - 1;
>  

Regardless, the fix looks correct to me!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
