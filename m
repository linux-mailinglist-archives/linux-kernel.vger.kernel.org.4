Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D7066730C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbjALNSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjALNSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:18:43 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FE51E3F5;
        Thu, 12 Jan 2023 05:18:42 -0800 (PST)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CCIv4j032551;
        Thu, 12 Jan 2023 13:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pps0720; bh=7Dsyh+GtOmF3ELHbK3wucFT8G+cX8RPbqCVEacH3Iu8=;
 b=Ohbj0/9gKlrV6S88hbK1fyteZXR21otUx0XUMCOZhoHEcK7flTKiR2wDLJ6xzTRjERl2
 1pj8xXLSp8QzzMDzG0kCG4R3pd6jG9rhz+auo2c/ZP13XycGb0qoxMJWozRB1LzU5h7d
 zZZ6wdbVeZ9WxcFxkJNVUCe+SKhMIWZcl50reEcua48CkRVXg0EY574R5sUARiqyhekx
 ZyOUHCkR1MgNvKqKM7uSnZFeQIdXadvh1sGjHKUWuAdPzbMvCtD9iD784I8DNQHQdJ06
 Vj1fESC9nvodaNeP8np5urjbbVukkL/Tfpev4jvIi/WqvL1f1Hljmb5vCQ4GSz21U5MZ uQ== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3n2fc9j62g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 13:18:27 +0000
