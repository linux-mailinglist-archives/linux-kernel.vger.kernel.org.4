Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3D3710574
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 07:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbjEYFu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 01:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbjEYFuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 01:50:23 -0400
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A373D3;
        Wed, 24 May 2023 22:50:20 -0700 (PDT)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34ONblmM003945;
        Wed, 24 May 2023 22:49:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=proofpoint;
 bh=P9E482ssF6jpa0GGkh4BPQAa7G7KL89Va43qU8sTeQw=;
 b=HvaqFxt9tHw7qGnec576g0JLt3QumyBTW8cawwE2hDzs0I/PL03au+sloW+HlSw2Yj49
 QJNYr6Vn52oGG+WIuTJvMgZ0AzMarsTf9k1Qy41Qoqumx7eghEDNA+lywbwNa5Sln9vU
 6V/N7/RUNLzpuNFYKEBCWD8a46sJfGf+5AYkSVO4W1EnnPEB3Pj2qGRuSDUrLjZQQzY4
 /Qk2B3loDa2Tv+h1ql8hqz4Rjo9EtagT56Lu3xdzJUP8oMEzLscnTF097ZcD2zWaNhw/
 GcUW/brgnuFg+nuWPzCIwxwc7NEErCPQ3qJ6/XWIHdIxLJ5PRLcOj0mMhDOcRH63JPo6 cw== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3qsvdvrxk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 22:49:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afH1x+MjoXIam3/p6nrCby8PY5Z2brISVzUkp1IQHoKINgjuOppv44Rqp9k7q8enni/IBhUat7zVWGasPUlDoQR94m6j+1EdSPhQ8ursHgXuZowhHsLDEQLF2hBKga8b3laVgB3nLVmhT4PCFpIV8Pq9G7e1Bp/JDr59Lkj2Efyhw3H4Oxec8hl5/g/E1ajU19P1na1WMzoNpt+RGgJ2AZ5GG/4odW+ldNH0HvkcDCH7wh1pVpIirQbwJwFqEJKQv/HR/t8/lcd4DS20Yv7Psycm4aktYTJVR3zYiAEKNsYPNGhlEUAZ2X0PH8/D/XXqzVWAQVGVL0dxtGAyARBXDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9E482ssF6jpa0GGkh4BPQAa7G7KL89Va43qU8sTeQw=;
 b=mhaG1HsjVBygXSd0c5DDzeKHZWX/NlqNCRYm0xvepCd01zA1IFK0+jnOI5+fpUmt9dtgazyVpjgwjPB21Re0SsvVzssp5LRyDxSIIBmfVBuZJFP1LnklRN8TbfQgnoe3T26tQ9UOK5TXrqSCyUHKVmY4TQa+5i4kVDf4Q/W/q/aAgVCu1iK42vZw2vytITatgJSWX31CnRl9ThkwDMkQfPsJSudq59zHI7NZ4ovIAziBSwgtK+mD0/xxnxIoLPLPfChj1ejC1h6DN1PT4J8XyNO7n2DYqWRcVYqyj2mPvCoFJQpmJGEVvXSmWEFhfKkRE3bjrwWS2eLa/vSOl76tkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=bootlin.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9E482ssF6jpa0GGkh4BPQAa7G7KL89Va43qU8sTeQw=;
 b=JuQ0TfbMGIJFJwDPiuiYk0mK/RujCC0JnuMeuVLMbyNheFA4caQt8AiBeS3TKHBJlVlVRiSxieEM9hQhhcHyzagZ8Pu5KoOJnNaZsYSued/3EtAXQXYPPECFvVZjzGKc91ClAl8oiBBIHaOSK6Ya0zMxnd0f5cw5DIUR35tf98U=
