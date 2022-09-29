Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C48A5EFA4D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbiI2QWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236290AbiI2QVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:21:10 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD08F6C773;
        Thu, 29 Sep 2022 09:20:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7FLaj9TnJeUJ5eHc6X0DEfN3SLEg3R41i5Nrnn/vhdk9oSaz2L+TOhkekGkAWueHd6CywNAl60xMxfyK/SNaJ0hqUUCyYnCViy8/0UxK11EG0u9SUt+4LWvIKCPCVA2xn+fyp5azY+csIk683u5uT5PgZ7VPUkk8seLw2cCzuPg3yqRBi99yjwp6MIlA6pL+HqEAhUp2lLqzlFeGGnKWjbo2ndHIoZpsBO8TcQnWLIKO4ozfVpgmBEhV1OT90sUAUXODree0OQNreg/M++WvvV0bwEEFWA72jlmV1Kftj4AYOcetCJGMiHPe77Urxh62LFXvccq+DhCzuB1fSe96g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ERtdDCg/37mjwioZEq1SfrNFOeefIa1aqPA9zkktC0=;
 b=aY8MlhRYU5C37IWcAepWcGXTrNe9i/inmUjLBBlmS6O3kIanj8rGABghgpTw9TuZbuKElylDdgfR8QVnATYSNIVtBu8KoMNnuxrU/FV5Nzn95evvZcXhm1LZSu63/gmyOUgjF94DcwkmcCS2cgnp2432gd8eqsTjhJL5tqYQTiUxI4Q1EAgCVtGovzdFKnJhOCRVatx0xctg7EXNK0MgffbmaYWu52mRSwmGtcsaM7rn1a1KGpmk7u/bz/aj/+N1aPwbuxjUK1zqank1x6psm5jCrCLzqpZZdLzLj+5cp0p4UtPjs4z4nYaIlJT168zcMbtVOj5VM2y7B6VdG5mHHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ERtdDCg/37mjwioZEq1SfrNFOeefIa1aqPA9zkktC0=;
 b=ixpIN6wTcuutq9unZIm6iFKu0jyDbJZNCOjf4G2BOc1w/rT3wQ5lpoO9TL6UcYG6xnRmzKM0PNX3WxFhNXI1v1HRsknqTcC0vGXbhJQhFiNAgtDHwawPz79d+KmPoz6bkJgjkZEt4uySt5Be+3pDONPn58Uq8kquEt2vVVz8UeXAO3JbrStHKeI78W9jcc9djx8sMhKSNFmDwoDlC4RuEiUUd2kQDC0bz2zPlz9+Hbzn2Gakkm5Wu55KTtauzQWtkpoxbYsDf291RI2mS8Bgyeqryy0i8U/4yhVqvMyTGSOlMqRPLOc4kOWEZVchCS0dvzRjcRKTqVsI09ZP4hBUKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by IA1PR12MB6091.namprd12.prod.outlook.com (2603:10b6:208:3ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Thu, 29 Sep
 2022 16:20:02 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::f0c0:3a28:55e9:e99c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::f0c0:3a28:55e9:e99c%5]) with mapi id 15.20.5676.019; Thu, 29 Sep 2022
 16:20:02 +0000
Date:   Thu, 29 Sep 2022 13:20:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] iommu/s390: Get rid of s390_domain_device
Message-ID: <YzXFseFbiwZFSx9N@nvidia.com>
References: <20220929153302.3195115-1-schnelle@linux.ibm.com>
 <20220929153302.3195115-3-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929153302.3195115-3-schnelle@linux.ibm.com>
