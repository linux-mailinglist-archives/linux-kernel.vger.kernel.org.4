Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54435E7296
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 05:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbiIWDz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 23:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiIWDzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 23:55:25 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304F482D24
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 20:55:24 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id x1so10657943plv.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 20:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Is4ZUuvsA3sjDvAuffgt8Yjeir7RGhGpld/940IgtKA=;
        b=ork+z5O8SaPp7wmqFpJ1fbIfEy21Bezflnx3W+MKpNishKPRFG1VbE4UdJSems1w5W
         aVDZ/V0iKcIpcOZ0cOq2uTymc73kly+coupqchS5MMHZHeDKPPKYBYQzfzhop0nZtgDF
         oGUwCQNJBGsuSGc4+Zwcxs1pq1glMrLaW/ADpL2L7LRDCkYLPhpApuzHWa9OEmnooBNb
         jdNbBUC5CJq5UbxpUXTde9wQg2oR6LxkC+2YMRn52zTLVUR7QiThk3eKzBLyhychmgOB
         Qpvd58fd5K7VuNNQdPF5UumyLryhWf7ttMqAyQdhug0m5on3KOPe1syo2XOCU/MvM9f9
         ZS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Is4ZUuvsA3sjDvAuffgt8Yjeir7RGhGpld/940IgtKA=;
        b=04kUe0FXWtMQoJyyXDsxyTaK8Nk+oqGH3gjuhF2K8z/YMtGIN5rRsoAaxh7wO5ZX1e
         DfZswkZUkqXLOUCnjwxkk1NBXEYMUkL7LmjtO2AtZZO/zeiIYxPxmYfZ/s676LeIjGT6
         oE1VVi3aD92wKnifAtwW+6n6zbHFrF+gobIyOGx/9VcAO364nRdr48n55U2clVUu2LOF
         zbBw4Tf+taCr+s8XBqVEHToFx6nIn2wRkUVNuVfSwC3+Q35NmPqKDe/W/JW/Lqueb+TG
         cbF7Kv9fFTLT43w+gfNL1I3Ims8Vt70pklsS+jZ4+O8+C+hPRnB10wMYARM9pLZHaHXk
         mLEw==
X-Gm-Message-State: ACrzQf2HoaCWd0p45DP35K+PlnIuWuci/i+yqsTRBq+f06ZSUPB/6F8i
        rzzvvLa3BxazMlkB5aCNyEI=
X-Google-Smtp-Source: AMsMyM4bHukWnITYIjGMHwOj87yAZ3XsOTst4unZ9qeD+zXCqaCppO8PmrHzdyO6bfX0BAo+llc7fw==
X-Received: by 2002:a17:90b:4b4c:b0:203:1eef:d810 with SMTP id mi12-20020a17090b4b4c00b002031eefd810mr19073797pjb.75.1663905323635;
        Thu, 22 Sep 2022 20:55:23 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id a19-20020a621a13000000b0053e8fe8a705sm5371037pfa.17.2022.09.22.20.55.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Sep 2022 20:55:23 -0700 (PDT)
Date:   Fri, 23 Sep 2022 11:58:05 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] erofs: introduce partial-referenced pclusters
Message-ID: <20220923115805.000051fe.zbestahu@gmail.com>
In-Reply-To: <20220923014915.4362-1-hsiangkao@linux.alibaba.com>
References: <20220923014915.4362-1-hsiangkao@linux.alibaba.com>
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

On Fri, 23 Sep 2022 09:49:15 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Due to deduplication for compressed data, pclusters can be partially
> referenced with their prefixes.
> 
> Together with the user-space implementation, it enables EROFS
> variable-length global compressed data deduplication with rolling
> hash.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
>  fs/erofs/decompressor_lzma.c | 3 +++
>  fs/erofs/erofs_fs.h          | 7 ++++++-
>  fs/erofs/internal.h          | 4 ++++
>  fs/erofs/super.c             | 2 ++
>  fs/erofs/sysfs.c             | 2 ++
>  fs/erofs/zdata.c             | 1 +
>  fs/erofs/zmap.c              | 6 +++++-
>  7 files changed, 23 insertions(+), 2 deletions(-)
