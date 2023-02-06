Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBC368C7E6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 21:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjBFUs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 15:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBFUs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:48:26 -0500
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29601DBB8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 12:48:25 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id e12-20020a0568301e4c00b0068bc93e7e34so3571237otj.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 12:48:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lVCM7ppZvWPv0FWgAoeEHCyX95o4pmFH2WhzfJapagw=;
        b=du/Rr05MsZoyDDriWw9JxDc4W5e1jJ7W8K9JASgOpe/J1GW6QldOzPZ4lod6bR0q2M
         r0d6UFNzfV43hj1EaIRY05J1bnrsb5CsDbhhDGfCWO5u3oGpP2FNJfgRu3pcOjQvqPYh
         AcsbA0r9lMiLNIv9cqWUQ6Rql05CWxNwQZg/kDFIyF7+nOiHvBVula1enPDcxBfSxkLI
         zggHS5tDdTau/N5EGUIOp1ZUtFLxRC8NQH/Ylv/5tFiLCN2+eTMUjIj/7h1F7um8UfiZ
         CnVygLqMNnSQbwB00VJelCqBYuU3JL9XCpRuHw4+d+uC+YMSHf8NEqUjlVQXWF35C8tS
         at4g==
X-Gm-Message-State: AO0yUKVqTTbRMyTxSN4uaGo+aLqptXbZPvz9fwx7hsNLhHcCnFgRb9TW
        7SQCbEoeu0J5G7hiMGBJ7w==
X-Google-Smtp-Source: AK7set9pbh7Wq+E4iW0fy5jRxV6qrIaaJOqCgRrwmo4+qbg0biC+0/V8bxLln4dTmWv9uVIZTvvgzA==
X-Received: by 2002:a05:6830:349e:b0:68b:d4ac:1ca0 with SMTP id c30-20020a056830349e00b0068bd4ac1ca0mr633920otu.29.1675716505110;
        Mon, 06 Feb 2023 12:48:25 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l21-20020a05683016d500b0068663820588sm5585250otr.44.2023.02.06.12.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 12:48:24 -0800 (PST)
Received: (nullmailer pid 1453774 invoked by uid 1000);
        Mon, 06 Feb 2023 20:48:24 -0000
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf: arm_spe: Print the version of SPE detected
Date:   Mon,  6 Feb 2023 14:47:46 -0600
Message-Id: <20230206204746.1452942-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's up to 4 versions of SPE now. Let's add the version that's been
detected to the driver's informational print out.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/perf/arm_spe_pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 573db4211acd..b9ba4c4fe5a2 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -1105,8 +1105,8 @@ static void __arm_spe_pmu_dev_probe(void *info)
 	}
 
 	dev_info(dev,
-		 "probed for CPUs %*pbl [max_record_sz %u, align %u, features 0x%llx]\n",
-		 cpumask_pr_args(&spe_pmu->supported_cpus),
+		 "probed SPEv1.%d for CPUs %*pbl [max_record_sz %u, align %u, features 0x%llx]\n",
+		 spe_pmu->pmsver - 1, cpumask_pr_args(&spe_pmu->supported_cpus),
 		 spe_pmu->max_record_sz, spe_pmu->align, spe_pmu->features);
 
 	spe_pmu->features |= SPE_PMU_FEAT_DEV_PROBED;
-- 
2.39.1

