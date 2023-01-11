Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B10666589E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbjAKKK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237988AbjAKKKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:10:00 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8762140FB;
        Wed, 11 Jan 2023 02:06:17 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id fy8so35431256ejc.13;
        Wed, 11 Jan 2023 02:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORHQd0uW/DYf9xZjyiu2NQW0oYhRtYQlzsx2cCGgO2U=;
        b=eJccLBIoNknMuHIwnLvBDMZXp3LqxYu3OOzUR0i9bmMS3uC13KM1L7O97ILCFOyEti
         2QwqNR5vVxQVkwM5132debeUDhAr/9Xf+gFdhUSCySVuEocpwFzTNzv0/HYhv9nrIqB3
         Rr87/E7XZcCFN1BdXBGqYLsZgvg35oOijwZC9+ZmvNWRG0i3L54qo33k9bXqDj9RzqfV
         zx2u49buCU8xbRlm4fPgEVQOvmdfOSktjy4YqFFDLkXVVjIX0kt12PMBtC5afYJkOM1w
         G3107iA2NfFDOCInee68RUZH4cfsLB2nbvKwASU+L5++Kpdr0nYh+D4yzpMnWuKuNJ3B
         CiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORHQd0uW/DYf9xZjyiu2NQW0oYhRtYQlzsx2cCGgO2U=;
        b=Vvtw1nzEXQ4AwkcaRnLtPOxpvw5+jTqVs+DgoanL6GRHeGJj6XRiEVQjEBVIV1dari
         N+w2o6bucFeXsxZu0TOYS15tdUdygE91iIcNxtWyx2GmwloX5eldawB5OOzCbWnC25uW
         ieqk8yptBXKBGMFH9VKCT0d3xYAJSyAJxHJBIrnPuLV3iA2zsHI7eB/wkpocN5DKGPgQ
         woeWYf4UeGX1/j/EirwjPDYn7VqEe/cCFLdGZFSiAl8aR0iBZNF/E3BCk7BC4OpKtobC
         xaqO1dLL1LSP1VAD9nBHrxG1KTxc5tQwNvOL2aHkjXb8fxpFfz9fCYwFmm+QlGDo4xW8
         NMxg==
X-Gm-Message-State: AFqh2koKK+jopUoPTQ0XpaAVT63cO82ukBDgnQsnOEGFjjj5tQj/zGxk
        F9ym5Z08IQQwQ8WZj62qS8jQY6TrJd4=
X-Google-Smtp-Source: AMrXdXvoFgQnph8HVT1XmkH/GJbj4aInTs/SnbR7ks7N3WIYkBT0pKeDQ8wbfk+Td+VWiAVTuB1cAw==
X-Received: by 2002:a17:906:910:b0:7c0:f71b:8b3 with SMTP id i16-20020a170906091000b007c0f71b08b3mr56882076ejd.57.1673431572026;
        Wed, 11 Jan 2023 02:06:12 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:a47e:7f3e:6b25:bafb])
        by smtp.gmail.com with ESMTPSA id ku21-20020a170907789500b0084d43def70esm3995517ejc.25.2023.01.11.02.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 02:06:11 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] irqchip: remove redundant config PCI dependency for config LS_SCFG_MSI
Date:   Wed, 11 Jan 2023 11:05:54 +0100
Message-Id: <20230111100554.24500-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While reviewing dependencies in some Kconfig files, I noticed the redundant
dependency "depends on PCI && PCI_MSI". The config PCI_MSI has always,
since its introduction, been dependent on the config PCI. So, it is
sufficient to just depend on PCI_MSI, and know that the dependency on PCI
is implicitly implied.

Reduce the dependencies of config LS_SCFG_MSI.
No functional change and effective change of Kconfig dependendencies.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/irqchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index d79683154f7f..59bcce29b1a4 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -384,7 +384,7 @@ config LS_EXTIRQ
 
 config LS_SCFG_MSI
 	def_bool y if SOC_LS1021A || ARCH_LAYERSCAPE
-	depends on PCI && PCI_MSI
+	depends on PCI_MSI
 
 config PARTITION_PERCPU
 	bool
-- 
2.17.1

