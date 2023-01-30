Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720CB680401
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 04:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbjA3DEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 22:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjA3DES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 22:04:18 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACD81BADD
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 19:04:17 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id nm12-20020a17090b19cc00b0022c2155cc0bso9772721pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 19:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZ6yrQ8QtaF+R4KmbpHk9smJ4moMIfGYvuFm4fbV6sc=;
        b=UdmzHx0zsT7cWmAEfDg3Pvx9yJhOEKanG2EXeWgIdwce6Me6hEj2X4Fd/tukd5ugfa
         FP8S2r8lRPk1z5J5+VNGZxevrDVZ8hQQdBJkU1iCQOR4utbSuqvR6HoRSZI2huRh4iam
         erL4WKX3HEIiS/TnXDYPpDECgAmeFH8NxvxllsjTRNjSmpTW+v9LwOv3TC8bUrjszDAJ
         u+Trn4UyXbDfGqreWnCbe1E+3d0xrMh65MNPOHIyxeeMlf0khBlc4yST/M43zxSEAthC
         Nj5R1sg3OZQHWW5i49QdXUrRAQvkNATID2IOHf0C+hEQ7/EIW7AcbqIX0pmP0yWArtJz
         xh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZ6yrQ8QtaF+R4KmbpHk9smJ4moMIfGYvuFm4fbV6sc=;
        b=SotpJVCEBYhrNvEFsjojFoU90kLzVv+bNa1+Jfx1Iq2Te/bE7Zr0FemvoK5K4/loBp
         wI5lq48wWyGLvzjM/C5wVcnTsKDsOKROzgHXDgdYae+LOmBCRZdZH4mfkP7KnoeTokqH
         TsXZyzYx5mFdJzOxPLfg/h2HxrDJ9CPRoMDgkrgWS5Ln4FPzDlGzdvjiAfGtuyfAmvWi
         OuhUhgl/eEkT+O17AwRRyf12KfBiGjVcXF9y9k5QITQc42tF/+ayUHQnOVRGkgNC/vpl
         M67gY1sGF84Ctz9AuJeKlv/u/23SyEiX9ww1NqTyetJ0ASQnwI9ZWsqhaR9suKDUPKXK
         qoGg==
X-Gm-Message-State: AFqh2ko+ungGG0KGBGm4Bu3WEpAwa+2/gQMKrg5CSld4pvXwnKfjUxX1
        DjolzDnoO0JTZSHYu4alywOOZg==
X-Google-Smtp-Source: AMrXdXtNC0YC4yCuWmeGwlvLEC/vsMCLN4G3Xe7itukdLDlq37sr1l45AqKpaL+PAvHwwcRna1KmGg==
X-Received: by 2002:a17:90a:af91:b0:226:df9a:969c with SMTP id w17-20020a17090aaf9100b00226df9a969cmr11145645pjq.0.1675047857186;
        Sun, 29 Jan 2023 19:04:17 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n29-20020a638f1d000000b004d3f518eea7sm5667103pgd.94.2023.01.29.19.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 19:04:16 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, josef@toxicpanda.com, paolo.valente@linaro.org,
        yukuai3@huawei.com, jack@suse.cz, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com
In-Reply-To: <20230130014136.591038-1-yukuai1@huaweicloud.com>
References: <20230130014136.591038-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v2 block-6.2] block, bfq: fix uaf for bfqq in
 bic_set_bfqq()
Message-Id: <167504785585.199828.6199773692964530920.b4-ty@kernel.dk>
Date:   Sun, 29 Jan 2023 20:04:15 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Jan 2023 09:41:36 +0800, Yu Kuai wrote:
> After commit 64dc8c732f5c ("block, bfq: fix possible uaf for 'bfqq->bic'"),
> bic->bfqq will be accessed in bic_set_bfqq(), however, in some context
> bic->bfqq will be freed, and bic_set_bfqq() is called with the freed
> bic->bfqq.
> 
> Fix the problem by always freeing bfqq after bic_set_bfqq().
> 
> [...]

Applied, thanks!

[1/1] block, bfq: fix uaf for bfqq in bic_set_bfqq()
      (no commit info)

Best regards,
-- 
Jens Axboe



