Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38326DCCA0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 23:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjDJVNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 17:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDJVNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 17:13:05 -0400
Received: from mx0b-00010702.pphosted.com (mx0b-00010702.pphosted.com [148.163.158.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FF51BF7;
        Mon, 10 Apr 2023 14:13:04 -0700 (PDT)
Received: from pps.filterd (m0098778.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33AFDYcd008151;
        Mon, 10 Apr 2023 16:12:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : content-type : mime-version; s=PPS11062020;
 bh=uf8rVM6G8gt2Yd75V9JHp3LKgDW0FZIRYo4qK7Bcmvs=;
 b=LJtD9Zwfn4eH/1WUz1SUUD+KYdnAyiqJmzjP2bm2Q3rpesWcCGBKqHMDP7p6EuufFs/8
 SPlK8CWZK9OurZHuCyXkWKgQ4KeF13xNW4plFx5MHOkeQovf12VNHMNqBtMRxkuXT9ga
 rUR5EGZBk7kmPBdJEfzI7iXzey4YUNgnlDWIiloNPCCQITK6s0GSAEJy1gGPKGSb3MsJ
 rr58prLEatqiP7Jk3jjJPRl+3n6CZDGjb4Z5aImw1c10j7UcVG9bB6pT/n/zqLLMEfXB
 +3WNwDgp9fS3ovz9Q/Pqjo1hQty/gV1Quk6DHtZ72ufqdlAHj0dayODtsDwQ053FvYd+ sg== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by mx0b-00010702.pphosted.com (PPS) with ESMTPS id 3pu5832yj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 16:12:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tu/9p8UrYFzXMhxai5gRHdO4GuZZ7VxM1IiO1lwfVG9F0uZV+wybo6VCHSOD8d6RYWu7F2p9sQDE6kgBBPGno4IWX/SaLCUr+eRWPzx90bemRxpepr6TQMyTmupNVhutljoiDWi0HTHKZjGCFy0jrg5QTBGSeHbqb7yj6h4bKeNZvIwiKsM5Qatc8m9ar/VZq7R090K1tzFfrZW7a/JQmJnabbS2wmynIZmjCwoIW8UKpXVJdMjR2mKB7XPz0JCDbO0pKjJKEm9rdALs7/UHS/fdzhVA+6X34puRhKVa92KI8y3jNjl47jI/MtMjulzwz55HnRFqhLbNjEfthEUqzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uf8rVM6G8gt2Yd75V9JHp3LKgDW0FZIRYo4qK7Bcmvs=;
 b=WVWZHv8jm5i02aMUvdPTwrMzBAEiD+jdxYlkf+PxBzNVyA7JYIv9BW2JcskaH9j03oRhDNOW+F66GDo1ja5DItmg3EjDjAMwikPPvyTLfSyblCKyRabYoUqL+QlmJhJz7JvcMFEWCdq0ykw7MXxv4hh0cB6M0UlXk9PCnHKAkPEU1lUepW6NwUuKBwoPAS2MJJfANh6lHkjyBPyM7aRST4cPbRT3m6l4a0pOHNF6Lt1rKVA8N6YjtIifELTyVZwP5TqfKLZ6wqFFzLwaonGgALI5qhhS5Aor8fFWByBLQify15Lw2lN4ryF/VgMBz6cCEC9OQ2P94ZcV9F0W9pedEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uf8rVM6G8gt2Yd75V9JHp3LKgDW0FZIRYo4qK7Bcmvs=;
 b=ptsoTb4vVNH6gGoG2ybAFl6GmyU3TTSSkJjNZ7oLolViSAxQZ6FePAp7EnriSTF84YdpMsZWuEx9pse4RA9R62jN7rwBEKm+SPaV8KBYpiiU/zvZ9M4FPPyLXAUu3VI8F+oru6fypxpH3IrAMDF3IC97g7THzT6G/7mN7jaF/bI=
Received: from SN6PR04MB4973.namprd04.prod.outlook.com (2603:10b6:805:91::30)
 by SJ0PR04MB8568.namprd04.prod.outlook.com (2603:10b6:a03:4e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Mon, 10 Apr
 2023 21:12:49 +0000
Received: from SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::bb22:1910:9f48:1f00]) by SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::bb22:1910:9f48:1f00%7]) with mapi id 15.20.6254.033; Mon, 10 Apr 2023
 21:12:49 +0000
From:   Brenda Streiff <brenda.streiff@ni.com>
Cc:     ilpo.jarvinen@linux.intel.com,
        Brenda Streiff <brenda.streiff@ni.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 tty-next 0/2] serial: Add driver for National Instruments UARTs