Received: from BYAPR21CA0018.namprd21.prod.outlook.com (2603:10b6:a03:114::28)
 by SJ0PR07MB9717.namprd07.prod.outlook.com (2603:10b6:a03:4ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Thu, 25 May
 2023 05:49:49 +0000
Received: from MW2NAM12FT100.eop-nam12.prod.protection.outlook.com
 (2603:10b6:a03:114:cafe::b2) by BYAPR21CA0018.outlook.office365.com
 (2603:10b6:a03:114::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.7 via Frontend
 Transport; Thu, 25 May 2023 05:49:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com; pr=C
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 MW2NAM12FT100.mail.protection.outlook.com (10.13.181.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.16 via Frontend Transport; Thu, 25 May 2023 05:49:46 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 34P5nhWk101837
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 24 May 2023 22:49:44 -0700
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 25 May 2023 07:49:43 +0200
Received: from eu-cn02.cadence.com (10.160.89.185) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7
 via Frontend Transport; Thu, 25 May 2023 07:49:43 +0200
Received: from eu-cn02.cadence.com (localhost.localdomain [127.0.0.1])
        by eu-cn02.cadence.com (8.14.7/8.14.7) with ESMTP id 34P5nhF1243889;
        Thu, 25 May 2023 01:49:43 -0400
Received: (from pawell@localhost)
        by eu-cn02.cadence.com (8.14.7/8.14.7/Submit) id 34P5nZIO243765;
        Thu, 25 May 2023 01:49:35 -0400
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <Daisy.Barrera@siriusxm.com>, <Cliff.Holden@siriusxm.com>,
        <tony@atomide.com>, <jdelvare@suse.de>, <neal_liu@aspeedtech.com>,
        <linus.walleij@linaro.org>, <egtvedt@samfundet.no>,
        <biju.das.jz@bp.renesas.com>, <herve.codina@bootlin.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2 0/4] Introduced new Cadence USBHS Driver
Date:   Thu, 25 May 2023 01:49:12 -0400
Message-ID: <20230525054916.243330-1-pawell@cadence.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM12FT100:EE_|SJ0PR07MB9717:EE_
X-MS-Office365-Filtering-Correlation-Id: d37121c4-655e-44f3-e270-08db5ce3d8b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WGGwI4l38gkm/7g3TQHqr84uImABUm1KiJ+H0ZIBUXKCOIogabCBRKCM5zya5DqecKWi9n4rEuAb77nN2V//XYo1B/p9SRpnNOkkbryw/T3+YOFHLXBmKR6WQ8Ywcl/KuNl78PMQ1t8HbM1Qsjragk5UtrhkEcQIxw47/v3pYlHUn2EmcExKELdz4ZZSkmnPEViR+Giqn1livMXTm7oZ/xsYH1vD6EKKbA3ZX53kfAzYyfKMDDCNZwHxBet58ISCWtNN8W9GcKOZo9GdKGsIcHC76plcEs40vOHhStTdUKSrw2cWz+QLUjxMt4sFb8L1UBJs4iyJE4FyOcPASol9ph6uj4gKd/Qln8ZBYXmbqG3cg6qihgOnBVDt3+nZRnxcFq7NPNYkdlNB37Hwc5/qWxdbrLuRDYfRRg1GKQtd7XgETgHxC3kOiRFY39kLjHjjsrBpIpA5YF4fXwZFja/7yy4N+P//SvfLcxrHluWO8QJOn1/YeHsjQkgUEgh05hd4zOzzStDF/tIkaGknEuXXjDrGQPt0hWHp1QoQhqfsPt7kNzBBBj855yU9x0ol1UI+RaBCLPPHhp2+Nio1z/FN7Mw9K24r+0sL+TJKMaqmtRtCnki7rPnFJPeROh4GuOfSS4gwa7Vet32zSoEVz2W9KlehA1zgpy6QdOKn0ad/8QIixMLXZ1qsUHh7KOy9bBig3Xj8AlIsWc2keVYdLZOhYhXpsQK+1swPON/nynLimqb57e1ysmEv6nKa38P8ZJ8t9yzYwaHmMGQmRe1JQKCWLQ==
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(36092001)(451199021)(46966006)(40470700004)(36840700001)(336012)(2616005)(83380400001)(47076005)(40460700003)(426003)(2906002)(186003)(36756003)(86362001)(82310400005)(82740400003)(81166007)(356005)(36860700001)(40480700001)(6666004)(316002)(41300700001)(8936002)(7416002)(8676002)(5660300002)(478600001)(42186006)(54906003)(70206006)(70586007)(6916009)(4326008)(107886003)(26005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 05:49:46.5365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d37121c4-655e-44f3-e270-08db5ce3d8b2
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT100.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR07MB9717
X-Proofpoint-GUID: n2WSpRtTk5aA4pBq-szNyAlKSM6kRETI
X-Proofpoint-ORIG-GUID: n2WSpRtTk5aA4pBq-szNyAlKSM6kRETI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_02,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 clxscore=1011
 phishscore=0 mlxscore=0 impostorscore=0 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=387
 lowpriorityscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305250045
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

Changlog from: v2:
- used SYSTEM_SLEEP_PM_OPS() instead of SET_SYSTEM_SLEEP_PM_OPS() 
- simplified code in cdns2_req_ep0_handle_status function
- raplaced wmb with dma_wmb
- added __aligned(4) to all packed structures
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

