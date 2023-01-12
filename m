Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18647667306
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjALNRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjALNRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:17:43 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B36B7CB;
        Thu, 12 Jan 2023 05:17:41 -0800 (PST)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CC2Kj4004351;
        Thu, 12 Jan 2023 13:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pps0720; bh=1kWQh/A5bvc2gpNDja3+lWLNVs46b8PPd83uubgYBdk=;
 b=XGBPxpvKT2czDDBjBAxxjW8hYNwaBuL0+5xV4LIUbLXP/+q0AXCIl4ui0YeyqXT+sc7I
 ague9J9DJlTnZpUCZTQW8jfMF2B9zT25P9Dj9w67uCXh3gksn7HH4V7+MLvv5fAvx+D+
 v4TvDarQ/lX7AtiYsWF6lFqcLExmfw088+yMIsVBIqIq2cjwC83O2TAjGZwfBnODJsW3
 TsyOsiOW7jgF/VXm1dxQJKsQOCVolA9TNTKxGyiOPbq7cJyRxJ3ox/U807Cb7WaghuA6
 MM58Ncl4uSNlxb7OVPaP4JcYKHlw8+AlYg5obDboMJAau0z7jp3UoO/QP0g4STJ90okN Ww== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3n1xbrs8cc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 13:17:31 +0000
