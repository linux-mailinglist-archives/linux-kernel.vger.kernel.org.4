Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C5F7305DB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbjFNRSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbjFNRR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:17:56 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE38D26A6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:17:42 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-77af8476cd4so185816239f.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686763062; x=1689355062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fRPE1en485fgipWFHZePCu5grK9T3reUk/ZQQmM4jPI=;
        b=cRReFOOT/AI2O7j/W8F+25CiythNAiNClqz6XPr2nNeLDo71QnFYgpv+6Xyr1E9B1I
         vw3k2Bzlu52Eeb9B6/HOHYAyGpKLjXPC0whdbTRo9LYFZRWac4mff0a2vsYy0SVbmyUX
         Wdmvj/dTGM7XeytX+r6tuxJRJlwv+BeKcfmM93sL6TeMEK2108a2vqKWLGtA9epoco0a
         Nu6uFySOaGzp4dvFDZvjPYHWjoj3SJMMgRuPjKliXl7uAntTT9KfZWX+l0p6XkzVhzp9
         MJ+x+4ScDD1kbQEJc7K9YRfh0K2OD1+yCE5AecDjPJdd3RHzyfsU/gaz54aIrl0Ib7ha
         KDDA==
X-Gm-Message-State: AC+VfDx458J0Uy4cO3byMeo4kJL2SyIFfy1AU6lFNSjVQK8IhOoxya7Z
        GbYtNPhZw9fcviw/GL8cO3OFQSGjnA==
X-Google-Smtp-Source: ACHHUZ5A60A7vgjjtAmIlvkG1bo3D2NjQKXfldt7NImSW743rHOfA7n43Tp86e7opfaHS6dpIfLCpQ==
X-Received: by 2002:a5e:db0d:0:b0:77a:d862:242f with SMTP id q13-20020a5edb0d000000b0077ad862242fmr13623229iop.21.1686763062023;
        Wed, 14 Jun 2023 10:17:42 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id w12-20020a02968c000000b0041d7ad74b36sm5144823jai.17.2023.06.14.10.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 10:17:40 -0700 (PDT)
Received: (nullmailer pid 2404355 invoked by uid 1000);
        Wed, 14 Jun 2023 17:17:39 -0000
From:   Rob Herring <robh@kernel.org>
To:     Anatolij Gustschin <agust@denx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kernel test robot <lkp@intel.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: 52xx: Make immr_id DT match tables static
Date:   Wed, 14 Jun 2023 11:17:23 -0600
Message-Id: <20230614171724.2403982-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some builds, the mpc52xx_pm_prepare()/lite5200_pm_prepare() functions
generate stack size warnings. The addition of 'struct resource' in commit
2500763dd3db ("powerpc: Use of_address_to_resource()") grew the stack size
and is blamed for the warnings. However, the real issue is there's no
reason the 'struct of_device_id immr_ids' DT match tables need to be on
the stack as they are constant. Declare them as static to move them off
the stack.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306130405.uTv5yOZD-lkp@intel.com/
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/powerpc/platforms/52xx/lite5200_pm.c | 2 +-
 arch/powerpc/platforms/52xx/mpc52xx_pm.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/lite5200_pm.c b/arch/powerpc/platforms/52xx/lite5200_pm.c
index ee29b63fca16..4900f5f48cce 100644
--- a/arch/powerpc/platforms/52xx/lite5200_pm.c
+++ b/arch/powerpc/platforms/52xx/lite5200_pm.c
@@ -47,7 +47,7 @@ static int lite5200_pm_begin(suspend_state_t state)
 static int lite5200_pm_prepare(void)
 {
 	struct device_node *np;
-	const struct of_device_id immr_ids[] = {
+	static const struct of_device_id immr_ids[] = {
 		{ .compatible = "fsl,mpc5200-immr", },
 		{ .compatible = "fsl,mpc5200b-immr", },
 		{ .type = "soc", .compatible = "mpc5200", }, /* lite5200 */
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pm.c b/arch/powerpc/platforms/52xx/mpc52xx_pm.c
index 549b3629e39a..f0c31ae15da5 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pm.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pm.c
@@ -60,7 +60,7 @@ int mpc52xx_set_wakeup_gpio(u8 pin, u8 level)
 int mpc52xx_pm_prepare(void)
 {
 	struct device_node *np;
-	const struct of_device_id immr_ids[] = {
+	static const struct of_device_id immr_ids[] = {
 		{ .compatible = "fsl,mpc5200-immr", },
 		{ .compatible = "fsl,mpc5200b-immr", },
 		{ .type = "soc", .compatible = "mpc5200", }, /* lite5200 */
-- 
2.39.2

