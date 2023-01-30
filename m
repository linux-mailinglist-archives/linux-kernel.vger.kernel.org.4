Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5172681692
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237598AbjA3QkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236723AbjA3QkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:40:16 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7D9366BA;
        Mon, 30 Jan 2023 08:40:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbH2BosLOj6yX5xxr3mwObLrfL4sbqj1/OoIkHP48uSW99QDP2OTCHPvxBTa2E47OcBPtISG4tU+gvmp9Xv14gRWGL4aJU9POd5My0H/QN6UIA8rLZDZQT9RhUQxMHhQ5uRGKHLIFoiFbJqXg40GeHKRcLvUyUHfnAFhCOCKBUNBprx+sAUzD597wY6VwCKCJIba+RUVNE5uHn1RAfqGpykf8WEgEFXZ1ftVKkPpt5lgiPbbza8mYazcApjHiLmssb3IQHj83iP4sy+azOEVryvT41K7M4i2RsgicVziNiWMUtVajEZ9hUEq1MfmlD+5WOw/Pgv72fGJHsrnfOGrVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpzoZMv2quCfixBfLvztcGz9MhlsEfKGjtXq+iu499A=;
 b=B2uj7sqRQqRQo2W6ASsmzhS8Jj8SLCIxsZmV5R8/vRiDBHYC1Bh6GPS1GnkyUd3d1lV/YF0ZEdGHbVCCeNKYbwM5Is6MBKbaONMVU3x2txdRVEHYf1KHNAVrdQT3W4GQ/ofC6i6JHXSLN5XLbihAhhhUOCOtKgLKwXMAsUIcllQ24XO3crW0Ws9G2Xex84akQDIvlFiLQ2eBeVNL67VP7R9F3XCP8I/iioD4Vq/vBSZmLYwC8vTodj0fpCOPQXOi9Jau+HL3aaWxKtbMdWHv98mVmEla2qbHUmHcv7eev1LTCJTnewcbvO2lpn7jLRcCL/jdkjSaszm9b7oROEXnKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpzoZMv2quCfixBfLvztcGz9MhlsEfKGjtXq+iu499A=;
 b=LriR8NEeBwW9CXPlhDGWcCMHtVBxMuaz27skk9KZCaw7+HWPgn7FK4BtTFPx/GqDzJ+lX7g47eD1W/+GE19rLuRzpaKkf2CPzvE9oD9TyAVeWvXZSss9OwfVWSWnduUTHtA6Tx+8VTiIWMoU5hRxMyoKwvYH9jDO0j+BFwcDcerEzYf8V1vGGU0kDd9FQ9q+/gg6WAe6hjKQXayvWXrA2T/+KbCkXJRXH+0k8K4AB7kjyQ6gkKQflJ+J44+FT6w8ObPtLnSOAyx4G4TkRWwgO4nb+skSGpwa1Y/q4PMTu71EAb1tMdFyjwdaCYhyIvQ349F9dCVrDlQGyLVDbh0RBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB8497.namprd12.prod.outlook.com (2603:10b6:8:180::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23; Mon, 30 Jan
 2023 16:40:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.033; Mon, 30 Jan 2023
 16:40:09 +0000
Date:   Mon, 30 Jan 2023 12:40:08 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
Subject: Re: [PATCH v5 5/7] iommu/dma: Allow a single FQ in addition to
 per-CPU FQs
Message-ID: <Y9fy6KXdA3OqNudY@nvidia.com>
References: <20230124125037.3201345-1-schnelle@linux.ibm.com>
 <20230124125037.3201345-6-schnelle@linux.ibm.com>
 <1e016926-b965-3b71-07e1-1f63bc45f1a0@arm.com>
 <Y9ficPosWtGqbDit@nvidia.com>
 <8209c172aaa415eace9dcd4b5675ef8506a34538.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8209c172aaa415eace9dcd4b5675ef8506a34538.camel@linux.ibm.com>
X-ClientProxiedBy: BL1PR13CA0250.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB8497:EE_
X-MS-Office365-Filtering-Correlation-Id: 93a80fc4-fda1-4a8c-4912-08db02e0a690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q4FNgwRwL4JWHZPK2s0lBXqpIjTwe3dd1leo1R9GuksGvKPK/4LuFT2CPtxEwWlFFE2dPDmkYJZsxSrhAUJyBPFqNGmzpd9IXLUvjBLRYWQsFR8IpJStAhYbJAGgkZQ2iEGUeS2eJaVdrpgdB5xQ76wYiLcZX1ftDA6guijHfQwa0oXNJ+hJV/9CNh8+hy/QchyuLRWxCFlGw5rW3fgfymlZ5VgMf2JN+I7wIuSeCwEy5YtR3A87J2xBsu3eksT/jnf16jI2eCr5g9r0eMp8N1BwNA4ukk/7aTiT7XaR/iV9aXvKpCcyxjdSoZa64lqRzlvVHcdd9DZo2GCvV8erCB27Gj6+JK3XhdCdan9a8tiLnF+ed8ojlbFJJsUgnvI6oQwgrSwdH3CLdl2r4AWEW1URW5y7EUtuTcFC08nyJ1t1Smvh81FHZbIuSGyXpSBXG1DKpWq0L/uO+r+FQloMbLY+YgV0R8oHNTOh498w5eGSqr5TAMCq/8rX6zrgxFCtYiAlEMZzSWtMr5rAuoekU3fMetTurlAZSi3ScZYS5a7PZgc5s/s6V2Gx2KbJlubNeclQJU4S2m6O/VN3Rlq+6L6yxN0bAr5rSGx68BhQyGVvXOfOvHLAj34fBRpfVaOVfvxMMd2px9R2Qe+ax1d3Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199018)(6916009)(5660300002)(8676002)(4326008)(66946007)(66556008)(66476007)(41300700001)(8936002)(316002)(54906003)(4744005)(36756003)(6512007)(186003)(2906002)(26005)(7416002)(478600001)(6506007)(86362001)(6486002)(38100700002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TmniaP7Dri0FbFJLa3kk9pVAhqjaCHXMjWS+NPLQjfFhcIBGmtV2uh7CjB1T?=
 =?us-ascii?Q?bhknRkNkwUrS0XOo790KqLCI4cNLcV0JZ+KOZ4jCOL56rzsCV+MkpuvReaJo?=
 =?us-ascii?Q?J8pcZXXa/WESXkO+dSsQ2q8yVAmbCEoR/h9ZBkkZ01EqcbgEU4ix8N6KbafZ?=
 =?us-ascii?Q?l00a9Lgjc7kJm4I6fTDzNKoNgSWK+IuiNMnVp78RLx60F81goHECwgNPZMyB?=
 =?us-ascii?Q?kyBFCWCbyzvDxHg3hYjpkiRRHgKTOY73rw+YmhrOxcjaKGZi6jqbBvEQGnRw?=
 =?us-ascii?Q?AlAZfeMxcAGekf06rDRao/Da+RcEnqSLFaToUlInosgLdgnYymrQLuIoOEoM?=
 =?us-ascii?Q?Qx7SiwSLvQx2/K0/fHRxMoIQ+ytrzMw7HojMhkpAGfxZ0yAYq8zA0eHpCUg2?=
 =?us-ascii?Q?jX7qwvXlE6kEvBTgM9qzaiaer/lWqyo1zgeV+PCj3CU9xIlMh395SjJ8uqt8?=
 =?us-ascii?Q?20YvRZ+Khzjb/RzmmtNkOx+JUxkzg/sRrXQwNAv6Nrk+4hB0W3EbimJ7EeMM?=
 =?us-ascii?Q?UWa4QEh+5H0RhC4bWzurJzG1zt7zCgybJTWUMEP68eRS1oFP+Ko+BdpPwxuW?=
 =?us-ascii?Q?IJfUtHYToaT+607RxzHgJsvWPBRjCUStAmpZ9xGRojWYego/udctiOD4YCY0?=
 =?us-ascii?Q?rsaSU/IeZXpXZ65qR/++wckAXtLANwBRHtQ9Q2+iMGQxop1o0nk5jMbhPSB9?=
 =?us-ascii?Q?QcUZqIhwBt72dM44WYN7daKvXYUpZlFc6PivHUrcO0EwcgTwjA2A6dU2RZFC?=
 =?us-ascii?Q?O4ktg7WkALE1a9Gj9U3aaC8IraS2gtSaWunULJp+2HbwXN9kpz22THchI3WW?=
 =?us-ascii?Q?rv+dguKkwpZ1HKIjSOn4wyxqaGHKu9RJLwLHxVQK7bElGe+6BLTiazO0uHp7?=
 =?us-ascii?Q?j7fIJAm+Cfz7fDXjoiMbQNaR1QKOn9ssdXWxiBi9xzaBm0nh3Or4Im37Ss8Y?=
 =?us-ascii?Q?YNRgmJIUnJEO8MpzEh82if+VVEAvzK8itckF2Lv9/5XS06wvalDK4QoKKKEO?=
 =?us-ascii?Q?ebY4sku7iceWjG/uKCdQy0SrW/Icb526w2CyMnE0iJqBOPJ5fe97o06OitlG?=
 =?us-ascii?Q?LD5ZWBnYvRn/Za8uJZi0/rBQjC5yhcKlH2pSn3X0nqpjNSKHlKdVcPzeWToL?=
 =?us-ascii?Q?n2WS9OzdKpvxINF6ASvrT0A0vUPey/D7D8BxWqUF9fEVm3OQRI7Ify+MSPKn?=
 =?us-ascii?Q?/qq6DYhKqvtzKWBibQH06eIDlAAQkdbZB03GPOiH+SWnSF9rjemfwFBvzrdT?=
 =?us-ascii?Q?ksZczQl+Eh8BZh69cPziRhS11PYysV/P50R6bqS4Lqh2yKRXRS5lqvBKmO0J?=
 =?us-ascii?Q?5DzU8YAEse0ImMTR7QfNdQgBv4vvp8LToXLweUO0BubOshpqdsXLO1X09wPw?=
 =?us-ascii?Q?UMLuL0OVrkYcFv6VlH851CJOv8P09W1kTAcrOsaIviwwp3AhqsNQXxMN5p44?=
 =?us-ascii?Q?EsEFFLJ90xA9wFtgd12+1L/ttq30tXweq919oDjhhl0RREBSQhriyFX/mxk/?=
 =?us-ascii?Q?xlM/KwadrHTei/BY8s/xKvoG5MfrTVCAu/7A9EM1wAyhiwdbPwz1OJ+XVzjh?=
 =?us-ascii?Q?/V76aIAJzZFGZQh3j9ecgUVsavm23wP0h+VhsiFy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a80fc4-fda1-4a8c-4912-08db02e0a690
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 16:40:09.4866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WsYtvM46VfQ52zCNrfNTiyqHFIaqXtZ/VFrnsi4ptSl0+xyPCzs23g2k08s1G3d8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8497
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 04:57:56PM +0100, Niklas Schnelle wrote:

> I'm wondering if maybe instead of plain flag bits it makes more sense
> to have a dma_iommu_options struct that contains the queue size and a
> flags value which indicates whether a single or per-CPU queue is
> used.

Querying the driver for what kind of performance tuning it would like
to use by default makes sense to me.

> Then I could add an iommu_ops callback that takes a device and a
> pointer to the dma_iommu_options. That way we can still set the options
> per device but don't need a whole extra domain type. This callback
> would then just be called during initialization of the DMA-FQ domain
> and not having the callback just leaves the defaults unchanged. Does
> that go in the right direction?

I like it

Jason