X-ClientProxiedBy: BLAPR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:208:32d::20) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|IA1PR12MB6091:EE_
X-MS-Office365-Filtering-Correlation-Id: db197d5c-5bb0-4257-ed11-08daa2367617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SPwGCOfveBFfIyRb59VIiD7UFYUTrV4JYT8sWii0lo4WVKS2Wa1ZcOKz5w4jZXq1vGngzl7+WCj2m3g9JzAr3wXGhU3IzaiSD2RXt38wlsbdFXJS1anqCWNEMxP6TZzOOfrnqmOHS2N6S/My0zNbnjkDBVrWym0u07XWz/8cNjVANofSkkiAPONu2xSP4yZ5xDcAzOeMm2NuIxjojNC4X+YWbH+2PCNpO9SV88ieyN2L7htRa4HqQfigTaqrKpC1TxviIV83QHm2FXB/V9XDZFgC0Co/4Ph3kDbMs4GS3lhQP2RGEMbSfGkphqTQoE03Zb28N3wuBPHkVToYrOu5KU+d/ADLR/nhw1aF97jm5ogmpvr0hhHb9Ueb34+IrUIFp4DDwm0WGHmeeAqWjq1dVAAvAUsRNosp/c7FoZwGLdJvCGd5KGBT147wdGe9ICofiWiTopu61Pqq5kspUf9okgv5nLY88J21KjKrkXaqRErsVezFLBIUOyiYWGX9a1CgVGKM9zMBVlFarD72DceEyRTc3TcqutCIyLtJa4pfK62miikm1adC5znOb9L7EYk3g8As/BonzxMaehSsnyRnUeBOg0DN1f54dIpoNsi5TIUgA5IMGg0BrINoFVX1MvPWNtTlJ1zdtWgM4Qdltltiq1Rcixk8MWLTvQkPl6xPLVnvfYm274g0CZT2PBWLd8/NItEjwXY06IudftzsI1ghfY5TTXxxQAL+cwZKowYBwsmC/iSxUstARQoto9CalAXv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199015)(66946007)(66556008)(6916009)(8676002)(41300700001)(4326008)(66476007)(6486002)(316002)(54906003)(8936002)(4744005)(6512007)(26005)(2906002)(86362001)(38100700002)(478600001)(2616005)(186003)(7416002)(5660300002)(6506007)(36756003)(26583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+MwHehKyyQptup/t9IL7RCbD7VuSd4c/lYBXrjwacCfyQRIcBw5XhOToCiy1?=
 =?us-ascii?Q?5C/HVZQz9ZQBWdf+wBExRKZYoHUxAh+XGCcs1LFkaRWLeE0MNshmgMEMhgWB?=
 =?us-ascii?Q?e28CXwRvC8FTcxOMsvoZeeB16Zw9pA4CG2tQX3UeSsI6s+4hLWCd9x/2goEI?=
 =?us-ascii?Q?tdJivQPjLarUxjp27WJiVcc5hovmmCtaagm4oDmwkSR8OQF1PH7nAuCyHBjG?=
 =?us-ascii?Q?UipEPDTvfRt4ANt2FX7u/+IHlRjnQ8QslUJvOguzEaEPJKwD6wuMIgKpru57?=
 =?us-ascii?Q?721JQ49R9ttkyoL13S6UP8Df3qHJ6WDF6XyUJdM/nB/mztue7IP1cvDI9E5o?=
 =?us-ascii?Q?n22maRjXdG1Y92Qb4OgP1X3XwIDMvx7vrfZtYsFp6g1A7WD98WRsXvmRdhTN?=
 =?us-ascii?Q?5mL72Niuzlr5DkOjE0tfogd0lzW6CZrVcfethWR16bYvXHV2SanpFOjrxbUS?=
 =?us-ascii?Q?aLFMZQTusT+p7rmYwn3298n4vgA2eIGdDcnNAHenNiUSrhKSksPwhvGnbLZ8?=
 =?us-ascii?Q?q6OSuq+71G7Wa4XhvjRzZepaiBPvCDWqaOcmxTKklaYwUPuTqqEtF1JbfFC8?=
 =?us-ascii?Q?wLb8SiEVDR65kjPH5k4H9mQtWno3P50fwSm2yhG2W9bNMeRlrIiw0u6aYWql?=
 =?us-ascii?Q?BhVfRySCmROYUafxbdqv/FlPEDBOa/PixW8itdSg2AU/JFbSoT4G/m6edC6G?=
 =?us-ascii?Q?cEtxOG0rxde4zoFjRgMFlqgndFThRNi9aDHlEp/Pm6Av3K3JgPrPfmGVCjnm?=
 =?us-ascii?Q?w7sPr9k+zrF8t0iW5i0pQ0HIO6UD7necQXhVEgFp+L5Vp8M6OFJC8wos+eWN?=
 =?us-ascii?Q?TMVePN0UPNzgWHLOWhO+OcPw2cxOl5JTHTLrZ44GAfCVGBfVsod2k2fcYhTF?=
 =?us-ascii?Q?OAL4Dfelv+3/g/2MtLYNn2fAxTNFjxTGvV2cbWhGPiS3eVTnCZjnQfi9FqpI?=
 =?us-ascii?Q?g3oyH1Vt3lWSkTu9IT8iLnaFUNa4qWgL9KtypGwZal1lgT8FoE0hCfZW96X6?=
 =?us-ascii?Q?EdUcOqbAMI7iC7PaZK/kHoDbl/87pTD7uN7pmf5yDPWC/WVQAIo7vsMuOTp4?=
 =?us-ascii?Q?Jnmy+yaqU2W6SfbyvN+z5RaxwtMFseg0lWLvf6ctmEJ/QpiBM3GPekdx8ocq?=
 =?us-ascii?Q?3afsm3kGCBme9bOS/FgOkepBQIjovESXICUqRfdPXJmJm9F2ms+bKtT8nfgZ?=
 =?us-ascii?Q?pcxuexQDfh56jGmr/lHFzRoQiN1vSfT0yWrC2Up3ZOgkUB7tCVqDfCoysFzS?=
 =?us-ascii?Q?DOgZLDt5iD+vfTnWLfmpSmIR4ImodbAZUH5KlG48lU3bjX8Rf4pxOm5PkttC?=
 =?us-ascii?Q?vV/haTeuxSuEDUTTzZc0Ze3TsNSbXgjhHER3agaQsmff/aaJfYScp8m2Q4+/?=
 =?us-ascii?Q?f9MJT5w8tctWCoNB10S2hfMVW/uwIbKp3nDmFqVMb3mQZTgz6BZhwVcFXUyS?=
 =?us-ascii?Q?27pfrkljkOzSlHOYYVGcwXyLQ05jMF1/jmE+gEGZducT98STLnoZGU61uLcj?=
 =?us-ascii?Q?l/ha3vqqp3qxRMhst0fNk/8oRaAQ0RmyzmA2AZqc2ujSGMohs6M6+wOhK6VU?=
 =?us-ascii?Q?mxJtFgHAkyqTmNLfE/E=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db197d5c-5bb0-4257-ed11-08daa2367617
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 16:20:02.1278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6ucap6nOFEqgjhjaVhi+WLaO/9u05WsqJhkpfspCrbI6XgvIXDaQpT02FgNXUnf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6091
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 05:32:59PM +0200, Niklas Schnelle wrote:
> The struct s390_domain_device serves the sole purpose as list entry for
> the devices list of a struct s390_domain. As it contains no additional
> information besides a list_head and a pointer to the struct zpci_dev we
> can simplify things and just thread the device list through struct
> zpci_dev directly. This removes the need to allocate during domain
> attach and gets rid of one level of indirection during mapping
> operations.
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> v2->v3:
> - Remove search in devices list when we have the pointer to the
>   list item (Jason)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
