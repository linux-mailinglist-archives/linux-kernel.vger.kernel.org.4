Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367766451B7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 03:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiLGCFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 21:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLGCFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 21:05:24 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547B840474;
        Tue,  6 Dec 2022 18:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1670378723; x=1701914723;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5gvLHz9/RmuCHyZaZr4kvK5GKQwiKL9wboByT6H5TWI=;
  b=Bs2gUsTIgqzVSpuh+Rf7mhYT/aLA1W7h0wgRU8s/lXDka2putKWN8SW8
   ea8zicre4VddirgWO9RT+/c3Mntfsf9iFZimAkMwiYWpqK/l/Jirvxl3B
   059b851QpxiGqxD6PyF3YQE5jK/kR2kyczDZnbs7ZiuNDXKisg3zRKJND
   M=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Dec 2022 18:05:22 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 18:05:22 -0800
Received: from hu-collinsd-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 6 Dec 2022 18:05:22 -0800
From:   David Collins <quic_collinsd@quicinc.com>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     David Collins <quic_collinsd@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/3] thermal: qcom-spmi-temp-alarm: add support for new TEMP_ALARM subtypes
Date:   Tue, 6 Dec 2022 18:04:43 -0800
Message-ID: <cover.1670375556.git.quic_collinsd@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support in the qcom-spmi-temp-alarm driver for the new PMIC
TEMP_ALARM peripheral subtypes: GEN2 rev 2 and LITE.  The GEN2 rev 2
subtype provides greater flexibility in temperature threshold
specification by using an independent register value to configure
each of the three thresholds.  The LITE subtype utilizes a simplified
set of control registers to configure two thresholds: warning and
shutdown.

Also add support to avoid a potential issue on certain versions of
the TEMP_ALARM GEN2 subtype when automatic stage 2 partial shutdown
is disabled.

Changes since v1 [1]:
* Updated the thermal API usage in the patches to work with the recent commit
  ca1b9a9eb3fd ("thermal/drivers/qcom: Switch to new of API")

[1]: https://lore.kernel.org/lkml/cover.1663282895.git.quic_collinsd@quicinc.com/

David Collins (3):
  thermal: qcom-spmi-temp-alarm: enable stage 2 shutdown when required
  thermal: qcom-spmi-temp-alarm: add support for GEN2 rev 2 PMIC
    peripherals
  thermal: qcom-spmi-temp-alarm: add support for LITE PMIC peripherals

 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 406 +++++++++++++++++++-
 1 file changed, 391 insertions(+), 15 deletions(-)

-- 
2.25.1

