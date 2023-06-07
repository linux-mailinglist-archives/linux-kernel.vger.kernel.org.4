Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F09B7252C5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 06:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbjFGEWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 00:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjFGEVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 00:21:46 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B4F2695
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 21:19:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBUZToYx1vwbzYROIIA+ZwS5MeCOIIJY2Hi9zq9pjT7dtAdIL5+7N4izvkhdRs7WSTN7/jdGIuzXB3RERWbT0LxmUBbRD6rbOrov5OlFlOdXpFFET/isQN/RGdQh8iRNBVDn3Z+HCkosiI4WBDICmhvBGlzhw7UmFVvN7G6Rxmbb4vXK42+FPL1ufPlq8XCSrIhOeAg36cFT10gy+UT73nGMiQevV5NjmSr9UHkthLF30XPMdcYcqDkJaKO13xBcb7Jpw6/hnEkq6U6BO8aAdSwPbsL1Lsy4Js2q+sUXsUwL9hMHB9ddfZt88rzDUjV4ligr3HlBAQ8Zsu8S/YDAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=johPKzC95uwnqjq/A8l1LI4UFwfkha+sn7H8Buw0kNk=;
 b=KKSvG/so8q0W3EIDP7vVoKXL/QFhg4dLoM2aFiWs25Xx3Bxn61DYZmcCsNgCUZ3C0oOHmT05M44IxQOqN9h5fIb7zfNCuR6S7x0FeX1fPgpizHOhAQXG+za6QWIIK8k37cdCUaj3eNMU8XIHbpDLtqEXWiDMfl3bAmc6myhvw686jLa0H3rmcjCHopWJ89Z8a1sy0irFPUlr55D4vlt+3Bc8fXHnLWjisixYCvQMQKeB9yGONntC4A163dbf0ehZGMbZjRsCZ2bh6hqKIg4pKOz5YmpVPX0q1UnOb5kNGYa8tldoa+kXcr4t9Tr8hZopTD2BJp4xlEnlWSCgKXlJug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=johPKzC95uwnqjq/A8l1LI4UFwfkha+sn7H8Buw0kNk=;
 b=dcB9zkTWUfePRsJcwLG+vHFQR8l4SsEVKgU1NUmJLmSjI0l/F30M5LleiwM+srSgFgYDDNXJO8g6Mk/MY+5/MDTULrFAbEhWEuDFSDdZu6rYtx1wgGKf4AFfj2Qn2owyvJJFrzjkOfzo3SEJONNe/F2N+HhvEX7H8wurB5Y3cYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BN9PR12MB5084.namprd12.prod.outlook.com (2603:10b6:408:135::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 04:19:19 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::7cbf:236a:55b:2c99]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::7cbf:236a:55b:2c99%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 04:19:19 +0000
