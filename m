Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042C8724224
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236833AbjFFMbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjFFMb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:31:29 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A43E10CA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:31:27 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b026657a6fso52440425ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686054686; x=1688646686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tnSMPv17DxTIc0EApfFv62sMiPCzQPBGurL8DNcMIjg=;
        b=ED5wHJmn8ZLA4iS49IErYUL2x+RV79G+ND9qTHeNJbgfhZx7HbbumKO2Om+e9nia4V
         yLaa3ju2IQyNwjbRagoYWRS8/l4YVdjaaw6ihstAhHGdELxqy6r+TLRL2ywnhZciz3KV
         GnAEUMWUEEL21U3AJweaap5Ejp07h7T8TlbdcFl6CRQX7Wm+mscilpdpQLlPOBqMlPo2
         MriRTlfdFH7X8ZHh1SrhCrNNIG5XlOO7DgaBK4BKLkHnI6MIfD5pNEhzYAvNO3ANhGE6
         DtvXj5S0QGMn1naH/1ZH9yW9pz5Ug+gFXZ/hzfvymwHBZWUwoCGvIUxnaDAe+7MtLYqL
         JSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686054686; x=1688646686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tnSMPv17DxTIc0EApfFv62sMiPCzQPBGurL8DNcMIjg=;
        b=UPorIUpcd/mlUGvwVUBE8KGGYbp2hTNHYxW11OJaerrnvrtXY4hxNfX03WvKChMO+Y
         rYt0cjc6PweFqeS8bs63wfCVLi2ySk/YZ0Z3JlENj0802gd58fYbT+qKgDxyARangH1j
         54AWIdiDU8FKK+UBbSSYDtCgvUMaEOn2HYAujxHeNz/2PvYnDGgQ6IHJKmSTfWkJirtd
         JTA9OXI09LzwIW4jhO3WaeAzO0RDuPlpuPIEdRNAwUEqmkqgdEKoEU44kM2NbT/4OKV8
         yFCEJc679ZOcHVeH0Amx1R2iJ6BLggYUyzGAp0oek2WlyBF2EUkc9++MA3FU9XgQc89F
         9Htg==
X-Gm-Message-State: AC+VfDwHUAxbjNwK+Q3t13Gc/y7RLrs1xjrxtqp6HGFmiZgPXCBe94Ed
        D5XJS+HDPPMDUm1oSL/oziZE
X-Google-Smtp-Source: ACHHUZ5LRdxhkL8Kk+RGl8CqeDCwiNOHqL0Cxwey/pXI4lj1u2B/gUi3CJwfcNE/jc4Z0yeasnVUKw==
X-Received: by 2002:a17:903:22c3:b0:1b0:3df1:c293 with SMTP id y3-20020a17090322c300b001b03df1c293mr2206016plg.45.1686054686649;
        Tue, 06 Jun 2023 05:31:26 -0700 (PDT)
Received: from localhost.localdomain ([117.202.186.178])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902c74500b001ae59169f05sm8446431plq.182.2023.06.06.05.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 05:31:26 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/3] Add MHI Endpoint network driver
Date:   Tue,  6 Jun 2023 18:01:16 +0530
Message-Id: <20230606123119.57499-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds a network driver for the Modem Host Interface (MHI) endpoint
devices that provides network interfaces to the PCIe based Qualcomm endpoint
devices supporting MHI bus (like Modems). This driver allows the MHI endpoint
devices to establish IP communication with the host machines (x86, ARM64) over
MHI bus.

On the host side, the existing mhi_net driver provides the network connectivity
to the host.

- Mani

Manivannan Sadhasivam (3):
  net: Add MHI Endpoint network driver
  MAINTAINERS: Add entry for MHI networking drivers under MHI bus
  net: mhi: Increase the default MTU from 16K to 32K

 MAINTAINERS              |   1 +
 drivers/net/Kconfig      |   9 ++
 drivers/net/Makefile     |   1 +
 drivers/net/mhi_ep_net.c | 331 +++++++++++++++++++++++++++++++++++++++
 drivers/net/mhi_net.c    |   2 +-
 5 files changed, 343 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/mhi_ep_net.c


base-commit: ae91f7e436f8b631c47e244b892ecac62a4d9430
-- 
2.25.1