Received: from p2wg14936.americas.hpqcorp.net (unknown [10.119.145.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 53D6A312A3;
        Thu, 12 Jan 2023 13:17:31 +0000 (UTC)
Received: from p2wg14934.americas.hpqcorp.net (10.119.145.213) by
 p2wg14936.americas.hpqcorp.net (10.119.145.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 12 Jan 2023 01:17:30 -1200
Received: from p2wg14936.americas.hpqcorp.net (10.119.145.214) by
 p2wg14934.americas.hpqcorp.net (10.119.145.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 12 Jan 2023 01:17:30 -1200
Received: from p2wg14930.americas.hpqcorp.net (16.228.19.10) by
 p2wg14936.americas.hpqcorp.net (10.119.145.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Thu, 12 Jan 2023 01:17:30 -1200
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (192.58.207.38)
 by edge.it.hpe.com (16.228.19.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Thu, 12 Jan
 2023 01:17:30 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwQGSXqlT9MIwbAZ/B6Jb1dI4RTCk8XsulwYYgT336HXo3DmdRY9T1kIlb988NqN5YBstKqHj1qu9ONpTLIkqKDMqvrYpKcVZQ4XfS/mcXNAihPV4UIg9+qWVCUhlC6dH0n2ZAZrMuqmgRgu0CK5S6WKsAwSSTUnZJPjj2b1/4hGRc6fFx1C7i3MmTQmhXYFPX+MovHI1Dd5rY+b4vSHK7JLBRNfIIpf+jxkc9YxGH857VcQoidFNmRJz8qOiBExlbYQELs6dvFGF6X2L81QaVHL0s6voGdeG7a9mNl6/tG5TVuJ9ZcP8qAYTlGoKlsuubzdzbTpMriJfIoYrL0t1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kWQh/A5bvc2gpNDja3+lWLNVs46b8PPd83uubgYBdk=;
 b=BxgWgSCwKsjGsi9REmomfeTGyXeEKtqY+xiirZAYQ/TSINWUlKH0TZC0kLXIbxE49VRjOUdP7MqBPEj1Amzm9lo7UxVLYfO25GgpMUQ35B1Hmh+SWvIwCNwNZtGJPqbM8a/92jzXKt/Fw7FOJkzLLLTLpQgeaF3DczblTl7nhuLauV8bgiiJgcKC43ilNBFKEgjObT1vO+y8DSUZhpYFbKw0MKNnR2e9GBacxlpAh0RJQtnfnThdu5A/S6lclnLevF5RhsS0TLIcMKcP9wg72ZiNzZF92tRc+U/IoRQie0daw9qT8ucWRfllNYSQvOrO+VTLqhVR3CraH1I38DIJNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:173::21)
 by SJ0PR84MB1798.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:434::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 12 Jan
 2023 13:17:28 +0000
Received: from PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::337:c28a:4e41:d735]) by PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::337:c28a:4e41:d735%7]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 13:17:28 +0000
Date:   Thu, 12 Jan 2023 21:17:21 +0800
From:   Clay Chang <clayc@hpe.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <verdun@hpe.com>,
        <nick.hawkins@hpe.com>, <arnd@arndb.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux@armlinux.org.uk>,
        <olof@lixom.net>
Subject: Re: [PATCH 4/5] ARM: multi_v7_defconfig: Add GXP SROM Driver
Message-ID: <Y8AIYUYSZu+57Mea@enigma.ccjz.io>
References: <20230110042533.12894-1-clayc@hpe.com>
 <20230110042533.12894-5-clayc@hpe.com>
 <39774fd1-e89a-9c16-7833-80cae36133ca@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39774fd1-e89a-9c16-7833-80cae36133ca@linaro.org>
X-ClientProxiedBy: TYCPR01CA0045.jpnprd01.prod.outlook.com
 (2603:1096:405:1::33) To PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:510:173::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR84MB1480:EE_|SJ0PR84MB1798:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e00d910-4f76-4eaf-985f-08daf49f5abe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hffMPJvbhRqT+a2Jv9oBJ47hFN/t03FojvWywaSmnzSzOQUmgEVMseR6afc/w0R/AzCqdWjb3nPYOBWjYyvq+JMll6EKiq0kN3dOYDlZ7SN9eG/hVKihs1XYUikj5rqvvTLaEzNZg7/gKC+/Wo8iciHHuC2/g6hVpbnuR9Zhug/tgxO7o4GrR7tR5/wZb8a8DP4Pw1GarTHKpqsCpwYZCOeWdzfJDRNXYHHhlgV3IGVN6YYzrQOQ6RJbDhTWhsdhi3HBrNXb7ncd90DHliDYkzJ5QHIknHGOgkurBB3lPOzHZ4tkZcu/uhkN6rzlJl8JjHGwEHfmKk0icAEwsrMth8ALVjsD97jJD2aAtStEW8o4sIkmxEeHdGYQj/oQFvYL6g32xYi+AXSp9AQhpWbtBXI5AeE3v+kF1STnmUorjHWgSGuDEuLzcwuzBHU/lRtdadjFW/DaWqX7LKIlZkIy45lwDh9aHaSBMBpyTDRaFjOlr2UmHigDzI/IlAz4E/WjbXOvbItjvGHyImD/0gLYOb1lOMPwGybnjHOUTTDarY8JBaqE7W43p6hicTR3/NMgLlbXfziGDaebhm02cb5QxZhJ74fYf+dagt8S7cZLuHKSI6QC5V9ylNh1VaBi/5D44BdG37VbM6QmWYz0TyBmT4HOoStG5E4HCCwXste5f/JAuna30rZozbZ1P2ZLcExO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199015)(82960400001)(38100700002)(86362001)(41300700001)(6916009)(66556008)(4326008)(8676002)(66476007)(316002)(66946007)(4744005)(2906002)(8936002)(5660300002)(7416002)(9686003)(6512007)(186003)(6486002)(478600001)(53546011)(6666004)(6506007)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zsgBNn6NRxELUx1F8HCgR2DRthagkNfVPLhS6NYvX4DhbS2c/S/lDvcKwTHO?=
 =?us-ascii?Q?DUwLS5jbyl+Xr3noVAAGD25mdMTTmWGfmJuy8l2OytaUdUPLySlbKwjl7SYN?=
 =?us-ascii?Q?azYU43TMBvKz0bKFzUq16KuttHZJBQISNLYwyXxfINwYNj6hcFR26RttDArH?=
 =?us-ascii?Q?LZ7AWN8By7a5gB428rANiunl4ApvrbDCFxk129L65/UHVA1p0zee5xvR8pEv?=
 =?us-ascii?Q?Me2FO/pEo4sYLSJiKIOgaR9uDQirWM1O9QO6hI7YmuBeEo1PsDwRKabodxYD?=
 =?us-ascii?Q?P1EL6OVufzNH9Dc65fExjrOzLQqiExYvN3HyM79p1DwCY34sNCztORkhoPVa?=
 =?us-ascii?Q?HfxgaGKFXjHQLMBmfWu6f4repQfCjCyj0ma6mwvvt+0egZfVG8F7IPnkRQgl?=
 =?us-ascii?Q?0Ks0LDEXWtxg0FPuajA9AZ2L3Gn/yINNe1Z+A6Q1PJEvpPbRhCWSeEDylPEc?=
 =?us-ascii?Q?XKDdt0JSf4adM9KQrreYhlNU/02/B5O2kPHtv1s26vp0ALysk7wchlOarypf?=
 =?us-ascii?Q?DdbuL8Q63asYL2He0tOfnjBb53OxeVquahyIzfK8/9BY80w86BHEifDhoryN?=
 =?us-ascii?Q?XWvVueN3AjhJF7HT0iNGviaFgGfL9fG7iisHASdYlH2ZylGEj8RJOQ/pG/jV?=
 =?us-ascii?Q?ABic0dth7h6Z+ck850lbFToikou+D7aDEb6KBKeGBU8qTFmV+MytIhAH2ZgI?=
 =?us-ascii?Q?dmyuFigSiw6sky+yPrjDsDsp1YxbAxU8NDLbsbYkUb5aVAQnxVLHsuSUo43D?=
 =?us-ascii?Q?JKn6gmibSkfO89UKw3O3H4U4AdbbeuZIbnygUqnirabt8hqjEaKOS68X8t8L?=
 =?us-ascii?Q?z43xNESsvr6k/JcU/3sdTSLkeyDba/FsffKQHR9dorDNrbkXZFKWVeIWUVBD?=
 =?us-ascii?Q?LgiQ/fj6SdQyVrWpQya/Znu36PuCdx1Wf+J3XRraVkfh3e+0EoA1QEJFL3OF?=
 =?us-ascii?Q?XrOXD4ZjtrOl/dwvqOYOrxS8iiPA91j2VcpxNktsuMslS5CjzhobB9DqxM57?=
 =?us-ascii?Q?zEEAdLWHjq7+9ND2dRVkZmyt2+JmfdA6jL3BdoFDhiDhuUh+Tgpy0xWHvcj7?=
 =?us-ascii?Q?0em7B5tWxXlFTP8RY//7LUw18tdFBfnBohPHso0AhzqC/Czl2a7dHxal/9gt?=
 =?us-ascii?Q?UfDAK+41Fvum1PkRp00W38CUgxT3xmxKJOokmRwUwPzx6HtCxPDAl2aroWkN?=
 =?us-ascii?Q?DhZLQIa5Z6FpOUpoITphVPsdd/ER7p6Iw0sOM3IFPiosXd00QUrZJiQEp0v7?=
 =?us-ascii?Q?BuKgVTfPdwNBhhNuvFk5GHk9AjkOir9Sv8vfuLbviE/JhaxTX5fyBM9A4ny7?=
 =?us-ascii?Q?6hBfnuGa0vLsBfknwsXUtXOfVDik3lTHXv821nu5LOWipkFfhzZuG6ysFwHz?=
 =?us-ascii?Q?F6XUtymWcRynRPtJnBLwM2bDXqklUvAPNqVzY2CmFdQG1rOhKIHI894lQ0Yb?=
 =?us-ascii?Q?RDAZSQQxeOCsMtmdZMoyjNYcBs6Rzs72kiAM7zc7GTzRBijgvvp2m74u5Vgm?=
 =?us-ascii?Q?HDHaa1eyrwiSHhKhq2CAWoAiXiY1vXp7XwtfE4lzXhBATXB+EkTGQNDaQDEX?=
 =?us-ascii?Q?d0vp3FgM8/+ZUZ1+SQ5zaUJP10l3AKpczxChFlziZ4ON/km13x9Utzqd6FF+?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e00d910-4f76-4eaf-985f-08daf49f5abe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 13:17:28.8419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfCctUSZIvVAyxakeOFFQ+jSrFJmJvNjaDaAc4J6UNgQnGnsFeRFUhqrh8S86+78
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1798
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: X81CkDEL_PFf78rOvxKAITql_tjtAIFK
X-Proofpoint-ORIG-GUID: X81CkDEL_PFf78rOvxKAITql_tjtAIFK
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_07,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=362 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120094
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 10:50:18AM +0100, Krzysztof Kozlowski wrote:
> On 10/01/2023 05:25, clayc@hpe.com wrote:
> > From: Clay Chang <clayc@hpe.com>
> > 
> > Add the CONFIG_HPE_GXP_SROM and CONFIG_HPE_GXP_SOCLIB.
> > 
> > Signed-off-by: Clay Chang <clayc@hpe.com>
> > ---
> >  arch/arm/configs/multi_v7_defconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> > index ee184eb37adc..f50a3731b84c 100644
> > --- a/arch/arm/configs/multi_v7_defconfig
> > +++ b/arch/arm/configs/multi_v7_defconfig
> > @@ -1254,3 +1254,5 @@ CONFIG_CMA_SIZE_MBYTES=64
> >  CONFIG_PRINTK_TIME=y
> >  CONFIG_MAGIC_SYSRQ=y
> >  CONFIG_DEBUG_FS=y
> > +CONFIG_HPE_GXP_SOCLIB=m
> > +CONFIG_HPE_GXP_SROM=m
> 
> Don't add stuff at random places or at the end. Add in proper place,
> defined by savedefconfig.

Thank you. I will address this correctly in the next revision.

> 
> Best regards,
> Krzysztof
> 

Thanks,
Clay
