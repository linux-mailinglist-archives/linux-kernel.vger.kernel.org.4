Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EC56E8D82
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbjDTJHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbjDTJGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:06:20 -0400
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B414C37;
        Thu, 20 Apr 2023 02:01:51 -0700 (PDT)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33K5lkiO008206;
        Thu, 20 Apr 2023 02:01:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=proofpoint;
 bh=FKemIb+GWJRWpjoTCU2zBWgT5DiaxGY7aq4biuszJnk=;
 b=Lr6A4iJHyDj6aaiDaKRA7vUucM2oCxTpBaNkDXdCkw2KGdQQ2n9vOgJTrCiwLc6T23VQ
 9slt+T5U6VN0sVjg0vafLZu33u7ooTK1db/JYe+js4vvGSbaLzoJzNU7SFefmu3F0X+Y
 QlKg7qtvDpjebd0Qlw0bELoZoN5U1sfg/FKB6ui7tBNPAnutGPXMHGaWtscCJEFK+bdZ
 c5WHOdF3NS1swE8rJZ98b242AvYr+u1IbH13XNUHcCtIDt075F/pL9ZvWEmHUEHh9YUS
 u6Bq9IYMZ1YU6TWyl6xgL2r5wKMJ+LH4LYndsEtDOFYZNDtxaeZrwoybNDc+Xiyg0sA1 yg== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3q2dncxar7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 02:01:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/m9HloaPQeWlcJ253x//8/EXOkO4FOSLq6I5aqZd8HQrMTWmsEN7jtj1SxpIiHNEZKn3pgxv4mVxT+Q63+gDLURyGxVH+2ia8ajH3OVmA4CA9HfTzPILuZ3b4cGUaK7YYEg2zdN/C+mvekJ6VjdBThSi6L5nxYspz6vAATn+eFFS7fyihFjn4TIBnpfM/1UWxEtbJhfrJ+XbdfHv8/vN4qAgzC1z7nglzBQWdApTE6EyWDZrVYRzNsqeML7OpyylWgNVSfqNNR/Y458xfYfW7mii7jIj1gz63qia+nTSyttGqQmgWpcsIewMONqldQvPQjM/nzPTWCD5epgsQSHDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKemIb+GWJRWpjoTCU2zBWgT5DiaxGY7aq4biuszJnk=;
 b=Gus6ngQBP6koKFOycfwa5NrDNJFBLKz4C1FuIC7DnAONuKpI8XpLQKODcsXknffIkaJVUGRfmhWyg943eU4kKBlfLIkvCPs1kaqg15WDr4UCFUHO+rmSurSUAnNthmiTKZUItMsZEVG7J0cLoFZ1xBtYWnQ2MvXyGFoYsv+ak9i58NKUQbBat6HcOKJ/gBrHjAP9cEuXek1ejIg+ZtPU3y9qqT5MYV/8n/NsTu857g8NWuVQvUwuTB9PzyV3Ev+/yJaRqiPTbyraiXD7Q5fJ59bWitbNGrMNP/BwxrPZZFD/7KGvLLNAYgrJecEPcXuekauzscBXgHTbM1MEmgveAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=bootlin.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKemIb+GWJRWpjoTCU2zBWgT5DiaxGY7aq4biuszJnk=;
 b=G0OMAGP7kvdYoS3doQRibNkgcDd9Y6hCPRmf2C8+u3ba1ndJtSNSx0U+DVtbA7ZtbYr8fXwXJ6qwBFLGe7pDChWkvKWFFTZ1jOKeslBa1Zb7HXQ/LbbUjCynVbps9b1C+dt9sXxUUhibWw9q+ItxYKKLhLoOAHKYZ2eQQKfaln4=
