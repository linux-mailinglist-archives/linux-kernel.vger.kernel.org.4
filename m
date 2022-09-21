Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E815BFF35
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 15:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiIUNvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 09:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiIUNvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 09:51:03 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C30980E97;
        Wed, 21 Sep 2022 06:51:01 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28LAdCd3018914;
        Wed, 21 Sep 2022 15:50:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=hFXadpIrKGD7WEM+4GHRXOPvu2WIWu7PVfsSYP5VwQA=;
 b=Kc/i2TopvK8sHRP5Bs9yECm1TArh6Qem5izSkilncux2qshLSphdRciQMss5birT+NQS
 8i6x9p33mXm9K8+ayFUUoLzLnAq7aHMk64NDqpV90df3Ex+aN+8I/DcOIqrapmNuWv5g
 LN0JmkOf0Zg7HDSXUIHeYvxZ4uQnf9xGginjgQNRbD80GtoJyMh9dGdfBy/njkZSIQcn
 SlX5LSv70h7CNoGB2ucw2eruPcYmD8FXwYosR/WTNuj7esSJd2UmGdF5z/P3CnP/2dKL
 Tnq5b/qGy7l9Pl2sSsV+5IIbZfc7IIJk3iVMLTT6Auc/aSiY3NGenzzLLL2HrhjCEdfq ZA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jr11x11u5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Sep 2022 15:50:49 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0AEF410002A;
        Wed, 21 Sep 2022 15:50:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7D2222278AF;
        Wed, 21 Sep 2022 15:50:47 +0200 (CEST)
Received: from localhost (10.75.127.47) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Wed, 21 Sep
 2022 15:50:46 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Bruce Ashfield <bruce.ashfield@xilinx.com>,
        <arnaud.pouliquen@foss.st.com>
Subject: [PATCH v9 0/4] remoteproc: restructure the remoteproc VirtIO device
Date:   Wed, 21 Sep 2022 15:50:40 +0200
Message-ID: <20220921135044.917140-1-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.24.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-21_07,2022-09-20_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1) Update from V8 [1]:

- rebase on for-next branch [2], to apply series on top of commit
 7d7f8fe4e399 ("remoteproc: Harden rproc_handle_vdev() against integer overflow")

[1] https://lkml.org/lkml/2022/8/26/532
[2] https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git/commit/?h=for-next&id=c81b67199cc4e2e4e8caf1abbbca1dc1b80bc642

2) Patchset description:

This series is a part of the work initiated a long time ago in 
the series "remoteproc: Decorelate virtio from core"[3]

Objective of the work:
- Update the remoteproc VirtIO device creation (use platform device)
- Allow to declare remoteproc VirtIO device in DT
    - declare resources associated to a remote proc VirtIO
    - declare a list of VirtIO supported by the platform.
- Prepare the enhancement to more VirtIO devices (e.g I2C, audio, video, ...).
  For instance be able to declare a I2C device in a virtio-i2C node.
- Keep the legacy working!
- Try to improve the picture about concerns reported by Christoph Hellwing [4][5]

[3] https://lkml.org/lkml/2020/4/16/1817
[4] https://lkml.org/lkml/2021/6/23/607
[5] https://patchwork.kernel.org/project/linux-remoteproc/patch/AOKowLclCbOCKxyiJ71WeNyuAAj2q8EUtxrXbyky5E@cp7-web-042.plabs.ch/

In term of device tree this would result in such hierarchy (stm32mp1 example with 2 virtio RPMSG):

	m4_rproc: m4@10000000 {
		compatible = "st,stm32mp1-m4";
		reg = <0x10000000 0x40000>,
		      <0x30000000 0x40000>,
		      <0x38000000 0x10000>;
        memory-region = <&retram>, <&mcuram>,<&mcuram2>;
        mboxes = <&ipcc 2>, <&ipcc 3>;
        mbox-names = "shutdown", "detach";
        status = "okay";

        #address-cells = <1>;
        #size-cells = <0>;
        
        vdev@0 {
		compatible = "rproc-virtio";
		reg = <0>;
		virtio,id = <7>;  /* RPMSG */
		memory-region = <&vdev0vring0>, <&vdev0vring1>, <&vdev0buffer>;
		mboxes = <&ipcc 0>, <&ipcc 1>;
		mbox-names = "vq0", "vq1";
		status = "okay";
        };

        vdev@1 {
		compatible = "rproc-virtio";
		reg = <1>;
		virtio,id = <7>;  /*RPMSG */
		memory-region = <&vdev1vring0>, <&vdev1vring1>, <&vdev1buffer>;
		mboxes = <&ipcc 4>, <&ipcc 5>;
		mbox-names = "vq0", "vq1";
		status = "okay";
        };
};

I have divided the work in 4 steps to simplify the review, This series implements only
the step 1:
step 1: Redefine the remoteproc VirtIO device as a platform device
  - migrate rvdev management in remoteproc virtio.c,
  - create a remotproc virtio config ( can be disabled for platform that not use VirtIO IPC.
step 2: Add possibility to declare and probe a VirtIO sub node
  - VirtIO bindings declaration,
  - multi DT VirtIO devices support,
  - introduction of a remote proc virtio bind device mechanism ,
=> https://github.com/arnopo/linux/commits/step2-virtio-in-DT
step 3: Add memory declaration in VirtIO subnode
=> https://github.com/arnopo/linux/commits/step3-virtio-memories
step 4: Add mailbox declaration in VirtIO subnode
=> https://github.com/arnopo/linux/commits/step4-virtio-mailboxes

Arnaud Pouliquen (4):
  remoteproc: core: Introduce rproc_rvdev_add_device function
  remoteproc: core: Introduce rproc_add_rvdev function
  remoteproc: Move rproc_vdev management to remoteproc_virtio.c
  remoteproc: virtio: Create platform device for the remoteproc_virtio

 drivers/remoteproc/remoteproc_core.c     | 154 +++---------------
 drivers/remoteproc/remoteproc_internal.h |  23 ++-
 drivers/remoteproc/remoteproc_virtio.c   | 189 ++++++++++++++++++++---
 include/linux/remoteproc.h               |   6 +-
 4 files changed, 210 insertions(+), 162 deletions(-)

-- 
2.24.3

