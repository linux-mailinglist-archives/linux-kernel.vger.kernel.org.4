Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720FC66E875
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjAQVa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjAQV3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:29:13 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223D85528D
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:53:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOVZ6XhX/SyrKSaZOmvd7nSeMKXsrM8nmhW74XHGl7o/meMQ/WdoawWpsO2SKgyc2c85YuJHrxqWq6LRSuY1FpUVRUnjopCgj7SMzcWySvSAx9oZCLuUHxlYPeenYx5HfeVOznxX4VaYeKZT2bojE5w6i+mkCKR89LW0oZkrCN81ODx43aprx0c7cRKDEE4+U9ndTPwsMZT0Iz0W+hr044nPsDjUlbJ9KgL4dIKSwOPtbWivr0vU7p0jXJftBI3LrGQwGwFnW6VohlhkKFQfh54JIhR5ZbSzJxQ5DIeG/fFaw3q1SMoxGfxNN2xZRcLQgZzNYH+ht2NoojKtUTvNzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ar4tLFzz3TZGgXkxypPzJ3C9RoEcvFgaQc0oopfDjZg=;
 b=JhC/FhTKRg0sSdl5SAfm3uHGQQXdftvG1pu1DivDqVnuSlUOF8yVkBhbqJlTG5lNuXHbx6I4MGVfqoRS0/fL48/CzEEefjIPPaXqv0rugBebRB+Sawwg4PMHguParNK28YGjEJ+ZVLNMX1x3Oyj2869LL2ghWvCV96lbZ+etkamyWZBcEeYiJfMKmr1C81cKUCG+9b9A3wPIJxmcTj037exNuakRsVkb6qBkYVLZkNhaD3f6qvPXYyq7w+xjs7AKG2XvaRncvbhWUROwMXKRdxZRgPJmda0uoTAipV7cTdvy/jWfQSfQ13Jkvzm0dVjsra9A/I/SxYBud9+XXNaUwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ar4tLFzz3TZGgXkxypPzJ3C9RoEcvFgaQc0oopfDjZg=;
 b=aemIl5+aUSPq3mUC38C+IPybPFolz4m9HIaPoy5NBZijAgZN7Xpl+S9mD8z9kjPW2xVd2tdl0b0uQvXEqBVa3A4gpVrktfpO49P7GXBnpsWOM5rmGrouK7dCaC0qsb1+/3mOQGXKhgY5ph2JT5O4dk2JziIdanHpF48feXFyZcU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by BL1PR12MB5288.namprd12.prod.outlook.com (2603:10b6:208:314::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 19:53:35 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::3ddf:d47:b37a:5a7a]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::3ddf:d47:b37a:5a7a%3]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 19:53:34 +0000
Message-ID: <d6166b85-01df-405b-3112-d9bde16b6bd9@amd.com>
Date:   Tue, 17 Jan 2023 11:53:32 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0)
 Gecko/20100101 Thunderbird/109.0
Subject: Re: [PATCH] firmware: zynqmp: fix declarations for gcc-13
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Tanmay Shah <tanmay.shah@xilinx.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Ben Levinsky <ben.levinsky@amd.com>,
        Ronak Jain <ronak.jain@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230117164133.1245749-1-arnd@kernel.org>
