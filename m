Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E125B5489
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiILG36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiILG34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:29:56 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CFCE00F
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:29:55 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h8so6703330wrf.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=eJpetYLvd8t1fhFVDnNO/2TqAinXp5zIfJwgDELUxmI=;
        b=Z2APGz+u9boMJ5/zapRBac1k/AOu3vzAVNEoUMY0mA6x93A9ywX16FjQP+ZEKQYlTo
         TX7I/pZJCOr/+SD/8Xa3O4r2g3IyvOOpO145ErP5/HdiqwvAWRAPyk4qnHLPvNuC1pUF
         nVEp+kkhaOfxCobHa51iKtN3YNxJyEudBtoy0SVeHB1gQ+Tr0SGc3T/FN5UEOS/JIkvE
         U9/l7Ir06H7U/Orv35Hl81uTYhdXo2UKgtpPVBw2nmkVHxxu4wGR0vcIbers5MUSFrOV
         s+S1B6xc3SHPjaZEHqR06KaLau5MWan28zlADfUjdRoV6YLYTTTgCBrVH8cJyeakwTt3
         W5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=eJpetYLvd8t1fhFVDnNO/2TqAinXp5zIfJwgDELUxmI=;
        b=wHq0VEQQWB1wkofUZV16nbxkuv5yyrfq4rYR+VjejDRWpkQEe5XTJ33g7JGGxStVxj
         gC7sOYMU6cvxFs+/55npY1GcCKYoekxr1ZaeqgL7UAITM1i5EGLtyrstMxbcgWA5i6Fb
         rwQtrBMsxG/5WhTWuneG714BHgcuM4HzliRrjpjNM6ekhQIxl0BiJ/2rWkJ3HTy3/yz+
         TB06ybOF2HhXALefDHCWWrEnAS1JtbeL6Z79by2KXRNaugrHly/qr21HVzTttZrwDSS8
         tH6+lPVqdaFB+NQl0T02AlZAd0mrwxd29IMUm3VZhWBjPVpR3818MxJUux24VMb+U+iH
         cmaw==
X-Gm-Message-State: ACgBeo0/DNBPRm6W8XdCN+HlKov5DNoy4achYeGgLA68BQRJK2HVrri6
        73/BRb6AwEcRKdAjkYzwlYQmOdkpk9v0pn8GDlw=
X-Google-Smtp-Source: AA6agR4GSrw3bwi1+ZRWqXiAJR+JncOxzPoQRCKfiQYCJNJ3/rOuYnBwdlNPOVOu8o8s7Sfuow22QA==
X-Received: by 2002:adf:e38f:0:b0:228:68f0:4f85 with SMTP id e15-20020adfe38f000000b0022868f04f85mr14817773wrm.570.1662963629431;
        Sun, 11 Sep 2022 23:20:29 -0700 (PDT)
Received: from [127.0.0.1] ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id id11-20020a05600ca18b00b003b332a7b898sm8480508wmb.45.2022.09.11.23.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 23:20:28 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     cgroups@vger.kernel.org, yi.zhang@huawei.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com
In-Reply-To: <20220827101637.1775111-1-yukuai1@huaweicloud.com>
References: <20220827101637.1775111-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v2 0/3] blk-throttle cleanups
Message-Id: <166296362850.59359.17771579764308484678.b4-ty@kernel.dk>
Date:   Mon, 12 Sep 2022 00:20:28 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-65ba7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Aug 2022 18:16:34 +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Changes in v2:
>  - add tag
>  - remove patch 4
> 
> There are no functional changes.
> 
> [...]

Applied, thanks!

[1/3] blk-throttle: use 'READ/WRITE' instead of '0/1'
      commit: 7e9c5c54d440bd6402ffdba4dc4f3df5bfe64ea4
[2/3] blk-throttle: calling throtl_dequeue/enqueue_tg in pairs
      commit: 8c25ed0cb9d2e349ebebfeacf7ce1ae015afe54d
[3/3] blk-throttle: cleanup tg_update_disptime()
      commit: c013710e1a7eba8e33da9380a068fe1cec017226

Best regards,
-- 
Jens Axboe


