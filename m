Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E515F80BE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 00:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiJGWXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 18:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiJGWXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 18:23:16 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA17FD01A6
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 15:23:14 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id t4so3647111wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 15:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MImtf0Wf4m+QCdLQViE/JC/7ATAAtbSE1jIuWWLnJvA=;
        b=EkmsnPinOHoAe1msnfPZIqppKVi9NZfAp14tWuESUEWdySA7FzW5P/Lx7qmFQc5xoT
         tIKmNTq6cmITRsdnhWIdolKS/+mmCrIMH1Aisj0SVlIvqptcAnQ+WsiTrKqWlI6LGhIV
         Tc46U5KQE4FgKgp9V94Y4A9sSU9QoVvPDUqbkZnrS98Qvz6+LJIkucRiHUX+ojVUTUB+
         1i9RXsjYBZc+1bSKss029x+0cBASDUBc09UNd0Sasm4ix6ScqlDlk98SOUHk/OT6VRmz
         r4tEwMbLwO/NjKoOWpsj+p4kAeDQIXdnOhao/zrS3U8OoV9fqbVLz7eyb2zBy1cHie5y
         joYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MImtf0Wf4m+QCdLQViE/JC/7ATAAtbSE1jIuWWLnJvA=;
        b=q0MhLisswx6dPTD15iSne96V9SyYJLOVZpEh9S8z+WePpxdK+OoSx/GaPGHr8O0aEY
         bsllREDfRN3kE2F11/C4IH7pRaG3g1KfuGlMlplpKIldtMv7zg+O4ljv+TSci1W3Xdvk
         kvRBmJe8f30RU68I9iuBhl65KG8IEl2Izw+1FNyuldHxlHxJu9DMF0n1s2ruZI7K0e++
         jxxxmbSJ6ofk4kB05lQhaSMiBLGW8fLTxJPhOke+ShKygkW+qRgoJSGmgXNyF/h8HUqN
         CGGdPZNJFwi9jGNHHOLA0xxucUxay3+QGw+o6Jh4WDuGQ5+mG1FZLbv1JDS7TbVS5cSC
         tCvw==
X-Gm-Message-State: ACrzQf31mBtU9bpFGB6G85OA9r0XTY0tWveVbyVBinDUlmMgDFHRxuff
        +EiwG3kIUIfiKnOa9w/5zsYgUQ==
X-Google-Smtp-Source: AMsMyM5biB58MjjwoI54Sm9NJ1aowLkAk7UBf2LQFmWAjoz9bJsxy3V8abHtA4Ks8YUspX2Axq9hPg==
X-Received: by 2002:a05:600c:1d23:b0:3c0:7701:8a54 with SMTP id l35-20020a05600c1d2300b003c077018a54mr9273178wms.84.1665181393349;
        Fri, 07 Oct 2022 15:23:13 -0700 (PDT)
Received: from localhost.localdomain (cpc76482-cwma10-2-0-cust629.7-3.cable.virginm.net. [86.14.22.118])
        by smtp.gmail.com with ESMTPSA id d5-20020a05600c34c500b003c409244bb0sm1115777wmq.6.2022.10.07.15.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 15:23:12 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        phone-devel@vger.kernel.org,
        Caleb Connolly <caleb.connolly@linaro.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v5 0/2] power: supply: introduce support for the Qualcomm smb2 charger
Date:   Fri,  7 Oct 2022 23:22:01 +0100
Message-Id: <20221007222205.126190-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the Qualcomm PMI8998/PM660 Switch-Mode Battery Charger.
This is the second generation SMB charger, and replaces the previous
SMBB hardware found in older PMICs.

This driver provides basic support for initialising the hardware,
configuring the USB input current limit and reporting information about
the state of the charger. Features like type-c dual role support and OTG
switching will be added in future patches.

This patch series depends on my previous series adding support for
the Round Robin ADC which is used for reading the USB voltage and
current, it is currently queued in linux-next, and can be found here:
https://lore.kernel.org/linux-arm-msm/20220429220904.137297-1-caleb.connolly@linaro.org/
This has now been merged

Changes since v4:
 * Fix typo when setting FAST_CHARGE_CURRENT_CFG - the OnePlus 6 now charges
   properly!
 * Limited charge current to 1A until we better understand the thermal
   protection features and how to use them.
 * Address Sebastian's comments (thanks for your patience with this)
 * re-run clang-format

Changes since v3:
 * Drop DTS patches, to be sent in a future series
 * Add POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT so that the charger will
   be exposed as a cooling device,
   see https://lore.kernel.org/linux-pm/164f2458-fb66-f238-7143-bdbe1e200870@linaro.org
 * Run clang-format and prevent it from breaking the formatting of the
   defines
 * Apply Sebastian's suggested fixes

Changes since v2:
 * Use devm_delayed_work_autocancel
 * Minor driver fixes
 * Pick up Krzysztof's R-b on the DT patch

Changes since v1:
 * Rename the driver to pmi8998_charger
 * Drop unnecessary (and very broken) mutex
 * Rework the driver based on feedback to v1
 * Fix some minor bugs and improve Automatic Input Current Limit support

Caleb Connolly (2):
  power: supply: add Qualcomm PMI8998 SMB2 Charger driver
  dt-bindings: power: supply: qcom,pmi8998-charger: add bindings for
    smb2 driver

 .../power/supply/qcom,pmi8998-charger.yaml    |   82 ++
 drivers/power/supply/Kconfig                  |   16 +
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/qcom_pmi8998_charger.c   | 1040 +++++++++++++++++
 4 files changed, 1139 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
 create mode 100644 drivers/power/supply/qcom_pmi8998_charger.c

-- 
2.38.0