Received: from MW4PR04CA0146.namprd04.prod.outlook.com (2603:10b6:303:84::31)
 by BY5PR07MB6872.namprd07.prod.outlook.com (2603:10b6:a03:1ed::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 09:01:12 +0000
Received: from MW2NAM12FT087.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::38) by MW4PR04CA0146.outlook.office365.com
 (2603:10b6:303:84::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22 via Frontend
 Transport; Thu, 20 Apr 2023 09:01:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com; pr=C
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 MW2NAM12FT087.mail.protection.outlook.com (10.13.181.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.11 via Frontend Transport; Thu, 20 Apr 2023 09:01:12 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 33K918as010082
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 02:01:09 -0700
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 20 Apr 2023 11:01:08 +0200
Received: from eu-cn02.cadence.com (10.160.89.185) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7
 via Frontend Transport; Thu, 20 Apr 2023 11:01:07 +0200
Received: from eu-cn02.cadence.com (localhost.localdomain [127.0.0.1])
        by eu-cn02.cadence.com (8.14.7/8.14.7) with ESMTP id 33K917vN080965;
        Thu, 20 Apr 2023 05:01:07 -0400
Received: (from pawell@localhost)
        by eu-cn02.cadence.com (8.14.7/8.14.7/Submit) id 33K917i4080960;
        Thu, 20 Apr 2023 05:01:07 -0400
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <Daisy.Barrera@siriusxm.com>, <Cliff.Holden@siriusxm.com>,
        <arnd@arndb.de>, <tony@atomide.com>, <jdelvare@suse.de>,
        <neal_liu@aspeedtech.com>, <linus.walleij@linaro.org>,
        <egtvedt@samfundet.no>, <biju.das.jz@bp.renesas.com>,
        <herve.codina@bootlin.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2 0/4] Introduced new Cadence USBHS Driver
Date:   Thu, 20 Apr 2023 05:00:57 -0400
Message-ID: <20230420090101.80812-1-pawell@cadence.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM12FT087:EE_|BY5PR07MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: cd81ee3c-49c9-493e-673c-08db417dca37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Qp3q3I5NDUDCLON0q36TAsdL4J58pZ5mZL1sZ9SZ79G8cdyB01Loqw7iv4Kivr8JoHwSlY1vppXC1m3fNHtEisqm11Z2zESD17VUGYFQA1h88HBwOqx3fzJuXZeZ1gX3YMCjmRwQwhxhHzVMTfrhamxUdp3XvjuK9bmJo4eWS1JZtsn94XsN1iOp6JYDJkBJZNk4PsAEKRk9Gdq3+G1GnQYXj7oGeC8hJnX59+ut/Yhl49CpbZuxiulThIWhcEc5p9RCBQ2VyKpwODPTavPo7WssEic2DRJAwHQOgzFMDGKk8CvzPcHqxqy5JhPPZIyX4kCp25n8Vho5MTvkxNzM7CzfuR+0aWBYfWOmSJ856Ap9XBNNZNp3dfkexna/I/Xpsm/UBk2SBrcb7qRF3I5Ks93tNA845RGEZHgOG06o9kjd3TmsPKDYO8PCZBwd+SRMc2HKwTAw69JCN1bNZcsrWXpPUlPYXxv8QDrYstL9AO2GaArAKkLcT/oXEjSTeLEBWEPWvtewFKy7npUcFKYgRjqtdtfq+zjECM2k+nESAI0MdvQwPUoQHjTPLkM+dHdoxFCpOJCJj8CRmAUFSBpVQ6PUuMpjwVsWELm8EGfnZat2UC9RIqFIbnlbokOi+bPoZ5SCWjBwM3vXt/PP3ZKcQbRsX47bEe9ZWwWcKJWEvUvLnPcIhBivFdw0X8ZtGXu5LFdzVGZtQwlaU2ZuQkKrQ==
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(36092001)(451199021)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(316002)(82740400003)(70586007)(4326008)(6916009)(70206006)(42186006)(478600001)(54906003)(8936002)(5660300002)(8676002)(41300700001)(356005)(7416002)(7636003)(186003)(2616005)(336012)(47076005)(83380400001)(426003)(36860700001)(6666004)(26005)(107886003)(1076003)(86362001)(82310400005)(36756003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 09:01:12.1778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd81ee3c-49c9-493e-673c-08db417dca37
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT087.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB6872
X-Proofpoint-ORIG-GUID: 39heJdxIJ5YZ_y9CdSwXSDnbILwbj2Dk
X-Proofpoint-GUID: 39heJdxIJ5YZ_y9CdSwXSDnbILwbj2Dk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_05,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 mlxscore=0 mlxlogscore=245
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200072
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduce new Cadence USBHS peripheral driver to linux kernel.

The Cadence USBHS Controller is a highly configurable IP Core which
can be instantiated as Peripheral which supports both full and high speed
data transfer.

The current driver has been validated with PCI based on FPGA platform.

To simplyfiy reviewing the driver has been splited into 3 part:
The patch 1: contains main header file.
The patch 2: main part that implements whole driver functionality.
The patch 3: adds to driver tracepoints.
The patch 4: Adds USBSSP DRD IP driver entry to MAINTAINERS file.

Changlog from v1:
- changed some __dynamic_array() to __get_buf()
- removed kernel-doc warnings
- removed some compiler warnings reported with option W=1
- removed unnecessary casting from cdns2_pci_remove function
- fixed issue with ISO mult = 1 and mult = 2
- improved ISO transfer performance
---

Pawel Laszczak (4):
  usb: cdns2: Device side header file for CDNS2 driver
  usb: cdns2: Add main part of Cadence USBHS driver
  usb: cdns2: Add tracepoints for CDNS2 driver
  MAINTAINERS: add Cadence USBHS driver entry

 MAINTAINERS                                 |    6 +
 drivers/usb/gadget/udc/Kconfig              |    2 +
 drivers/usb/gadget/udc/Makefile             |    1 +
 drivers/usb/gadget/udc/cdns2/Kconfig        |   11 +
 drivers/usb/gadget/udc/cdns2/Makefile       |    7 +
 drivers/usb/gadget/udc/cdns2/cdns2-debug.h  |  203 ++
 drivers/usb/gadget/udc/cdns2/cdns2-ep0.c    |  660 +++++
 drivers/usb/gadget/udc/cdns2/cdns2-gadget.c | 2476 +++++++++++++++++++
 drivers/usb/gadget/udc/cdns2/cdns2-gadget.h |  707 ++++++
 drivers/usb/gadget/udc/cdns2/cdns2-pci.c    |  149 ++
 drivers/usb/gadget/udc/cdns2/cdns2-trace.c  |   11 +
 drivers/usb/gadget/udc/cdns2/cdns2-trace.h  |  605 +++++
 12 files changed, 4838 insertions(+)
 create mode 100644 drivers/usb/gadget/udc/cdns2/Kconfig
 create mode 100644 drivers/usb/gadget/udc/cdns2/Makefile
 create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-debug.h
 create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-ep0.c
 create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-gadget.c
 create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-gadget.h
 create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-pci.c
 create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-trace.c
 create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-trace.h

-- 
2.34.1

