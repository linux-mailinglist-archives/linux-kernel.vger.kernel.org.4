Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09815B56A5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiILIvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiILIvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:51:08 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209422B255
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:51:04 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id b21so7925371plz.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=/UeNpP+VC97GxtM/tp6ip0ihWytOFO+8NfMTiiZb64A=;
        b=Tk2ZeLrKXwzkwyP2gg/3iL/biwqdAmBEtphjyT6uO6r63r19dU2BGwwnqRfoxF46wk
         wgDK0HlRY1LYsPaHrVcBxLZ9wG07D78g2CrMCLX6QvgJ3nXDqXGR6q68U0uov3lpzkbW
         bhlec8jh+BMtVOwvN9cBG5oZ+6bCrVZSjh0FqfJBuAQoXFpdxM2QBmCOozaZBka6uc8/
         6VwN8sWSz0n4R/TQZii3awQ9itFtyGUiGSa06QGjbDJW0RDrV4uBPT5eEGC/noMPYcsR
         ZZ88nGS8NU3vmBnwgyIZ/gnhNltoBswVTMhJ/o3PI01yL+rcEmA/nN/j0mLybKNSejNV
         60lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=/UeNpP+VC97GxtM/tp6ip0ihWytOFO+8NfMTiiZb64A=;
        b=LGi06xWTzV9OgMH90KXbsU6r41xlx52CapsTbqgE/rdRJLt+ZljUlNBq3YdCUU9Tvr
         kCS4MIAhO5unItESp0nw1KZJEostrA6YB9UXPi60vjj2OL5+W9YRmwdBH7gIVALvJ/6/
         Zzv22xpqbKx/xJaai7NndcstItwjQSIn6Xzj+8v2oObWKVrlB7P/kwQxjYQ6Zin4UjMI
         Dy0UJd7wyDv2nuyCUvGUKe2PZNg45GBobSrkvq6k7BEQdl89W8aW51BzTkS6qFlc012k
         cIFhfdbMkugZVYdcUiazD8K3GxjIfoNlZOezJbhchYuzxCESTInj7Wl6SJ8+3jFYe3Pm
         05uQ==
X-Gm-Message-State: ACgBeo3e1hNvcgmlo+sQ3dsXABclPwDfDnK1wjxc0Uo2gvpjIjwtiDGq
        c5Wky2YYGQKiMIDUSQPQb/FstM9aiOoNtg==
X-Google-Smtp-Source: AA6agR43dq9ilseW2ZLnOobj5xvkN3BRzRdVtKpqcF2vjeJLYTZspljXXlvcwBWS7skmTT0WCOmnCg==
X-Received: by 2002:a17:902:bc44:b0:176:909f:f636 with SMTP id t4-20020a170902bc4400b00176909ff636mr25363438plz.21.1662972663290;
        Mon, 12 Sep 2022 01:51:03 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:5362:9d7f:2354:1d0a:78e3])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902f54d00b00172897952a0sm5326699plf.283.2022.09.12.01.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 01:51:03 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, robh@kernel.org, andersson@kernel.org,
        rafael@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com
Subject: [PATCH 0/4] thermal: Introduce Qualcomm Cooling Driver suppport
Date:   Mon, 12 Sep 2022 14:20:45 +0530
Message-Id: <20220912085049.3517140-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces the Qualcomm Cooling Driver (aka Qualcomm Thermal
Mitigation Driver) and the related support code (dt-binding, MAINTAINER
file etc).

Several Qualcomm Snapdragon SoCs have Thermal Mitigation Devices (TMDs)
present on various remote subsystem(s) (for e.g. the Compute DSP, aka cDSP),
which can be used for several mitigations for remote subsystem(s), including
remote processor mitigation, rail voltage restriction etc. 

Here we introduce the Qualcomm Cooling Driver which is based on the
kernel thermal driver framework and also employs the kernel QMI interface
to send the message to remote subsystem(s).

At the very top-level, the dts is supposed to describe a TMD node, which
should further represent the remote subsystem(s) present on the SoC and
further each child of a subsystem should represent the separate cooling devices
available on the remote subsystem.

Note that this patchset is targeted for the 'linux-pm' tree and the dts
patchset/changes targeted for 'linux-arm-msm' tree will be sent as a
separate patchset.

This patchset is based on the CONFIG_QCOM_THERMAL related fix sent via
[1]. Otherwise the latest changes from 'linux-next/master' are used to
rebase the patchset.

[1]. https://lore.kernel.org/all/CAA8EJpoM5nW=pVJB4zy4Jh9Q3gE4KOju2QVy_WtmUokKMyXtuw@mail.gmail.com/T/#m4e2b765e68e3123b3c0e28c806409dae4b988432

Cc: andersson@kernel.org
Cc: robh@kernel.org
Cc: daniel.lezcano@linaro.org
Cc: rafael@kernel.org

Bhupesh Sharma (4):
  thermal: qcom: qmi_cooling: Add skeletal qmi cooling driver
  thermal: qcom: Add Kconfig entry & compilation support for qmi cooling
    driver
  dt-bindings: thermal: Add qcom,qmi-tmd-device and qcom,tmd-device yaml
    bindings
  MAINTAINERS: Add entry for Qualcomm Cooling Driver

 .../bindings/thermal/qcom,qmi-tmd-device.yaml |  78 +++
 .../bindings/thermal/qcom,tmd-device.yaml     | 122 ++++
 MAINTAINERS                                   |  10 +
 drivers/thermal/qcom/Kconfig                  |   4 +
 drivers/thermal/qcom/Makefile                 |   2 +
 drivers/thermal/qcom/qmi_cooling/Kconfig      |  14 +
 drivers/thermal/qcom/qmi_cooling/Makefile     |   3 +
 .../qcom/qmi_cooling/qcom_qmi_cooling.c       | 632 ++++++++++++++++++
 .../qcom/qmi_cooling/qcom_tmd_services.c      | 352 ++++++++++
 .../qcom/qmi_cooling/qcom_tmd_services.h      | 120 ++++
 include/dt-bindings/thermal/qcom,tmd.h        |  14 +
 11 files changed, 1351 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom,qmi-tmd-device.yaml
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom,tmd-device.yaml
 create mode 100644 drivers/thermal/qcom/qmi_cooling/Kconfig
 create mode 100644 drivers/thermal/qcom/qmi_cooling/Makefile
 create mode 100644 drivers/thermal/qcom/qmi_cooling/qcom_qmi_cooling.c
 create mode 100644 drivers/thermal/qcom/qmi_cooling/qcom_tmd_services.c
 create mode 100644 drivers/thermal/qcom/qmi_cooling/qcom_tmd_services.h
 create mode 100644 include/dt-bindings/thermal/qcom,tmd.h

-- 
2.37.1

