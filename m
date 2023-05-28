Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4721F714127
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 01:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjE1XED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 19:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjE1XEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 19:04:01 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A75B9;
        Sun, 28 May 2023 16:04:00 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f6e72a1464so17672825e9.1;
        Sun, 28 May 2023 16:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685315038; x=1687907038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gR3pYGfPVyH0hYUnnYCKUh5S0BZMqF3OzYZgsuhOxOU=;
        b=AjhoWOpA1bkRnms5HkmxtaS40ifIOE4uBO2a0sraqFZZEbEDuiBZJPlkZyqLoX1KcJ
         XCMu0aJUute9Cr5O8F1qZ6P3e8WQZUEhFebcs4u8zeoqtGGaEgU6CTARv/QTXJqJFucl
         2woPmAq7dnMNAFfINzWGOhkm9xR8ku+rbNmX2AJUYT6Qp4W6CbIe4fj7rFhKUrntSUoG
         pkh/yZ04tFn+zjUq+HybpmyzReEz2Rbnctp6nyZFusvR7QgjSjUo8SVBEQy/j3Hccjjb
         OPWoiA8aQ5y7KoCcXQIwUeUbWJhXyBbwZ8fNtoGgawX6wmRfgXQ4Pu/3SP8fCikgn5EW
         IeOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685315038; x=1687907038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gR3pYGfPVyH0hYUnnYCKUh5S0BZMqF3OzYZgsuhOxOU=;
        b=ObOtt812cT/9WcM/GP0KghZP5/KcWhRkHjSbhQnGAxO1KUdaze7amGQYVLpm3aeT2e
         3CCMJwgYbGm8WdyAIQtKDMVaCK0eLqCJ6m9lyXFBmt5+RRCHgxVr9PAhTrtRtTJwz4Lg
         Xo2o+gyynwSxNRRjHejs0uH5VviBl7nt6TAU0011I2FHnH8pEdlyXRcRNzqrXEH+GEmc
         UX2bTzGLnjIPQRRR9U9PgcReMg867JwYJVgVHaJLLuaL11KAuJl9Fk4279u3HAJIih+g
         qRPQc7OB70yA/oNIYdfhIUxU0AK5C0iw+Y12bNSyXcC7c/TB1LamMVo3NbAxnkEUN/ii
         BJjQ==
X-Gm-Message-State: AC+VfDxrQvGkpfZYj6RTiuwNNOEa2XQZU6qdbIoWYN2rsQqnLFwnLgx2
        E3Aa+BBD8fYu9F1WwBoiStg=
X-Google-Smtp-Source: ACHHUZ7qUpMLI136ZMjAZH38OlQMamAr4RnW+3SUcXa1X8NFKYq8cG2/YtK3MoOS1pm2e3AtPnr25A==
X-Received: by 2002:a1c:e901:0:b0:3f6:148f:5867 with SMTP id q1-20020a1ce901000000b003f6148f5867mr6920229wmc.4.1685315038344;
        Sun, 28 May 2023 16:03:58 -0700 (PDT)
Received: from xws.localdomain (pd9ea3c90.dip0.t-ipconnect.de. [217.234.60.144])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c22d800b003f4e47c6504sm15995411wmg.21.2023.05.28.16.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 16:03:57 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Johan Hovold <johan@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] firmware: Add support for Qualcomm UEFI Secure Application
Date:   Mon, 29 May 2023 01:03:47 +0200
Message-Id: <20230528230351.168210-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.40.1
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

This series adds basic support for the QSEECOM interface used to
communicate with secure applications running in the TrustZone on certain
Qualcomm devices. In addition to that, it also provides a driver for
"uefisecapp", the secure application managing access to UEFI variables
on such platforms.

For a more detailed description, see the blurb of v1.

Previous versions:

 - V3: https://lore.kernel.org/lkml/20230305022119.1331495-4-luzmaximilian@gmail.com/t/
 - V2: https://lore.kernel.org/lkml/20230127184650.756795-1-luzmaximilian@gmail.com/
 - V1: https://lore.kernel.org/lkml/20220723224949.1089973-1-luzmaximilian@gmail.com/

Patch 4 of this series depends on commit d86ff3333cb1 ("efivarfs: expose
used and total size") from the "next" branch of

 https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git 

Changes in v4:

 - Integrate the QSEECOM interface into qcom_scm.c instead of
   instantiating a custom device and requiring device-tree bindings for
   it. With that, drop the respective patches exporting SCM call
   functions from qcom_scm.c and the DT bindings.

 - Restructure management of DMA memory and move DMA mapping entirely
   into the app_send() command, removing the need for DMA handling in
   app client drivers.

 - Add support for EFI's query_variable_info() call.

 - Move UCS-2 string helpers to lib/ucs2_string.c (introduces patch 1).

 - Add fix for related cleanup-issue in qcom_scm.c (introduces patch 2).

 (Refer to individual patches for more details.)

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
  lib/ucs2_string: Add UCS-2 strlcpy function
  firmware: qcom_scm: Clear scm pointer on probe failure
  firmware: qcom_scm: Add support for Qualcomm Secure Execution
    Environment SCM interface
  firmware: Add support for Qualcomm UEFI Secure Application

 MAINTAINERS                                |   6 +
 drivers/firmware/Kconfig                   |  33 +
 drivers/firmware/Makefile                  |   1 +
 drivers/firmware/qcom_qseecom_uefisecapp.c | 885 +++++++++++++++++++++
 drivers/firmware/qcom_scm.c                | 419 +++++++++-
 include/linux/firmware/qcom/qcom_scm.h     |  27 +
 include/linux/ucs2_string.h                |   1 +
 lib/ucs2_string.c                          |  16 +
 8 files changed, 1387 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/qcom_qseecom_uefisecapp.c

-- 
2.40.1

