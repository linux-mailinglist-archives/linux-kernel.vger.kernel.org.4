Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56501643D13
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 07:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbiLFGSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 01:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbiLFGSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 01:18:35 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D832715C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 22:18:34 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so13846165pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 22:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2DddouEQKfe5T1HPT/o0Lvg9osxHkFVaTa2j8bSG2k=;
        b=C9WGBIcADVx5WxbQuiycCiuFkyWSPSIJiFzY157WCnH+dsSXS5Y///0Xd8j3BvHF6z
         T4zcCEx+nLcHdxv8DH4oVu0NZlyNlGnSMbYj/IJccrz/lk/TiZUBVwoh3q+xllkaAlz6
         2zfoKYdgoU7MITUXmSc4UC2F4DTwhuM6U7UOiIZREHtwlo9MF5NVgZ2tBoCIyhW6NAnv
         L1NYGgleRCDUjVf1Up21uxmodRV5MkRkMtMX6JbuAVzhngTXk78mz2u1FmFYUXPnmRja
         7F+uHdS3mL7Wa54KykG7QWCUddnkwoL1BMQx2ZjUlLX6J5hF9p9b0c/ZuxWlaMLQ7qXy
         akvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2DddouEQKfe5T1HPT/o0Lvg9osxHkFVaTa2j8bSG2k=;
        b=lAio2KPS6E9ETAo+n2IqdZ+MHpkbxJnpG2g8vp/PGA6lXdlLa1puZF6VCFN1JpgtK2
         TlpD0T7LiW/ntRTaIxqz9xnjLhyx8g93p78zE2PJt4bBvYVoCqdWrU/zyu2CxaI03tAl
         6VZhEHN4a8ew2XK/RwgKHJC18izXEvKZqoEsyY9USWY1r9PKJz9S7fNDgw3yWWwr6hM+
         dKFhy8UX+gE2B9jWZC4Ip856eyy9OPMReGDy/hoyRGGB/7M6WFVvRrAjk32narr3FRaA
         MwP986wHTxcPIM3y2P36xqH3gHbzcMvICCKRKp28XaHbn3uSngbgVKG9utVGjVN9Wt4b
         FZPA==
X-Gm-Message-State: ANoB5pkXArU23d4LXWkVABSYf2aPajncWdKQR4OYjypnKRKYkyarGO8D
        CXyqJIwiVD5EhbPXdre7ets=
X-Google-Smtp-Source: AA0mqf5wxtCVesu9mY9IFcfl8szGXpgSADbr5LDn5xdnCZXE2JllW6Hek5ZLQ6Xi5jvDGUgduV8lpg==
X-Received: by 2002:a17:90a:9402:b0:219:6c4d:ba9d with SMTP id r2-20020a17090a940200b002196c4dba9dmr28116826pjo.175.1670307514015;
        Mon, 05 Dec 2022 22:18:34 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090a280d00b00218a7808ec9sm3489737pjd.8.2022.12.05.22.18.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Dec 2022 22:18:33 -0800 (PST)
Date:   Tue, 6 Dec 2022 14:22:51 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com
Subject: Re: [PATCH 1/2] erofs: fix missing unmap if
 z_erofs_get_extent_compressedlen() fails
Message-ID: <20221206142251.00001fb4.zbestahu@gmail.com>
In-Reply-To: <20221205150050.47784-1-hsiangkao@linux.alibaba.com>
References: <20221205150050.47784-1-hsiangkao@linux.alibaba.com>
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

On Mon,  5 Dec 2022 23:00:49 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Otherwise, meta buffers could be leaked.
> 
> Fixes: cec6e93beadf ("erofs: support parsing big pcluster compress indexes")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
>  fs/erofs/zmap.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index 749a5ac943f4..98eff1259de4 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -694,7 +694,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
>  		map->m_pa = blknr_to_addr(m.pblk);
>  		err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
>  		if (err)
> -			goto out;
> +			goto unmap_out;
>  	}
>  
>  	if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN) {
> @@ -718,14 +718,12 @@ static int z_erofs_do_map_blocks(struct inode *inode,
>  		if (!err)
>  			map->m_flags |= EROFS_MAP_FULL_MAPPED;
>  	}
> +
>  unmap_out:
>  	erofs_unmap_metabuf(&m.map->buf);
> -
> -out:
>  	erofs_dbg("%s, m_la %llu m_pa %llu m_llen %llu m_plen %llu m_flags 0%o",
>  		  __func__, map->m_la, map->m_pa,
>  		  map->m_llen, map->m_plen, map->m_flags);
> -
>  	return err;
>  }
>  

