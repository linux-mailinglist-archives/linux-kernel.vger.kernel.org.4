Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB916801CB
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 22:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbjA2VpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 16:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235183AbjA2VpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 16:45:20 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C3018B00
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 13:45:19 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 143so6393441pgg.6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 13:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mlWGWk/xGZIts3NL177gYapbWeRI/F898dfij2bn5Y=;
        b=VUpekjT4eobTtgSswm2s+LU/r9TV7s7D3lDG1sNT1jYByWNdh5CN5OPW1Tv7HVToxp
         eXd2GHd79ERXvAQiXiSpgc3bYsW1zdr32gwYedjPB08H9RPe+CR/R793Pe5t37cIGa46
         yeXQ6r26Hk3pN2sf2GlH/RpHmVlWyZfTA51hg7JSREf6w6woSa1m7hGt67FlUDJWNw9H
         a44BTWOG0DFl68XvsvA/YtdTBEq+dVJeNhiHrx+oCEQXDvYzy/pShvVuNkRvP2Hw3cv0
         +l300uvjTQvOkOQUhHP7T/Oj/cnGX26pjapjNmTv/eAenZGsGWAUDY13Ffmj9fJlouP7
         D/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mlWGWk/xGZIts3NL177gYapbWeRI/F898dfij2bn5Y=;
        b=an3AGdTYSfVJrgA78f3boX9lIGMjRkvHCZSYkZkzV7qCw7UlOt/YRt3PX3pOfDkoja
         n8CBxQ682m6/yNpLtpevjQfaVKyYyZR3bynOqYa0YRn4PgQLm9nATfG4QOBO5iE7iZ3U
         AjTN3JLKUtYnzdbwSJ/2R+Q1oTI79QAacs9oCFlQeIJr+pxs/yrxNu/WIw1Cg2gqORdU
         Xe1ZIOe7PbO7aU/UoK+hqfw32GFgEYIFZL+STpH9JkIQlFfJa/Qrfh+WJtDDYZNG18q5
         GjYeEArzzgbap0fDZMt2IKyTIjRHXImKdLuX1LoGbCWkXdZEXHY/yfZxjfLBhpGVjTpm
         k5uw==
X-Gm-Message-State: AFqh2krjJjnhGQrqqCjJqXCxCDm+adSMUHb1HkuipPD+ZBST/zBF8UQU
        BIMZBQlLalVsiTXTJ2OA7XkcZw==
X-Google-Smtp-Source: AMrXdXtsvnlhy1C1Bo22+pe5X20bbQRF+CKJjGRH+4jc3FrfRPhRtkK2qI0LPGwV3zDdJ4Bm/e7btg==
X-Received: by 2002:aa7:9114:0:b0:57f:d5d1:41d0 with SMTP id 20-20020aa79114000000b0057fd5d141d0mr10615241pfh.3.1675028718976;
        Sun, 29 Jan 2023 13:45:18 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v66-20020a626145000000b005882b189a44sm6032360pfb.104.2023.01.29.13.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 13:45:18 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Zhong Jinghua <zhongjinghua@huawei.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yukuai3@huawei.com
In-Reply-To: <20230128030419.2780298-1-zhongjinghua@huawei.com>
References: <20230128030419.2780298-1-zhongjinghua@huawei.com>
Subject: Re: [PATCH-next v3] blk-mq: cleanup unused methods:
 blk_mq_hw_sysfs_store
Message-Id: <167502871809.54799.13535290595162039137.b4-ty@kernel.dk>
Date:   Sun, 29 Jan 2023 14:45:18 -0700
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


On Sat, 28 Jan 2023 11:04:19 +0800, Zhong Jinghua wrote:
> We found that the blk_mq_hw_sysfs_store interface has no place to use.
> The object default_hw_ctx_attrs using blk_mq_hw_sysfs_ops only uses
> the show method and does not use the store method.
> 
> Since this patch:
> 4a46f05ebf99 ("blk-mq: move hctx and ctx counters from sysfs to debugfs")
> moved the store method to debugfs, the store method is not used anymore.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: cleanup unused methods: blk_mq_hw_sysfs_store
      commit: 52627f3c2935342dbceb2ba6fd710f1deac627a1

Best regards,
-- 
Jens Axboe



