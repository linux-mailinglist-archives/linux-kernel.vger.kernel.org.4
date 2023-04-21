Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2776EA3D1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 08:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjDUG2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 02:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjDUG2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 02:28:14 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BC840C7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 23:28:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezhMOR6aGdvGsH2dqTRrEC+tGNutYitAVhYH2Si6+Y2ZG4+Q0TYrOKXWovEIsFaloU8ue/5d0Uyi+Zu5NviGA25u4OtBNFt/IPc8O20sqRse8xoremMSfKxci9abKAkJa76xZAtw6XqW6nYrc4S6BOPUF02YcU6MtCxU2nByvG0I3EAwKNhYMK/V6gfuvy1ocVS3SRShhEIfC8bOdAf3t6pEx87gXPVqTxCwWLXPcGk3Ugd/+LxqCfS9e2KoqX/z1Tnv76CyMW6seQF42J1AVG6w0Ne3u8+1W4Tqp/iLbPDLh0uA/Qy6AVakdJt2pGIxp108E6PA5vdgsRhQb4ImIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5jQKZ4J6OC06VUjdaR9kztWro/dStS35oK1yyzES0Q=;
 b=at6jO6CcMIA4whOF5yPQffQrWDAdIVz9owsJRpYEBoERA4yJv1i6sve+qGot/aMEuz1UY9xnIh9cB+UyU99E5u2pqr6V26DWOEoPdMntp5BTHFrFh6aLbhu2xsCNJfe0Ga4Ko7c7UDC4HWLW8yg4hbHl6p6O4ofWFwznEuV1O+YE9FU4rxZBjyGwm4h2DiBXDBz9tWjeLcnx4hjFzxOvLCjw6DT0UWS1DIj1IM+vSiGPZzd+ompmLMK1yDXAbhUq1oOtyyC0xnVOugkSlpNnDhg/+85VQ8HcdpVKuPpwHD+l1sml7gc5pXECisc+d0IqnRfQECrMXO/Yyej89jExoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5jQKZ4J6OC06VUjdaR9kztWro/dStS35oK1yyzES0Q=;
 b=eWzMWni2xB9xaE6lG4WXr+l2Prc6NJJzaRgsyNbEalm/YrEWkoYpMyl43xKqu9iueVB0oV4tZDp6KutprNdW1WeZNt3+bPmkOasm93/AZdZo9Bs07qD1puTWq+VoUp1JHfoCaxCZyira0OZRHS7iZ6lEN6THNZSEhaHmxU6w4/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20)
 by MW4PR12MB7468.namprd12.prod.outlook.com (2603:10b6:303:212::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 06:28:09 +0000
Received: from IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::ba93:7430:35d:284]) by IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::ba93:7430:35d:284%6]) with mapi id 15.20.6319.020; Fri, 21 Apr 2023
 06:28:09 +0000
