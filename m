Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D574A64F4C7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 00:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiLPXKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 18:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiLPXJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:09:47 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC3F6F4BE;
        Fri, 16 Dec 2022 15:09:46 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id jr11so3959640qtb.7;
        Fri, 16 Dec 2022 15:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w9GVHJtCv2J5OQVq85gmnzsHWES4g25wbmqi8FJt3vw=;
        b=hI0CWZ3p8u02SOmYoSbP4T2pyMKJ9+AMV2Fq9hH9SxGz7OmFU3tsLnxg9MfiMmUYwR
         z3CsEsKtpcvVFF64iVZ6A67ZoicPg/mFfIWIGmcFxXgWdx1zWCBsBuvigY2T2lS/RnvY
         v3upasTSdDjBTfWZDfVNnYk/OIDLf4xVBqClz+h6QH0KkUJxKgy1eMqeo70ztQdvAxA3
         vFz2PyAOUSEiTSqmTu4kObhnbrwLWXzYyCT1JKC2eF1gW5jBXG5NANpeCOxL0MIQoxpw
         319qNaUg42dvtVbnAiP+JJLyWPs7awfKf16WCccdp51TBuPrmXG8WOOnj2jEuDI28Cpj
         SGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w9GVHJtCv2J5OQVq85gmnzsHWES4g25wbmqi8FJt3vw=;
        b=8CXMXr83VvnpTZp+vMQZAtzaB2htST2DV6LAGfqQ/JRAZ+8FXX5/JwWLKx7dxP/7eB
         ANWr+HEOlIgq/CWWD24BhlcKmTlDe6jXkABtxzURHpU6JUC9DslIdL1fDfqo6tZ3wRNG
         KncYImXcKm300tJEfT6O2IcP9FhgkWHIYeiG3BgP/rVwCBj1nK48D7kWsKUl2yNnrD4n
         NRR7FVutTxV29Ji35Y6zakQ3+y5B1hyURC5NaNQDKGL4c1CoWrltiW4QsAbSeSBqWk1T
         XWu/8vk00stOWxIZKGUvWFd5w/ZKgJy5VuBEj6lPGk0JwGHagnFKbOLdvnaVhdvfjkvp
         G+9w==
X-Gm-Message-State: ANoB5pm3kyjstdlCQOGzgLxaasbZ9CdPpVpfMt1zavuaGCUrvERWHhw5
        catTqGkZohuXLv7u7WIAF/zvEp+kjbMJVA==
X-Google-Smtp-Source: AA0mqf7IcKMzQqr1LbkZkZM+ufQ6U6ajREk6AJq2fFYgynYmPfPOWJS0vdeLLHFRNXp6O9rfCt31ng==
X-Received: by 2002:a05:622a:1818:b0:3a6:8da6:65bc with SMTP id t24-20020a05622a181800b003a68da665bcmr59363686qtc.13.1671232184569;
        Fri, 16 Dec 2022 15:09:44 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o70-20020a374149000000b006e702033b15sm2360386qka.66.2022.12.16.15.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 15:09:44 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Doug Berger <opendmb@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-mips@vger.kernel.org (open list:BROADCOM BMIPS MIPS ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH 0/2] Couple of Broadcom L2 driver fixes
Date:   Fri, 16 Dec 2022 15:09:32 -0800
Message-Id: <20221216230934.2478345-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small patch series ensures that IRQ_LEVEL is set for level
triggered interupts in both the irq-bcm7120-l2 and the irq-brcmstb-l2
driver.

Thanks

Florian Fainelli (2):
  irqchip/irq-brcmstb-l2: Set IRQ_LEVEL for level triggered interrupts
  irqchip/irq-bcm7120-l2: Set IRQ_LEVEL for level triggered interrupts

 drivers/irqchip/irq-bcm7120-l2.c | 3 ++-
 drivers/irqchip/irq-brcmstb-l2.c | 6 +++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.34.1

