Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516B261501E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiKARLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiKARKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:10:44 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EDE120B9;
        Tue,  1 Nov 2022 10:10:39 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A1HAM0E069054;
        Tue, 1 Nov 2022 12:10:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667322622;
        bh=FbzwNulMhStZkBpt09FcqI/Q3vAIkqWjr6dbqa2DZd4=;
        h=From:To:CC:Subject:Date;
        b=q2wFVi8gtWesrqBBzX3sA9mQ0sLJ7BKzt4CBXR1GeqV1f/hnlsQtnt2HuT70kLkKc
         Sit7Jacwxl9PDSbchX8fQ+ADbgtHrr3Zl4tXLr0XYxtFghky9f6traU6XV5+NPWaTD
         VTl+uBdrki47J0bZuJkmQAFRu597E7vXNbL6Pkf0=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A1HAMrT017055
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Nov 2022 12:10:22 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 1 Nov
 2022 12:10:22 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 1 Nov 2022 12:10:22 -0500
Received: from maitri.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A1HAMwA106008;
        Tue, 1 Nov 2022 12:10:22 -0500
From:   Vibhore Vardhan <vibhore@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: cpufreq: ti-cpufreq: Enable AM625 CPUFreq
Date:   Tue, 1 Nov 2022 12:10:17 -0500
Message-ID: <20221101171022.133322-1-vibhore@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This series enables CPUFreq for AM625. This version is a fixup and 
rebase of the patch series by Dave Gerlach on v6.1-rc3 [1].

It updates the ti-cpufreq driver to support parsing of the speed grade
value out of the JTAG_USER_ID register and adds necessary support code
to use cpufreq-dt.

The operating-points table that gets added support 200,400,600,800 for
all variants and then 1GHz for the S Speed grade only and 1.25 for the T
Speed grade only. 1.4GHz has been added in board specific dts file as it
requires VDD_CORE to be at 0.85V.

The latency between pre and post frequency transition was measured in
CPUFreq driver for all combinations of OPP changes. The average value
was selected as overall clock-latency.

Tested on am62-sk board using manual frequency changes and then reading 
back frequency with k3conf, and this shows matching frequency to what 
was set.

This should not impact existing K3 platforms that do not have operating
points table defined.

Regards,
Vibhore

[1] https://github.com/dgerlach/linux-pm/tree/v5.18/am62x-cpufreq

Dave Gerlach (4):
  cpufreq: ti-cpufreq: Add support for AM625
  cpufreq: dt-platdev: Blacklist ti,am625 SoC
  arm64: dts: ti: k3-am625: Introduce operating-points table
  cpufreq: ti: Enable ti-cpufreq for ARCH_K3

Vibhore Vardhan (1):
  arm64: dts: ti: k3-am625-sk: Add 1.4GHz OPP

 arch/arm64/boot/dts/ti/k3-am625-sk.dts |  9 +++++
 arch/arm64/boot/dts/ti/k3-am625.dtsi   | 51 ++++++++++++++++++++++++++
 drivers/cpufreq/Kconfig.arm            |  4 +-
 drivers/cpufreq/cpufreq-dt-platdev.c   |  1 +
 drivers/cpufreq/ti-cpufreq.c           | 36 ++++++++++++++++++
 5 files changed, 99 insertions(+), 2 deletions(-)

-- 
2.34.1