From:   Tanmay Shah <tanmays@amd.com>
In-Reply-To: <20230117164133.1245749-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0015.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::28) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|BL1PR12MB5288:EE_
X-MS-Office365-Filtering-Correlation-Id: 839498e7-8002-4f8f-5f4a-08daf8c48445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GY6BUVUcEb7g3khfb46UDtfHfebkqH9GIbJ275TFvuLk5jPlhxsxAxQseuuxtcJjQ6srJTqVtlDHszA0DyaSToRbmFmTCRRFtZhpz4nxSal5stgTu6QdBflST9obyoQnHzegGhxrGma4Dcuh0n2MC5NydXB2iTWylNB0w6fh66s6qhy6wY6TX6vKxDGXdD2GvDLMwN6r4jXeiZlPoJRI/Qg3MhKtS730m+sxiCNrtZ0aB4g6/7YWKqhouD+pfKroeqqgW4tl3o4fgvIafhIWqW19E5YYr1lblOLjEMzIHgwmzoFLXld8qRoJ1TTMX+K9iutE51OlZT8MmQ8oEtABOieVRKZ4LFt1H69TgKBx4J656x2KZpie7ChTUNHXxJoihn++nwjtRBiazamypn3NhuHaL76zQhI1e+EhgUmxycS2PxAhIobBK0lQHzy3+u+XDO+DOTkrb7IaCaK2Yf12eThGlmy53/idRY2bY947HFRaKgrv9ezxTtDPmARqlOm/BjyOyAzXFPiIbM/eh6cV1JddlI02giYTz72LqF1N/o/Ux0sH1KOv5gMYMRf8+CA/nzNX9ekNlrkVY1DhQLzCLLfgWPx/wWRLrCROnCxAhZCWjA6laKRmO82UB+O6xYwnvH7X+P9m1F68pFNe5lYZroQ+1j1HMznNQnXmN4KCzlarzRmf6SEebdej5LxzFf7aNXxfjr8fpZeand3vA3kLmGd/hJN0vIhxrooHlVAD9MA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199015)(2906002)(31686004)(5660300002)(8936002)(66476007)(4326008)(83380400001)(66556008)(36756003)(8676002)(110136005)(316002)(41300700001)(66946007)(31696002)(6486002)(2616005)(53546011)(186003)(6512007)(6506007)(54906003)(478600001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjYwQTNaTVJsZGViclc2aVRJS2FoblZaZWdkczJNcW0wTS9Td3ZSa3lKcnZT?=
 =?utf-8?B?TkZmVW92dXM3VmY3NzFSb1JCeVNobzZBRSsxVHorWHc2azAveXVXUkZiUC9z?=
 =?utf-8?B?enI1ckVtYWFKVkFuaUxGcTVUeTY3LzlaZHZKbXdmc1ZyZXdaUzdEK1BrM0h0?=
 =?utf-8?B?dzV2bXZyaDBsTHJ3VWQyODdZR09SenJrWldONktXVEd1MFJSQWdWT0NldDVE?=
 =?utf-8?B?RE1XOXQ1QUd4eGZFOHFtRzRYSXpNMURPMjQrSG1PbVRWY3pkWC8zVk9YMjUx?=
 =?utf-8?B?Q3dyY0p0T0xEMzlwTDh0YVBKRDJlcEhxV09iSTZkR053anppTU40RXFuaHFX?=
 =?utf-8?B?akU3SlJUaEVaaFJaeW1NQ1pwVzNNNkp1eVdEMnJHQnhDRUIyaWdiK2tzY1p5?=
 =?utf-8?B?bFRGYWkrU1RCRFZoMlhFcVNNaU1hU0o4Sjh4bkVEZFdJSjdTbEJSdksxNEUx?=
 =?utf-8?B?T0xmL2FGcThxaXg2Zll2Vm43WXpHY2tTRHJ5dTFOV09ZZVRveWJmei9na2FI?=
 =?utf-8?B?eWNsalEzTkJIUExqNVR4UlJydWVtcDdGZkxDM01IVkNnM2thT3lVdmhXa2hF?=
 =?utf-8?B?VXJqRS9tbyt2Q0xzV3dOb2VwYzFqcHh4MjlBYmpOWFpVaGRBZ2UzYmxXaUww?=
 =?utf-8?B?UVJTNzJ2bUVwTHJVT1dzQStkZHJwOElTYjlNY2g2YXF1Rk1lQkJGQk1aQkNH?=
 =?utf-8?B?S0l1Z05lVWRtWjFhaTc5eDdNYkFEODFESmVMc05HZkxoMkJWdTc1UVlaMU14?=
 =?utf-8?B?L2kwQVZmZ0ZFMmM4dEM3RFdqMnUyVnVKWm55ZUdkUkR5bzN4aTU0Zk9TREJY?=
 =?utf-8?B?L3pucHFOZUtSLytZeEF1SXl4blg3L1Q5d1IvRUZ0UkltSURGZzBUYzhmZ3U5?=
 =?utf-8?B?a3M4MU8rMGI1MU55c1RNQ1F5T1F6T1dITVZqOVRESEovVHdPbnVnQ3k1eWlw?=
 =?utf-8?B?bEpvT2I1aFYzYllGaWFFd0lYRXZNNkYvVEVLd2hiRkdyZkRwZTdRYloxYU1p?=
 =?utf-8?B?aTBlOXV4Y3A0Z3VzMXVEUVlaRGFoOG1jTnJwdUtOYlJTdTJPNEtSZSsrMTFV?=
 =?utf-8?B?YVo0SVdTOElXSVg1Kzg3THh0cGFlNTlNenhQSFA5YXllTk44aHdWRmdkU0ta?=
 =?utf-8?B?T3ZlVkhYT1hOVERxTWRORzZrdXRuMmNzd1lyK1BCVUVVMmRHQlRTeTMxOVh6?=
 =?utf-8?B?dU1vVGIweWxqeTd1anZHU2YvSjJFSkJVb3QvdkUyQ25Lcmh3bndZUU5aRUp4?=
 =?utf-8?B?YmxpRUhkOWxIWWlLWFEvUEtzVkllWkM0STVQd2lCbUg1TVNzV0RVWmorb0tL?=
 =?utf-8?B?RVRJdEk2UzMzY29VbnBRNS90MFZaMU5qT2xtRHNMbXdDZW0zMlRFVDVWaWpN?=
 =?utf-8?B?VHFMNlc4Tzl2S05pZ0JOTGY4Qk5lWkw1ZU1zS0lQeXZKcCtiV2JPME44dG56?=
 =?utf-8?B?R3FrWE5oSUNwaEFPMVJiT1pQNlp1cm02dk5heVFMREswblFMMUpwM3F6Ym5X?=
 =?utf-8?B?NDFXYXRDTDB3QzdEeVBscHZXNFAzNEZOMmlHVlBaWTdaSkZ2c1lSZ240aXFO?=
 =?utf-8?B?SVp6WXRqNXgzSE5GOVIyNEs1d056STFEejBqdmw5YTE4N1pIWWIwUU1UUVJY?=
 =?utf-8?B?ZUhTV3FkSHUra2pscmJ6Q0plNjdmK2h1SEpOSUhONnhtRlUrUGxTMmsrT1lD?=
 =?utf-8?B?NWZwZGJmWGdxYUFIM2xtaXM4TlAxWHBsaXdpS0FRQmh1cVFjTWhnSzR3dlJo?=
 =?utf-8?B?cEFTLzkwQ3g3RXk5SFNiV3daQUJVMXdtcjliWWkxTWlCZVIzTStoUzJWdFhh?=
 =?utf-8?B?YUVTM3R5a1R3bzhKMjA1bHNNL3BLc0NiNnIwMEdNbkw0Y0ttZ1hodE1ReXVL?=
 =?utf-8?B?S3NDU3duMVV4UHdUYVkxekR2Ry9qdndGeUt4SEdBaVU0WWI5a0Z2TmRJaEpW?=
 =?utf-8?B?eWhBd2NySlNHRmNhWkZhdzgyZUtFS0tOeUtObllLWkZ1UmZrZUJmT2NKcGYr?=
 =?utf-8?B?VHN2S09PdWZURWRLTXBUODlaa3MrN1pzc25uaXJsNzZqaVBnUjFDc0JIQmFY?=
 =?utf-8?B?dkQrRTRlRWJGdmc1WG0rektVRE5rckNqZzRIbjhLRGlNc2lYcXJTQzUrVEND?=
 =?utf-8?B?cGxXTjdZbHZxVnhUY2ZPZExONWpkVkpkeGFidldlZ3RpU2FieXpmdWlrcDJH?=
 =?utf-8?Q?VjPxU9XiIyymLkD5JkUtrNxqDa4eGAr3I+hJPfSaEaaZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 839498e7-8002-4f8f-5f4a-08daf8c48445
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 19:53:34.7763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqv4tUVVmxaZUogdDRw/RzxbuZGBewPOqNojFcs/L+Rq5Ih8/eFHcrjV5K8kN1bi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5288
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thanks for your patch.


This looks good to me. Thanks for fixing this.

Something must have gone wrong when I ran sparse check on this patch.

Just one question, does this patch need "fixes:" tag?


On 1/17/23 8:41 AM, Arnd Bergmann wrote:
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
>
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> gcc-13.0.1 reports a type mismatch for two functions:
>
> drivers/firmware/xilinx/zynqmp.c:1228:5: error: conflicting types for 'zynqmp_pm_set_rpu_mode' due to enum/integer mismatch; have 'int(u32,  enum rpu_oper_mode)' {aka 'int(unsigned int,  enum rpu_oper_mode)'} [-Werror=enum-int-mismatch]
>   1228 | int zynqmp_pm_set_rpu_mode(u32 node_id, enum rpu_oper_mode rpu_mode)
>        |     ^~~~~~~~~~~~~~~~~~~~~~
> In file included from drivers/firmware/xilinx/zynqmp.c:25:
> include/linux/firmware/xlnx-zynqmp.h:552:5: note: previous declaration of 'zynqmp_pm_set_rpu_mode' with type 'int(u32,  u32)' {aka 'int(unsigned int,  unsigned int)'}
>    552 | int zynqmp_pm_set_rpu_mode(u32 node_id, u32 arg1);
>        |     ^~~~~~~~~~~~~~~~~~~~~~
> drivers/firmware/xilinx/zynqmp.c:1246:5: error: conflicting types for 'zynqmp_pm_set_tcm_config' due to enum/integer mismatch; have 'int(u32,  enum rpu_tcm_comb)' {aka 'int(unsigned int,  enum rpu_tcm_comb)'} [-Werror=enum-int-mismatch]
>   1246 | int zynqmp_pm_set_tcm_config(u32 node_id, enum rpu_tcm_comb tcm_mode)
>        |     ^~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/firmware/xlnx-zynqmp.h:553:5: note: previous declaration of 'zynqmp_pm_set_tcm_config' with type 'int(u32,  u32)' {aka 'int(unsigned int,  unsigned int)'}
>    553 | int zynqmp_pm_set_tcm_config(u32 node_id, u32 arg1);
>        |     ^~~~~~~~~~~~~~~~~~~~~~~~
>
> Change the declaration in the header to match the function definition.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   include/linux/firmware/xlnx-zynqmp.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index eb88b4ba62f9..0e4c70987e6a 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -549,8 +549,8 @@ int zynqmp_pm_request_wake(const u32 node,
>                             const u64 address,
>                             const enum zynqmp_pm_request_ack ack);
>   int zynqmp_pm_get_rpu_mode(u32 node_id, enum rpu_oper_mode *rpu_mode);
> -int zynqmp_pm_set_rpu_mode(u32 node_id, u32 arg1);
> -int zynqmp_pm_set_tcm_config(u32 node_id, u32 arg1);
> +int zynqmp_pm_set_rpu_mode(u32 node_id, enum rpu_oper_mode rpu_mode);
> +int zynqmp_pm_set_tcm_config(u32 node_id, enum rpu_tcm_comb tcm_mode);
>   int zynqmp_pm_set_sd_config(u32 node, enum pm_sd_config_type config, u32 value);
>   int zynqmp_pm_set_gem_config(u32 node, enum pm_gem_config_type config,
>                               u32 value);
> @@ -849,12 +849,12 @@ static inline int zynqmp_pm_get_rpu_mode(u32 node_id, enum rpu_oper_mode *rpu_mo
>          return -ENODEV;
>   }
>
> -static inline int zynqmp_pm_set_rpu_mode(u32 node_id, u32 arg1)
> +static inline int zynqmp_pm_set_rpu_mode(u32 node_id, enum rpu_oper_mode rpu_mode)
>   {
>          return -ENODEV;
>   }
>
> -static inline int zynqmp_pm_set_tcm_config(u32 node_id, u32 arg1)
> +static inline int zynqmp_pm_set_tcm_config(u32 node_id, enum rpu_tcm_comb tcm_mode)
>   {
>          return -ENODEV;
>   }
> --
> 2.39.0
>
