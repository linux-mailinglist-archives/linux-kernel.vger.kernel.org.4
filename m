Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDB66B1C5A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 08:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjCIHbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 02:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjCIHbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 02:31:33 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32694DD59D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 23:30:49 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so5164797pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 23:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678347048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1bDXhfS+Zf3czIKMHqpIQcR1bLl3EJ1K2VTEtlTGwI=;
        b=bcP5IcOKm+tJOzafpX8ImYC1LGFfWUAqO5mJ/P7OSlWq/O3ZBq9tz/9BD9C53ypQGw
         tzpbALLWOGFM2Nv3H9FCFS4g62Q1meaHncmhBvcBgSrAmH4yhsEVe1zFUzSb5CzJuQhw
         FQliadhvVwXuRFrFT9N553574uW2V00VXLRoN/kHSTgfbWaOWmrV7ge36yzUG18sh0Qg
         zn0XZ+6us3Z9cjFPjKmdx7b3eOAVQllz7nwHfRG3jF0U7YIaT/aMObMLH4aJHG44XjNH
         iB/uy/9wCDeG62XB96qNUL8EMWOVpNbH3CdpbZl2824L7xcEDeSMRzmYQae+bmz4/1Nw
         URqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678347048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1bDXhfS+Zf3czIKMHqpIQcR1bLl3EJ1K2VTEtlTGwI=;
        b=SuYD82uxhD6mhoYXD0NQUlW164y2ri59Lrz8YTs1+2A6kmHkHsqgpBgm4n4GhcSMg/
         iNvQTh762s1Mwzv9rInaGupC0cHvbhsphfC0ZGWLuc/xIKHL6dJAHcoLp4RKV/tzZ+tj
         kkzIkcS/H4OuPoGqPwZgD9P7avXtywRvBIXk8zBjsLyr194QhU1MVmfNIyIkVLrxIYZR
         Xr4+C1CxLkgVRGx6gJNaEpWt457dw+v3PbDQKWWhLvpEW3hhrMtWBsS/o7V5/mQSbdxd
         lCUmZQKUKAEiI3/I44Prgyn2REOKE0VSY1R1TXFN8BOP9jlXLHG4BLkGxMsy2oAei3jX
         JhzA==
X-Gm-Message-State: AO0yUKVUEJEZ/IoQdSXnuFmWAsGVTLtrealqIyG9S59fBDbH7pzclAxZ
        An8CtGMYsIAW3K8zcDJLcUE=
X-Google-Smtp-Source: AK7set/5X9Br2s/E6UyT7fzWcZUDC2+vFH93YUrD2Xn8Oyv0c0u5FU1SsWUTwCXRD4waj21OGszXOQ==
X-Received: by 2002:a17:90b:4d04:b0:237:47b0:3ea8 with SMTP id mw4-20020a17090b4d0400b0023747b03ea8mr23685827pjb.41.1678347048464;
        Wed, 08 Mar 2023 23:30:48 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id n8-20020a17090ac68800b00233ebcb52a6sm928461pjt.36.2023.03.08.23.30.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Mar 2023 23:30:47 -0800 (PST)
Date:   Thu, 9 Mar 2023 15:37:09 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        xiang@kernel.org, zhangwen@coolpad.com
Subject: Re: erofs: use wrapper i_blocksize() in erofs_file_read_iter()
Message-ID: <20230309153709.00003876.zbestahu@gmail.com>
In-Reply-To: <20230309071515.25675-1-frank.li@vivo.com>
References: <20230306075527.1338-1-zbestahu@gmail.com>
        <20230309071515.25675-1-frank.li@vivo.com>
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

On Thu,  9 Mar 2023 15:15:15 +0800
Yangtao Li <frank.li@vivo.com> wrote:

> > @@ -380,7 +380,7 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
> > 		if (bdev)
> > 			blksize_mask = bdev_logical_block_size(bdev) - 1;
> > 		else
> > -			blksize_mask = (1 << inode->i_blkbits) - 1;
> > +			blksize_mask = i_blocksize(inode) - 1;  
> 
> Since the mask is to be obtained here, is it more appropriate to use GENMASK(inode->i_blkbits - 1, 0)?

It should be another change independently to this patch. rt?

> 
> Thx,
> Yangtao

