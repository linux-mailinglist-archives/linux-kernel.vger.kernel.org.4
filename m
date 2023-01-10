Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E86566475C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 18:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjAJRZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 12:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjAJRZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:25:45 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD30A6267
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 09:25:43 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d3so13889386plr.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 09:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2gF6FoqJtPIyR+fBcapwMAGkhtOU0DIoLd2Zjiv/2TA=;
        b=oT1JqvTVUXY0gvO8YSB7oOoHrR/SMn0kTcLvQy/mkaZB9sS3SsqHCBkIbtbdYdEDZl
         3qF9fAJ0Dfa0cGiwOe8EB3CIPNMNH28kj5s4ywZGj8CuB/ixxTJ1ovJhGtn6U7aevJRu
         IZgHZ5dMDLPbjmVH/wg2TlOgOQp8krT/5IY5eQshnPX3Mcoi4n85BdSijDATKfmMS9Ut
         7jPkxsHJKHF1W71h4uT8/HlKgbr+Nz3HtfWHK73NTOYNzcI35DtfnRLDYWMLofB0w/Hk
         is4YvnNVXgjzSDMTxFtKV8d1zqsRvPdfyrNtKmEXAvze1TzHdzQ51pyJpXYcKIpK/rJj
         6x/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2gF6FoqJtPIyR+fBcapwMAGkhtOU0DIoLd2Zjiv/2TA=;
        b=EP+idzQnVCAhQcPZsnF4NTSbr5TTZCoK9hIsB9tBLzfY6L4/qor3HlqYQgi67nYGJM
         5mPKBbL2Zd+Lvncn94AIj2UFgAWewBEsaJ21oGQ+a8y93LBZfPbMi9wKtwe31JZQdzYC
         BhTJE9H0ODZMnk+iJ/go8ICjFeRNNYjr7GvbdIlKPa5raw2WzzMRO9JuHHv+RS5hxQ4e
         cgIFPH3INilFKAdb9y5pzybdKitdF4kmSl+A+pBzGUF48T5IyIB2nCT0LPH3I466sn0T
         3Nw+Z8jKCY8qMBQjgqWLKC1KfDUT30DD2tlQ1Cu57NhhXbKEfCOV3xOMcSZXKKOhE4dt
         iY4g==
X-Gm-Message-State: AFqh2kpcpu2qRsYrCzoYCFXia2LodYrj4sQr7CF0X1eZeAegVDHJnWnv
        2GMH2jdUIjJoVS2MLCl083oINO2P6eM=
X-Google-Smtp-Source: AMrXdXv//80O/zc+FayD7GZ7PJI90ephy+6ZNVXXKwM+FtPbshLs/xOzye/c4RfsDXfhQ1556O3wLQ==
X-Received: by 2002:a05:6a21:7890:b0:af:757c:ce6b with SMTP id bf16-20020a056a21789000b000af757cce6bmr101158224pzc.51.1673371542935;
        Tue, 10 Jan 2023 09:25:42 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902e54700b00191292875desm8354904plf.279.2023.01.10.09.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 09:25:42 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 10 Jan 2023 07:25:40 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "lilingfeng (A)" <lilingfeng3@huawei.com>
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz, bingjingc@synology.com,
        ebiggers@google.com, james.smart@broadcom.com, houtao1@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH-next v2] lib: parser: optimize match_NUMER apis to use
 local array
Message-ID: <Y72flHV4lsxUi5/T@slm.duckdns.org>
References: <20221213141755.768643-1-lilingfeng3@huawei.com>
 <f0af597f-0c56-87e1-995a-e0c55e645f7e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0af597f-0c56-87e1-995a-e0c55e645f7e@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 09:49:21PM +0800, lilingfeng (A) wrote:
> 
> 在 2022/12/13 22:17, Li Lingfeng 写道:
> > Memory will be allocated to store substring_t in match_strdup(), which means
> > the caller of match_strdup() may need to be scheduled out to wait for reclaiming
> > memory.
> > 
> > Using local array to store substring_t to remove the restriction.
> > 
> > Link: https://lore.kernel.org/all/20221104023938.2346986-5-yukuai1@huaweicloud.com/
> > Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> > ---
> >   v1->v2:
> >     change the name of buffer's length
> >     use match_strlcpy() to copy string and keep string length check
> >   lib/parser.c | 42 +++++++++++++++++++++++-------------------
> >   1 file changed, 23 insertions(+), 19 deletions(-)
> > 
> > diff --git a/lib/parser.c b/lib/parser.c
> 
> I can't find the maintainer of this module through the script, does anyone
> know?

Oh, send it to Andrew Morton <akpm@linux-foundation.org>.

Thanks.

-- 
tejun
