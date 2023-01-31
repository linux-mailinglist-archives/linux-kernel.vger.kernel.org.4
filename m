Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C907682E4F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjAaNr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjAaNrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:47:23 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB38269F;
        Tue, 31 Jan 2023 05:47:22 -0800 (PST)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VArKth011284;
        Tue, 31 Jan 2023 13:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pps0720; bh=PsJcnGdcwROA0z5uh2sK2pJv608+RwTfg7af4/WMKt4=;
 b=iowGG6Q10ZOuq6P3FW18HmWQE1cjnWFvGHi+KCDKgBc498IC1lgSFR2JJ/Jy9csMCxvr
 twiL5fa2UYD01w++azezutN//HKXdKlX8kHmhT4PVB3l1w9iVjM59+hkf6sT2F4pVuec
 arcSytlEGgQJyL1SeEC3DCaYkB6cMDdjrJOqOXyjbNuniMie4sCvUQq3yqZ10NDQjGs5
 UdVOa+sgl35Mxd8oyAnkaV9uHFQfFgm0pMSY6dtwfGZxojPqPIokk0MFPficNumNLJSm
 8SIX/W8F6eBVL/A83Cak67QsFh2wDZQvLBoLBXWQOqSE0ECSvkrocRxYmmGpqJ7xKaUn rQ== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3nf1mgj5gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 13:46:59 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 54DB9803723;
        Tue, 31 Jan 2023 13:46:45 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 31 Jan 2023 01:46:42 -1200
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 31 Jan 2023 01:46:42 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36
 via Frontend Transport; Tue, 31 Jan 2023 01:46:42 -1200
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 31 Jan 2023 01:46:41 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJwkzaW75/jN+KHWOD4dmiYYd5i8UF495iSQqbpq3opzXCSWk8hq7dPORwzf516ZWAciglZVjUHd6LJheXfhiU7avnqr0us8nlkZy9p2msok13C7Gr1/iPi7YTr5iikPAiyF7yD5elBhrz0u/o9WFeum60GK0+CYpHobXcPOwVyhyLJEvGZwroAJC7ErwBgx405Jan7v7oco1YT/uUMwoHwjVrankfA6mnrYL0su4mVDcA0ADVJeyAtvDANyFRAzVeqCCtSL9kLtlRNpuQGH46YSTt3G8Si9DLbyh/3WGo+LVLj1gHFxLPxV8c/iHtuFqDOavmAhJ+walBO6PhxZSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsJcnGdcwROA0z5uh2sK2pJv608+RwTfg7af4/WMKt4=;
 b=HHkNMgnYvQ3Dkv1edBG4aqSseZzXGoGjmbjMf8CEbwM48FB4dp7X7wBLE7N2TKyG09EufIhwHEePRMxBD9k2HnOhyWW+nTF1/2saCZatLwY7ieJoiWWhxeQevG+Mg5w2YUJvuaghwdAYEGgzJS6pmQ+ZJIoGcOx5yaw4TzzoHkXrbkMIUsi+rBvC1DzpWUZHDlq4a62VGlaKHct3O2aoKdsx4pxetUF2mYIo+z5jUYpjbK7q8XBQj4qW3TYX/U3Jeo9qJIBhGm0U3hfPtp/7JwNuvhxcZAvNbCkOO4n4aTTw2o3UG0q4DAT06ASMnJtAlOied2WcO2UwLyX8P9QHxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:173::21)
 by MW4PR84MB1585.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 13:46:40 +0000
Received: from PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c770:7bb6:97df:69e9]) by PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c770:7bb6:97df:69e9%9]) with mapi id 15.20.6043.036; Tue, 31 Jan 2023
 13:46:39 +0000
Date:   Tue, 31 Jan 2023 21:46:25 +0800
From:   Clay Chang <clayc@hpe.com>
To:     Andrew Jeffery <andrew@aj.id.au>
CC:     <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <verdun@hpe.com>,
        <nick.hawkins@hpe.com>, Arnd Bergmann <arnd@arndb.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 0/5] ARM: Add GXP SROM Support
Message-ID: <Y9kbsRsRcOnGS0ps@enigma.ccjz.io>
References: <20230110042533.12894-1-clayc@hpe.com>
 <7734c165-5918-4677-b8d4-f7d5a3ed37d5@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7734c165-5918-4677-b8d4-f7d5a3ed37d5@app.fastmail.com>