Message-ID: <d85e993d-5474-3222-62a9-4489b33d94a0@amd.com>
Date:   Fri, 21 Apr 2023 11:57:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] iommu: amd: Use page mode macros in fetch_pte
Content-Language: en-US
To:     Jerry Snitselaar <jsnitsel@redhat.com>, iommu@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20230420080718.523132-1-jsnitsel@redhat.com>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20230420080718.523132-1-jsnitsel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::14) To IA1PR12MB6043.namprd12.prod.outlook.com
 (2603:10b6:208:3d5::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6043:EE_|MW4PR12MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: 95f52e0c-e39d-424d-9c4b-08db42319344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: snxg13d+S//EubTAUGrDrRwasXBDElNLduNGCkz2fh7AllRdBDH1uHJRL/7Pzdj417sOLUSmPNHwiNKtKoRI9wj1We2Yvw2+JKE47yRTzfFbyF+DLEL+Wf9Q+RRsMNH1OsY+RbmVgdnR7oE8yOsb4aY6b0MQrLOtfiJWKyGQEuRLmWlcOyyMfxrzYFpgzf0m+aIOW8LPNu/y7gZKaOxhpw6ntTi7BFiayG2MbMGkPkH8NEngfSBqIxNX3H0slXjoxsivfeFDNabnzBzZj9LF1l7TnMJ7WFuST3HdClb9/1CyqcZQNjMalEymZez2xAJ60SvzZlj93mf9SALu1VtZglVEtVtVSpXyNKGDi9sPbQFo7Sa4HWRwG9tDgYzdjXg1bRKQp7TswGu+JKMISfBgrDHg1Fv5IkBbGjmtCKJZHTYouSJDqT9jv/sqsca8o8j98pMgiczvHfPBXGKpX0g+D+bwwtp+uWBHjXmOGIWp6hB1q1093I8qPd1LeSLngRqgtrD190lbvu/u9TzGntaaKJbJxVM+Tshq/5/WEwMz3xkvPrcyeE94fK936wQSlueaanq8/6cc6JxG2t8BwqspDNsgLVwciixhSBzpqCMG4YOI2dbf9sIqyd0M3LTVibzctDIlK/8djBAJK2idh2rPSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6043.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199021)(4326008)(316002)(478600001)(66946007)(66476007)(66556008)(54906003)(5660300002)(8936002)(38100700002)(8676002)(41300700001)(186003)(53546011)(83380400001)(2616005)(6486002)(6666004)(6512007)(6506007)(26005)(86362001)(31696002)(2906002)(36756003)(31686004)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGQxU3ozbWQ2UXlQLy82SFdSd1QvT2RzL3M0QnR0NlptTzRSVXE4MUlKOTVa?=
 =?utf-8?B?RzhIbk90dGpwR2phTmtWdjJyUm5sSk0yQ2UrNVlNS1lFcnd2MHFwWGcxNDRQ?=
 =?utf-8?B?aDJkaVRVb1NWZWIzNlpxNG9VeWpYTDJsVXg2ckF0U2M4dnpSUWZ4eVVrR0dz?=
 =?utf-8?B?SXhYbUlPczRYcGwxMkYrZHByMjRzQlg1ZjdVUEpUT3NESE13eVBpMDExOWYr?=
 =?utf-8?B?VWRrSVFzd0V3ald4MnJyVkx1QUpWNTJldGpyekJUbXdvRkg5N0ROcEMxUmVI?=
 =?utf-8?B?b05uUGlIaXFmZ0JNZWt3SVVPcW1VSFAySzkrUVFCeXg5TXZDOW96dWl1Rmt1?=
 =?utf-8?B?cXJrQmlRdlI4Wjk4enp0MExmdGc0NEI3dHZzclpKRVU4OWFKblB1YWVmOS9h?=
 =?utf-8?B?bkdRT3ozUDFha3hnQUt0c0x1ZFVsdlgxQVhJdG43U1BDZHBBaUdBT25CcnYz?=
 =?utf-8?B?M2M2elkvMEIxeUxBb1hrc0t4QjdCRHpJTk5zNDlmdUlaZEZqMjlOdVZoL2wv?=
 =?utf-8?B?ajRxbHVKdlQ5VEJMWnErVDM4OU9EeXVCcDEwZDViSDRTemdmUUZUVjZVeE1S?=
 =?utf-8?B?aytxejIzZjZzVUtjQStPVnZxVDR4aEFiZkVNM1hJbyt1UVk3Y3ZDWi9BWDVt?=
 =?utf-8?B?TWdWcTBBRG5jM29vT2d2RllrWEpMc3VCcWpFbVo1emtEQzVkbStXdG9jMXBU?=
 =?utf-8?B?QU5pKzNiMmtuNXFnbGdLTnVwemtOemNSQzVRclBFM1lBc1VycmE4RDlPNlBh?=
 =?utf-8?B?TWRLZjRoWmRqR3d3QkhtdkR3RGdMRnBYUWF2am4zQ3ZMKzhhSjNzV3NJVXNP?=
 =?utf-8?B?ZUpiclRPRmpWTHQwV003bEovV25aT0NWL3RpWmt6WXN4WW9JZFpoOEpJVit6?=
 =?utf-8?B?U3pCajhpSmxIZ0FLaUVpdXBVcHU2ZUswUG03bGhyblFuQytjR08xczNENUkz?=
 =?utf-8?B?MkY0S1VsK0FtN25BZ2V1dlZRZHRXM24wQ0hwNDhjYlFuYUU0d2NpK0tFUlI2?=
 =?utf-8?B?WHhuZkw1dzR2OTRaRjZxaVFHb2hzSEVIS3hXdU1ETUM3YmpaeGNXNTBRajkw?=
 =?utf-8?B?Njh1VWJ6aXN4MmI1cndmKy85Unl3SStIeWVadUN6OEsyVHRVVEZIUmlnSS9S?=
 =?utf-8?B?MmFURWVOYXZyYVFKcy93N245S2NCMWp0UEFkQXR1VDdRV29RYTJpaU5uczBZ?=
 =?utf-8?B?T3JKUS9HRHV5a01jUHhwVEE0V0FxUzRVZ0VzUnRscFgvNVErYkcwVWk2S3FK?=
 =?utf-8?B?RW01ODRZaXdZUk1LcFNyZGxXdERxeTByZzBwb3N6OWdjeVNIdmNENERqMlJs?=
 =?utf-8?B?eUt5d2pBOTExOTQydU5WSitQYnNNT0tKVDNsUHN6S2R2SUhRbnBBaFpJb0lB?=
 =?utf-8?B?TmVzZHU0eXUreDRDLzd0bStZN0pHSmNTbGhkNFBYRDZpaDFWaktQbUtJUmRG?=
 =?utf-8?B?bUhTMG1FZjBxamlZWk1VUkxTTk56N1A1dDZ5V09aTjhhSFF4WUV1c3JDQUlX?=
 =?utf-8?B?QkpYQ2lFWEJUSWsyVmZpM2VjREtSeGkrT1BqelNKU1BuMUV5S3BEeXdVRnpj?=
 =?utf-8?B?TlNiSE5kWXVmU1JvVTZ3RFZZZnRqTTdXWW9oY0JtdisxcUo4WW1IZUVVUmxh?=
 =?utf-8?B?cStxWXg0SXhlVkNPQmM1eGpoaXpNRVhRQ1ZaTVdIZ2dCcW9wODA4NFVKcEli?=
 =?utf-8?B?dUdvRVljRFJ6YlVWMGhNMnBOYytBZkRaUlZqMlpqSjhzSkdZYmlacEVHTC9y?=
 =?utf-8?B?V0JFZHpjTWlTNWNDL1ZpR3lpMjkxVTJZbTVnTlY4enRwNUpXeVU3YWJQMUl1?=
 =?utf-8?B?azE3ZW1EUnpRN0J4SGZhREpTVDhiZDdxSWgwL2IvQzFCeElQaEVJRG9aR090?=
 =?utf-8?B?TnRGS2FpZXFuaVlxT2NXM0ZZUGYxUVFpM1REdC9SRkwrYkJxR1VmbGtoUk1E?=
 =?utf-8?B?Z1QvTmhoME1LbU9WaUhSazdIb0JIT2ppVjU2T3BPdmFJbjRsUkZtNFgrbGZV?=
 =?utf-8?B?dklDUDBhZVNMVndjTm1TY2ZEYlRYUDRhbHYrY1crSlpkK2xka0FNVTMwRXZO?=
 =?utf-8?B?Ymp3eU1OQ0M3UjFXa1VuaU14K01ib0o1US9qeHNZNWUzbnh6UFhtdFJaZlRS?=
 =?utf-8?Q?JhgPoUreNNJ1QcbKzp0+G4RAf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f52e0c-e39d-424d-9c4b-08db42319344
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6043.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 06:28:09.7466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tCKRPYD2i4USaJTqBf0loTFwkgeiY9AvymDC9AbNZZ/sRoGkmTQdqYTp4FEUDtNfKN+52YjRY1XaHT0mcarG/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7468
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/2023 1:37 PM, Jerry Snitselaar wrote:
> Use the page mode macros instead of magic numbers in fetch_pte.
> 
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>

Thanks for the fix.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant



> ---
>  drivers/iommu/amd/io_pgtable.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
> index ace0e9b8b913..61a99d715b23 100644
> --- a/drivers/iommu/amd/io_pgtable.c
> +++ b/drivers/iommu/amd/io_pgtable.c
> @@ -310,8 +310,8 @@ static u64 *fetch_pte(struct amd_io_pgtable *pgtable,
>  			return NULL;
>  
>  		/* Large PTE */
> -		if (PM_PTE_LEVEL(*pte) == 7 ||
> -		    PM_PTE_LEVEL(*pte) == 0)
> +		if (PM_PTE_LEVEL(*pte) == PAGE_MODE_7_LEVEL ||
> +		    PM_PTE_LEVEL(*pte) == PAGE_MODE_NONE)
>  			break;
>  
>  		/* No level skipping support yet */

