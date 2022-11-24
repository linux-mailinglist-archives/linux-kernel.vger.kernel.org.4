Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37CF63719B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 05:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiKXEwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 23:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKXEwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 23:52:17 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D77C8CB9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 20:52:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAxRGe7jJB37Ua2HNr9OzHMj7RojGVMRIPX1t86hCwNM/ebJtM7Zoy2v5der+JmxWdcvTsKJ+TvvilBtmyJmdEIbXFoOU70IaUlbge3XCiyxlb2vUMHPLJ4lr2L/XVFa/dAcPVe7JIopmeDtM+vxFfrii4YXMidqx6f2J0833B4ARD1boNJl71VbXL17Kjapagwg5bDP9mcoUzokgt+JHE0WojYfwCQCDq2KPdL+Blc50mdGTyiSj8nkyvG7ikXS8vytb2V8N9Ddy+YO3txHCHzu9Ku8K+bShJHkqW5Hk/7RSP9BX/QWRwzuuvANgHBmKKnX6B0YN5diX3IGH/CfqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SP91+VEjVgULdS2CWUoD0oOnDP152BQPRaB/2XgOzdM=;
 b=XzSJfdUP8deZT8EK9EciqKpkThoqg3kNubZPtb+R+t4h0S/J65/xiS++jkR1Y7KkjQif94a6N70t5yy/ee14fVqUu7CWjQdtCIAify9rb+H2YeIgUP4lMxtLi4VM0cB6cboJ5p7bT0MtxqmUXM3N2yZo3M9ijH+Xo8yVMxQe067MjZJNWz44UMmbKWkB5UNhPgdXWjXcgGlEvKKdROagHmm6PHQRAoKbQgFIhLb+YoPFf4psvVAeeIIdb38HSNqXuleXZ3eDxuIygcQLwePrsbdQTWA7vyU+mRVPt+kmIAbsUwHh/eZGjyjkhZy/n4mHQkcIeijXPdFoULf5a7HRxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SP91+VEjVgULdS2CWUoD0oOnDP152BQPRaB/2XgOzdM=;
 b=NEKO2juXQWxnQr+8qDX+U68K9jgAy/bjes209zI9e4ocL4RcLGX4SZdHcHAUxRk3PM8zYgw2WKsasFCo6L5XwpQxMqe3unWxwBxtLZMMnbeLdOerIrcJ0BD/lpqec+Lkea6x/wVTHDzLDWjj5v47fSvo0QAHzPu4gr/DBcNLO70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SN7PR12MB6767.namprd12.prod.outlook.com (2603:10b6:806:269::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.15; Thu, 24 Nov 2022 04:52:10 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::7ab1:7ce9:1f79:6b79]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::7ab1:7ce9:1f79:6b79%5]) with mapi id 15.20.5834.015; Thu, 24 Nov 2022
 04:52:10 +0000
