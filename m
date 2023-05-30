Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCA8715AC0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjE3Jxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjE3Jxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:53:49 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C552FE59;
        Tue, 30 May 2023 02:53:15 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b021cddb74so20953535ad.0;
        Tue, 30 May 2023 02:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685440394; x=1688032394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f1cCBXszeZH11zIMBvJPlg2HDVzddl/X2tcxJo4hA6Q=;
        b=LB0HlapQrUoUcQyXN2kV1cNBqsB0mhKRubxXVJf+aVQKSd9xyg04UXSqy9fMrJrnns
         rj+5uVWByFjPg6AXmBRshQ45mx0bjsZVZLaKrVqvXXxxGo+R3vr9jN+cMX4qdfhc0i5j
         btFu5An7KRImmK51dCqY4102mTKL67GbzbbujaH1Ta6L+58J3Zp/byX9LZxLIrk1FahA
         WiKYw8cBlxQs/+p1TykcLjp1HGiV04Hwo9Lb+A3ZhqBQrm2dB+0faN3Hnli8tJTqxmxm
         t+6nigd+5oC7a92icnbhrowfUvPkmUgDUtn7hxiorhh4d07nEBat4LfV9jKYxT/jYxfh
         nq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685440394; x=1688032394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f1cCBXszeZH11zIMBvJPlg2HDVzddl/X2tcxJo4hA6Q=;
        b=O1ysFqhIa/Jtb1znTKRFoorht273cQVCy3s3GXJuCVmplmSpHJLWnFARrdsdGNmYpg
         k55h9KBn3VEk+DMtpEoBDXHSKyN1OU5oerofZFCjziWqQJd+VO1miVD+EIEWeob0n2j3
         4BgxOeziJGaWusigweZiP3/440uTM93THO6gEB9ACD9hpsN5yoX3JMu/7AXnzGmtAW8/
         Hv2XRV6XjN3qWFjPyuZB0TCvrqXgsh/GFqABIkeLqubsyi3WmIdB1fJE/jiRvwwvVhi8
         0ObuAr44CWxkPqiV8lIWqUrggtBMfJnVBl7WRAV4CB7Od9egBqszftxuJgDMErWrcFEx
         QbpQ==
X-Gm-Message-State: AC+VfDxCXJugl44AaJHII/NBLxwIXjOMaWAH0GMPmXNQu5456iiKiUZx
        OhK4u19XzAyfV+l0lKh4P5M=
X-Google-Smtp-Source: ACHHUZ4QaDA5gTWilwgM3pgeGDvm8s3KobapkkUPTj6aD2j6usLWgg6kdhR/Bypo4Xis9NMhfjzGBw==
X-Received: by 2002:a17:903:1109:b0:1ac:a28e:4b29 with SMTP id n9-20020a170903110900b001aca28e4b29mr1981663plh.26.1685440394483;
        Tue, 30 May 2023 02:53:14 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e454-8dbb-e3a2-cb83-43b1-731b.emome-ip6.hinet.net. [2001:b400:e454:8dbb:e3a2:cb83:43b1:731b])
        by smtp.gmail.com with ESMTPSA id j7-20020a17090276c700b0019c13d032d8sm9832760plt.253.2023.05.30.02.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 02:53:14 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V2 0/3] Add Genesys Logic GL9767 support
Date:   Tue, 30 May 2023 17:53:05 +0800
Message-Id: <20230530095308.8165-1-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Victor Shih <victor.shih@genesyslogic.com.tw>

These patches support for the GL9767 chipset and add support SD3/SD Express
mode for the GL9767.

Changes in v2 (May. 30, 2023)
* rebased to the linux-kernel-v6.4.0-rc1 in Ulf Hansson next branch.
* Add set SDR104's clock to 205MHz and enable SSC for GL9767.
* drop export sdhci_check_ro() function.
* Patch#1: add gl9767_vhs_read() and gl9767_vhs_write().
* Patch#3: use mmc->ops->get_ro() to instead sdhci_check_ro().
           use msleep() to instead mdelay().
           modify the wait time for Power valid to CLKREQ.
           drop unused definitions.

----------------- original cover letter from v1 -----------------
These patches support for the GL9767 chipset and add support SD3/SD Express
mode for the GL9767.

Changes in v1 (May. 12, 2023)
* rebased to the linux-kernel-v6.4.0-rc1 in Ulf Hansson next branch.
* enable MSI interrupt for the GL9767.
* add support SDR mode for the GL9767.
* export sdhci_check_ro() function.
* add support SD Express mode for the GL9767.

Victor Shih (3):
  mmc: sdhci-pci-gli: Add Genesys Logic GL9767 support
  mmc: sdhci-pci-gli: Set SDR104's clock to 205MHz and enable SSC for
    GL9767
  mmc: sdhci-pci-gli: Add support SD Express card for GL9767

 drivers/mmc/host/sdhci-pci-core.c |   1 +
 drivers/mmc/host/sdhci-pci-gli.c  | 398 ++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci.h      |   2 +
 3 files changed, 401 insertions(+)

-- 
2.25.1