Date:   Mon, 10 Apr 2023 16:11:49 -0500
Message-Id: <20230410211152.94332-1-brenda.streiff@ni.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230329154235.615349-1-brenda.streiff@ni.com>
References: <20230329154235.615349-1-brenda.streiff@ni.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:806:20::32) To SN6PR04MB4973.namprd04.prod.outlook.com
 (2603:10b6:805:91::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB4973:EE_|SJ0PR04MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: 038dbc69-0879-4976-8921-08db3a08569f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZBmQpyx7zWOvDaq1HnCcdF78RUaM1MC+Z/QeSpD6CCDti8XZHq4+SVFrJ6xhBS87XPzmmZxyGABIk1CLGB0kY3e9gELIjT4rdmjAGzQfciNMmWVzzHhhtL/CyTOyrH9goZ2nmusBwkZtTYT2fJV/knLo2Efzuaa2AMUh3pcforVK5yyCkYnwegMubanqfUh2dRzgkOUkaLI/h/Px7nPf59ylmbbA2RdcpwEZCjVqZrUm3EAM4dUfuC8iO3ji73mUOC5HHesuiAfvSTkvWrI3+Md+thjdYnfrrV6ejWt7xc3/m8R5bX3ewxwWDioFf8aENZpjBhUAsQt37L/vpvt5r/ej5vxaOXunWMBDQindPBSdqHbgZXsZfg68LaOZi+kmWERfW9xDdvsCcMq07TGVRVqiuFCskytzs2+BVEpWksW63gxaTKsNhIOzLND9/uE5N4Zp/eUPWZDLxgGBJQ+CgF8Y4u1GXQGIxrf7vglZs3QwLwRMDqdsY0g8gR+y9/9b73cFDV16ipOAVp0vSSqvNRRPvhPTSsV2yzojIpg47gcG5e2pEL6cCidRJE/PvCrYcYVxh5FmuaS0wsmAadMC1mxlM/3tPufN8QBwv8AMbYs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4973.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(376002)(366004)(396003)(109986019)(451199021)(66476007)(66556008)(38100700002)(8676002)(66946007)(4326008)(5660300002)(2616005)(44832011)(8936002)(2906002)(41300700001)(54906003)(86362001)(26005)(186003)(316002)(36756003)(478600001)(1076003)(6486002)(6506007)(6512007)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yD9GNp26j5d4lNqO7Mi7PyZcEXrq0xm9dlpSMMYgfy343kY+y6Cv+d1RH1LX?=
 =?us-ascii?Q?ar0oAXoUFDcLzENJur6OXHhrFWTrTsIl31GP7tfCPTLBr061DVnPe+2g/byy?=
 =?us-ascii?Q?8WtlddAl9tD/VZHg4EKyDfNtBZu09iTAgaZq2c9Nfip5DQ48SUvnWk3Lh9q1?=
 =?us-ascii?Q?LiB56htKlMFzFharSWfCd1G2RcE29NhU1N4A9TZA+QXfuG46sbx5tZs6yMfI?=
 =?us-ascii?Q?q6wtUmUIfmlvQZCKXd46TYwHnen14ogDsvZ9VUYGAT3ZbVg9XnzjvcXJEM38?=
 =?us-ascii?Q?ZWiBxno4rFWoQ+L4zcPqpuSULUBGISsr6XCoKNGBSybZWNzVsavomwcRZoJ6?=
 =?us-ascii?Q?vWbY57hHOAXGiwGJ5wE9mulGc/RidpB5B1pXHH/M3j7ErjydjMNF18z7uRU4?=
 =?us-ascii?Q?0QE9EkwrJcankLz76nStJZm7ahltnkb44UTaZ19CXU8mSexCIJXeXSUH2ZcS?=
 =?us-ascii?Q?+Df7fYMXeysxl1fNcWI1T8h7oUOhzTEkOnnm5vp2S8bLY6uHD1XqTWSI/ri5?=
 =?us-ascii?Q?GoTbhAjjmxFtpXBAe1BNvQO5cP6PEIL5l27bK+iOJwKlAtVJh9IavTL7FgWc?=
 =?us-ascii?Q?dyf4NUUQWmR9kBWIB+BwbcU4W/OBC05URout2NOb6gwft/Ejbrcx7tBwgUJF?=
 =?us-ascii?Q?Ou1tTDZjfa0bldpEUnzssjsa8Ah5FLNAPgH/kc5n9+is8smW0QU3C1O8/tVG?=
 =?us-ascii?Q?r8GZqkF9ZFaEWzD5pQzemOAahEX3J8sKRtKeS9j/YzvJsaH/+vbD/uksXfV6?=
 =?us-ascii?Q?KFLqccivri8UEW7UCYAIeIZyBiIhK+dloFRgqvpDTzJJPFHjMc+w7uaJqJ2k?=
 =?us-ascii?Q?1poDDjj9KsjtVf0pyffPKiqMX+lXxMCW/D0dviMgOzmBuSKGKO187z2lbC01?=
 =?us-ascii?Q?+UO62zcIpFWLfNQNci/dsaLu5meYAsK7XDaGqi6bpqvu2o7YLOHFZEvsnxhn?=
 =?us-ascii?Q?QVtKT3Lj79QdYuyoVy0dgdS47c/RIuFMocGrymwbSOb5clu8VhFBzP75apv0?=
 =?us-ascii?Q?R77rsfMz3Q35xjFZuRmDwbxy34AiszQB0eEblIFeNRjXuVxgMWRnp0svVJXD?=
 =?us-ascii?Q?bs0gdvzk+vpJQ/emaud9O98mV6Qn9xKTfW9A+7FxNT4AgnFa+8j3J7EXB5RJ?=
 =?us-ascii?Q?uzeidB15hWePbj32U4y3/Bu3+WLeFvHJuqoJE+SkUKnmi/GrmKEZ5ncfqWoG?=
 =?us-ascii?Q?JTrqvs28Gt6Pq/17IkMa6riw6HvpSVk+bruhUZphyt6poA0cAwucRl12qq5M?=
 =?us-ascii?Q?gjPf9FuKkMJldR4ujQ69xNcn1nYfexQEwVnnYeJIjDPg7u9ScRfF2xYBUbS1?=
 =?us-ascii?Q?hE+cdUrH8VcYEL4ZdvLxKDa6BHwhFIt06MotHqOWjsfbMrynkKqqYB83R+Oe?=
 =?us-ascii?Q?DEwze5IyKQf3r1qylhoUAnrlz0cyB5IUZ9Vgj29tdKBWKB0pwUwvN8eXVrmU?=
 =?us-ascii?Q?OLceG3WWk5ipyjJoeL4NAKy+b5sTPy5b0jwOroGX7pvhO8/4vinBR6pkB0DE?=
 =?us-ascii?Q?1xW/rLQ9u/1BwLGDevTr1n83iaKVgn4R7+9M7GhCmMX2GLnvAktX2Vx2bT0D?=
 =?us-ascii?Q?V331Rq6SP+PMWI7Q9oYeTGJ3oaoL0zkOOa77ZMtt?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 038dbc69-0879-4976-8921-08db3a08569f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4973.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 21:12:49.2173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 339yMwG4/cjah9uZvTTyRGHIvHg0suI46JMZongqnw1HcjFlpBGXa2nYeV51a/997Be1+VLfo1T6mLZbg0Bs/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8568
X-Proofpoint-GUID: -tgrRowrQYsQfJEyAp_V6pFjoHHetwwm
X-Proofpoint-ORIG-GUID: -tgrRowrQYsQfJEyAp_V6pFjoHHetwwm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_15,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 bulkscore=0
 adultscore=0 phishscore=0 mlxlogscore=945 priorityscore=1501
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304100184
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a driver for the 16550-like UARTs on National
Instruments (NI) embedded controller hardware.

These UARTs have an interface that is compatble with the TL16C550C (for
which we build on top of 8250_core) but also has extra registers for
the embedded RS-232/RS-485 tranceiver control circuitry.

Changes from v1 -> v2:
- Schema fixes:
  - Fix schema to now pass "make DT_CHECKER_FLAGS=-m dt_binding_check"
  - Rename unprefixed "transceiver" to "ni,serial-port-mode" with a
    description. Describing this as a "mode" rather than a "transceiver"
    seems more semantically correct in comparison to other DTs; other
    schemas with a "transceiver" property (isp1301, lpc32xx-udc) have
    phandle values, which is not the case here.
- Driver fixes:
  - replace C99 integer types with kernel types
  - reverse christmas tree
  - stuff PMR mode/cap masks into locals to avoid repetition
  - wrap ACPI match table in #ifdef CONFIG_ACPI to avoid build error on
    non-ACPI platforms
  - NI 16550s are only on x86 and Zynq-7000 NI devices, so constrain the
    Kconfig "depends" to only present it as an option to users on those
    architectures, to prevent it from being needlessly built on platforms
    that would not possibly have them.
  - document module name
  - add check for "ni,serial-port-mode" property; "transceiver" remains
    for sake of compatibility with _DSD ACPI objects for NI controller
    BIOSes currently in-field (but also DSD-properties-rules.rst says
    that _DSD properties don't have to be identical to DT bindings.)

Brenda Streiff (2):
  dt-bindings: serial: ni,ni16650: add bindings
  serial: 8250: add driver for NI UARTs

 .../bindings/serial/ni,ni16550.yaml           |  51 ++
 MAINTAINERS                                   |   7 +
 drivers/tty/serial/8250/8250_ni.c             | 454 ++++++++++++++++++
 drivers/tty/serial/8250/Kconfig               |  13 +
 drivers/tty/serial/8250/Makefile              |   1 +
 5 files changed, 526 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/ni,ni16550.yaml
 create mode 100644 drivers/tty/serial/8250/8250_ni.c

-- 
2.30.2

