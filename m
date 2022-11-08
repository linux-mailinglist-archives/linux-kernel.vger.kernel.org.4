Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB78362188D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbiKHPlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbiKHPlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:41:03 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC78D5C74A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 07:41:00 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5so9080809wmo.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 07:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dtMFSLGIMNeVTZxLCqkj7tWGtF0CJEz5WaekwP9dego=;
        b=NjnfutBKN3dagOdJZ04/4o6UvHmx7gCBH4fD5QajTuq9HLnGT8gsyYgeufHeOQhRfQ
         c3UDrrJanI7iDjSyOtOIN2OX+0pTdLqzyyyUwVnQodK1EvF3WmuXbGrOQgGTDmxUxujP
         ZS6ksVzKgmFsGUzrds/lR9X00QQjyUvQWP+ysiY8E6wMQeOIe79pAbGVrQRn6mMiOQAj
         sVsZAbuBhM+gWczD3LQHhGJ+aNXaE2JJADY5jCRC67HB6D9efRyJGfy7Uw/4QKELpJzW
         nBQ7hc+I4DytKZqFLAf2+on9jkiDg3EAnNu3Y6FYyy/P2sIgbtqTUD8iq3jrnpNi3BSs
         FlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dtMFSLGIMNeVTZxLCqkj7tWGtF0CJEz5WaekwP9dego=;
        b=lE/zf9HZx40rCQcAcQpDJ5En9906WeEfxYB/O8gkqMYGsiRwwoN8zEX33IhM5s4a+g
         wOjubdNWv5a0PHMEW5LwDfujYDYIwI4LeAHfNnAdxIxCEiASHUnK8FrNDDfkI67y42g1
         K+7tt/MFeBEOrJNf/un+8Tw19VrDFLRchwiUy23XQfam+B3ux+F87geYmYWABcQ83hEq
         NeqzrzHUz3uI7S9RzT3NfCkc22Sl+fTYx7PImdgx+KDz7v+I3weKWxO8Peb7+fe7Ko+t
         c/bkipyIvM7iEl8BlmIwKtxqAPgMmw08PZ+wKC175lhwwGwPCQxs0I/3ShsK+LZ1QSyI
         +3Rw==
X-Gm-Message-State: ACrzQf1DaVHcK0hghxPyBHUrJmW3tLSyg8RhM9GJ2YhzqhS5ISMLfqV2
        eGiFjquhIQ1wOvjbA10Mls43
X-Google-Smtp-Source: AMsMyM6SWVW4hweJvSHlGAIvASyg36sxqkTSS6y/q5ALexhcDDH5J0V0eJOICvasXwcjz8F1weG6GA==
X-Received: by 2002:a05:600c:2150:b0:3cf:6c05:b4ab with SMTP id v16-20020a05600c215000b003cf6c05b4abmr35259174wml.161.1667922059445;
        Tue, 08 Nov 2022 07:40:59 -0800 (PST)
Received: from localhost.localdomain ([117.207.25.46])
        by smtp.gmail.com with ESMTPSA id e4-20020adff344000000b002364c77bc96sm10906899wrp.33.2022.11.08.07.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 07:40:58 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org
Cc:     johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 0/3] qcom-cpufreq-hw: Add CPU clock provider support
Date:   Tue,  8 Nov 2022 21:10:34 +0530
Message-Id: <20221108154037.111794-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds clock provider support to the Qcom CPUFreq driver for
supplying the clocks to the CPU cores in Qcom SoCs.

The Qualcomm platforms making use of CPUFreq HW Engine (EPSS/OSM) supply
clocks to the CPU cores. But this is not represented clearly in devicetree.
There is no clock coming out of the CPUFreq HW node to the CPU. This created
an issue [1] with the OPP core when a recent enhancement series was submitted.
Eventhough the issue got fixed in the OPP framework in the meantime, that's
not a proper solution and this series aims to fix it properly.

There was also an attempt made by Viresh [2] to fix the issue by moving the
clocks supplied to the CPUFreq HW node to the CPU. But that was not accepted
since those clocks belong to the CPUFreq HW node only.

The proposal here is to add clock provider support to the Qcom CPUFreq HW
driver to supply clocks to the CPUs that comes out of the EPSS/OSM block.
This correctly reflects the hardware implementation.

The clock provider is a simple one that just provides the frequency of the
clocks supplied to each frequency domain in the SoC using .recalc_rate()
callback. The frequency supplied by the driver will be the actual frequency
that comes out of the EPSS/OSM block after the DCVS operation. This frequency
is not same as what the CPUFreq framework has set but it is the one that gets
supplied to the CPUs after throttling by LMh.

This series has been tested on SM8450 based dev board with the OPP hack removed
and hence there is a DTS change only for that platform. Once this series gets
accepted, rest of the platform DTS can also be modified and finally the hack on
the OPP core can be dropped.

Thanks,
Mani

[1] https://lore.kernel.org/lkml/YsxSkswzsqgMOc0l@hovoldconsulting.com/
[2] https://lore.kernel.org/lkml/20220801054255.GA12039@thinkpad/t/

Changes in v5:

* Switched to Hz unit for the CPU clocks

Changes in v4:

* Rebased on top of cpufreq/arm/linux-next branch

Changes in v3:

* Submitted the cpufreq driver cleanup patches as a separate series as
  suggested by Viresh
* Removed static keyword from clk_init_data declaration

Changes in v2:

* Moved the qcom_cpufreq_data allocation to probe
* Added single clock provider with multiple clks for each freq domain
* Moved soc_data to qcom_cpufreq struct
* Added Rob's review for binding

Manivannan Sadhasivam (3):
  dt-bindings: cpufreq: cpufreq-qcom-hw: Add cpufreq clock provider
  arm64: dts: qcom: sm8450: Supply clock from cpufreq node to CPUs
  cpufreq: qcom-hw: Add CPU clock provider support

 .../bindings/cpufreq/cpufreq-qcom-hw.yaml     | 12 ++++++
 arch/arm64/boot/dts/qcom/sm8450.dtsi          |  9 ++++
 drivers/cpufreq/qcom-cpufreq-hw.c             | 43 +++++++++++++++++++
 3 files changed, 64 insertions(+)

-- 
2.25.1

