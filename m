Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA39D6EF3FD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 14:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240797AbjDZMGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 08:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240267AbjDZMG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 08:06:28 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20624.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::624])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213F159F1;
        Wed, 26 Apr 2023 05:06:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3rR+PowSaaBqp6nwSmoCYf8RE1Lg2GLtcZ98gg0u5aR+nB+wjAOCske5cMN38qMIhycVECyy+TAP6NtF+itEDZUm1qJxMhYFl1WaxSIobDYhBJjrBcV6wuIqZzduPAavE8HaCpHuRqN1WQzImwjkgdGbyuG2kOmDlw58s2IuuTff3vfh+h73bZLR3rEFV8AoSK2AQc9GuekAGtpBfY/v7o+K51ZcOD5oQyj0aa4p5BrURhmAms4Rqk2x54aAkPcA1GR7q84IHqos7n8PLd5OqvZT80iLQeOZ8kAumkCEw/7PjVT2sFvwDSVL0hNssT9nJHCvpAu/qifjh9YbAiddA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Jy9GVv7FhePxyf+UsTYcz18+NHjxJ8jPSpzT81qO+I=;
 b=ft66ugfhhbZ6D2I/yCZkod9FcpGSuhS1Rzb2gcwe4ZwYMGJXTsxZ0uvHUQf5XELw445st9kre/qze+UnDVyN7jVVSUGSkREXQ5eA2vVtLn27zhq50sVf+70aLTVZaqDjGezm9M9x5KNSx3rXPMj7gBYKJcEEI9VDEY2hrGrKjS3Z0rsQXsWcgWNI+vm2yEVolzNV6Y5LzkLdZ19OEw/M75e5JN2jpyveDfQVgX4hjVW3TjRAHp8c6K1Jzr0ByUwlQQplbWPjsVVQer0/xk7rS/i881YnTF6aaAs+NcE3x0o9XZ/OubTonGVFHVaxZmhK7HVAAt6Akl07AUzA45JD3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Jy9GVv7FhePxyf+UsTYcz18+NHjxJ8jPSpzT81qO+I=;
 b=Zo5EfwsM6s4p9exepS2Iyx+RU6JvDL65l1/MsPCWC4IdcWLy3ymgfgM51KEF/G2eVJqL2idk88SE45aCQFXWgFgfBCBkpS7OMSnmBakeoHZrVKs4q7kOzaovarNcXNQTYBq1+2SWdjkvh3p4MmpIFnoNmhp2i8AZ6rWZlINFzLs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by LV2PR12MB5749.namprd12.prod.outlook.com (2603:10b6:408:17f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 12:06:19 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::8c5f:e48:a658:7611]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::8c5f:e48:a658:7611%5]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 12:06:19 +0000
Message-ID: <905bd588-38c7-e3ad-c201-534c4593aa51@amd.com>
Date:   Wed, 26 Apr 2023 14:06:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC v1 0/2] Introducing generic SCMI pinctrl driver
 implementation
Content-Language: en-US
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
References: <cover.1680793130.git.oleksii_moisieiev@epam.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <cover.1680793130.git.oleksii_moisieiev@epam.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0004.eurprd02.prod.outlook.com
 (2603:10a6:803:14::17) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|LV2PR12MB5749:EE_
