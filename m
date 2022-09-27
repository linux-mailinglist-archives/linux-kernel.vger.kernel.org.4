Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF735EBDE6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiI0I7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiI0I7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:59:01 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE66A7CAA9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 01:59:00 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id iw17so8542166plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 01:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=moz07TbQsZiM7w/D7SkEWNGBlBmpAeho7lKvgwF+ioc=;
        b=GgBmwcCkCghH3MmiFp36Bde43puo4yGC6iHlrQyyrizw7oRjuKA66En2G4yrAdj/Hm
         x75igb7Y2V5fQgBHvtXdEP9vrqSM8nAkGLcs1+tViPK1OPp8EpSSr/aBMRSGiZC48Vxu
         P6Xv/hQ2ifGTD9Qtfm0/5pve8/z1pwNzUDMVeaMmfjbL6RGR4T8x6107BNAEFCsrra05
         z2gqE8SKGmB2FtxIric0wWe8/zOyAaiOsoRlb6sj3CEegylEaws1mdTIM+A0u4+AVo9y
         nDDcDbj0XoSypdTwHmHwyz9nL1YrvS1pdXaiydwayVeGYESLhkGaazDr4oIM/IwK2JLi
         GCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=moz07TbQsZiM7w/D7SkEWNGBlBmpAeho7lKvgwF+ioc=;
        b=ndEfVdrr6DxBS+UtgDTchmv77Ahd/lIYeXR92JjbwwlAmBm8VaLmig0gJ+PEc402t0
         6pN+a+6JTu3WONU/F7xvkVuOxyX43yUDw95QMBkwb1HYjPFWGngurPc87lt2tXelrJIf
         36McfW6NsspYMBdCXsq20eE141oXMx1prpGg3g63BsWMb8YAQsX0WvLmujoan1w1H9cZ
         nBiCTNiZ7m509r/w3LzeggyK4tXld6RsRIgJqegtw+RVysOUiKosnqEAWUR3YDwowBjT
         YvEyLW/tp/ObwJEfSaee6jgU9WDtFctWnUHNRYIEH97KEjKfV9C5mScLcxjjiXmKzqjs
         QrCg==
X-Gm-Message-State: ACrzQf2MSvzTsbgbdGwN0OSZp10valwEXfKy5o/Iv6wKsOPgElzx6TGZ
        J4QFQxyKrW+YNTduWXF0KeKkBprVYqk=
X-Google-Smtp-Source: AMsMyM7iCEjOg8Cze41po0WsIFUj30hSloeEo+ux85VFzGjsUyG+MekPzJ/Xwfw68xK91RCWJd3ZxA==
X-Received: by 2002:a17:902:f152:b0:179:f329:8d6d with SMTP id d18-20020a170902f15200b00179f3298d6dmr781012plb.122.1664269140134;
        Tue, 27 Sep 2022 01:59:00 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id q10-20020aa7982a000000b0053e56165f42sm1140996pfl.146.2022.09.27.01.58.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Sep 2022 01:58:59 -0700 (PDT)
Date:   Tue, 27 Sep 2022 17:01:47 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] erofs: clean up erofs_iget()
Message-ID: <20220927170147.000021fe.zbestahu@gmail.com>
In-Reply-To: <20220927063607.54832-2-hsiangkao@linux.alibaba.com>
References: <20220927063607.54832-1-hsiangkao@linux.alibaba.com>
        <20220927063607.54832-2-hsiangkao@linux.alibaba.com>
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

On Tue, 27 Sep 2022 14:36:07 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> isdir indicated REQ_META|REQ_PRIO which no longer works now.
> Get rid of isdir entirely.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
>  fs/erofs/inode.c             | 24 ++++++++----------------
>  fs/erofs/internal.h          |  2 +-
>  fs/erofs/namei.c             |  2 +-
>  fs/erofs/super.c             |  8 ++++----
>  include/trace/events/erofs.h | 11 ++++-------
>  5 files changed, 18 insertions(+), 29 deletions(-)
> 
