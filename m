Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EF25FB9EA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiJKRuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiJKRuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:50:46 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE4632B8B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:50:43 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id u21so21185455edi.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=utPrbE2BVpHRFeW5CkjvteB3YQtVT8Yss/hrJKsa4ds=;
        b=Fmu1aHk/J7PoRiXS5yduxpI3iTB3YV7jq+GVOm/wWDNsVrlQ90G/SNxQYWauNZMeuA
         T/Af/8ZIKpE6ZVGaCoxtb59s2n7LA1nff5JG03qdleZIen3RjyaI/Jlk3me7Q77PPCgz
         OZybzPZJE4jzPUwb0minf6xcziIgd9z7RsneWT/LZiVmDvBlngaHqXZ45DJEvfoyVqP+
         24+3Ge+3Oo/SgSDH53LA1tHxWC0mJaY3LiL1vpPDYVI6T1BZANYM63bqEp4HBVv6LnCo
         Ql3Jck8EfDEXuv3N0I6Obgwg2UMzj5whwYoZ5kDqj5cSms0prGmCRlhljdjQI2EB3v0r
         EC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=utPrbE2BVpHRFeW5CkjvteB3YQtVT8Yss/hrJKsa4ds=;
        b=XyczNd4SmwAjmIwXrqex7NNtu1Gx4MpsPmbCEYF+mvFrUIme7sy5xawqBANRBBydjR
         CYTPsgGIp+I9KjInvSGG8bogwIHUrWzQGJ+qBLJ2/aBM769c18Rr533JQRZT2pGTm8VF
         E9t9MLUPNuTOe9yii/ZSoVwOs5VcfWFOQf+6E0D/txcwzety3EsKfybqI7bKJgrDTLBj
         gG0YEDEDGSipLUeuqo2Kpm2/bCvRmPJgb+qt82ouGo5uFsNZMWdSLOTLRzbahGBS/FQb
         3VshV0ffHACA0CFBKbZRYI28uTu89od1lwE3jx6kGn8I9eFawL6jtPn/CkJDgz3oICbQ
         x8ww==
X-Gm-Message-State: ACrzQf2hXmsuzTY41WWdM+szLH6qd3bDyYPXuUaFPEN444vpPat2ONE1
        jGk9qSFgQ52w+svGSZ1bLgsuxO9aIonWFw==
X-Google-Smtp-Source: AMsMyM4iF7JtNbWsxFqdpKcpXybVYArSNuZeDz7D8SSkLYBl/uMSb4CdgAeYTv4Xbmeaiz/HXACngA==
X-Received: by 2002:a05:6402:292f:b0:458:e447:5c with SMTP id ee47-20020a056402292f00b00458e447005cmr23149616edb.286.1665510641703;
        Tue, 11 Oct 2022 10:50:41 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id 13-20020a170906318d00b00770812e2394sm28438ejy.160.2022.10.11.10.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 10:50:41 -0700 (PDT)
From:   Andrew Jones <ajones@ventanamicro.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yury Norov <yury.norov@gmail.com>
Subject: [PATCH] RISC-V: Fix /proc/cpuinfo cpumask warning
Date:   Tue, 11 Oct 2022 19:50:40 +0200
Message-Id: <20221011175040.1782772-1-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upcoming cpumask changes will start issuing warnings[*] when cpu
indices equal to nr_cpu_ids are passed to cpumask_next* functions.
Ensure we don't generate a warning when reading /proc/cpuinfo by
validating the cpu index before calling cpumask_next().

[*] Warnings will only appear with DEBUG_PER_CPU_MAPS enabled.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Cc: Yury Norov <yury.norov@gmail.com>
---
 arch/riscv/kernel/cpu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 4aa8cd749441..592ff065e09f 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -166,9 +166,12 @@ static void print_mmu(struct seq_file *f)
 
 static void *c_start(struct seq_file *m, loff_t *pos)
 {
-	*pos = cpumask_next(*pos - 1, cpu_online_mask);
-	if ((*pos) < nr_cpu_ids)
-		return (void *)(uintptr_t)(1 + *pos);
+	if (*pos < nr_cpu_ids) {
+		*pos = cpumask_next(*pos - 1, cpu_online_mask);
+		if (*pos < nr_cpu_ids)
+			return (void *)(uintptr_t)(1 + *pos);
+	}
+
 	return NULL;
 }
 
-- 
2.37.3

