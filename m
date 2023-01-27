Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB83067EDC5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbjA0SrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjA0SrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:47:03 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2738757BE;
        Fri, 27 Jan 2023 10:47:01 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so6017650wmb.2;
        Fri, 27 Jan 2023 10:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LOd4MaOi70eTswd7u4FzE7uVQwcH+9a89ao4D+uNHTk=;
        b=Q0hrfw64vXMJ/FAGMTz9DA9s8596eI+mPllIZK+Fq29tu60izkVAs3mFVfAZUcyHTR
         tqQ0BlyLE1iel0o4ZFFSzIwtxXqnwnwUfGtH8LW+SsmTMwnjuJaQsoX9ibFkrd7+fGVB
         oPfTexW+jdWNqu90AQhvtk2fVCR6ZST4vJbof4CnLyrJ/0btozti/VRdzhKPm+kY6jkB
         mcO0m2islB0OuAMkBsCQjjdAwlaEy2h5cUZbvU1Y5IuSxJok9JPK8HMJXDCREczSgtxp
         oTHNA3w9HBguxoGkm7o2Ebtf52TzO3v1eRoIVKB9/8P4ERAFdyQbOexrF76LMoNmaCVK
         lU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LOd4MaOi70eTswd7u4FzE7uVQwcH+9a89ao4D+uNHTk=;
        b=dWfgKQclSRHikulFD7CMFLJT5li/ufRq3wcGVugioAALTh5she2fg9IomGgfyrNdML
         rc3/SR/r3C+QJfrCrJpAZwXCfUQ11LqFEaDY5y/A5/2GxVkE+TaexsS2HztKffBMBm2L
         zCTApVIT/Zwx7OfjgMA7BozqMSgNrgHA37Dr8AoWs97awXVLu6T6t8ogmHad/hEBZ/Kb
         DVidtKRCJ3FIHSEC8f0SRbR8E6+kc6MNDaUvnt5cqzd80B4PNDbVZ6LRBd94An3JwucQ
         ecDHyz/yLlGZGxRokd9s7SMXhfNKZA1lt1RHLX35RdsIIeGG2Ln4dFngwV3BNWMk3t1l
         8ROQ==
X-Gm-Message-State: AO0yUKUQDsOKgjKAkRFjNCZlpFryesgaPAqT0ncUv+JYC6Q9HRtV+VNg
        YOmDF1J0VzT0LURkoIbYEls=
X-Google-Smtp-Source: AK7set/gEzWkZhyaLRTt2b8FFgXZPieBFRu9D2u4vPEFozdj4nKODUy9Ve+ghxWfozB/47czSvoZFQ==
X-Received: by 2002:a05:600c:3512:b0:3dc:2c7c:6616 with SMTP id h18-20020a05600c351200b003dc2c7c6616mr6348952wmq.21.1674845220107;
        Fri, 27 Jan 2023 10:47:00 -0800 (PST)
Received: from xws.localdomain (pd9ea339c.dip0.t-ipconnect.de. [217.234.51.156])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c310c00b003db012d49b7sm16234208wmo.2.2023.01.27.10.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 10:46:59 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] firmware: Add support for Qualcomm UEFI Secure Application
Date:   Fri, 27 Jan 2023 19:46:46 +0100
Message-Id: <20230127184650.756795-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.39.0
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

This series adds basic support for the QSEECOM interface used to
communicate with secure applications running in the TrustZone on certain
Qualcomm devices. In addition to that, it also provides a driver for
"uefisecapp", the secure application managing access to UEFI variables
on such platforms.

For a more detailed description, see the blurb of v1, which can be found
at https://lore.kernel.org/lkml/20220723224949.1089973-1-luzmaximilian@gmail.com/.


This series depends on the following series:

 - "efi: efivars: drop kobject from efivars_register()"
   (https://lore.kernel.org/lkml/20230117124310.16594-1-johan+linaro@kernel.org/)

 - "efi: verify that variable services are supported"
   (https://lore.kernel.org/lkml/20230119164255.28091-1-johan+linaro@kernel.org/)

   with subsequent fix

   "efivarfs: fix NULL-deref on mount when no efivars"
   (https://lore.kernel.org/lkml/20230126112129.4602-1-johan+linaro@kernel.org/)

which have all been included in the "next" branch of

  https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git


Changes in v2:

 - Bind the qseecom interface to a device.

 - Establish a device link between the new qseecom device and the SCM
   device to ensure proper PM and remove ordering.

 - Remove the compatible for uefisecapp. Instead, introduce a compatible
   for the qseecom device. This directly reflects ACPI tables and the
   QCOM0476 device described therein, which is responsible for the
   secure app / qseecom interface (i.e., the same purpose).

   Client devices representing apps handled by the kernel (such as
   uefisecapp) are now directly instantiated by the qseecom driver,
   based on the respective platform-specific compatible.

 - Rename the base name (qctree -> qseecom) to allow differentiation
   between old (qseecom) and new (smcinvoke) interfaces to the trusted
   execution environment. This directly reflects downstream naming by
   Qualcomm.


Maximilian Luz (4):
  firmware: qcom_scm: Export SCM call functions
  firmware: Add support for Qualcomm Secure Execution Environment SCM
    interface
  dt-bindings: firmware: Add Qualcomm QSEECOM interface
  firmware: Add support for Qualcomm UEFI Secure Application

 .../bindings/firmware/qcom,qseecom.yaml       |  49 ++
 MAINTAINERS                                   |  14 +
 drivers/firmware/Kconfig                      |  31 +
 drivers/firmware/Makefile                     |   2 +
 drivers/firmware/qcom_qseecom.c               | 323 ++++++++
 drivers/firmware/qcom_qseecom_uefisecapp.c    | 746 ++++++++++++++++++
 drivers/firmware/qcom_scm.c                   | 118 ++-
 drivers/firmware/qcom_scm.h                   |  47 --
 include/linux/qcom_qseecom.h                  | 190 +++++
 include/linux/qcom_scm.h                      |  49 ++
 10 files changed, 1483 insertions(+), 86 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/firmware/qcom,qseecom.yaml
 create mode 100644 drivers/firmware/qcom_qseecom.c
 create mode 100644 drivers/firmware/qcom_qseecom_uefisecapp.c
 create mode 100644 include/linux/qcom_qseecom.h

-- 
2.39.0