Received: from p2wg14938.americas.hpqcorp.net (unknown [10.119.145.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 7ACA5807139;
        Thu, 12 Jan 2023 13:18:26 +0000 (UTC)
Received: from p2wg14934.americas.hpqcorp.net (10.119.145.213) by
 p2wg14938.americas.hpqcorp.net (10.119.145.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 12 Jan 2023 01:18:26 -1200
Received: from p2wg14937.americas.hpqcorp.net (10.119.145.217) by
 p2wg14934.americas.hpqcorp.net (10.119.145.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 12 Jan 2023 01:18:25 -1200
Received: from p2wg14930.americas.hpqcorp.net (16.228.19.10) by
 p2wg14937.americas.hpqcorp.net (10.119.145.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Thu, 12 Jan 2023 01:18:25 -1200
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (192.58.207.38)
 by edge.it.hpe.com (16.228.19.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Thu, 12 Jan
 2023 01:18:25 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQtQPJVGJw6RLroyYqSJOH7I2cqLnikqlVx3fDi0u9kq2xWzk+CutOiy9+R8+rKLi5k10feP808Mk6WwCQd6URxMtH48tW08ciIYNm9MzjGtlcGVMmv5KtOWXOZeDKfDVeZlQ6m4XgcfcGIdVLHRt+b+QajYTRIITiXjBQ6jYvNays55yKo6diBHha8JCxdRVhccxLxKEVWGx/OjWvV1XX19kLzg//lIay01YU8PpuSuejr8m6ral3P6O+5X7wTirnLDF1LlZAKi7BTx4zK31l1QaAKpcwT5fHy1t4IZUBdsXmT620qCYSgVFD+OdlYaE2N1OAu4fpW9apJFO4/QPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Dsyh+GtOmF3ELHbK3wucFT8G+cX8RPbqCVEacH3Iu8=;
 b=V1v4wOOpzZmlSfTxe4o/EWEvhgk+00DZAh18kcmAchA+IuBcXY7adlKsCrguTuPAYGCaVZW7sYvVuCKiVxs1BRY4jCQWeH6Bm3bEVjNK7fyj15XNNMaRmkw41IEFKzFq2PzJC8wlfyGcx4qfLtbOOeFcMuP7+FEwlUT7qStJogYnFQC42pOXaTwF3OBkZZ+yZBTVCjfNyheCsz0yNA2mSe9ypCurWumofIsdK6EaK4gZrk2jEZm889x8woZvoKun17AyUG94I6N5+yCYpv8bn/9koArmzp+3FbN/ZA4ELS3g4x2FKi2A1o4Tyr6S43YxJ1ivwRQvi3wbdHzi5hbPCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:173::21)
 by SJ0PR84MB1798.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:434::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 12 Jan
 2023 13:18:23 +0000
Received: from PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::337:c28a:4e41:d735]) by PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::337:c28a:4e41:d735%7]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 13:18:23 +0000
Date:   Thu, 12 Jan 2023 21:18:15 +0800
From:   Clay Chang <clayc@hpe.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <verdun@hpe.com>,
        <nick.hawkins@hpe.com>, <arnd@arndb.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux@armlinux.org.uk>,
        <olof@lixom.net>
Subject: Re: [PATCH 5/5] MAINTAINERS: Add maintainer of GXP SROM support
Message-ID: <Y8AIl4/J+YwsQrgF@enigma.ccjz.io>
References: <20230110042533.12894-1-clayc@hpe.com>
 <20230110042533.12894-6-clayc@hpe.com>
 <83e7b2b0-1840-bc8b-e657-ab94975b955d@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83e7b2b0-1840-bc8b-e657-ab94975b955d@linaro.org>
X-ClientProxiedBy: TY2PR06CA0033.apcprd06.prod.outlook.com
 (2603:1096:404:2e::21) To PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:510:173::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR84MB1480:EE_|SJ0PR84MB1798:EE_
X-MS-Office365-Filtering-Correlation-Id: 56a4744e-053b-48e1-9388-08daf49f7b58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BI6Cy62x6f1gwumpZ3oJ0gjudVHLSaCO3Pg8HOVEWbUJSDQUFvOTNpUKVnaj3OKunVmkvcZ1ImUPxHBI24SlTYyXoxjGlxht6NaZDZZ0hK3esdqZVjXk7W8f7kLV04URK59wLCXmKDwv85Gp7E8A+0cdIzl8G8SApz6wOPa0BhZsUEjYsA7Sjz301LqXT5y7a7hXEt+YA4RLEg73EoubspvRn6voL5qezBtFiRrwjYYX5yIHtTuq+WawYa1iCSzOADs0g4U5kIfRPi3GSsQme0Ufxg7ROrI2PqReMKi/FKJfQgv97RefGGpW26wKA+S+kvHvxJNF762tDHftD9J7mY0Q5QO2jJ+jr01Q7/bRTxPI2MfhEjAuW1yDpZGVSocCQRPx9mi4POy5on4X6q1OiBlKc7ykkI4vXGwa9omK5IyZC5Vjw/iDXdczqumG9J7Y3M+JQKwu05mDFb0pnT2SJFfgPmU10q4qZhcCtqEKSOrZc9Sxqohj6cA9QyzXeqD2P1hZjUqcD4Pz86vTyBb9xsnmD2Lx38YK/RX90JmmM7MZG6mC/lZ0NdVsqFhXFMMLXK5zMSu+1xinXSC8ALjOxLwMJ7qlbNq0vsibLya3hHdVqXYw0qcBPlfZroncBi1cs/h2FGFvBWW01tXuZlYa+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199015)(82960400001)(38100700002)(86362001)(41300700001)(6916009)(66556008)(4326008)(8676002)(66476007)(316002)(66946007)(4744005)(2906002)(8936002)(5660300002)(7416002)(9686003)(6512007)(186003)(6486002)(478600001)(53546011)(6666004)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UUdmKtmjRq08n0JgR7+vMsXELN0cEK/AAlApK5DyFchERVWz5VK0zXT7IMNv?=
 =?us-ascii?Q?yBanDEO+nZYsCMrYU/3VzZ/mT3ZWH71zsVQr5xTB2QjvLa8sQB/6twPkZp58?=
 =?us-ascii?Q?FGoSu5CetUaUi/C0rOHYt47DFAwDv/mGlNsArzJzpS+aEdN5pRBf+Ci0Px/6?=
 =?us-ascii?Q?RSkeEExLLHXCAM1gDwiZWd8rOOFDAdgvtTeTycuAUfmVc8N5CGlCkWQwFrMZ?=
 =?us-ascii?Q?+0FeFOtPSTCtRqALDeb/2oOy0mUpndgfm8Rlgdc9rOwHX/5kNSCx5u0qmepJ?=
 =?us-ascii?Q?aKM1QOjmEXRDndm83Hn+4gWFtQ+gb001yEpHGVxGxGf1xm8WLVxGsvVBFsWl?=
 =?us-ascii?Q?1l4XtxvCgzuBzs8JB5nZWxMUnqqp17+FozSFKe+LiMw/pUgSz7Q/MXqYTRW2?=
 =?us-ascii?Q?i8+AxU93ykB658Xxcm+tAN7fablAAKPgHKp0PVAQZ7iUcijG4CMJLZoI/la+?=
 =?us-ascii?Q?t2WPwxfVPD0LIuHjl2G7M9GDe1BGVSILgnuf/FCEM5JluYyz7+ihCpvP5ZaG?=
 =?us-ascii?Q?E60yshRYczWdz3bpq6Kyr4crKoRSt2OJivsGZG5Y5EV7nAIFMycqOsf2P4oz?=
 =?us-ascii?Q?VSqWtOfdX/socXqqX5e9WLCzhJkamJ9RpsH5KwMigmnwiqX4+Cppy5hN0UF2?=
 =?us-ascii?Q?ycqCvdCHu9QwxNWa94B7hPPrjA2U3l8lJCT3B18UDK4HSKuHpvg31XeT7omY?=
 =?us-ascii?Q?VH6hzGLfZNuLNRfXL2cjES0eRviTiqtqS8E/duTgNOgu7sWvmRoRMbl8WHei?=
 =?us-ascii?Q?ogi+TbqbVmV7iUVKpEb/hL1dNnFBH3u/8Fu85WlQ3AbbTDgovYAT1IMAYts4?=
 =?us-ascii?Q?UOYCgVtlE8mSs83RrDbHqoYv++KzT4tOdTglSav/I4FmgjhR/pcg6052nJuq?=
 =?us-ascii?Q?NLjhTtrx7kYmtEOKgTSCLInTNFLctnanmHoKHse+O9S8bS7UfRblJy5XTNnc?=
 =?us-ascii?Q?EtGgQMpugHzaDULfPb1tFNAOIeKWZ5j1qJt7XBTcxmXLpk/A7UZCs+TeUdQR?=
 =?us-ascii?Q?0ycbTr8qqxKdzm7iSlh/Y0X8bOhr2fVJSuV8eOYuR48s+NATQnabsDywUvVc?=
 =?us-ascii?Q?bF0w2f/fr7orbHS0Jqgo3uKIwb+DWOFYYQWZqBUDFDsb9mVROG9NBVMXstB9?=
 =?us-ascii?Q?wFCaLwAiyEDThQvOY7HGrH1Mz40wkZxayAgF4UkkvQjhtiZc692uw9PuJ7Fd?=
 =?us-ascii?Q?8heimhaA/7cwZYcAKGNZl69ykLw6fIdPM/y726VdhtPD1ptwOxkADp/58ScH?=
 =?us-ascii?Q?g55fCeRljHja22fD0lM47UTyu/IG0TtpA0d064154XrjFWWZMB28nuF63CcL?=
 =?us-ascii?Q?3guyIVgDGCNUPpyhduDvXAuzXcr188b/KDhXzwQIOfmbWahXPv3DFtDJ2j5Y?=
 =?us-ascii?Q?QAyTrjf8NnRWGZuYEAMbVcNparp6d2WqwELwRvuZiSyptxn/zhw+XV27zyTl?=
 =?us-ascii?Q?HaunKse/BvA4rqQUTs9i1T6Jbuihi+HsJTvzKL4TgQpCsJg2cwwz3Nfv3bb/?=
 =?us-ascii?Q?jC7ibAeqDQwEZiEQBtlsknXD2d1WU56bcphpQEbErr0A0K0nlVM6rwDL551g?=
 =?us-ascii?Q?ekvWx9XWgbkuHZ/WjMo0IqdgIkLh5b81LSutbaYjxIKYxd7RZ6eL1DKiPMkH?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a4744e-053b-48e1-9388-08daf49f7b58
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 13:18:23.4444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vyySUfVMSejp1l0CM9/lVTU6AF1EhhIWGzh2CBhrSuHXjZY5eVJODQxuVpLXo4ZU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1798
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: 3RQt8HVWlNZ66_GRX8lrxnD1KkfbZdWx
X-Proofpoint-GUID: 3RQt8HVWlNZ66_GRX8lrxnD1KkfbZdWx
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_08,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1011 adultscore=0 mlxlogscore=953
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301120095
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 10:51:00AM +0100, Krzysztof Kozlowski wrote:
> On 10/01/2023 05:25, clayc@hpe.com wrote:
> > From: Clay Chang <clayc@hpe.com>
> > 
> > Add Clay Chang as the maintainer of GXP SROM support.
> 
> Your commit is not doing it. Nope. Either make proper entry matching
> this commit msg or make commit msg reflecting truth.

Thank you for the comment. I will address this correctly in the next
revision.

> > 
> > Signed-off-by: Clay Chang <clayc@hpe.com>
> > ---
> >  MAINTAINERS | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ea941dc469fa..164571ac1cc5 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2279,14 +2279,22 @@ F:	arch/arm/mach-sa1100/jornada720.c
> >  ARM/HPE GXP ARCHITECTURE
> >  M:	Jean-Marie Verdun <verdun@hpe.com>
> >  M:	Nick Hawkins <nick.hawkins@hpe.com>
> > +M:	Clay Chang <clayc@hpe.com>
> 
> 
> Best regards,
> Krzysztof
> 

Thanks,
Clay
