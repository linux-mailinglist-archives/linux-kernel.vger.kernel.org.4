Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B683B6DFE40
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjDLTAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjDLTAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:00:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A3D40F9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681325957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LsekIlFf4oq6puv8x/mUu67gc6GF1RbRh4gmOlexPQc=;
        b=PgWqlA8/B2PLmptUp0OoVjPxl9mBfE4+riy55F912/OEXf1SThCCPx+/kuJbWYCxU/KyDu
        +jMGZ4heaJjqJ1btiTijPmp4jwGZ/mxVt2PrpimC6hhv8CplGy4nazBW/4cXRk7O9ePMxf
        pvjkHnrpR/MNdORGUH0aG3xJFr5PJLA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-65LbHk3IPrqmD7NF7qmB5A-1; Wed, 12 Apr 2023 14:59:15 -0400
X-MC-Unique: 65LbHk3IPrqmD7NF7qmB5A-1
Received: by mail-qk1-f199.google.com with SMTP id c128-20020ae9ed86000000b0074690a17414so6569452qkg.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681325954; x=1683917954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LsekIlFf4oq6puv8x/mUu67gc6GF1RbRh4gmOlexPQc=;
        b=VJWxMj3xp4peebFaAORVOIs3y/7g2MBddADzQ/nKbrOP1SXOHWm4roF+PmvZhOluJ7
         TUrpFQbVsd7Ui91MOrS8ryHuiyYmeBgSlfpXht/mBCuf0pdJtLwhoMqvjEuWcn8A8IUu
         QZDYwgjgsQXa0RXTyP6UP43tIGsQS1tQ8OlXh8muzy+kwINitJlNnxpHHtzfOlWf8gJk
         RDAGoSzcCUPVadutiTJclVN8b176uHQSvHmkfYGNvonPVcoT5BdpL6bO1RIbF7poWkHn
         znT2bUpqBEqup+RGegtHVyCesL2gyYFPIOJ9TcSPB83WFhDjp7CvVD9z5jNLULlgxKPA
         OCdg==
X-Gm-Message-State: AAQBX9fJrgXkHm83WekIwqi71nehzJkuGDp2G8k/iiNabt9OhaopFw8z
        7KpkyiSVQZHL7se+QU1m0S3kY/ow92WFHjvJuUIxWxaTgijzohoHhE7ofhfO36PzTw+jrqUu+ZW
        OgcRY2QDcysyRsq9AGlOJgPfNqynyubmk6beEYZCqHv9OrsR8slL3BBHYZMA8Rvl9CQpCzoj1gx
        hj6XGhSE8=
X-Received: by 2002:ac8:4e4d:0:b0:3db:8942:cbd2 with SMTP id e13-20020ac84e4d000000b003db8942cbd2mr4578830qtw.61.1681325954640;
        Wed, 12 Apr 2023 11:59:14 -0700 (PDT)
X-Google-Smtp-Source: AKy350Ytfd6UQO/faje7ao9Zj5NDNkMuJuG88zVCdvJHUYSS4EtUT4r/Rek/sPM2QLubhJt+hrIQtQ==
X-Received: by 2002:ac8:4e4d:0:b0:3db:8942:cbd2 with SMTP id e13-20020ac84e4d000000b003db8942cbd2mr4578811qtw.61.1681325954332;
        Wed, 12 Apr 2023 11:59:14 -0700 (PDT)
Received: from thinkpad-p1.kanata.rendec.net (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id k21-20020ac86055000000b003d3a34d2eb2sm4417558qtm.41.2023.04.12.11.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 11:59:13 -0700 (PDT)
From:   Radu Rendec <rrendec@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 3/3] cacheinfo: Allow early level detection when DT/ACPI info is missing/broken
Date:   Wed, 12 Apr 2023 14:57:59 -0400
Message-Id: <20230412185759.755408-4-rrendec@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412185759.755408-1-rrendec@redhat.com>
References: <20230412185759.755408-1-rrendec@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent work enables cacheinfo memory for secondary CPUs to be allocated
early, while still running on the primary CPU. That allows cacheinfo
memory to be allocated safely on RT kernels. To make that work, the
number of cache levels/leaves must be defined in the device tree or ACPI
tables. Further work adds a path for early detection of the number of
cache levels/leaves, which makes it possible to allocate the cacheinfo
memory early without requiring extra DT/ACPI information.

This patch addresses a specific issue with ACPI systems with no PPTT. In
that case, parse_acpi_topology() returns an error code, which in turn
makes init_cpu_topology() return early, before fetch_cache_info() is
called. In that case, the early cache level detection doesn't run.

The solution is to simply remove the "return" statement and let the code
flow fall through to calling fetch_cache_info().

Signed-off-by: Radu Rendec <rrendec@redhat.com>
Reported-by: Pierre Gondois <pierre.gondois@arm.com>
Link: https://lore.kernel.org/all/dea94484-797f-3034-7b86-6d88801c0d91@arm.com/
Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/base/arch_topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index b1c1dd38ab01..147fb7d4af96 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -835,10 +835,10 @@ void __init init_cpu_topology(void)
 	if (ret) {
 		/*
 		 * Discard anything that was parsed if we hit an error so we
-		 * don't use partial information.
+		 * don't use partial information. But do not return yet to give
+		 * arch-specific early cache level detection a chance to run.
 		 */
 		reset_cpu_topology();
-		return;
 	}
 
 	for_each_possible_cpu(cpu) {
-- 
2.39.2

