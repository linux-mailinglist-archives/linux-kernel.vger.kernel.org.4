Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A0C60041E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 01:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJPXUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 19:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiJPXT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 19:19:58 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C541E3C2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 16:19:56 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id m6so5738612qkm.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 16:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yeRgj7nCvyYN1J0qmxgCU75J7PbcVNkqP3g2jdN0MA=;
        b=OZg6inTz4w7JxKGq1bUOsEn/VJjamYC5GJKOv/G+crG/xSA0CWpgx9VsH1Is4QjdY3
         rZ2MuMSMxgHxymvM9CeKPjSUy6dINVwrA+AoEGN4U04zEwsisI3h51f/bTisVXNEzyk7
         r2qhhiDudn8sJen28bq127O4Jh8EzvNIRoMIqtf/sVZp6RFG7Xp/4V6CJQac07oV9d13
         /k4pkXqmvAmT1Vv0nbPDXRMQn+hwSyTtY2yKUX0aS2j6G2WnrX1IY2/FxUXXr8/6Gk42
         bYzqMWd92EoKTVAT/5nu1GQwdV1L287MKsdBnR1KBBFDcdmA0Zk0xvaKsw4E6GHtV6kA
         xvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yeRgj7nCvyYN1J0qmxgCU75J7PbcVNkqP3g2jdN0MA=;
        b=H6UpEBlsk751P2OCag58SCtAqFp9cYgLrQ+XfBnFbq90cEDcnyvMolMNhTBvLj0qD3
         0hstrToeb1oYJpkzRj0e4lFdNbKNTOtOzPBy0hOd6aYVrl0l93DPHFnVY590pRqSVVpU
         ul4Qf+gmEeT2j3LuJ80mfINl5HHoI4w5pRJyUajnDNIXhuAxLhleCHNyhsNE/N6ApxZ3
         TeSnJEW+syGVV9QMY9YfIERqfYqsDOhsfmpKqdNI4EbNMA4Ml0nmM1fhHkCBOpfeZXWm
         M3b9K0iS4Lr/tlUszX4G2AcilHDY/47e5hrtMDS+wS+esKRDaimp4tuPOLJt46RTjTtx
         /yQQ==
X-Gm-Message-State: ACrzQf0poRYuV0EuYHQEVDX14w/FQF8wNvkGeRZIg2YCOjZqJFmWIFC9
        KpF2Ln9QUKHgJUSF23t1zGq57Q==
X-Google-Smtp-Source: AMsMyM4C85WF7zM4dCjMDzaKfisZN7kSN9D5fKyAqyZb1d4Md3ETQibbb8m9PJxKb970AKfKfiwFfQ==
X-Received: by 2002:a05:620a:2406:b0:6ec:c5f5:6304 with SMTP id d6-20020a05620a240600b006ecc5f56304mr5830132qkn.95.1665962395686;
        Sun, 16 Oct 2022 16:19:55 -0700 (PDT)
Received: from [127.0.0.1] ([8.46.73.120])
        by smtp.gmail.com with ESMTPSA id y21-20020a05620a44d500b006b61b2cb1d2sm8198642qkp.46.2022.10.16.16.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 16:19:55 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linan122@huawei.com, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, linux-block@vger.kernel.org,
        yi.zhang@huawei.com
In-Reply-To: <20221012094035.390056-1-yukuai1@huaweicloud.com>
References: <20221012094035.390056-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v2 0/4] blk-iocost: some random patches to improve iocost
Message-Id: <166596239158.7476.4104083595151630912.b4-ty@kernel.dk>
Date:   Sun, 16 Oct 2022 17:19:51 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Oct 2022 17:40:31 +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Changes in v2:
>  - remove patch 4 from v1
>  - add Acked-by tag from Tejun
> 
> Yu Kuai (4):
>   blk-iocost: disable writeback throttling
>   blk-iocost: don't release 'ioc->lock' while updating params
>   blk-iocost: prevent configuration update concurrent with io throttling
>   blk-iocost: read 'ioc->params' inside 'ioc->lock' in ioc_timer_fn()
> 
> [...]

Applied, thanks!

[1/4] blk-iocost: disable writeback throttling
      commit: 26c07fd872021288989238b6074423afe8090e84
[2/4] blk-iocost: don't release 'ioc->lock' while updating params
      commit: d5777253bae5d43e50f5c30d7d32059e094fca55
[3/4] blk-iocost: prevent configuration update concurrent with io throttling
      commit: f71da52a257b300e7f23a882628d724aa9b82f98
[4/4] blk-iocost: read 'ioc->params' inside 'ioc->lock' in ioc_timer_fn()
      commit: 8a731474c3cbb1b843b59a3ea2cbeed1c9a34ed9

Best regards,
-- 
Jens Axboe


