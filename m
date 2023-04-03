Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4516D3C71
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 06:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjDCE3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 00:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjDCE3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 00:29:32 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CE6AF3C
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 21:29:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i37yZvAIn1CHZ+nMRfAYp/89xcJPSIZTeTW+nIboxmLPsc4SNLZtnEvjQpGv6AYDpD2G/+lNBC6yXjiQaNqz2WjB1WOzJCNqaIyB99OvuTUrdBHwZz5ycT8gTTai3zMHmvaci7LYU2MuKzbfLZMi6P11KCoaI4/ORAs6jDaM1Er2140iRsx5Yr65hFdXjXKh5dJp1aVLgjIirhU+Oyt62ABlAao2dsX5fFWU6QUh/C5+kw2ZNl3YyOND3I93Ampjk/Iv2ytzeTRFAlAiem/LNUnMDmJGCD/YIp2ECkQVwfe8+LWf9iHzNbOKUtV1HAcuc/aH18OABbKvV5Hw1aftHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9gN64kVsN8tdlAbakK4MAIjRdSB3p/8UeqNwPa2DpM=;
 b=gdawtXB+YQM1CsGeX7Ru4w6/RQhOI1Y30u6gz7RDYEys3qOP5tonrcbmT2NaHJpn/Jgn/MXSIcELUy4y0iFgDZ7QfOLgOv5G5JBIp+MPQAYF5/+mWPgmx7FfLEXVsj7SK2aVvGlD5IUX5Ml/lIKTTZgYAozjHatLZuAoIhii+2EIYv7ZWIKeCVpLjQUm2kWsuZ/wIf9BuX3Xs2G0mEBGipu5SMka0LLtdcMBroeDtXImaN4b3+zaZFcoJSacklK764KvxwcJaWqHLNSj5U/ppvd/yV18cJNnCaRyEoV6TJDCPDyLKbaJCY5EcR3uKjd+piTQyHYSXZIe2r9RFpJh9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9gN64kVsN8tdlAbakK4MAIjRdSB3p/8UeqNwPa2DpM=;
 b=aBU0XotHkSOKx4ifRQxczvI1NoYsJ+Z4p0ca29BuNbCQNIBkgZhWKf+b2HMRKapTOMW+7W+M60lBhsVBkWS9qIL0jKytuq+FMKrDGYrYDyHsyXRKgf12YhHtY5nIzBnxOkIppdX25jRyPYNlAeVCaLfgmn3g57eHqwC0yyP3A+M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DS7PR12MB8275.namprd12.prod.outlook.com (2603:10b6:8:da::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.28; Mon, 3 Apr 2023 04:29:25 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::e959:436c:d41f:f9cd]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::e959:436c:d41f:f9cd%2]) with mapi id 15.20.6254.028; Mon, 3 Apr 2023
 04:29:25 +0000
Message-ID: <575ef405-9d43-b99c-cae7-f88cfd6063e2@amd.com>
Date:   Mon, 3 Apr 2023 11:29:13 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] iommu/amd: Fix "Guest Virtual APIC Table Root Pointer"
 configuration in IRTE
Content-Language: en-US
To:     Kishon Vijay Abraham I <kvijayab@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Vasant Hegde <vasant.hegde@amd.com>,
        Santosh Shukla <santosh.shukla@amd.com>,
        "Nikunj A . Dadhania" <nikunj@amd.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, alejandro.j.jimenez@oracle.com
