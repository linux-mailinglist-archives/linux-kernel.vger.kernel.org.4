Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90206422CB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 06:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbiLEFhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 00:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbiLEFg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 00:36:58 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BF214002
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 21:36:54 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id a9so9817547pld.7
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 21:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdzchblXoZwUvD3xpYvgxo8UUz9Y8yBlv4ETk+uk1T4=;
        b=dOEx4YK/b7I2bwdB6L+NvLbB0HkWQ9qtGRWQVBIhQgaIE5EqDjGOfkYNGMmMpKlBK+
         cS7ELPOud/i9bIMCBtkoVD4LhjwV/dO562heivoHwNxZEoytFehXoyYI+DYdCl0hhOxj
         O4QZ/Dt8HSBVS+6ZTAoPt9nKVhldCg/+BawBaaaJhhUdvBUWOkZzRAaV5dCxTHhxoALr
         YH2JG6us3IGbdSvjReEhRfNo8lbj1YDoKkjBUA1CNegtxjQwu66PoMu26zqZzRiRnlU7
         AW2LED0qkL23jSWpgq5GamyDdbDgU5PYSxucOvxNPsEwrL8YGDnTrpoODFWuRfsjfNr2
         n44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SdzchblXoZwUvD3xpYvgxo8UUz9Y8yBlv4ETk+uk1T4=;
        b=3jw3vDpwoqS2TeMiMgcXD66g83PXi7AgUi9jOOoiaRM9im5WujK40Vn34RrFa9m8lA
         IndKdTqh2LxrLGZrjc0jO1IU2q2uL1gzn6Qhdf/WiJGXVJugmOCGSBE02nD4Ds/etXaL
         xQtTQat9Y2FVhsn5eCD0wGoU8bNO6b5AZKcHcZNrOiHgTWTmbG1lHGyPrFzJjOtBFZjs
         hhnOlj2QYKcHUhiGpgdmfvGPVkuCkkb/TpuKcMVZbOoovAgcl7Mr6xCPgDPujFx9kvPe
         YqXPTeFDVhJfkQudaw8b7U5exCiufzvtApySC5mJ11MEbGDA9+3GUXeUxuMl0IW/b8f0
         sQVA==
X-Gm-Message-State: ANoB5pkDnd49moUbSsWu154HP8D4urZ4tbXJTOzIWUkSK7oEFjhuIBYu
        5Xd9NQhVW1pU0W5PVZD5BcdTA5X/pAU=
X-Google-Smtp-Source: AA0mqf6EOFcQ308Qx6fwTUhkM4VAQ/6VCJZ/G4WtMTPbsyMPdYmVO2PvOb91RDlSLyAHBIu5N+ZmtQ==
X-Received: by 2002:a17:902:f095:b0:189:b352:a236 with SMTP id p21-20020a170902f09500b00189b352a236mr19268112pla.75.1670218614380;
        Sun, 04 Dec 2022 21:36:54 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id b9-20020a170902d40900b0018703bf42desm9573235ple.159.2022.12.04.21.36.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Dec 2022 21:36:54 -0800 (PST)
Date:   Mon, 5 Dec 2022 13:41:10 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     chenzhongjin@huawei.com, huyue2@coolpad.com
Cc:     linux-erofs@lists.ozlabs.org,
        syzbot+6f8cd9a0155b366d227f@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v3] erofs: Fix pcluster memleak when its block
 address is zero
Message-ID: <20221205134110.000031d1.zbestahu@gmail.com>
In-Reply-To: <20221205034957.90362-1-chenzhongjin@huawei.com>
References: <20221205034957.90362-1-chenzhongjin@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2022 11:49:57 +0800
Chen Zhongjin via Linux-erofs <linux-erofs@lists.ozlabs.org> wrote:

> syzkaller reported a memleak:
> https://syzkaller.appspot.com/bug?id=62f37ff612f0021641eda5b17f056f1668aa9aed
> 
> unreferenced object 0xffff88811009c7f8 (size 136):
>   ...
>   backtrace:
>     [<ffffffff821db19b>] z_erofs_do_read_page+0x99b/0x1740
>     [<ffffffff821dee9e>] z_erofs_readahead+0x24e/0x580
>     [<ffffffff814bc0d6>] read_pages+0x86/0x3d0
>     ...
> 
> syzkaller constructed a case: in z_erofs_register_pcluster(),
> ztailpacking = false and map->m_pa = zero. This makes pcl->obj.index be
> zero although pcl is not a inline pcluster.
> 
> Then following path adds refcount for grp, but the refcount won't be put
> because pcl is inline.
> 
> z_erofs_readahead()
>   z_erofs_do_read_page() # for another page
>     z_erofs_collector_begin()
>       erofs_find_workgroup()
>         erofs_workgroup_get()
> 
> Since it's illegal for the block address of a pcluster to be zero, add
> check here to avoid registering the pcluster which would be leaked.
> 
> Fixes: cecf864d3d76 ("erofs: support inline data decompression")
> Reported-by: syzbot+6f8cd9a0155b366d227f@syzkaller.appspotmail.com
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

Thanks.

> ---
> v1 -> v2:
> As Gao's advice, we should fail to register pcluster if m_pa is zero.
> Maked it this way and changed the commit message.
> 
> v2 -> v3:
> Slightly fix commit message and add -next tag.
> ---
>  fs/erofs/zdata.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index b792d424d774..7826634f4f51 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -488,7 +488,8 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
>  	struct erofs_workgroup *grp;
>  	int err;
>  
> -	if (!(map->m_flags & EROFS_MAP_ENCODED)) {
> +	if (!(map->m_flags & EROFS_MAP_ENCODED) ||
> +		!(map->m_pa >> PAGE_SHIFT)) {
>  		DBG_BUGON(1);
>  		return -EFSCORRUPTED;
>  	}

