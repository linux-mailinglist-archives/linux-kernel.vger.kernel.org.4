Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917BB6188F1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 20:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiKCTwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 15:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiKCTwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 15:52:00 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0850A20183
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 12:51:59 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id l11so4692470edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 12:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+MC8kK4zWQiBOS9TmUZzl813e7Kce9jFI4colJBhao=;
        b=qA13inhD1EP6l24EPFrU95U+zViK6UVln1wnFLBXMzU3guuv5XL87mQ657GGlBJDv5
         Ynobk1ef/cexQULn5sXQz2W0DyjHLeN7af3yGWh1e+lEc2Ci2EuKhObBAOHiQw202pbb
         R0A9SrGxiRDi2/BfD0GbOpeSesGZlhz1/w/9u3MExoFW2+fBs9XPOktTxlaIj5vZ3DA9
         wAsSWuQhV1ShmHc74HtGrM/RnLpTzmFNT3bIBaR/+Ty0SC55iaEr0ywSRpT1ZiP9Lele
         IsDff9Xm4w6mcr2mzhB53onaIFRvURcJExNk1TF372aT5uZ6RbcwgSWVohvYMIrkep41
         GRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+MC8kK4zWQiBOS9TmUZzl813e7Kce9jFI4colJBhao=;
        b=LXSxCud5lsmnooufqA1MfmDMTx7SVPrPRKnFnI0JpKi0YOWaE5lhXBd+5HIkoSAW0J
         xR/BwqWSZ/quLdxgcY4s+pTKf8BCoP5DfHVWchCDye2rfEjsanyGzdneB1THWTEof2qz
         tACu+vW6G//3/RCzfXZw8ViChaPfa0l1fW68Egj6hoieKmqWEAqVJpczZoqLiRW///xm
         R9zMOO7n9uEc1sh3UnfrtDS3VsCLAszd82+Wm75J2IxcHCK2gbt/oxt63h52F+chWYOw
         r+W1YzaKuNQCQ2Y7lYrs2OLLTAENm6Zr9UPYJ4TOozJ0faNZPBosXqHV29JwtK2Keol3
         q/1A==
X-Gm-Message-State: ACrzQf0VhvEjTXwe/DXjPEkrggvd1soehFC2Rfy4+I/7CgVa2liJBu5M
        +HmqAA4gAZqUGBru4+jhCNCrEg==
X-Google-Smtp-Source: AMsMyM4XDFAXZNyMtBoTJ07WXs5ANJcqdCknrHoZzRGrPrQdaq9x5LBRX5LsVLVT4RaHWxBqe5ZMeA==
X-Received: by 2002:aa7:c1d9:0:b0:463:aeaf:3383 with SMTP id d25-20020aa7c1d9000000b00463aeaf3383mr16737337edp.253.1667505117553;
        Thu, 03 Nov 2022 12:51:57 -0700 (PDT)
Received: from localhost (cgw.msart-bajzova4.ke.cust.o2bs.sk. [90.176.4.227])
        by smtp.gmail.com with ESMTPSA id j1-20020a17090623e100b007030c97ae62sm847433ejg.191.2022.11.03.12.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:51:57 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        David Virag <virag.david003@gmail.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 1/6] iommu: Export iommu_group_default_domain() API
Date:   Thu,  3 Nov 2022 20:51:49 +0100
Message-Id: <20221103195154.21495-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221103195154.21495-1-semen.protsenko@linaro.org>
References: <20221103195154.21495-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iommu_group_default_domain() may be needed for module users. E.g.
exynos-iommu driver is using it right now, and it's going to be
converted to a module soon.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - (none)

 drivers/iommu/iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 6ca377f4fbf9..006a65411a28 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1675,6 +1675,7 @@ struct iommu_domain *iommu_group_default_domain(struct iommu_group *group)
 {
 	return group->default_domain;
 }
+EXPORT_SYMBOL_GPL(iommu_group_default_domain);
 
 static int probe_iommu_group(struct device *dev, void *data)
 {
-- 
2.35.1