References: <20230331061723.10337-1-kvijayab@amd.com>
From:   "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20230331061723.10337-1-kvijayab@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|DS7PR12MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: d333cf06-2dda-410c-9265-08db33fc00db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sVHVSEGIi2hTFHTosDUIuBskgnwfAir8uQg9LkuRYinA2+0/aUExFu5C6ytBXgP9jFwPyxgDDgWqOwpI0Ei8TBib8I3DIWEp1RGhTWxtKmdZ5vLr3nrUyVo2iR1GAuylBpP1rjRPnypDwx01lb71Zx6fIrVNCbH/t0axGED4hAW6temHrOEwRplD8+Sq04OnG4yKvw6raZnkNFNfQxfrNNqzkHwZ3UeQNEcFdsacBE4ZSM7HYHeiLh/v+/1uVePHRWAwS8iLc6FZIDniGyaHQvyygYRAPhZ3CvzW9ux3S36sWbLzSVfxhvDjDCV3vUIuhHhCzuj7wkekpxM0UxNMOA1q00+4jRXxvfT8/L5H9Kbdz96kBtihKSYKG+2zLbjxaX0yB9ViAiP+6k+Gc8N7bV1k/NqLbP05wNh5QtYuZyyHXF551qiSFC081RIE6lILu5znoiit8Ms1TO3wh4EU8jWHc6uqvNutlS8zKAQnxdM8dSj4WBhWPrJxal6pTaAwbEa4AULSpzGsCGIrx0wzIe6ZiUroWZpPvin52twPcV3Uub5KtpPZptXiKyDnazqLwDi1B5Cx3n+fUY4WwbZgAFbxxEc+Fvq7hdUU9/HoaDw13tGR0X4yphSew2CyR9AtUsa2FdKyAXCK4qvXHt+mkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199021)(86362001)(31696002)(2906002)(36756003)(31686004)(2616005)(186003)(83380400001)(53546011)(26005)(6486002)(6666004)(6512007)(6506007)(8676002)(66946007)(478600001)(66476007)(66556008)(41300700001)(110136005)(5660300002)(38100700002)(316002)(54906003)(4326008)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0liUlkvT05xemFJNUxNaHhYTTgrV05HS0dOYStUV0dla203M0hRb1NMVzBy?=
 =?utf-8?B?YjRFR3cwcmI1eHhIYTc2ZUtydTZvQTh6RXlRbndjc0NXaEYyRjNXdDVyb2pE?=
 =?utf-8?B?OVF1VVFsZFNxWjdsb0taeCsvRXRUMDNrNS9TQ0JuY2FDc2RkTXVVNjFwUXRF?=
 =?utf-8?B?a01VbTZBK0VLZXVPdW1ldXRmdXdnWlZuMDd6dmxnN09KeVpacjJsaEQrZ0lG?=
 =?utf-8?B?YWJMRk1tbTlRVVJqYWIzejYvb2djNGRlRXQwUCt3ZkpVTW5kU2Zpek1wVUJ1?=
 =?utf-8?B?ZFhyZGpIUHNUL0FiUldUR3hHSmlzTlpOSVVtM3RRQnNqNnJySHpPbnVEcWln?=
 =?utf-8?B?YmVmUUFKWnhpVStnY21QLzdmMHpYbjljT2I5WmJPb3B2OFR4eXRIaHlyRGp4?=
 =?utf-8?B?a2FLWmZoenY5QTVxenQrMnBxM24yOTV0b3kxTzAweEtNTFllQ3pZV1JZMTBj?=
 =?utf-8?B?OVNmdldhZHNWVFRLMzVtdzdQUlFnRTZvOUNWNUZaZkZDUnlld1FRNk1nNEhJ?=
 =?utf-8?B?TjQvNDBNK0JVUVN4d3JXVGhCbnh3OUhOYkdZWDlKOVVMVDQ2UHBObzE4aWNh?=
 =?utf-8?B?d0tPQlhkajMrczJLRjBNbkVlVDRVZTRQWXVLVmV1UmtFV29lR2RKNU9lZUlX?=
 =?utf-8?B?Zm5uVmNmQ0RyUU5sbkc2aXFCQi9HczBqRXUrdGIvcDJwZXptbnFEWGtSWXVo?=
 =?utf-8?B?S3NNNFdjb25rcGNwRm5KcXhlYXZlbHpmZy9LOVpjTnZOUVh0N3oxUU5CK3ht?=
 =?utf-8?B?UVd6RVlzcTl0R1FrT0d0Y1lGOXc2QU5uUXZhK2JsbUFlZ21jUnZZdi9QUytF?=
 =?utf-8?B?MUZLendSS1k4R3owdzl6bWxBVTBYYjR6T0VHTHJ6QXp5VG05amc4S2dnUFJF?=
 =?utf-8?B?cHdDSVZnVDR1Tllvd1ZHT3dNRzlndUhxNWZJU2NKQmpFM082VVlNNVZoY2Mz?=
 =?utf-8?B?U1M4TGFzRkxHSEw3QzJvZXAyYU8wbnB2aE1pUDJPU1lmVmdjTTZwNkxtNmlw?=
 =?utf-8?B?RWFZNjBZa2NURUJqSitPVG9DQ2RHcWZweTNlRTNEZFU5bHhmc3BDN3hWbkhY?=
 =?utf-8?B?c2ZWYTltTTlBMXdCYVRGdlRvQmNZM3BDb2dyeDJ6SmY3TGo2TFRCampkQ2Nu?=
 =?utf-8?B?bWNMM1A1MFF1R0JsYlVlN1ZqQlRBNUNveUFuREtFeG1yMTJSUVREMGxUUTBH?=
 =?utf-8?B?dmVwdFpuOXMvNll1NVNzSExqQ3pZWFhyckxEYVNFa3dwOHEvWVZoNC84T0Zt?=
 =?utf-8?B?RDgzaUhrNWx6dDc0dXM3am5JMlRoMlRJYUU4ckJEbld0aFRiTDcyOU4wQ1R4?=
 =?utf-8?B?RktFWXBZd0ovS2pUNGJVdjZOYlZqRU9ESklnN3IrbXlibG9HWnRRUDIvc09v?=
 =?utf-8?B?N3pVbm5jT3Z6YjJPV1J3U0tZUUtYVEszd0RIS295ZUV0Q2Q2STZ1ZGpTYXZ1?=
 =?utf-8?B?c3F3UU5SdnB5VW00RlRaRjVJR3hXZW9sWmVpV21lR2ZVZGNLSnFBT2NOUGFM?=
 =?utf-8?B?MTdlZjdndlVXZXdXQk5Ib05SNXl5clA4MG9OREJhQXFLT2ZqRlVEOXkxUDlp?=
 =?utf-8?B?ckpZeWdxU3Frdmw3aXZXMG10ZmQ1ZVFtNFRwYnVZSjNsRWg5UUpTZU55SXo0?=
 =?utf-8?B?RDkvL2Q2ckRkcnFtU2swbjFuSExqQndQZXhMWlpHYXB6RWUvdE5XN0NvRTk5?=
 =?utf-8?B?ait5UVVIV0V6bHdHVWdobjRaR1FGa211TkIxNldDcVNNTUhLMU1SOUVMWjBW?=
 =?utf-8?B?emtkTTRPeUhnd2RINlBLV1RXTENTbWxFVnFlUlNGR1lYSEJSNnNkL1E5aC8w?=
 =?utf-8?B?bjJLcDdlQ2pva1RBYU5rMUFiWjBqSENOVWtIcDJzZFdPejRkU0VTWHRtN3k1?=
 =?utf-8?B?bTdaYU9KMThsQ2U3eGZseERtZmlDZHFJMW9jMExuZDQ1dmhDWE9uL2d1Sm9v?=
 =?utf-8?B?bmUwSHB1cDBGRnBCTFdoUzhFbXdxbjRZSUw0eG5QNGJLTGtGNFlXREhtVEd5?=
 =?utf-8?B?RzJjdzdpT25PRDlHNkxnUlV0V2J2TCtIZnlZM0Z1MyszbXhoZzBxbVliWXoy?=
 =?utf-8?B?Z1E4RWpuTVVqLzUveUpsZlJDcDhMMWlsRG9QRkhWY0cwS1hoaEpMVXZxdE5u?=
 =?utf-8?Q?CwM+e6FGo9H7a1TTO5eoeZ0/G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d333cf06-2dda-410c-9265-08db33fc00db
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 04:29:24.6044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vyFf8sLrTsln9d0sgpEqSdFgAI3ocRk4WUbmdC67AL0d2h8KvO8TvWMB/hsiBfX78+rybUsH+8EMk0oQ7ms93g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8275
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kishon,

On 3/31/2023 1:17 PM, Kishon Vijay Abraham I wrote:
> commit b9c6ff94e43a ("iommu/amd: Re-factor guest virtual APIC
> (de-)activation code") while refactoring guest virtual APIC
> activation/de-activation code, stored information for activate/de-activate
> in "struct amd_ir_data". It used 32-bit integer data type for storing the
> "Guest Virtual APIC Table Root Pointer" (ga_root_ptr), though the
> "ga_root_ptr" is actually a 40-bit field in IRTE (Interrupt Remapping
> Table Entry).
> 
> This causes interrupts from PCIe devices to not reach the guest in the case
> of PCIe passthrough with SME (Secure Memory Encryption) enabled as _SME_
> bit in the "ga_root_ptr" is lost before writing it to the IRTE.
> 
> Fix it by using 64-bit data type for storing the "ga_root_ptr".
> 
> Fixes: b9c6ff94e43a ("iommu/amd: Re-factor guest virtual APIC (de-)activation code")
> Cc: stable@vger.kernel.org # v5.4+
> Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>

Please also add
Reported-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

Thanks,
Suravee
