Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F78640945
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 16:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiLBPYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 10:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbiLBPYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 10:24:51 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988F5CEFAB;
        Fri,  2 Dec 2022 07:24:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSMevba3P0q9cx1brwutyuX1663uooTe+2G6lgrEBQ1tmPjFuQkB7NczHKU23GXp3XMjYPqlKzgl2J7Ft05JVoFSW0lK+HVa50h+KyYBX0Z7fRAnJsDS4k70AgcLG/8XBXH/wLVIxtnFC0QAeLvD6B66Di0aKJWWtdGemqof/+Jy5PCXxSi3L66Wm6i9+2gMny3iNMPe3NSTCj4iSMBR6H4cHpiLGJjgR0BBuKtYSWYPhftMQ1C01r9mJMQIAFHrdlU1CRv4Z7N6iimgd33bnUydh0PjeaeVVPskhsmd0YHY8O4gOntAYTGSbHGBVJkwYi5CBqFxfTE9meiT5JBPAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72OWx+MHWW9dAjHOv8ZIaFV7ZJqhTk8SzpWfB5vqRMI=;
 b=m82MPtrF5mugf6CwqaAN0dEt20vqkDQ6Rs+SNab6MoqNmb25aCqqpdAC0043t0YPsi9oN72LBsE/Fyis3dmMIWDtzgAiwcGMWOXYfCwNjvvHCJG17xE/nvE8wo1EanX2RJQawzIbS88jshwSay75/le88CN+tCmUwYe3k5zatW7MV54SGVwMiXIp1WPI6d9klKaa7cqEVjujgO/Pt94ne4xUGKojJpUCeNKZH0OX+jAYf404st92PsMrOWX7c1qEsFOllI9PeewDw158tFeuA2HjtUMvz7VpmL0Q+E9zommn2HCGEllkStPeWpt0DPwY5WKsTfuF1sSFKW0jrfzoqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72OWx+MHWW9dAjHOv8ZIaFV7ZJqhTk8SzpWfB5vqRMI=;
 b=H8hM4kmwa2R0QVkBiJsiH7UwBalaGdlkpiLsbKoAqiJRVrXIEcYphZNxjRejXCZZEkdFsDye76npeov8MFssBD0lR5xWMNKE4Z2we3WgCqrUzcvES/ADuulzMYQplxq3IgVvOHOPpglwjRLkqfTc6ndWdRoZemDaPHPFUaRPTpdxnedf0KInr9K90yjJ7HEiNOhIe2u9ZYJxPSUmZ3ZCyxftJYvruuq3HMWLuoPZgMK9m/qYIToUfHs2ziqf9pkbGZ3XZHUERyPoqRC6R18BYeWVw39/5A3OvojmeowsBv6WLlJlYImtM8AGg1v3Esxxgb0kd2kNYgTB7yqooU6SMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB7642.namprd12.prod.outlook.com (2603:10b6:610:14a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 2 Dec
 2022 15:24:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 15:24:49 +0000
Date:   Fri, 2 Dec 2022 11:24:48 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
Subject: Re: [PATCH v2 7/7] iommu/s390: flush queued IOVAs on RPCIT out of
 resource indication
Message-ID: <Y4oYwOnRpWhtwwww@nvidia.com>
References: <20221116171656.4128212-1-schnelle@linux.ibm.com>
 <20221116171656.4128212-8-schnelle@linux.ibm.com>
 <cf0fed35-2d9d-3d19-3538-1ddcbfd563b0@arm.com>
 <8ae4c9b196aec34df4644ffecb66cfa4ce953244.camel@linux.ibm.com>
 <6cd52999-7b01-a613-a9fb-f09a845a27b3@arm.com>
 <c6c4458bb49d1144a304e34c65a70dc2ebbb4082.camel@linux.ibm.com>
 <c06dc451129127b660d40886afe89c92471a913a.camel@linux.ibm.com>
 <Y4oO8O4wCnWAeoGS@nvidia.com>
 <175d97e1a9d29d712f0334e37fc207a50c3ac5e7.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175d97e1a9d29d712f0334e37fc207a50c3ac5e7.camel@linux.ibm.com>
X-ClientProxiedBy: BL1PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:208:256::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 61fc5d2f-f78f-49d5-b8f6-08dad47959cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y+8YZ/SrIKT/9RrbdihxvxJyprJQqydPF85fDzwWQD/3GBMex4zjBhfgvWHW0KcMxKsUJsKR3WuX3Vjv/oaAJqToDDHXQOeI9FQ0sutVNEjRE49N0FlI3h3K1WmyIT7I4Xyw6NCVfvE7jmLNA0hEimD8Gll4+OZ2hrmfb/Ak8/NWV2JytZ1h+EIUpr2eeIMEJknqHYBiUIYdS4jfA4dmZn+qZO5qV2hIADUf3eVMueq1/4Tev3h0bJHhGeFivsBqQ79gdW9mB3D3CZOggpyj86y/ohsp0CQn1SFQZObkX0pZo4VYYE+PRxcp72Y0CKkHJ6eowExl3rZJelB4H+Azmpacl/4AIOxYhwpMk0w7H7txq//pfffJdxHlwwNW+BHpzbDPfTOdshnIi4vau506/Vh7Ba1g5lgRJeeZ9X/2btskbr+k8T+H8awqcsea4tBFKQSQTLzkQJE5OMdBLfVctwV4NK9sEpQlOHFv/SJP8d9EjquNhFAhzxjSoQtYtgmxBjCTnW7p9iUf2/ErcG+Bjns1m1KbOVgRF0LlJycVi3G/8tvlru8cofsYpK8Nebl0vNV5awhmMhNPq8WX3GFp2NTWmqpDY/QOTyiM86y3b4NPKZ69XbPz9mrOLUiVDziMJr0UN2dYQ+d/CvsDvCRREwxvovl6ar1U233sRXVs8yW8lt5jbTe5bHwm5xG39kUH+lUE/ziM7Znu+VEafbIstw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199015)(36756003)(38100700002)(6512007)(86362001)(316002)(6916009)(54906003)(66946007)(8676002)(66556008)(66476007)(6486002)(966005)(478600001)(26005)(186003)(6506007)(2906002)(83380400001)(2616005)(41300700001)(4326008)(5660300002)(4744005)(8936002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KeI9hGHkxbXKTz1jiQIFnj6nNW0VcWJvSlP++KDvxoMpxcsez/hZ+9IrWDES?=
 =?us-ascii?Q?cAqkWaKGOKi2/Q7HNq8j7Q9ehJ6z/ZU1wyLIsKOpfEUNtpz+7Y9rmGaQwytD?=
 =?us-ascii?Q?9Z0bgoBR+QV0fcej1H2BRPpi5b66eJPEfd9DsF1g/+R0/ltYx23Y17iRLC8o?=
 =?us-ascii?Q?WMEclQqSl+PDT44q9jcrs0Qioe2y+Hbcj3yiciAyv26oACeOvV1CerC0bbpe?=
 =?us-ascii?Q?sd1RzAQLx1YcaSVV6Zd99ZVU6S3QBnxUAk6T637NY1fji+GipvveynxS07hH?=
 =?us-ascii?Q?BJdve09CQ8ONhIzfP/YOeRNsWC0+yxgsmD4NpBKInbwI0hbF7KYgLiYIxH+r?=
 =?us-ascii?Q?HoO4NFRnnwzKrZ71JiK2pHG2FA9/o9RfiOhbb0Orb58GAvD6v9mTwXQEM/zG?=
 =?us-ascii?Q?snF9ZoK71VF6VbW196LySAepuEdDXW5SHeTGCeNfDJlOI7v+avbUA5KFcPAr?=
 =?us-ascii?Q?VwzXs1abXvvbjkXSTlCutmwEnyo/BY3Dtgx6Pl0yggeH7N/wyZus44FQr0gS?=
 =?us-ascii?Q?Yj2x+sG5zRwrMumqVwfQJsJiP9yrDRW4dd1uwggOusjw4OtzFLoawChqKlRO?=
 =?us-ascii?Q?iMo16jXugI9GJGblpaw+6oEMLnLeINM3e8HB4xkniNW/dg0+ZWWDU6twUgVe?=
 =?us-ascii?Q?SwTzRr6avIApTwwnHEhHyiVPd914/YjpNka2tYncP4F1SRlMZWBe0ss509IE?=
 =?us-ascii?Q?576qwop357dfj1NXZTNTLwo57iT/GYwC7yhIjy2MoYmXy4MD85PnUSgGe+p1?=
 =?us-ascii?Q?ms8aSiiwXoKtyhMmsduQMfpu/bLxsF87HOSajHC0bNdBzn4WKb2OFXT0wNvY?=
 =?us-ascii?Q?VkHLGc0u5PODoahh3asW1yG1QP0MER/Anz+pS3mLZWPy/AQ4g7CeZLBe5o8V?=
 =?us-ascii?Q?qWAuE1mAEOXk3vHg12AnnwZt4XX2IDYlGLoZ0PaGeXSE0X9F+vL7G2xV4jWB?=
 =?us-ascii?Q?giYwVzD5DYAM/9giXSjkWNZZEfQ20CuGqZ6zjtj87uyXrWVR8QMfgo1/x2O6?=
 =?us-ascii?Q?ke171luXqsiToMnB+LJrC8BPWrwWkD6mMhs7n+d+kBERm9C587dsW8frLNKM?=
 =?us-ascii?Q?nbQBeb/fGQBa7FL6sRAGPQQjaWOHUeOpN51GIarbCHXOwd8q5TByC1os4ncp?=
 =?us-ascii?Q?HOAAK22vDeOPd+4vx1zEfQYNeDrhirzeYw8HwypuDC95/Dsq+1FR0TtTvMoL?=
 =?us-ascii?Q?VvMtyvj6EhLjQVS4tbd0IAZYqictbKipK00Sr7q6PJLb7GWLudEwK3ORmumo?=
 =?us-ascii?Q?nYdbiSFHrZd+f6DBwc9g+a/74oK658joEnOnLc3bQS5rsgISosVKQVW9feQF?=
 =?us-ascii?Q?ICc+WuPPvid3mXN0+PCm3rbEvUmUToAlo7rhcI8QfiLVaBzUgWpbQ9DqWL1Q?=
 =?us-ascii?Q?a5mUo240W1wWGL0U8/EsMWYv8jYoCCF7TQ2Gq58jZBLPkgOknEZ7KgvN9G2V?=
 =?us-ascii?Q?PSziWH+h1N1F5+W5/c2x9NknkAY8pzrGpoke1IZMwLSVThLm+lF6MHM3omlI?=
 =?us-ascii?Q?mPl0T/52wWIgghnAc/xcWZM+u/xLYPjNanGSQPcqNeVwtv23AhAzPZuqEmLa?=
 =?us-ascii?Q?4qLQEdl3UP1x6X05/vc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61fc5d2f-f78f-49d5-b8f6-08dad47959cb
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 15:24:48.9938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZbAYJrolmxE6DOk6MX+74XW1Q/gYQosjWRfr3Z356q3XFf23NEfMdGC623BKeUzk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7642
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 04:12:50PM +0100, Niklas Schnelle wrote:

> https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/commit/?h=dma_iommu_v3&id=a2aecd821fe3c5e2549946a68d8b07e05b288a9b

This patch makes sense to me, if the sync-map is optimally a
hypervisor call and the hypervisor is allowed to fail it, then
propagating the failure seems necessary.

Jason
