Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F68164B5CE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 14:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbiLMNMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 08:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbiLMNLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 08:11:50 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87A115806;
        Tue, 13 Dec 2022 05:11:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isO6bDhbtC2S7nO5G/wCJ1kYGTJU0kOLUpyhQISvaigcrpJTxwS2hJfpv9SYa+/Zq1i9Q6nshOmdtgFWNQl5FiggL7PwrHpTMP7V5tYK2qdP6q+bjA+PNIxt/NGQg22k8Kf8dZdcsGiG9U+7sG0BUut+n1+Lg065JzCRVJwCgPXq0AEFzrpnBCmVgfQDtesdNA9UchIWj84FxQdA7sV1y6OXZFr+Ez+njnhkLDTa4+N5XYwQ8cWxMr4IUF+i0ewLwcTuxuX4hntZqYBv0pl4RGlNXjOVFomycJvYWBZcxWcMSTKTb5ry3Ay1c77WI3hm0RUS4GC4GToQM4a17vKb+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lo6QYDCWSgt6B0kUWFbmAgx7zZcjGCm2rTJqL3cTiiI=;
 b=iXLFAI/2Hm88CsPn7CKW0+lTk2Vj/uvnebQx/9iA6mXQWHIV32CjeQdE5bzqwH1W1JJcVBFv0lmQr0ijG470eplT4qskfqAHNiPEqx/qYaCI+ZBsOM3srKSvzel3RcHHsoCLjCDnXfSlviYhd4YIU943PM9XQ5nIWH4kehPy04znP4gA/pFmBpOwy8Xbato+tWCnCCwSe2VLv3dDKKkHwjD2hyKqtFpGkwLfDQIPvd1HZkv9wWFFPpUqzKOI4VZB3lrmpKLAD3/l/WNz1gq1ZRRlV7SJwiXb8CDm4kO9+R71nlGtX5aodFNf5FcuDkBXQh3n00v+6B3tryaBxHhBgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lo6QYDCWSgt6B0kUWFbmAgx7zZcjGCm2rTJqL3cTiiI=;
 b=l9DYpjz6goRXOtQ+YLZ5K+pofD1jaEo4Uwg+ZDQTshoCsEDcYmqcnOO21eh3erqm5OrG+ND9AZ4I707mATw9RsX8Vv1z9gKMaUq7B7LVHRWV7PoRTRMqRnuSWCacc33KlbB8DP3RaulqgT+cCvI4KvjAnVx8lA+LjaU3ToLTgIJi62rwqqh8XK6q9VDh7U+mgIZThpf4iQKNCiTB645tO+unO/cAXduv6hQkwYrbK42h23eC8HynjtOMlzYAc1Yu/T0ofEfoVXYTtr+kzUujFX+nfxBXulTaMQIbylHtLIhrJUObw/6P+Pey6IcArTyC0zQSphrx4H43Wfse2Lhn6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB5810.namprd12.prod.outlook.com (2603:10b6:208:376::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 13:11:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 13:11:47 +0000
Date:   Tue, 13 Dec 2022 09:11:46 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, will@kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Sven Peter <sven@svenpeter.dev>
Subject: Re: [PATCH] iommu: Allow .iotlb_sync_map to fail and handle s390's
 -ENOMEM return
Message-ID: <Y5h6EuA+mx29pMCg@nvidia.com>
References: <20221213121104.1659412-1-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213121104.1659412-1-schnelle@linux.ibm.com>
X-ClientProxiedBy: BL0PR1501CA0006.namprd15.prod.outlook.com
 (2603:10b6:207:17::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d26441e-8c08-4792-6410-08dadd0b96fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WbBuZwolU628UFgFuxhS6OpIOMY1G506CtRceH2fcbqP4pjENrKnKI8SsrunPc9wVdcmcvCZPAQz6JS61ZHuKnhRDRR5EqiLH8mVVrj+pSSUPVzNJtx3A9A5LE41V83BQe8N3UMFTs9pxbFT/8TFYLwfLLulRQlUlhW85qxh624FRhXFR/r/J0dAWplNQFz8yW1gGmaumDB0iBaNeNXmYsxpm3ikVX+mqyx4XBXXQlnbj0D6M+jBVLoeqTfZ6H8e7jYC8+u2PoHF5Fno+faOS8YVeWtkdZ69SJeBjRIj+r6SvFWI7bSv4ZZtnnbnDfLZ+yPvdHu6uLi7+MMSw0kS69bjUsVQP8dJFFnMwZ17zRVqmp5sfvpUemYifIQmMFBUk4bUjzXG5ufQhVv7htWf+feiWeJzsanSoPtE5W4e4yzXkAZqnuSqhfVBeQN++eWBpwMjJoI+uqfIw2KHE9t/eetQTFHoTW6RpaEdwbU3ScPa+YW4DZ7Iik9GFUD5bqADQ0Mz+lWp8ldtGX/QdlqFYId1E2R3ENTSgRNslpJhN31unMesW9/ALrMsZkNts4vXa3sjzaQHeAMcPuqwbkiRW9jMjhiN/LKd+z8AEPZAJKHeQiJkwFG1lBg6CcCv6boUrrm0AmhFlNBBQH/YwWwiVE3J2u8uqERXkfmmBu80wTxNP/Gdruh2C27D1vC6HOLuzbpgQ57atpc0B14U1hslqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199015)(38100700002)(478600001)(6486002)(6916009)(316002)(8936002)(54906003)(5660300002)(86362001)(2906002)(6512007)(4744005)(66946007)(41300700001)(7416002)(4326008)(8676002)(66556008)(6506007)(2616005)(186003)(26005)(66476007)(36756003)(142923001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5BJb8XFnJ4wwS2R/fTCTv82SF5qNeht/5v03VXv+cwd2lPTHT46MbOE3g0/n?=
 =?us-ascii?Q?MY61fIQRPcS2NvSmJwH4oQX9KGx9PfIVGfos1Edzb3hM/YiVGysa1po8uBxE?=
 =?us-ascii?Q?RusMlltQanD2/rF05Ejp6U7EysEsTRAEv3VoDnQfu6ZvcYXsx9VU3topYZT3?=
 =?us-ascii?Q?NOC/JRfS+dXE4cq4Dv+DnvvvUF9PlkCOjnv2j57PTZNTbTPTG4i1d0fFesEY?=
 =?us-ascii?Q?rZ/oD92l616r019NUr97MOe/2scQRkAwsibHhArwvGevCVYvKW9H3MHErfDX?=
 =?us-ascii?Q?nDp8JjB0GRbVk8hF34t5F8vHz06+bj3qCCsl/8jCPAuWqomaS+AllbksgiUO?=
 =?us-ascii?Q?mfIYgURVMjyc5cMWdeCX5au8ZokBk99djXCMUKmgEJGZxjkSG0fNaWNtAfS5?=
 =?us-ascii?Q?25UYyEAGGaJ9h9Z245zJJPvU5xSmn8yEAbPkAwfCpwnpwTzYc/2Yy5UDb+VI?=
 =?us-ascii?Q?ION+H73kJhn9ivncOVoQr5/emb3iSGDJHUiepHhi8Td42raBLUJpj7Ajm5B2?=
 =?us-ascii?Q?hxk66WkSD9aSkfMxL2b4uwhfvWDhgMUcFlFZ/Wvfsw1r1KLZrC2IN7mD1mzV?=
 =?us-ascii?Q?z+WVGwZVAQB6q/8rXLd32Zh/gskcmC4iiRtlDVo5n5M3kxVg/6yqplIdKU8g?=
 =?us-ascii?Q?7m2L4LAA5MhkXLdNtwRdjrnUi7vRcB5kzcENcOgGwX0LEtOOXwWFtgdcjeZN?=
 =?us-ascii?Q?mnX3K81/pzs76AA/GGWlzlJybGhjss/jP8eUXdMwt3gOsGeHAnfRn/whUfQ5?=
 =?us-ascii?Q?dPO/7nkHV/hIFKc62T3B/nH3jdTeEu2ujD8luLCV/10/WRGAJZEg2u2FZ4MJ?=
 =?us-ascii?Q?3nvRRZ/Ybxlj3qWR+Wjp15tMDzaNMLTQrI+2l9ziB4B5qYXJRLDSONRgtlZJ?=
 =?us-ascii?Q?ZHvYBbxNxaXU7eGsvfnORp7ZJBTDTmQ8EQpN1Aws6RQT02E6qhFQHa2Qpmma?=
 =?us-ascii?Q?hNs0mvImoA2vKckMwIHdfLcPPvoUQpI3dlJS7ggQ7KNIrMZS6U+qS8JL1NJe?=
 =?us-ascii?Q?e7htmMwLYfcHryBQwxDwXMRnPEOsYtpw0mJL4G9TGdGg6r58anGAYqU0Jwaz?=
 =?us-ascii?Q?KJQJ1k63gTrMcYgTJopWnvEa1xFt0awnrt7tMn5QBGrJyoqu3C79eJrmqYmp?=
 =?us-ascii?Q?iq+rue21C9e3xRcHjTYHr4hS2BwryLTDMeHrzGbd5pRk4SFjcpRcXp0fSUA2?=
 =?us-ascii?Q?Oy3G80Ua3DRpIWwEsRTq99RgYhW/ZgvLlxJZH7QmOLRGYKLh8JsHJ2nS4B0A?=
 =?us-ascii?Q?3uDPHx8IQ8sA+JwCywpHMmmZAK/nTx6FDidZtE4N6T6yLKEYmpH6XLgXlfEi?=
 =?us-ascii?Q?SYgOwgwo3o5v0RGFbRD/v4uw5sBHbnBfBAsi7lALFXiKDjF5iCrfMesyxBkV?=
 =?us-ascii?Q?IYxLRZbJDEjzbywic4dSoQ7QPZ6ticjWNq/WofcPhwqF1oFVCkb8xf2HZI9x?=
 =?us-ascii?Q?8DTbtOjiwgxWkL+QvGbjxGXkxa9MZZLtRkEyl+1r8WHU1p1tFaOSnSHYL80n?=
 =?us-ascii?Q?DAomMflOcoLvtnAU/hiwlM0BZsHmErDhr041V61+O/PZlDuuJVzQiwa378sN?=
 =?us-ascii?Q?BNSx6WCun0n0IpUBRiw5JYKlcOsc2D0F9NhTdEnz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d26441e-8c08-4792-6410-08dadd0b96fd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 13:11:47.5319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Px8Gk//segF36kIJp4Xi2P082dHGoLWbcpQHN7IL9pl6tsIDMyh0tE6h/t0WG0Xx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5810
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 01:11:04PM +0100, Niklas Schnelle wrote:
> --- a/drivers/iommu/tegra-gart.c
> +++ b/drivers/iommu/tegra-gart.c
> @@ -252,8 +252,8 @@ static int gart_iommu_of_xlate(struct device *dev,
>  	return 0;
>  }
>  
> -static void gart_iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
> -				size_t size)
> +static int gart_iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
> +			       size_t size)
>  {
>  	FLUSH_GART_REGS(gart_handle);
>  }

return 0 ?

Jason