X-MS-Office365-Filtering-Correlation-Id: d20c741e-0ae0-4ca2-019a-08db464ea4e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nwrSARBVA6KH3BcLydFvaYhvYOfzcM2qPgSseWDaAc4df/h0vsosilnJcwRhPCc6nQs/R2r8QwB1pwllgAp2uf+E02/2ATa58TmfEYN5OxhRWQOteuMHXFS7LM+yGzK0RC+9+CQpub38+0hVOE6bpB7Hwx2fCAy3hiASUpY7Gw3T70z7U+XlI5pbp2WYJNVf6KNo33nBJOGu4uctiW+m2/0T1oFwpKbEys10yCb8QGJd11C+XyMCjs2PERd1mop6vM8Uudd+xVnMMchmQUOwFW3HkJau2tFxNopw+/cfrWbWH1jjhfaNiXlyvPpOiSSkvIux0OGXE6U+EQQ4EciW1q0NHFDKablhSxRmKpNFrdSwE4s8p2OyLC4y5Fb1rb+o5X20mc7bDM0ToNviJ4rOWfAOHfV3QMRz96qKtWV1nIQPC09z5eB3O6J8RWpM9uXpNX+1f0MtXzPGs/k189BocFrUpHrSXMnBMi9qgkFKth0g64rR8UnERrORMsruS/ZjqYi9I7p4LFFCTYijBWKdyxgah1OcsvwU62K0cuNqZLU8RjJ17iwyQ0I4UUkIVE5MgZpMkUwpis8Zid9W0l72hQJj51jYm03MDBh0rDE79tQ42teS2wSE6ekXuRdIvcTMx77qSkI5q0IygNK3qB4yOnqnqZUNp4qirG+R86aYovk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(451199021)(31686004)(31696002)(86362001)(36756003)(2906002)(53546011)(6486002)(2616005)(6666004)(186003)(83380400001)(6512007)(26005)(6506007)(44832011)(66556008)(66476007)(4326008)(110136005)(66946007)(478600001)(316002)(5660300002)(41300700001)(38100700002)(54906003)(8936002)(8676002)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDByMlNnTjNuaDV5eWViaUN5WG4vNndYM2lkVXRMejUyRFFzb0QxZUV0RmNK?=
 =?utf-8?B?eGozT0pBMHdYcDIzYlY2Y2Y0ck5VQ0lsK0E5bkFFdHg3TXhWK3ptbCtkdU45?=
 =?utf-8?B?V0xKWnpYMW5PY05jckJpS1ExOU8yZFNGMGJ0V0dDSmt3NjE0czRyeE5DM2VR?=
 =?utf-8?B?VnBUQndsY05WR1JpSHNsS0Y4RmduSnhkdlJOYnFoVUVXK0RrZHorZ1BuNDdM?=
 =?utf-8?B?SmJQQ1EySERNcGNrbXY1YytmUTYyaVdXQ2VVaUtVYmlBQ2VZN0ZVYWVPY0RQ?=
 =?utf-8?B?RTZ3dHBSRVVZOGE5dFdvOXA0TC9GZUZyaHBlZzN5d1VHOHIrT2pqajBna21t?=
 =?utf-8?B?MzRTdDFTQld0N3hpL0hnOFpRWmdvcE9pcVhROS9jQ2RxZVBMSDdVVTNTenZS?=
 =?utf-8?B?QnNUSHpPUjh5OWs5U1oxRU5wcW1pdXhHQzRrelBraTJJYWpTL3FCUlI5TVh4?=
 =?utf-8?B?KzJ5TlQ0WlRoL3dQeVE5NmgyQW9JOUJ3ZHV1SWxlL09Nc2h1dWNnQUdaSHdh?=
 =?utf-8?B?L1FQcUdNa1JSL3N0SG5NVzRpQ3ZVSXBnZHNFM09aeGtxR29TSDhzQzNDa0FQ?=
 =?utf-8?B?ZndJZjgvZzFpZmQ2a3ZUSDZDVUxqZjJNYi9KQWdZUGVXWlVRSWwrWmU5cWxR?=
 =?utf-8?B?aDd5a0tkVlFBSjFjRzJLRTd4eklVZk1lSFFobUh3Y2V3WCtGTnFyVEZhdURM?=
 =?utf-8?B?ajlwYVoxWlJyQS96YVgrckJsYm9SU01kNE1RZDZVdmhtR2VHcmRHcis4ek5m?=
 =?utf-8?B?ZVAweVdtUStxc1dWeDZ2MzRkT2VXbjNlTjFyTVdlRExmV2k1Q0ZoTy8xaXNr?=
 =?utf-8?B?dDdUQ2d6NXRITFJtQXpKREVKbWtZMDlad24vWERzc0ppcktPLzNjVVVFYlRT?=
 =?utf-8?B?R1NBMlV6d1Y2SzM2SnVMWXFiNHlXTmlKVXRiTXFDVmJMRVRCdkVwckdnektq?=
 =?utf-8?B?ZFJod1Q4am5hZHM2Yng2dk1HZUIzWTNISEsrNVAybCtpZndhVzdkZmJlYVNE?=
 =?utf-8?B?Rjl6dk9lUXJHRnkzc2RrejZ3VDMyVXJ6ZDVIVHA0ZVU2WHB6aDNxYmlScVFv?=
 =?utf-8?B?TlNtMitHY1dadks2NkYrQ3BiSndQVHB0RmxEZ21nTUd3MTRjNTJGRUVETUxy?=
 =?utf-8?B?RmxZakpVREtaTyt3OHpvN0JpZnV2ZzVoUDVqdlhCQUNHTU9QUDhQK3QyVmYz?=
 =?utf-8?B?d1FycGFjdnVBTXlVQmhDNjhRQ3hFSHJKVkovS1Z4UzBKazN2K2E3bG5HOHhi?=
 =?utf-8?B?SW5OYkthLzU2SytSelI1RWxlc0xxM3BnZU1ucXc3VlQwSFVxVFdYQ2Q3ZkFK?=
 =?utf-8?B?RGY5VDcyS29yZE9TR0w4R2x6VU83eVlaUzdxcWVmei9ZN0FLVHdoZU91cDRJ?=
 =?utf-8?B?UGQ0TDhCZzJ1RDVDZDJvbWE4dnZKblArMzl2aHFsUWR5TkdabFJ1UVh3N0ty?=
 =?utf-8?B?UklhRS9QV0o4d0h4YzNyMlZ2WGNMMFFaRmI1aHFQZWU1VWRNRlZLK0VROXRK?=
 =?utf-8?B?Sm5UeFNua2lOY3dOa0VGVGg0WGlEb0NCWGY1d0N2NTZBT1lPUHhXTWszVmtP?=
 =?utf-8?B?bzRkQnJNK3Z0MERsSzdsU2pLOGdEMk1IdVNWdERBMFdRN2JnWTMwdmhHKy9E?=
 =?utf-8?B?VVlOTjc5UGN3K05tN0FlY2hPcWhVVUxxaW95S0pyMUJYc0FrdU9ncE9uTGNR?=
 =?utf-8?B?Y1NGNlc2USswMDFZM2lmcEtVaStTalNjLy9kTGtMM3kvbE10RFl4NGhqNUpH?=
 =?utf-8?B?VEl3RHNaTjRUZkJlZHBBQkU2R0tHSk8vcStKVktveWxYaDFadEIybXdKRFFI?=
 =?utf-8?B?a0JPbU9ROVJRb1V1eVYwQ0dYMm85eVczdHlQZXRicEU5NWE2NmRtOFFPaU4x?=
 =?utf-8?B?NXcyS245eSsxWTR3c05YUytQaTIxbzNndWJuZHZvUWN3ckZxSjhKOUFnMmxY?=
 =?utf-8?B?Y1kvR1dCQXc3M281YkRIcDdEeXg3Yi9mWXQ3TDk2dlJ5eThQWGFYZ0U1KzBT?=
 =?utf-8?B?MHQyWmRXNUV1RlpXVlBndmxnR1YzRVZpWWhTb0l0U1UySG12WGdQWDRsdXFh?=
 =?utf-8?B?MFVrL3VDRWxGRzBUV1BVdEErVWZXb0d3czJlRGZ3L3pLLzRRaDVOaEFtUDla?=
 =?utf-8?Q?BNF2zxqOGyFFTUVNQMmmoB14j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d20c741e-0ae0-4ca2-019a-08db464ea4e8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 12:06:19.2736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sVzZTgKJORIXnu3narce1DvevMtiq52buQlexQ5TxdPChx7EOJ/8jP4GO50vj6s1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5749
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/7/23 12:18, Oleksii Moisieiev wrote:
> This RFC patch series is intended to introduce the potential generic driver for
> pin controls over SCMI protocol, provided in the latest beta version of DEN0056 [0].
> 
> On ARM-based systems, a separate Cortex-M based System Control Processor (SCP)
> provides control on pins, as well as with power, clocks, reset controllers. In this case,
> kernel should use one of the possible transports, described in [0] to access SCP and
> control clocks/power-domains etc. This driver is using SMC transport to communicate with SCP via
> SCMI protocol and access to the Pin Control Subsystem.
> 
> The provided driver consists of 2 parts:
>   - firmware/arm_scmi/pinctrl.c - the SCMI pinctrl protocol inmplementation
>     responsible for the communication with SCP firmware.
> 
>   - drivers/pinctrl/pinctrl-scmi.c - pinctrl driver, which is using pinctrl
>    protocol implementation to access all necessary data.
> 
> Configuration:
> The scmi-pinctrl driver can be configured using DT bindings.
> For example:
> / {
> 	cpu_scp_shm: scp-shmem@0x53FF0000 {
> 		compatible = "arm,scmi-shmem";
> 		reg = <0x0 0x53FF0000 0x0 0x1000>;
> 	};
> 
> 	firmware {
> 		scmi {
> 			compatible = "arm,scmi-smc";
> 			arm,smc-id = <0x82000002>;
> 			shmem = <&cpu_scp_shm>;
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 
> 			scmi_pinctrl: protocol@19 {
> 				reg = <0x18>;
> 				#pinctrl-cells = <0>;
> 
> 				i2c2_pins: i2c2 {
> 					groups = "i2c2_a";
> 					function = "i2c2";
> 				};
> 			};
> 		};
> 	};
> };

Spec itself has as the part of pinctrl also gpio support.
Here the example there is no gpio-cells property that's why I am curious if you 
plan to also add it here.

Thanks,
Michal

