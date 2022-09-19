Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688805BC109
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 03:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiISBfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 21:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiISBfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 21:35:15 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5387CE089
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 18:35:12 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id go6so22120720pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 18:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=N8eqqewSNmFIl18uGjm9/zwnlUkZ2Q0UubEd4wLISog=;
        b=VwTS/iD32l18B+pXNDm5P9ZD7eMFp3vlJSuYaDdUPeMCzLhQhs/JW2ONtw3Q1opXD+
         I40OrHfOKTnrKAUE1loXBWZO+JGcdVA7OmXCKEimDHHimhVvAVyB9Yl+kECFQgRxyf7g
         SGINgLLmK8IMTm/lCy30VpdNramxoJtCwpGevCIujBagUt7koRlyMbu4m8jXTcJCC155
         cESv0n5Wdu6HCyvbfLMk6KhdV6Oh2ZGPnY+oSJV7+Sgs3SrbkGyjq8p0m4POIyJm0w4x
         6up2jG4lOk4Ipm0ofExSwhwmPg88SShlFEiY/H6nfMdyjF6u+JJvFQXd70PjDvBz4TRM
         g3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=N8eqqewSNmFIl18uGjm9/zwnlUkZ2Q0UubEd4wLISog=;
        b=avaZGOrkIBJe7MwdwpIMzbEiN0P2Q1BJdinw/I9FQ19TuPs+nGpOCgBcM2BQyqScty
         DIGwUVZfMqRqllJZNyWSVmTa9LZz3qfEd/NUJsVkveqlkLfgkRCL/ziI7Ie3rJtLIFpu
         duGT5UDvlGrMd9tsAkYydS2lJBuJdcAfJrlLFHGpAXJrz6BK9PGUOszhXFy94oV3NkjQ
         YfvX07bH7FknQKSs8zVYmr5ptYV15om9Y6d/OhayM710fVWoehna9SAEuGyICIyz43+o
         eFQFiXGM0S+2VTL/5tT7TNmuNs5TwtjTbzmFlBG/g09uSIX2tTkaOPHfwA3B8M43k9/u
         DI3A==
X-Gm-Message-State: ACrzQf2WvANXEcCAoDgd6+W3okzFB0qUNBQFoXLehlq4PIkRL96BRkQP
        WGgGoQ33zuU3XbZ6yhaUfMA=
X-Google-Smtp-Source: AMsMyM7lvEM+F5KGX5dk+CXMe09P0qpCz6hXV6oKU7UGjQPmGeo6vkBsjnZ8m1oqiBhixFIlsEMQ8g==
X-Received: by 2002:a17:903:2290:b0:178:48b6:f57c with SMTP id b16-20020a170903229000b0017848b6f57cmr10663601plh.78.1663551311817;
        Sun, 18 Sep 2022 18:35:11 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id a5-20020aa794a5000000b00543a098a6ffsm15837530pfl.212.2022.09.18.18.35.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Sep 2022 18:35:11 -0700 (PDT)
Date:   Mon, 19 Sep 2022 09:37:47 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org,
        syzbot+f966c13b1b4fc0403b19@syzkaller.appspotmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] erofs: fix order >= MAX_ORDER warning due to crafted
 nagative i_size
Message-ID: <20220919093747.00005bd6.zbestahu@gmail.com>
In-Reply-To: <20220909023948.28925-1-hsiangkao@linux.alibaba.com>
References: <000000000000ac8efa05e7feaa1f@google.com>
        <20220909023948.28925-1-hsiangkao@linux.alibaba.com>
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

On Fri,  9 Sep 2022 10:39:48 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> As syzbot reported [1], the root cause is that i_size field is a
> signed type, and negative i_size is also less than EROFS_BLKSIZ.
> As a consequence, it's handled as fast symlink unexpectedly.
> 
> Let's fall back to the generic path to deal with such unusual i_size.
> 
> [1] https://lore.kernel.org/r/000000000000ac8efa05e7feaa1f@google.com
> Reported-by: syzbot+f966c13b1b4fc0403b19@syzkaller.appspotmail.com
> Fixes: 431339ba9042 ("staging: erofs: add inode operations")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 95a403720e8c..16cf9a283557 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -214,7 +214,7 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
>  
>  	/* if it cannot be handled with fast symlink scheme */
>  	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
> -	    inode->i_size >= EROFS_BLKSIZ) {
> +	    inode->i_size >= EROFS_BLKSIZ || inode->i_size < 0) {

Reviewed-by: Yue Hu <huyue2@coolpad.com>

>  		inode->i_op = &erofs_symlink_iops;
>  		return 0;
>  	}

