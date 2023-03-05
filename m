Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0ED6AADDB
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 03:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjCECVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 21:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCECVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 21:21:30 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E091A13DEF;
        Sat,  4 Mar 2023 18:21:28 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id bx12so5618265wrb.11;
        Sat, 04 Mar 2023 18:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677982887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=osz72ebvHwJlWK48dUx/mcszv5dSaaCPJF4XFB/LD/M=;
        b=G8+Tx1KNt/alq5bRLYJq9EWinDVcay/HYa1lL7bIAyJK4Z6OV08Hc+CStUUCF8stx8
         yfZKTttIuB1yOtriZj7Q6PlgQuMeRBqeGghuMLbS4ZIjFn5ZNWjxmINR0hVCyyUAiLAJ
         BmHiYK6PJyrqPhIIoA+qoVZbr3bVzT9QIZKgIw4fESTqS/8LOq0nHL17ghv1h8ByFLNt
         6TAZthSvcvExHTb4WHxxK7OPvHa9ebeIlHPQpQw2c8zLRfKuIDEt7uijslpO0oGZ6z5R
         WN6taXS8VN9hnKKUpNM8S1nkAEJbAQigP9YBkte3yQmSk7/28aMhaktg6sPaGqIewE8m
         N4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677982887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=osz72ebvHwJlWK48dUx/mcszv5dSaaCPJF4XFB/LD/M=;
        b=CT/k+9WvwyqinGEej8EhIaOdLR4OfkON2eN6eTlTD337kVuwSraw4m1hABJ5XgSQnY
         X008a0Nir6IUgr55NVrr7ee+Nrl2xHj6a8aJT/QH4m+1Kz7mCrMX0xjibqLFITeCC26k
         n0wx+9lyV7W5y8tafC1h4FNvdmTrK/WdJ6jwcDPQtC4u/ZU5uZxJxLEb6pF7ALQNWLHw
         q6iohI+XS0FFz3OxuNQq4R1iPwYFm48Y24Uo8b2gBbklmnQ21cJuaadn+PZhW33mJEir
         3XHhsST4y1XQypsTmHrhwmyBAwxzO4IasG8faN0sae9JluVH/x+w1ZnuUeLAC++mIQRO
         K2lQ==
X-Gm-Message-State: AO0yUKWppBECWGWtYW5xB/fVtt4eRgbXoWBqBDeY//FyVdUZ3twORMix
        aQa6FKkEZGyhCdLn1cRtKAc=
X-Google-Smtp-Source: AK7set8Y17TW0v5cOxSa70J4mh1RK8OWdH4+y+sCOmOEFThBj5KJbmCpDtXn54vhitbnBSav/DwusQ==
X-Received: by 2002:adf:f448:0:b0:2ca:e8c2:6d29 with SMTP id f8-20020adff448000000b002cae8c26d29mr4165132wrp.7.1677982887128;
        Sat, 04 Mar 2023 18:21:27 -0800 (PST)
Received: from xws.localdomain ([217.138.207.232])
        by smtp.gmail.com with ESMTPSA id k4-20020adfd844000000b002c57384dfe0sm6356451wrl.113.2023.03.04.18.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 18:21:26 -0800 (PST)
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
Subject: [PATCH v3 0/4] firmware: Add support for Qualcomm UEFI Secure Application
Date:   Sun,  5 Mar 2023 03:21:15 +0100
Message-Id: <20230305022119.1331495-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.39.2
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

For a more detailed description, see the blurb of v1.

Previous versions:

 - V2: https://lore.kernel.org/lkml/20230127184650.756795-1-luzmaximilian@gmail.com/
 - V1: https://lore.kernel.org/lkml/20220723224949.1089973-1-luzmaximilian@gmail.com/


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


Changes in v3:

 - Fix doc comment in qcom_scm.c
 - Rebase on top of latest changes to qcom_scm.

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
 drivers/firmware/qcom_scm.c                   | 120 ++-
 drivers/firmware/qcom_scm.h                   |  47 --
 include/linux/firmware/qcom/qcom_qseecom.h    | 190 +++++
 include/linux/firmware/qcom/qcom_scm.h        |  49 ++
 10 files changed, 1484 insertions(+), 87 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/firmware/qcom,qseecom.yaml
 create mode 100644 drivers/firmware/qcom_qseecom.c
 create mode 100644 drivers/firmware/qcom_qseecom_uefisecapp.c
 create mode 100644 include/linux/firmware/qcom/qcom_qseecom.h

-- 
2.39.2

