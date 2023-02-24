Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7D56A2297
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 20:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjBXT6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 14:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjBXT6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 14:58:02 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DDF5DCC4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 11:58:01 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536cad819c7so5878857b3.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 11:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677268680;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p3M/U/RdbIKj9BRgWDZd3ub2xYwsuU8WGv3/rWkYSus=;
        b=eV22FgQY4o1TSX4cv+YeD6o76tNMkWk142BEeFVgpk4xF9u+7stqQA3Sl9FCfsQKee
         PwcyeHd4nbwK8yt2juTWJPeXWO1UQM5vrI85Ze8J/m11gIiGW1q4f0O+CYBbyMJm/kRV
         eyfo6/nu6IBGt9n2SQdIhuZik4w++NofHsebKLN/5MtNpusK2O77g82R1uvfnVcs6rTO
         X3vuq9gdXxOIynyuVLrFALUvBW7PjyG2rbQiyxAEjH2CNSd+Tbj5gok30D6J3SJOWjdT
         MKtbGoK/M7hkxlwO6SqpSsmgcR1aPwvMak0Oc1mXK5qyQLTj5nm7MXZD7FuJuPjwogwb
         /GXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677268680;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p3M/U/RdbIKj9BRgWDZd3ub2xYwsuU8WGv3/rWkYSus=;
        b=171UvGwjkWPCt2RlUw9p5PhWYtJJob/gF3JW6tFXQIWR0EL254rQLV29x6KetjY43d
         8l3uz4sSh1J3u6LmcngfipulXNsyNAicrLXGJWuEpoZKpCeAdZEWwtFXFa/GrBbWJWm2
         tW1Rg5GHATh5EOwCamOmMq5mVPY71gzsh0gQMl5eb2nb+Zg1poxIGN5BcrIRZMQV+EWj
         sXPhtzx4jkCM32AO6OLAYtZAsHg/PIUBncQ/Y5cxXBg7dZmuIzAYWeto/kPnyoBQWcEw
         uFUMRnojMFX7YHQwIvIPqDyMujGM3mCKSNwmN0qhSsO9vx9x1L1j8DV/z73zPFFVNlAe
         2CtA==
X-Gm-Message-State: AO0yUKVZTyi4OrAHcdR2SZziAsD7dKJMIoApFoYZXTGnA5l244R5+JlA
        kxh2mn8YUfN5ZqfCJ3/ikU1FvSaDWcI=
X-Google-Smtp-Source: AK7set8wMrOqDfT7CZP+3w1w3JB04DQEg+TLIn3ovFUbTFv2EDk6St0AtACcJNEYP2Xs81UYpoyOMbQ6C/Q=
X-Received: from sdalvi-android.chi.corp.google.com ([2620:15c:2:a:1808:5921:faf8:7a68])
 (user=sdalvi job=sendgmr) by 2002:a05:6902:1003:b0:9f5:af6b:6f69 with SMTP id
 w3-20020a056902100300b009f5af6b6f69mr699242ybt.5.1677268680297; Fri, 24 Feb
 2023 11:58:00 -0800 (PST)
Date:   Fri, 24 Feb 2023 13:57:45 -0600
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230224195749.818282-1-sdalvi@google.com>
Subject: [PATCH v1 0/2] Skip waiting for link up during probe
From:   Sajid Dalvi <sdalvi@google.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=" <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Sajid Dalvi <sdalvi@google.com>, kernel-team@android.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the Root Complex is probed, the default behavior is to spin in a loop
waiting for the link to come up. In some systems the link is not brought up
during probe, but later in the context of an end-point turning on. This
patch adds a device tree property to the Synopsis designware root
controller to skip this loop.

Sajid Dalvi (2):
  dt-bindings: PCI: dwc: Add snps,skip-wait-link-up
  PCI: dwc: Skip waiting for link up on probe

 Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 8 ++++++++
 drivers/pci/controller/dwc/pcie-designware-host.c       | 5 +++--
 2 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.39.2.637.g21b0678d19-goog