X-ClientProxiedBy: KU1PR03CA0018.apcprd03.prod.outlook.com
 (2603:1096:802:18::30) To PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:510:173::21)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR84MB1480:EE_|MW4PR84MB1585:EE_
X-MS-Office365-Filtering-Correlation-Id: 68927616-2cfa-4706-bf83-08db039193d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jvh1+iC48V5+i5zR5PPg5lnRfFB1HXqFk6Z5YULOoRA0wYyu+6VuLFsqWAVGPIAjU7mz8frPP4PdJUvtE0Jal1XKcGMMtt1loQpCDICj4ZmrbMJLtagZK+EoKpLgfMSa0L19rjIyaj3drUc3i2B0vFhPqcN4mkMqrHAtYA5x9KAj0y2JSxbhtrcA6Jo7tjeO+7e4vcNTrucGKDIfIuuGt3LjzjjINPj4NY1Sn5hyCqnaVkWvjOSlOHbKaaAdYjCY/Rub/M7wzoNMerYjH65EP8sDnutBAj/uPzu7LYunZh2M1NFNRsZP2Fbu6cHBFERdzNUgLU89bF2T0pHN6o8956THY1it8b2gTI1PSmyJoTRG4uPGnKjPrucKX8TfIMbbvwqbD/1BK7G2XfTD2KYK9BIem1qlJpYpTO7DbYvgiIR0wSbYwbHXuc8jabv+lPkx6iKoSoi1K8r43OezTNzh/1NrnHo86VdZLeHcMH3tylITZNltvbehgrMLA9IFRbmuoEUTzfO3M+fCjujP7ibmHtpWk6Q5/4bc69qFZdWb0msz0+mB/a6wio/YOicC9P1+mv+yntDHYf9WYxTHXAPEcOm22PEvlIpbsYHI5fyY5w4eIVVIM+FZzeEDIyk2O9DUrS1DwQg/Em5cSDAmFm9PpVGT98qFrWf+cbTCSz7cOuU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(396003)(39860400002)(136003)(346002)(451199018)(8936002)(41300700001)(86362001)(5660300002)(7416002)(83380400001)(82960400001)(6486002)(54906003)(4326008)(8676002)(66946007)(66476007)(6916009)(38100700002)(316002)(66556008)(6666004)(186003)(6512007)(9686003)(966005)(478600001)(6506007)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rQk2tfpb+4PPIZz5w77bDTdh9D5i/cANTSuhbeAZGRRpVuQ1iSeMRP9J7rjr?=
 =?us-ascii?Q?DkjgSHy3w1GcDvrJPqhUZ0BB6S2ZO2xieABlz1c3bz8br1tRdmZWZ3IFj0UK?=
 =?us-ascii?Q?UpKYSS8BoceLZH/oJIR4mP422iT0Bqqw9eCqw+z4nbqeZbOgkpoeAXeACU2+?=
 =?us-ascii?Q?WZiusBiU+ZZip3zFFIHyokqfU9iA41xuQuBA8uPqlCm3abXlpLeEhVjJbBex?=
 =?us-ascii?Q?oO4O4c1tDWWxjHuKMyh9Cmej++MJsa4JK2HaHKNYeO0IyMo9VzfjxYwf7efq?=
 =?us-ascii?Q?uB2yrgPRh8wmBNvB7jlSjIVTSX0IS1u4eD8URiLLbhqlrar8Le+Us0T4XBtI?=
 =?us-ascii?Q?obpi7gpJTiiZYjmz00F1lgxetL4WN++UiwrbxUlHAB1l2HUWPxLqA0vN9vbg?=
 =?us-ascii?Q?LSRpp+M39DDpffOR0RtzaQFjADAh2L/tqOxNEl5va5HwlrVedGpdhaxP7Jvj?=
 =?us-ascii?Q?h5qR2XZbE/M9lsQ866Va3WH2fqawgDiE0D2Sue3POW8o+8F9SPwdLIoSbyus?=
 =?us-ascii?Q?LkAAPhrCnkotmCQCDVCG5qPC5T4ooMYqMQeZYV4ezpDsTm2bbsLbrUZ9HeXk?=
 =?us-ascii?Q?n1Ax798OVe/316AwobC9r5mOEwrfnKbgcWhLgls4zuhd2WpyrbSqUfsGUTaR?=
 =?us-ascii?Q?vJeCzH7GjambEMvw/iNjdwR8wcRpcS0RH3nmfrN7uNKLzE88vuzLxZtgzTBQ?=
 =?us-ascii?Q?is/mUeG55YJqBjcGqm0CevBBFCF/kBmbvDNPA5Lk4U2KbkPhIJQncOF/mFcP?=
 =?us-ascii?Q?XAoFKMxyUsdsoqEJ2YrQOwkLZXxmohBAVbxrhoSKhgKMmFtND5E+IAG4IAju?=
 =?us-ascii?Q?b/2i/l0lNrBuCuSfgQyQIsW/I/C5u5MQTpyvZoBSZJaXtNPAWaOGwQp/jbA5?=
 =?us-ascii?Q?1V9KqBRNOPZ4kGsIHiYnYoI8CSBpZ5O+82s7eqAxmnvWE5e6xTx50AwD2SbU?=
 =?us-ascii?Q?fUUBzgPGPUF389HbD2kZf7/EoyIUidIS+jMJfe3PKQ6R+NAV7Atkd6Z4z0Vi?=
 =?us-ascii?Q?yipJhnwgE+fqffo+Bw1gzQ3d3NutnjRQIfPzr7MvPDTQ0D0TNKH1HqU9cT+m?=
 =?us-ascii?Q?0KYGQHcpeeFjQqL+/TXMNPrs9KVd0B1XQ6O/nUC3A+Z1SLKy2RFGQ0eAhkRI?=
 =?us-ascii?Q?0lOxQyaDpIPN6xu6FLjInt1EeVnkcpWVErAK4i/4Dw1t7n4iclVntz62HlAP?=
 =?us-ascii?Q?ZyPIfjEBbWNgKUl/S1yaIMl1UOvQvuQJ7g6zTjpjtJJ9VoQIfk/GrZT4YBFl?=
 =?us-ascii?Q?x03gH6dRXMrVV5usOItMgNtH/xrQFgsAaolaG1IoeW0C+KDxN3GHsaWDUU7t?=
 =?us-ascii?Q?Dmd7nP7iz5VR1vsUwg78IenCGTFRVCTd4x0/dhAxgqNMlNuSZ417kOGqXb00?=
 =?us-ascii?Q?0sQc/2xQB0BxCk96Qcea0xjrKhmrAK35XYGPbPiWwyNhXtM5QkUq7ha094Bp?=
 =?us-ascii?Q?5MZyKQEm1NdD5nspflUPTKc1TV2ocbGzMTwCek+Ff/T+5IGyrBmnaLtVVodd?=
 =?us-ascii?Q?6tQl25h25VeFkgpdksq7n2hU9YHZZbc60dFk/eJqyZAA+bVBVWFNegd7xv9X?=
 =?us-ascii?Q?q6opqiv+VdB5ub6fsx0yR91fRuEPMD46SvmY50VJYjlzDvkcofQT5RN1xWEU?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68927616-2cfa-4706-bf83-08db039193d8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 13:46:39.1622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fk2KPyvR5PGBGy833b22tMCAB2SA6wNH/MSxDv4IEpV+EKelSc/OrhogmqCpa2xD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1585
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: SYYm_7JpoEWv9rrD-x1fFmuznRCKWHt8
X-Proofpoint-GUID: SYYm_7JpoEWv9rrD-x1fFmuznRCKWHt8
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 adultscore=0 mlxlogscore=765 impostorscore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310123
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Thank you for taking time, and sorry for my late response.

On Fri, Jan 20, 2023 at 12:51:54PM +1030, Andrew Jeffery wrote:
> 
> 
> On Tue, 10 Jan 2023, at 14:55, clayc@hpe.com wrote:
> > From: Clay Chang <clayc@hpe.com>
> >
> > The GXP SROM control register can be used to configure LPC related
> > legacy I/O registers. Currently only the SROM RAM Offset Register
> > (vromoff) is exported.
> 
> What exact behaviour does vromoff influence? You mention I/O registers,
> but RAM offset feels like it may be related to MEM or FWH LPC cycles
> instead?
> 

Sorry for my previous inaccurate description about the vromoff register.
You are right, it is not related to I/O but memory LPC cycles. This
register defines the offset and size to BMC's memory for the system rom.
BMC uses it for system rom related operations. One way to access this is
through the memory LPC cycles.

> I'm trying to understand whether we can find some common ground with
> controlling e.g. Aspeed's BMCs LPC peripherals based on Arnd's query[1],
> but the description is a bit too vague right now for me to be able to do
> that.
> 
> [1] https://lore.kernel.org/all/66ef9643-b47e-428d-892d-7c1cbd358a5d@app.fastmail.com/
> 
> Andrew

Thanks,
Clay