Message-ID: <8610d516-b83b-3614-04a4-5ed2d4b66c56@amd.com>
Date:   Wed, 7 Jun 2023 09:49:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] iommu/amd: Fix possible memory leak of 'domain'
Content-Language: en-US
To:     Su Hui <suhui@nfschina.com>, Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     jgg@ziepe.ca, kevin.tian@intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230606070742.139575-1-suhui@nfschina.com>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20230606070742.139575-1-suhui@nfschina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::14) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|BN9PR12MB5084:EE_
X-MS-Office365-Filtering-Correlation-Id: c3cb58d8-4310-4c24-e817-08db670e5cf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XVWAsPu5G1cFVdnVKWcUe7QRODlplEsaV5r0BzIFRnP1dwvGWvJ4h/f09SNifNlLIe1gQXhDx3/l14zu7TVhNGVX4KZ6u3VuV4FamdvDwf1bpO2FWypqUTIk5ZqQgbfM7ugqo5hDrBCCYem9WRTIvtNin600lZgkUY9/EM299+iU/JLgtLjfFfiPRRCBN/etZjHnHJBlii1D3ZLdqXiEpV9J6L0+ott2xAmVZCFTF5GBymYWtd2/YTmwDfmhUUvE5j46iTbjQRKDRNSuTog/zcN01LPMv2yChR9uFKXYKqM8VbPNEmJfSteviM5Ljxsrs76Pvnunuuucz7T/R7JOPHysBWAfXzpr3xUlBvAkuAOP0xWMW5NPVL5Ox0qPGAmw+LtgRFfgC6UUd32VbHH79TzxvYnNKzEwy0iI6CD8ehifdMhTUDqHxcZoMk7nPOxNBBF+qDO0yW+zwXWNnShScZiZpSrjoiKwBX+9AaUb0f00bBuYjxI4n/eevdmXr7yrsBkGcJcLv5GLl8x1SKhn/tAQ03juRbF2G0OcU+DFGogo89fiiW5l87+WQDdkOybwj8cyzW1pp9tHO6HtgNf5a8dyKDEPNKgduyDFvYbKXEnd4gectKNncHMPqrkJJItjCp5eYpzKtkfStWJOIEBGrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199021)(86362001)(83380400001)(110136005)(4326008)(38100700002)(66476007)(66946007)(6666004)(66556008)(6486002)(478600001)(2906002)(36756003)(186003)(4744005)(2616005)(5660300002)(8936002)(41300700001)(8676002)(316002)(31696002)(44832011)(31686004)(26005)(53546011)(6512007)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z25uQktwYjJRMWtHdkc5bkhoSzNwM1k4OERKOE96ZEN4dHczT3lQWk9aTzZn?=
 =?utf-8?B?OWNvS1FlMTg1Wk44YndyZzFtb2xlSmlHMUU5aUtOQTl6R1pXZDNDYk1JKzdH?=
 =?utf-8?B?blh6OU9QRCtmbW1MdUJBS0R2SmtjZUJWM2h3cWJ5WHZHc3ZGZkZtWVFMU0Vh?=
 =?utf-8?B?bmJscEpUajBTMkh2Zkl3UzdBUmF5aU1yY1k3M3YyL0loOTNkWnduY2VBM29K?=
 =?utf-8?B?R0NGalQrdEszVDRmZnZIeU5ZdWdNc2lKczdBSE5mY2VIUHgxUTZsbmk5MWdz?=
 =?utf-8?B?bDdmeEZsTTBMMUpYZGRta3JmanFEY2RBcktJZDlhNmNEQm0yTXdrTW9LbzIz?=
 =?utf-8?B?NHV6K25wdmU3T1JRU1E4NVNQZHcyZTFwbUFrcWtnemsxY0xWMmxOZWRzZE11?=
 =?utf-8?B?WlU4M0FOdDV4WWVPVTcrUkxVOXJkTUpiYlcyUkpkcEJIZXpabWErcE1lU29U?=
 =?utf-8?B?N1BPbHg0S0JZcTFpTDFiTWdUNDVTcTQyUGNuUXI5S0M5TVVvZFBNanJRazM0?=
 =?utf-8?B?NkZFYTNPcm45aHRldU1ZM1V6RkZiYVdoOUJMb2o0OHNmbTU5ek5GVE8xNXYw?=
 =?utf-8?B?aTdGY3Y5eVlLMGJmckZEZTJmNHdvRStmVUdsMHBZMk5vQyt1Wm9XTHNIeW1W?=
 =?utf-8?B?bStCUGIzSkl0ZkZiUVBkcmR3YmIyWWZCTjFuanVGODBKQUFTSTdWZ2RlQjFP?=
 =?utf-8?B?N1VUclZoUDFYc1R2ZVlJck5aKzBzdHlMNEcwcFlnRUdVL045ZER4elpHU1Bl?=
 =?utf-8?B?WUQ0Z1V3N3RQS2lBWENCenpyYlhQS3hFRWs2aWxJdGlqanFmSkpBeWpNNklG?=
 =?utf-8?B?TldoN3FQckZrRkhuZU5DbjQ1S0h0bU1Ba0FLZi9qd3dnSjVWUVZkRS9pRHZB?=
 =?utf-8?B?ajVKcm9WMS8vNk13K21GMjJDOWpEenJTRGZMWHB0allWTTFDeXZLVWh5a0tR?=
 =?utf-8?B?elVrOENpNStVNENpRnNpQ1VlSjFQZzFTRTA0eHIrbENIc2ZYbUtmVlFsMThY?=
 =?utf-8?B?QXhnRkUzcUg0UHEyYkRWQXZXOWx6YnJKT3RVN0ppZmI4UEMvTklFeGUzMkpr?=
 =?utf-8?B?L1BZeG1oNDJVTlBwWEpBUHhlVSthVlpqUk02V2x2Y1VFYVBVUlFvRGVQQWFH?=
 =?utf-8?B?N0tENk12TkQ2ZzloR2FtVTB1OXNSSFUrQWZ3YWhXeWZVSmFLK2p3VjBpTlNI?=
 =?utf-8?B?a2p2MzZHQS9OUldUQUN0bkkxWFpuRWJGcG10dEcrVVVpeGtjMzZ1ek9rTFdH?=
 =?utf-8?B?M1JZWGFicHY5KzZaNm9aYVRvZERZdmNyaE53ZjNXK0pKQlVlNHBwWWY5Mng4?=
 =?utf-8?B?eU12allBdVFOb1VnM0cwYVl1OW1nUFFlZ3dIVm9VUUdmQUpWTW5xblNBUE13?=
 =?utf-8?B?aTZCd1pEc2lxN1VpanV4Q3hMSWxIUHFpSEcwTVljUTlzMGZRaGd2bXhrbHky?=
 =?utf-8?B?bHNVOVc5NHBLSzhzeHE1bUFMZlp2ODkwU0J3WHFCa1MxNDBZZGxQRUJqTnhY?=
 =?utf-8?B?dWNRU053NFh3RnVjUE13V3hZUS9HbzBBTmVsTjdzWHBBWFBvWjcxeERVaHJP?=
 =?utf-8?B?bjZFeDZiUkU0QUY3Z09VS0c3M1R1VEtHYkdqWHZiQUJDUGZnbnJ1WVhTMGZZ?=
 =?utf-8?B?T2NiMk9zbnZwYSsyYWNMNk95K0QzOUZiT2Z4TDhBNzhhbkZKelF4bTZVWjZ3?=
 =?utf-8?B?RDYzTkExb0FxcDltdjkrOGVjRlB2ZnZKUGxKWGQ3dEVBREZHR0c3UFk4cW1J?=
 =?utf-8?B?NWloU3IrVnlaTmlQOW9yeS8vWGh5dHB3YXhmMDlyTkduZTVaZWFESFk5NXpN?=
 =?utf-8?B?SXpNRFF0SUZYcWx1VjJtZUZVem9lbFdGUnY2ZWdIZVFYWlRBMHN6YmVSaEht?=
 =?utf-8?B?emcyVThSL05vWXBxSCt0UFhzbmNKdHZlUVprTWowblB1d0ZlT3FrSGYvVWZU?=
 =?utf-8?B?b2E4TE85QnVMYWsyWFdUdFlyRkIzMEhmdEpNR0l2OEp1UVA5N1Rpd3FOYVZ2?=
 =?utf-8?B?LzNKTVpVQm1naW5lK1VMekhXbEprZGRnMnpFMFVmeUJVMmVNelJRNTgvM091?=
 =?utf-8?B?MVVkUE5FR1Z6YXhXdkhkYWRDeXFzTWxHcHlUWEJnOFF0S0hrM21WRFFydlRJ?=
 =?utf-8?Q?VD9Dfe1of47QV/hdWqAhBsxju?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3cb58d8-4310-4c24-e817-08db670e5cf5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 04:19:19.3442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgG2t9kQ/t8gJHoZu13WN+X42pZw0ZBxrRiPP//M1raOAaokLd02uJlEt+KKXZ3wI6VPi0s7fu+Bow2ZVqYCnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5084
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/6/2023 12:37 PM, Su Hui wrote:
> free memory of domain before return NULL.
> 
> Fixes: 29f54745f245 ("iommu/amd: Add missing domain type checks")
> Signed-off-by: Su Hui <suhui@nfschina.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>


-Vasant


> ---
>  drivers/iommu/amd/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index dc1ec6849775..f08e65629c74 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2094,7 +2094,7 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
>  	} else if (type == IOMMU_DOMAIN_DMA || type == IOMMU_DOMAIN_DMA_FQ) {
>  		pgtable = amd_iommu_pgtable;
>  	} else {
> -		return NULL;
> +		goto out_err;
>  	}
>  
>  	switch (pgtable) {
