Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C6165C366
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237945AbjACP4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbjACP4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:56:39 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22A660C8;
        Tue,  3 Jan 2023 07:56:38 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303FOcfB016379;
        Tue, 3 Jan 2023 07:56:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=bjWIi3M8309vUsAZWRMOnVJ0qItI+ANgcXP1Agr1FnA=;
 b=D/lTZypOXozdeA9P3fk5J+RPodQU9abSotOkmVtUQKVcagt0bBR2zak5/0SWPZiWtTtE
 oiRTYLNwgkMJhYnZ+6oBsC5BhcmsPC9Kb9hQVNpn5CpE5NslCSADbhZ9XyDEH4TgG23U
 wE5G1lOSBHSQVPAM35nn94O0hV/RM7o7albhR7tz8YPsveA2BTNa1teTKik9T1fMD20h
 tQZgVgG4qCJT/C4ZV4AVCtVIvchq/vZ/hIu4tBOFc0/vT1Jrugd7leySYLcKTR7zMpqo
 2zwUwoCzAksyRVScalrsUAs7ERek1G9lX2+Z72Rag9HqUhKDZViq+yCV8FzSyLNSyFuB xA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3mtkauwayn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 07:56:34 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 3 Jan
 2023 07:56:33 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Tue, 3 Jan 2023 07:56:33 -0800
Received: from localhost.localdomain (unknown [10.110.150.170])
        by maili.marvell.com (Postfix) with ESMTP id D8F603F7089;
        Tue,  3 Jan 2023 07:56:32 -0800 (PST)
From:   Wojciech Zmuda <wzmuda@marvell.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@linaro.org>, <sgoutham@marvell.com>,
        <devicetree@vger.kernel.org>, Wojciech Zmuda <wzmuda@marvell.com>
Subject: [PATCH v2 0/2] Add support for Marvell MHU on CN9x and CN10x SoC
Date:   Tue, 3 Jan 2023 07:56:10 -0800
Message-ID: <20230103155612.6217-1-wzmuda@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: xUXnl02DWul4RoFc-0nyLjYqxpfTJTF3
X-Proofpoint-ORIG-GUID: xUXnl02DWul4RoFc-0nyLjYqxpfTJTF3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_05,2023-01-03_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support ARM SCMI for the Marvell CN9x, CN10x SoC, add a
generic platform MHU driver based loosely on arm_mhu.c and pcc.c.

v1->v2:
- Clean up
- Rebase on 6.1
- Remove PCI interrupts

Wojciech Bartczak (1):
  mailbox: mvl-mhu: add OcteonTX2 MHU mailbox driver

Wojciech Zmuda (1):
  Documentation: add Marvell MHU driver bindings

 .../bindings/mailbox/marvell,mvl-mhu.yml      |  65 ++++
 MAINTAINERS                                   |   9 +
 drivers/mailbox/Kconfig                       |  10 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/mvl_mhu.c                     | 292 ++++++++++++++++++
 5 files changed, 378 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/marvell,mvl-mhu.yml
 create mode 100644 drivers/mailbox/mvl_mhu.c

-- 
2.17.1