Message-ID: <4c196053-7c58-a2dd-4398-b1d03582b54f@amd.com>
Date:   Thu, 24 Nov 2022 10:21:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] iommu/amd: Fix typo in macro parameter name
Content-Language: en-US
To:     Michael Forney <mforney@mforney.org>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
References: <381fbc430c0ccdd78b3b696cfc0c32b233526ca5.1669159392.git.mforney@mforney.org>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <381fbc430c0ccdd78b3b696cfc0c32b233526ca5.1669159392.git.mforney@mforney.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::17) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SN7PR12MB6767:EE_
X-MS-Office365-Filtering-Correlation-Id: b58c3a49-fd44-4aee-3e65-08dacdd7a49e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /gxKRzA7NVa7jNd08qfy8CNt4MWilZNw8TWfZTh/Ie7PCp2Dx+eO1rzAp63l/KI+apZ14KTlnDDvggSJ9Wpu/wJmlGvaPsI5trXV6/x5miyBXETaJKkawiI68/LtEfQsw8yVovaAZDPNbrvz4tAS8BcSQKvF6NF8gPJ8NmeFBxknfsEuTAvLzr2LyaOosos1zkvx5RUnJ1hzL9plEK5oACOscknTVs/TG6QiXWmzX4xG8i74Uhrg3sykx6CfmDkWGK3w+hefIBIldSmI3SSCQJlySQXhLq+90XftD2/gDKNUTHcAMnihhvRoH00ktZHZP1sfHGFmbyhwExhQlAEi/+hg6Z4CXUYCrOxoqOl9DbgTA18e0jruPANnzprYw7skmlDYu0J8gvYvliKOoE9Xwe+HU6uA+BsoyKzFQbky7PKgx4M0YJB90smg6FomEsMu4i8EGh2yEG2K/QsXQ6MTHCQwy4mqLWQ5dnB/cy9MIe75xdBZx49c97+YglbC44inLETvY3IrEAP1YPfLrdJuhoA8GD4IeN+o8Ccq1nIHJNVH4Lhi3o7gC6dvd8s5mEWa2WAsewwCrSQ27LZUCXD+1z2ulngvzB+TSvrQOfBsBzUonl+MTEQ497wCCnHCj7nPXog3F3MzPwQTptb73waXrH5P/reBCO6KhDhGmR62m+wIv4I2pxuWK3I3HCDa4WRHDek82UmKI+IWKRvuvdBdDCjbQ3zHaIgjOudBGeXF1cA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199015)(31686004)(2906002)(186003)(2616005)(478600001)(66556008)(6506007)(6666004)(6512007)(66946007)(66476007)(26005)(5660300002)(38100700002)(316002)(8676002)(31696002)(36756003)(4326008)(53546011)(8936002)(44832011)(6486002)(41300700001)(83380400001)(86362001)(54906003)(110136005)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1R5bTlZQ0xBTG55bk94ZTJGelVtSnNwRFBKMk8rc1pibDhuWDlJTzlKcGxG?=
 =?utf-8?B?YWNwRzNjbEN1bzcyOFZPQXA3U1RaZy9aMjl4VlVPaTd1NjhnVEVwQkJXaC9z?=
 =?utf-8?B?VDlKcUZkbzFEQnBzcXlCRmhSWHZISEFNNm5SNGp2bEdyaFRYdmR0dVFPSU5K?=
 =?utf-8?B?czQ0RDZOejFCS2xFL3I2K1RteVpMWkxWdk9hRVlNemZ3enJTdzhMYU5CYkpq?=
 =?utf-8?B?aWk5KzVJRjNqSmd2K0FGdjVVZGxiUng3Ymp2dXM4L1Q3TWZqTXR4dVJGNzJT?=
 =?utf-8?B?STMrMTVhVVBkb0h5bHNLbk5Fa0NrdTdsdW02UUpHYkdzbXNmeTFWSnc3K0Ev?=
 =?utf-8?B?RjU1SlllVEJ1aFN4cWl3aENlaFAvV0dobHZMeUZRWnE4am1MdW1ZUUl2OTNC?=
 =?utf-8?B?RklFVm1EYzNGMVh4MGszbjhvaU92cnI0aHNnVDBGOHlYRDBaYUprNGVSVGtU?=
 =?utf-8?B?ejg4WHcrVC93U0pyN3o2UDE3NFNvcmR0RVEyazNQWnlWMHRIQm1FR0ZpU2lt?=
 =?utf-8?B?alF2cXR5dTNRZlF5dURWWVU1TWoxNGJscWV0OStaRm5meWlQQ0RlaWxFTS9v?=
 =?utf-8?B?a2R0RTBPUnlRZmNBREErc2dTVlJCaTg5ZDFHTENnS1ZzbGp0d0l6dUlPUDRN?=
 =?utf-8?B?R1oyQ0RNMGlSeDJScFA3Rllpb254Z3ZETFREaHoxL0VZRVBDdkZ5TVRGZmdj?=
 =?utf-8?B?SmRhSkhIZDQzOUNjRGRaclZMYjdWdlhvQ3EwRFp5Vkh2eHd4NWp1Z0NudG92?=
 =?utf-8?B?NGVkNnBDeXdyL0QzelpFQnV3K2Zqb2poMnFJYVdlR05aNE5lYzF4Z2FsOU9p?=
 =?utf-8?B?d29YOTd6SWlUdTk5NCtwT242bHJ1b3dlZm50MHF5Y1R0MitCSlR2RXRwSFJL?=
 =?utf-8?B?WXhaWk5kV0xGUEFmaFd1UHp3UFJHeVlURXphS3JYRkFoUkVZUkYzVTJ3Q1li?=
 =?utf-8?B?UzNCSkQyWkJwakZoRXFXVGFuYnBEbHV2VHU0enhLTnFyUFNJZi9jc08vOHc5?=
 =?utf-8?B?SDJVZE9CeW1SbWNObEUrdGdPRTR5U016MDN6UFpiYmFvVUhpTUV5RGlRVWJJ?=
 =?utf-8?B?K0diZUNPS2d5L1dCSTRta2dwNy9UZThEazN6Q1N0ZU90YmZueFZ5c1R4cklJ?=
 =?utf-8?B?Ukd1UlVURmp3ZWYwWllTKzVRNlNXUlZ1Z1VxTmVlRDJpOXVWcDZnZjlPbVBy?=
 =?utf-8?B?NWNqSGU4WmhwT1lRN2NCK052SXVWOUViUVJrQmVDTFVmSjVXMGhmaktCdzBP?=
 =?utf-8?B?dFJIbWxnQ3FaaHNWTkRLdVRmdVFEMnl5WllSOWdkRERDa2RnQThZMUg4blJL?=
 =?utf-8?B?TXRNV29PSlJoYlVOaEIzTmRxWVEwRmRoNWw0K0p5a3NIbzI3ZXAxVDVrczdK?=
 =?utf-8?B?c1RPUVJ0enY2WEt2cm4zQytTQ3g4anlRWXVJcVI0dXh4TjREekZRTFNyVGhi?=
 =?utf-8?B?UEp6MEpoQnVSOTVQbWM3RTVDVk1oN05jNzMwWU1TNU9ZTHVjYmRnN3VOTm15?=
 =?utf-8?B?SGpocTJXYzlsenJQR21oNy9Kck9LR1llMGZ0dUUxNGFyMU4rTXhjWXVlZ3R5?=
 =?utf-8?B?SWdCbVBNanJ2STY5ZzN0Q2FFYkF6R24ybG9RcWl6eTZaUUF3dHNQTERFQ1Bh?=
 =?utf-8?B?UEh6THpMOTdhYUJLVzV6RnI2UzBLdFp6K3A2UlVKTFZibGlCUk1jWU1FakxD?=
 =?utf-8?B?Z0hQd3RZYmVJeldOR1ErUG1sVlZWK1BYakZFUC94T3lFeitJdTRtV3VSTTlC?=
 =?utf-8?B?dzV0YWRNbzZtdDBWWEQ1YlE4RFhCWkVIa25NWGFlYksveHlxMGFCREZwUU5E?=
 =?utf-8?B?SCtjL1RuUHhNajVYL2dkbi8xQ1JMemltZzRlVW5ZRTc1OWR1UFpEYXRTNFpy?=
 =?utf-8?B?U3d1bWRpaHk3OVR5czdiL3g5Z1RXSmw1b3RFZTl2YVhmRVExS2xCTzI3amth?=
 =?utf-8?B?aXkwYlh0cnV6VDlYLzAzYlFmbmZHb3pEZEtzOG02ekVlSUo5bVErNFl5ci9I?=
 =?utf-8?B?bktSMDhnMXJWSTV4eFpuWEVGTmliRElQejFNRnE4Q2FJa2VvRWp1UTY4STJ2?=
 =?utf-8?B?R2w2ejUyZEluZ1MxY3RZN3Vta1FpTm5EQkZOQlZhc3Z2VFF4TGNkTncxV3VP?=
 =?utf-8?Q?YXiaWV/1Aj6I7+A2Ve5kxzEHM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b58c3a49-fd44-4aee-3e65-08dacdd7a49e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 04:52:10.5478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7CDtrPBr5tdp3As5jvCgFRfbs/vm1khnGzY7lLuf5AI4kxLyn9EGlQoBpq7iZ2ssWkeu82pWCz/wFszX5saudg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6767
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Michael,

On 11/23/2022 3:48 AM, Michael Forney wrote:
> IVRS_GET_SBDF_ID is only called with fn as the fourth parameter,
> so this had no effect, but fixing the name will avoid bugs if that
> ever changes.>
> Signed-off-by: Michael Forney <mforney@mforney.org>

Thanks for finding and fixing this issue.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

> ---
>  drivers/iommu/amd/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 1a2d425bf568..099ca3ed7d73 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -85,7 +85,7 @@
>  
>  #define LOOP_TIMEOUT	2000000
>  
> -#define IVRS_GET_SBDF_ID(seg, bus, dev, fd)	(((seg & 0xffff) << 16) | ((bus & 0xff) << 8) \
> +#define IVRS_GET_SBDF_ID(seg, bus, dev, fn)	(((seg & 0xffff) << 16) | ((bus & 0xff) << 8) \
>  						 | ((dev & 0x1f) << 3) | (fn & 0x7))
>  
>  /*

