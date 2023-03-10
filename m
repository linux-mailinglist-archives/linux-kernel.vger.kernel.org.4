Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35BF6B4B71
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbjCJPpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234502AbjCJPou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:44:50 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D7E126FC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:33:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvCa8hCt3kySMGllP0KZ9hMj5DmYKH6daH84WW6T2r+lt3x0ptjhrV9k1loWLAHOaWt2G9voInZQR72sXDZxzLtrEfV4T+DDojx8WV5zgdsRYwxrID5MJdrPrIY12Z8rKEwrQZqUIeseFrPXda+CJGJ1mNeNSvHY2HiVAmil1YiuetQtcdvUH+osfHle0J+zX/mAju/Zr+Ej0tQrRV5cUZJGa4HxyiT2ZEb/snLl5iBJbHBJyxpRrphp/qXTpR825BgZklzdvlU4cYUYjtQuaNSb2PNWrvKAbcP6FmG1YNhwbs1Y/aA6pMiZbU8kaWO5muLqucvLHHw7Q6yhL2veKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQUMvJ9IQ4RtEtKpViA3C7YicBk6ZYLf3GxByyiFbmw=;
 b=h39NLbm4iIIin4MsW2pZ27CbBHfsS74YJooXW1drWHunhX3+/wzVnsV2iPFL0OZ5CvdQTB+M6VTdq6aRKrX4X2YVUleNAsK/iek1O5UOlDW8AxcRVY8iC5Xeb25OLPdLKfu46XqoxvqZ44xuW7Fgxdfhmm23lQhozzxyI2SYdDeuwGQ9Vt2tm1iy3/oYdJKmY2NVOhDyj0erFLtawRkszopOFeM314RqPoHz2JD+HUB6VQIIhmhIm5i4JtNItk+NlXi25ni9Y3soavTnWsxYVqe5/6VEDP1pi5ZAYWEYwDfXpGiG448iKaKTVyc0+FuXlq0HTZqtdZj1DZbPPYTwnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQUMvJ9IQ4RtEtKpViA3C7YicBk6ZYLf3GxByyiFbmw=;
 b=Jmc5Y3I6ZuIrg3VR+Siad7aD/Wbix2upf16Jh6OewF6UvfgVOLnZsaNrkXTwvR1wLt42h15rWSQPtoLaJq+zHpKTILYsFNUt+tmQm7OmulSjgLRYxxOYDaYwlG0EEkblTAFwhQXEfTwXt1HjqK6j6YEVVxWCh9nftMl/CfolZ3zWHpedZP/gJ9cN4xVaft1sUpinjLkY4etC2QJiovyNCtqhJHWvzzy9Y0rNh3V3MLxH3Sr8EbaTOkpTtYSGgeVGvJs5f5Tz048VWsMYxXlcJje+q3jBtcdxc7qkXgGIX2VK8GXVu3odV4T6XgGuyrMfwUypflkrDNEpujDjhhiqMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5402.namprd12.prod.outlook.com (2603:10b6:510:ef::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 15:33:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 15:33:03 +0000
Date:   Fri, 10 Mar 2023 11:33:00 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, robin.murphy@arm.com,
        will@kernel.org, kevin.tian@intel.com, baolu.lu@linux.intel.com,
        joro@8bytes.org, shameerali.kolothum.thodi@huawei.com,
        jean-philippe@linaro.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain helper
Message-ID: <ZAtNrFAEHvmM4FOW@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <9b1077601cace998533129327f5e7ad946752d29.1678348754.git.nicolinc@nvidia.com>
 <eddde530-cd37-f493-7f0f-c97905f0de64@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eddde530-cd37-f493-7f0f-c97905f0de64@redhat.com>
X-ClientProxiedBy: SJ0PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5402:EE_
X-MS-Office365-Filtering-Correlation-Id: b73156ac-94d3-4c8f-cd9d-08db217cbccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +hPqnj4DCNyRBQELliV22VlkuyDWfwhHSqScgT84NSv43c2R7TcZjoux4354gTYLUA/ecFchk9E10CPMFmyj4wUmYyRrcCda5hbbqCQiZTqxumzXQ0gSEMKN0q+wj3/ZUSGsavm+cM1tYLJfXl6Y8o60emT6KjjqbWENGRwF/R41Bvo5MhHkor28HGXsiB4FQQJd+gz73yG7bbpCXQ6XtnHEpuC9scZ3t9yKjVSGf3t4enPoGI2fGxgTKbrpRgHGgI15Y+YwX4ssxHq1kNncmRzvHUX7MlVRjNfwGiTCMYYs5T6nQn1ljgFIA2cJ3LI4xIn5FFftGgOZzMe8u2M3MW/DmGHETZ+DeXRb3Uh7WZKBZAEDBZxAwSt70x6aXl0Nb49pClcLbz+78pGAcQhJOxlHwXwDY0P8peqsgdooOb5cGAsUX0OH99GDboXlISC3fTdNuqoeHltGhRuQUA+yjBuhjZJRYTs8pZRWIGr79z8wL1WgJetzos70SaftmLhJnmaPCQPjvmFUKAsKezmaEH3vNo9QOSI72N8aZhIwHLkM3hozUFZrqrux69Bj+6R2wsO10wP68wscXqmq5t5TNE50s7AJrClePHPV5x1Pd6KemA57bA8V4Qi+Joqa8o1Hw9s41Xx2x19pJuKwlgStQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(451199018)(2906002)(83380400001)(4744005)(36756003)(7416002)(5660300002)(66556008)(41300700001)(66476007)(316002)(66946007)(8936002)(4326008)(8676002)(6916009)(86362001)(38100700002)(478600001)(26005)(2616005)(186003)(53546011)(6506007)(6486002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nnq7Bgm751pUHQS41o4VI/9khcq5UM02+4MHxb0g8Y8f5NlSBb46k8eC0Mtu?=
 =?us-ascii?Q?6e4c9jaYY62Z9R71UMIc8+4FalaRGX/uM78TAjv9WdgQtRP49cJu1ZgAfOeV?=
 =?us-ascii?Q?mpYMe5C5Z6TpvwB+hIeUpNMU6aYFwxzhmHOEN3GAUgvX7yqoXa/z3zVn+CYv?=
 =?us-ascii?Q?7okTN1J14WD2pKcREKKwZqDi3GkMkEDMUKStqxL05qjNfIISE/OmfBvR1Lzt?=
 =?us-ascii?Q?tnddCEMCBB6Ayu+Mh0IBF7aBKfmW05Bt4yi9w5IECsTd+jgJzOpVijSePnug?=
 =?us-ascii?Q?48e4j3FAFql1NUfooCIEZNEl0m2hpzvGMwUELdWwVJLWyzVSkUhKO8SIcgh+?=
 =?us-ascii?Q?aPi3iX0EXJg82ZQTlscDJWzbxaQ710fVDa/fSUmgV9G9cr5Ey4EVH4sY/dF8?=
 =?us-ascii?Q?hwPkG2nl9g9bfvtvE0v+fwg5CdWGn0uIscfQvrTXl8Lp4ose+OlNndi4ZBab?=
 =?us-ascii?Q?UJOtKUDn3Dkv/rNt+3UA6j6UHWixVL0F/0M8/89lzhQ3+kzwmGZhAPLaW8ix?=
 =?us-ascii?Q?vpRhYZ9UEJVZ30czpNl8pOfX9cxbJSlUnlRYHhE1/yWVdXmQ2LHZf4TKnX7u?=
 =?us-ascii?Q?sAqKv5db7E9g5RFpkaYxi7vJqaBxVZSRXhrUgb9rNim101ql/LyLzTrTOgKx?=
 =?us-ascii?Q?nL7JCmbLtg8RZVlACLrKedC1fu7uZ6QzPNbiKm8H/LY15sK0VDRJ+KG6EwyT?=
 =?us-ascii?Q?YfUKOso9A8nAnkkhYGGtuGg7rcgBPpjZP5Lzcv77eOFRMs8h/inD88tot8/N?=
 =?us-ascii?Q?Dtzg9DpADLNHX3TD7xB/852S8AV+lQOAFIqNRSDLpNIordOZodarIxTMcNLw?=
 =?us-ascii?Q?6xWGWBpFcm1RzkK2LG63xjRCtfyuJ3PY6fDlCI8h/+hhC6tPheJNeR/gImgU?=
 =?us-ascii?Q?wSCXs9f4hU86kmCHV8RX0G2AbKJNKjNllt71pfyrnehcfG2hPNUGcIRoB+I7?=
 =?us-ascii?Q?DCXJFYWAn3t651U7DDA6x2hAQpbrJdGLYPgJnSlbKJ3A4T9TIp4QWpfmiXJl?=
 =?us-ascii?Q?rTOHFFvEzRyUXIHHaV4SkKGOq25Cged2IU/jA12NdLfX7C7cdjezHcSqV7rR?=
 =?us-ascii?Q?I0lOCt8gbiDjeyq/KIWD6Lv+Zkc0zLF9X36VBar6DeI7FCVNSQ0pyDgLi5MD?=
 =?us-ascii?Q?gYb6pvUaGSKJ7bNDBUPLlmla1EJWmadD0SWGw2iaxCP6wapziaxTpVUNFEqe?=
 =?us-ascii?Q?AhjtZEvkk3176aAbhgnUjRQdIiXo4EqrTsca3QF63Xk0uIR3APJNys+taUAj?=
 =?us-ascii?Q?1T2R5XIpJujgataSDNCXMXf+CWYcS54Oo2MjQov82EGDNS4FOhMBpuK94+w9?=
 =?us-ascii?Q?8z/Ilr8CRlW+IrrIgaorL800N3nexDvqDyc6iJAi0htA1Tjhwo+LTt2lI9q/?=
 =?us-ascii?Q?w0Z8owhNAfC1jg9SOTu5t5oXC14ui2vlR3Y9aforSzHS4elGJ/YvfMtM9KbG?=
 =?us-ascii?Q?YoG1hcioIbmsrCCF7DgrWtX1FrIgpO98OsM6ssIMGCg7dSxnIEOl5wqAweAJ?=
 =?us-ascii?Q?UCuDlL4dqxuEl4nDp+U+XybsxByLC6mNOEgZR5kkkZ77NziZcueU+Wpdu3YM?=
 =?us-ascii?Q?tddKzUxfDlto13R0mCLNbjg599jjZdavKx8pt7rj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b73156ac-94d3-4c8f-cd9d-08db217cbccb
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 15:33:03.2847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2yhrsq6eeSSQ5jtDLrGdB7im8PtrqetA5O8jkjSy3aRhWN29O0g09/NJXlbo67hO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5402
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 11:14:59AM +0100, Eric Auger wrote:
> Hi Nicolin,
> 
> On 3/9/23 11:53, Nicolin Chen wrote:
> > The nature of ITS virtualization on ARM is done via hypercalls, so kernel
> > handles all IOVA mappings for the MSI doorbell in iommu_dma_prepare_msi()
> > and iommu_dma_compose_msi_msg(). The current virtualization solution with
> > a 2-stage nested translation setup is to do 1:1 IOVA mappings at stage-1
> Note that if we still intend to use that trick there is a known issue at
> kernel side that needs to be fixed.
> 
> ARM DEN 0049E.b IORT specification mandates that when
> RMRs are present, the OS must preserve PCIe configuration
> performed by the boot FW.

This limitation doesn't seem necessary for this MSI stuff?

What is it for?

Jason
