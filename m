Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7AB67E0EE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbjA0KAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjA0KAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:00:34 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2032.outbound.protection.outlook.com [40.92.46.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5983727995
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:00:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDF9Jbq1pww27ukiNG/89OPrHFFe61GjOJd1KlQCVtuQfffemTiL+G98Dj/pYHox4RZ4UeH3z7w8XimJQwo84GljRgWW67h1L3+fihjyX6F+gCitGQEWFshzfRYk0FFPofWq+1JVP4ZGcj3He1elmGhC4PL8TsEhrWxUT9xxmSRJgvpRVsA7y1t/1Ko3eWLnQCiGOdsmFpmiRUKd054HanqfbFB2CnfuIqJRW9LCbPDQOhaYg3Mj9hYOkB2KDnsca70xi050vwfRNN27uCmG1qz735p7cscg8iDCbKVsO64Tccb3z+UDThqK19pRtDcOyXgMTKmVx5oUkJfGLQUvvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qSKADg/N6lQQmSP7XatOKm5WIVmTuqqPcedbGEm35w=;
 b=aTH8vn0FcWSb2QXhMgYBIwk2cID6VS/Xr85xMr796JcJ6f6nlPB7BsWc+Ka72g5/2GHSreztwWGbC1u5tAaERlSfTGwSgDWDgLQD18/WQOmQF+7PvBIEj4RIEJTt/FmLrrGoJx61sg8EmVi+6Kj8TsMIhzF8ihfC3K3rDfRBTwIoXVVgadts9YTff7zycfvnNaSru5c/BOGBXHJoED3D/VpdNEFP6qGqjAMGULs60fJYsIrCHJ70VcjkMlmQKxaneHhlS9yIrM4yi2OimSnK7awUDhybfeuuCRRFsinYv3r4YGhBQvWCfTcUrxAQGf/7BoW1vOBOX4Dmz+EQJa/Z7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qSKADg/N6lQQmSP7XatOKm5WIVmTuqqPcedbGEm35w=;
 b=JqjOJnThc6R6IMzbv2Wkp458MJ2v/h78mzVhjP0H4kskqv2n/BV20d5m/Jv8O4K/yNODLRv9vUGn/dEGELhjcZB2e3emdzVlatmQTvJrAz3V/t1pXolf54rEqGqo+74ERel8YsVw34B/4K/KYUTPcnuMiszlVltxLv3DSr0xlS2HXLszPr3wcvPCy5B+yhVGO4iTJZcAzlsl+J0QBZ/hLrUNK+nk/b9yPDQ6vqJ6kdWnDkURGrjCyBCUnAjvEKG80caFe4M7Bx6cb9VxbbW9QMW80/NVsnfCL/JwVugK9sZM5i2atPu1dBR8cHr8PvqxKhdsHJm7RZLAmZHEwZXkRA==
Received: from BY5PR19MB3333.namprd19.prod.outlook.com (2603:10b6:a03:188::23)
 by DS7PR19MB4535.namprd19.prod.outlook.com (2603:10b6:5:2c3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23; Fri, 27 Jan
 2023 10:00:29 +0000
Received: from BY5PR19MB3333.namprd19.prod.outlook.com
 ([fe80::2f9f:773e:b1da:5087]) by BY5PR19MB3333.namprd19.prod.outlook.com
 ([fe80::2f9f:773e:b1da:5087%4]) with mapi id 15.20.6043.023; Fri, 27 Jan 2023
 10:00:29 +0000
From:   "katiyar26@outlook.com" <katiyar26@outlook.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Mellanox interrupts are not load balanced
Thread-Topic: Mellanox interrupts are not load balanced
Thread-Index: AQHZMjMkUEeiz2tn4ECAxfc0bz4HOg==
Date:   Fri, 27 Jan 2023 10:00:28 +0000
Message-ID: <BY5PR19MB3333BC15B1D33E89A679D7A7A5CC9@BY5PR19MB3333.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn:  [dXSsiUagHQYxpdP9ovgqYCP2JRGr1X9S]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR19MB3333:EE_|DS7PR19MB4535:EE_
x-ms-office365-filtering-correlation-id: 1894a412-6d95-48eb-3ac5-08db004d51eb
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f3y6FXp/uS3cFVuaA+ciDoOGcQqsTh/ewK40lpz8lWv94Noe5ON+cBxv3rEWFL0na1T9WTXs2SRo6l/E13VbxaGeX1V5NKTzovbeV7GVjU0hbFOiSSyyMQcdPWO0CAX2mP32UIACYTE9C9hJcXW29rpydgiRTVcLkSr3LctiIpLXuQYqPRivLq389qMc5TSkL7pYcmhdvB32lKClSPTWxPwR/ei1ReR+B0bQAogDpMTwkzmFtdPBKMwGWtJeGLpZWwEf3hi3Fahl5L7Hzmu32cYqk/+lIGNhzq9Tj4StAQx0gGY0rFk2E/fgQXCgEfYEzl+Gm1zcR4FaCcQxQWHxuYb5ZJ65sOx66rbZ9ubDdFLcV+dxjXfpJ8FuvCpf9eo+bScYqWb3tizrnopTiXJ9ylO1L4WZsMcL6fNDEEHIX4M09AXq09eyUwvbHpur5+lj47es8U+h9hwpBjBsU5h/k0N3YLhaBNyXmnhh/SUcysHe5XAIx4NupXUS+YKV9h0DiIOmbHbnyVaKIJJm/FZmxEtnTP4bW8ZrLFmrsLxIDTANB91ECvVN2cSu75PEPPYpnlcAtKSrhe/4VI2tjpVmlVexCZRujQmxsvFXhtyfixE=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?d8RPUOG1yz3gSHtEF/4DBKSYscqYNFc91LdT9pgpr8jYMgqe2BklrQKKXa?=
 =?iso-8859-1?Q?h2THKnlIFz4LxdMQp/pZIc3vVRxCFfs/S9fCNXbvgXp+moBDUmHWUu/H7U?=
 =?iso-8859-1?Q?nse5EIFpY/rMLOp3On29W9wdzjbTcBFhlXJsm2rMaN3YPdYxllZzcUTVse?=
 =?iso-8859-1?Q?IVH594lsog7b+U1jGHTad97CrtetfvQk+1vnKgAW9qgLn+CncWY96erRTb?=
 =?iso-8859-1?Q?M25x8iGLfmyK96w57OO+k5bR964ILPXQ9CWaW7cYHWDIJGYRuh3PJkaVWS?=
 =?iso-8859-1?Q?LHbaj92fJEtzODZfURRL34PvLzl3cOfFSZ7BEPlKv3LYBILIALa5Kge17y?=
 =?iso-8859-1?Q?xAcXNRvc5jT17P/2fjUKE/ChjlPZRRVSFS3pcqvr4tEN2o+1uQq4VVkPjC?=
 =?iso-8859-1?Q?I64Z9PoY2OACTt/9e9miGcu5hiEa7uzQr/+II86thu2sD25mf3eANie6KJ?=
 =?iso-8859-1?Q?Ft5KG1FV35lPGCWAUV+Fq102zng5uEz7jBdg8m2mF+aLhKCbeQUF6mnGMY?=
 =?iso-8859-1?Q?gyhuPtfGRRTGdWEz8KRwy3HNO/E8WXCDkkhgzaynU7zVMruO1zwVDN3LA6?=
 =?iso-8859-1?Q?qq1Sb5xbxXeqoV6cxg78Dt0KtseQlNkitH2EI11kFLGmWTOxcXF7OZ1ibw?=
 =?iso-8859-1?Q?TT48Ma5d+jLbvA3/onS6aI8WPL04n6SgRCkdkrCmVRFvWYIxFNwU4awVHw?=
 =?iso-8859-1?Q?QCdPhvU+EZeLvISs0OFpxCjsVz6PSjUhE6jDq0d3mmqSyFxCNjFRSDLoTZ?=
 =?iso-8859-1?Q?bBDlHXW1/my7H3hYspAaKbb1x/1UEoF80UK+gSgFRAoSGIVKLmwpgl6ybx?=
 =?iso-8859-1?Q?DLTH9mCY8ECaV0cdPwEapxeqcvPd0JY8cMaiOtP8EErRl//sfqzIrxYoMy?=
 =?iso-8859-1?Q?abeI6nAMQAcaoNL8X3DOmo1bxx2UeJq5dHo0Diu53okd7pI12wRTg3z+zY?=
 =?iso-8859-1?Q?jHtatiiNKDSqoDydns8HrSKJJkogEqvMnePyFi3aDY2r4nyM94FgEf+Eum?=
 =?iso-8859-1?Q?vm1rV+LfqyHDz+csufcdTxiuOValqdMYXjfl4IUBSyBZTxuqVSLoeCMren?=
 =?iso-8859-1?Q?aJQjeRe9bQaj00pt6r2JMWXAmQKrpCmTf7mBaBSUSRbW13bej3F1o8DXAS?=
 =?iso-8859-1?Q?5J67QBZdNkWkoAdmrG+3iTrolA9OhAYt0zeebpWZFwFbduzbbN7JSjPkcE?=
 =?iso-8859-1?Q?O9C7HOMR9J7pPAV/To5BOWXSrA4GxhbuqIoEZgELSG2uQ32qIJs+S6BwBZ?=
 =?iso-8859-1?Q?0PxI1t88LESi/goXC2Kg8zivGkzhI6ThXQspOsf0nnnI9gn1RT9TL5BPPv?=
 =?iso-8859-1?Q?WxKg?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR19MB3333.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1894a412-6d95-48eb-3ac5-08db004d51eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2023 10:00:28.9284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB4535
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=0A=
I am running centos 7.7 VM in azure with Mellanox (mlx5_core) driver for NI=
C. It is running customized 3.10.0-1062.18.1.el7 kernel image with some min=
or changes in net directory. =0A=
=0A=
It has created as many queues and irqs as the number of CPUs in VM but all =
the interrupts are being processed by CPU0 only. Irqbalance service is also=
 running and smp_affinity is set differently for different irqs. I tried se=
tting it manually after stopping the irqbalance service but still all the i=
nterrupts were targeted to CPU0 as can be seen from below output.=0A=
=0A=
> cat /proc/interrupts =0A=
           CPU0       CPU1       CPU2       CPU3       CPU4       CPU5     =
  CPU6       CPU7       =0A=
  0:       9881          0          0          0          0          0     =
     0          0   IO-APIC-edge      timer=0A=
  1:          0          0          0          0          0          0     =
     0          9   IO-APIC-edge      i8042=0A=
  3:         21         25         13         19          2          2     =
     3        856   IO-APIC-edge    =0A=
  4:         68          6         25         22         21         10     =
    19        360   IO-APIC-edge      serial=0A=
  8:          0          0          0          0          0          0     =
     0          0   IO-APIC-edge      rtc0=0A=
  9:          0          0          0          0          0          0     =
     0          0   IO-APIC-fasteoi   acpi=0A=
12:          0          0          0          0          0          0      =
    0          5   IO-APIC-edge      i8042=0A=
14:        602        318        226        232        278        205      =
   69       8917   IO-APIC-edge      ata_piix=0A=
15:          0          0          0          0          0          0      =
    0          0   IO-APIC-edge      ata_piix=0A=
24:          0          0          0          0          0          0      =
    0          0   PCI-MSI-edge      mlx5_pages_eq@pci:8b76:00:02.0=0A=
25:      19694          0          0          0          0          0      =
    0          0   PCI-MSI-edge      mlx5_cmd_eq@pci:8b76:00:02.0=0A=
26:          0          0          0          0          0          0      =
    0          0   PCI-MSI-edge      mlx5_async_eq@pci:8b76:00:02.0=0A=
28:     123648          0          0          0          0          0      =
    0          0   PCI-MSI-edge      mlx5_comp0@pci:8b76:00:02.0=0A=
29:     152455          0          0          0          0          0      =
    0          0   PCI-MSI-edge      mlx5_comp1@pci:8b76:00:02.0=0A=
30:     102308          0          0          0          0          0      =
    0          0   PCI-MSI-edge      mlx5_comp2@pci:8b76:00:02.0=0A=
31:      89403          0          0          0          0          0      =
    0          0   PCI-MSI-edge      mlx5_comp3@pci:8b76:00:02.0=0A=
32:      86793          0          0          0          0          0      =
    0          0   PCI-MSI-edge      mlx5_comp4@pci:8b76:00:02.0=0A=
33:     107817          0          0          0          0          0      =
    0          0   PCI-MSI-edge      mlx5_comp5@pci:8b76:00:02.0=0A=
34:     117091          0          0          0          0          0      =
    0          0   PCI-MSI-edge      mlx5_comp6@pci:8b76:00:02.0=0A=
35:      59714          0          0          0          0          0      =
    0          0   PCI-MSI-edge      mlx5_comp7@pci:8b76:00:02.0=0A=
36:          0          0          0          0          0          0      =
    0          0   PCI-MSI-edge      mlx5_pages_eq@pci:83a4:00:02.0=0A=
37:      12427          0          0          0          0          0      =
    0          0   PCI-MSI-edge      mlx5_cmd_eq@pci:83a4:00:02.0=0A=
38:          0          0          0          0          0          0      =
    0          0   PCI-MSI-edge      mlx5_async_eq@pci:83a4:00:02.0=0A=
40:      35520          0          0          0          0          0      =
    0          0   PCI-MSI-edge      mlx5_comp0@pci:83a4:00:02.0=0A=
41:        576          0          0          0          0          0      =
    0          0   PCI-MSI-edge      mlx5_comp1@pci:83a4:00:02.0=0A=
42:      34139          0          0          0          0          0      =
    0          0   PCI-MSI-edge      mlx5_comp2@pci:83a4:00:02.0=0A=
43:      19951          0          0          0          0          0      =
    0          0   PCI-MSI-edge      mlx5_comp3@pci:83a4:00:02.0=0A=
44:      41038          0          0          0          0          0      =
    0          0   PCI-MSI-edge      mlx5_comp4@pci:83a4:00:02.0=0A=
45:      36569          0          0          0          0          0      =
    0          0   PCI-MSI-edge      mlx5_comp5@pci:83a4:00:02.0=0A=
46:      42023          0          0          0          0          0      =
    0          0   PCI-MSI-edge      mlx5_comp6@pci:83a4:00:02.0=0A=
47:      12610          0          0          0          0          0      =
    0          0   PCI-MSI-edge      mlx5_comp7@pci:83a4:00:02.0=0A=
NMI:          0          0          0          0          0          0     =
     0          0   Non-maskable interrupts=0A=
LOC:       1536       1224       1240       1107       1299       1379     =
  1171       2152   Local timer interrupts=0A=
SPU:          0          0          0          0          0          0     =
     0          0   Spurious interrupts=0A=
PMI:          0          0          0          0          0          0     =
     0          0   Performance monitoring interrupts=0A=
IWI:        726        143        776        309        780        370     =
   748       1047   IRQ work interrupts=0A=
RTR:          0          0          0          0          0          0     =
     0          0   APIC ICR read retries=0A=
RES:      59746      34162     150579      45146     149421      87954     =
149095      47137   Rescheduling interrupts=0A=
CAL:       2562       2717       2601       2590       2577       2649     =
  2572       2557   Function call interrupts=0A=
=0A=
Mellanox driver version is :=0A=
version:        5.0-0=0A=
license:        Dual BSD/GPL=0A=
description:    Mellanox 5th generation network adapters (ConnectX series) =
core driver=0A=
author:         Eli Cohen <eli@mellanox.com>=0A=
rhelversion:    7.7=0A=
srcversion:     7D9FFD656B0EB1000804CB2=0A=
=0A=
Same kernel with different NIC driver (in AWS) and igb driver in physical s=
erver works fine.=0A=
I tried centos7.9 (3.10.0-1160.76.1.el7) available in Azure market place an=
d there I don't see the issue.=0A=
=0A=
Please help in debugging/resolving this issue.=0A=
=0A=
regards,=0A=
Nitin=
