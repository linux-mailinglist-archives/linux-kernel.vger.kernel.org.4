Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820BA742F89
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 23:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjF2VdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 17:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjF2VdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 17:33:12 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266552D7F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 14:33:10 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2637ab3d8efso64603a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 14:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1688074389; x=1690666389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o83jcI1G1ZsT+qyL5GtnXINDpgyMSgFFKrn+OMZU0bQ=;
        b=P6RliEi/7YAsD7DwWKzXpii8hPyr7p3rLn3FzoQAlOOE2B2qRc7BNrCKD/DmISvMwk
         4AKLYqD2h4W/zXycI1fpFatKWcafdlOIK483g3FaoZWAmMv7GS/6tW8SKkdWFTdg2x0R
         MmgA9VZAJ+1UQ3GY/BNwrjzhDfSHyXbA/l4agQIG8nMeDY5FLKKAkBrjtQayLm5Efup5
         q5D3u9fHdabRzmh+eZFPAoDG1uZF4uvj1PnFd7nJP4rGRo3/TUVI15l2kipXuTPf0lQC
         k+stO5QQ+3zrrK0t/5lDzbZaXtS/yApFq3lpWfrM0Z9k6rHynEAc5VZCWUFdy+Y45j/S
         H0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688074389; x=1690666389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o83jcI1G1ZsT+qyL5GtnXINDpgyMSgFFKrn+OMZU0bQ=;
        b=VV2PEVh1u5/szx+NA4wjbL4zB1M9bFfhmVy4U0ikH21yFF2cj/EQImQvPMgdRgve0Q
         3rahyzNSjkSvA2iZVlyclDSNyiqPk0n7FF2T2A0QAWQAOs6hyOaOCHb3m0v6qdNXDn/Y
         rJaCwn9xY4ELMF1cRUWPUmSQaIAd/Zxn4Hh8bWK8M7seEKOjIgmrIjY+LM7tC/EIsmTA
         I9v0nIszcjAkLyc+FEjqiSBsA51sCFVH0/2D3rclGe9Uc72+/TAhzVspoO3UQBTLj/Pi
         VWFeixMTaia5HjDcE6HZviW4PYqxeQxsKeXBQy7MEXRMi+xXF+r0tg8aaDvfrybWjMCy
         rBkg==
X-Gm-Message-State: ABy/qLbnVdPxlLW03zALj8xp9jVVQC2z2uHF/WLqvm9ksLwUhzkQUdfC
        HS4zGe1QSNGycS4UJB3+0OyEyQ==
X-Google-Smtp-Source: APBJJlGWMQ6gS+bisZayuJKzqMgM5EqxAN2JKKHwbcvp71/M91QNObD9ajE7HrirTEsEPmZxPlTMoQ==
X-Received: by 2002:a17:90a:17e5:b0:263:1661:1d1a with SMTP id q92-20020a17090a17e500b0026316611d1amr626383pja.7.1688074389493;
        Thu, 29 Jun 2023 14:33:09 -0700 (PDT)
Received: from dev-yzhong.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id t8-20020a17090a024800b0025bcdada95asm4830016pje.38.2023.06.29.14.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 14:33:08 -0700 (PDT)
From:   Yuanyuan Zhong <yzhong@purestorage.com>
To:     leon@kernel.org, jgg@ziepe.ca
Cc:     cachen@purestorage.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yuanyuan Zhong <yzhong@purestorage.com>
Subject: [PATCH 0/1] RDMA/mlx5: align MR mem allocation size to power-of-two
Date:   Thu, 29 Jun 2023 15:32:47 -0600
Message-Id: <20230629213248.3184245-1-yzhong@purestorage.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Recently I noticed the mlx5_alloc_priv_descs() do many allocations from
kmalloc-8k. It's called from following chain:
cma_cm_event_handler => nvme_rdma_cm_handler => nvme_rdma_create_queue_ib
=> ib_mr_pool_init => ib_alloc_mr => __mlx5_ib_alloc_mr
=> _mlx5_alloc_mkey_descs

When the nvme-rdma asks to allocate memory regions that support maximum 257
sg entries, the real MR memory allocation size is slightly bigger than 2048.

The MR memory allocation seems adding "add_size" to guarantee that there
is enough space to find the memory aligned to 2048 (MLX5_UMR_ALIGN).

The requested size is bigger than 4096 after adding the extra bytes.
Then kmalloc uses 8192 as the actual allocation size.

For power-of-two sizes, the alignment can be guaranteed by kmalloc()
according to commit 59bb47985c1d ("mm, sl[aou]b: guarantee natural
alignment for kmalloc(power-of-two)").

Here comes a draft patch that uses the lesser of existing requested
size or the next power-of-two size.

I'm not sure if it's better to simply allocate roundup_pow_of_two(),
or if it's true to assume that slab will not have intermediate size
between 2 power-of-two sizes. Also not sure if a generic memalign()
will be the better approach.

Can you please let me know what's the preferred fix, or fix it directly
to let the allocation use the smaller slab if possible? Thanks


Yuanyuan Zhong (1):
  RDMA/mlx5: align MR mem allocation size to power-of-two

 drivers/infiniband/hw/mlx5/mr.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.34.1

