Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B815EB419
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 00:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiIZWDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 18:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiIZWCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:02:41 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BA3E21EF;
        Mon, 26 Sep 2022 15:02:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2UEM4IjTwxxX/y+zESTGR+I/OnCG1CrkHS8tDWkvMk2OiDYd13ftoq4hTYz5o3NCTfT5Gv2VGlz8DFvnWlFgDZc0wSYqFRs5wmwgqrGQgm1G7J3xiR3ZUJoNT5rugPDLIAKLSVOvBh31WXGoJ7F6418fqk0NAxrRTqJa6EwmqpYlCp0nVpWvoumaPZObLF0DpMlGatzpPSyfUINCnCbAEWVISYCtuO7yFe9elr42Lw4q/rcdLYcKjALJj6r3ryhYHBFT7jlYV1LkINJna19mau2pwbuw/C4kz5FWGvybMOyW22Qrp1y/qPOdec0xZdJijnfXfh49bJWJLynQNFbXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SH/9E9GWTUBKGS8MomMIuXtApQI+S2WQ8HKoIZHTcVQ=;
 b=YNKLxn9gSDQDdKpZsdBrqDQmOK18CPiz42CVPZAiGSGDvX/3fkdxTm9o4QQcmW38b0fPsD7DW7wpfaOjRPj5TUA+iZ/BBgVQIAyDzu4uOboK3XzWpFYEwOz6eHcIXj+dza23vlMjNxDp5UYEHAlIpccdT9GPAAfW8JKMXoJSZQQiRwVf8/Ntwf5ZMNhHObB7m30UMd9TNtTtWegtZ+hHAZAEOO/nTfstYrQFLR/uBTJycpE/8MiOchXckqkkwLrwESvFyVZ4c5KkfT14SN7wkqnqekVFiqIohs/Sy4TwCfRyYc/XrN2hW+OyLRVCWt3vBaxDwEKHtguu37mYN67SWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SH/9E9GWTUBKGS8MomMIuXtApQI+S2WQ8HKoIZHTcVQ=;
 b=v5s8ywJqDQVBikftls2NdW5I0kHTY8I5pY/XxrVGFSfLHuUW1iKE2mg9Nwk/ltjiPZz9UCBwwnwc9zibCZI+1d++xMjw7r/q7NUdPgIyKNHPZiZb9mV3a5bnzUlQ1GU4LvorQYn69yPEcSbBw6qx20tv4TWYWAbwoUPFvwsyN+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by DM4PR12MB6591.namprd12.prod.outlook.com (2603:10b6:8:8e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 22:02:24 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::3441:5a68:b4b7:e988]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::3441:5a68:b4b7:e988%6]) with mapi id 15.20.5654.026; Mon, 26 Sep 2022
 22:02:24 +0000
Message-ID: <d1cfa787-9f8e-fe8a-d816-0bd8c3a3244d@amd.com>
Date:   Mon, 26 Sep 2022 15:02:22 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [PATCH v9 6/6] drivers: remoteproc: Add Xilinx r5 remoteproc
 driver
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>, andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        michal.simek@xilinx.com, ben.levinsky@xilinx.com,
        tanmay.shah@xilinx.com, michal.simek@amd.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220708013955.2340449-1-tanmay.shah@amd.com>
 <20220708013955.2340449-7-tanmay.shah@amd.com> <20220901202517.GB626605@p14s>
From:   Tanmay Shah <tanmays@amd.com>
In-Reply-To: <20220901202517.GB626605@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0244.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::9) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|DM4PR12MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: ad101344-4192-430f-0172-08daa00acb3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jJaSC23EVYs+rIUB3UeHaZlbgPLgZ7UN0zp66Wz7w3PdeWtlPSp3ZqYH2ntRv/AJCXMLAAnRGbXc+XOsXudHOeK2+ecPscsb62Uuxy9AyjX1UdERWN5CSFDYpfNlr/AhN4M3esi9tzW7A9It6OFDEh0mlVd80OVYigRCZgMEvEuS+28R1X9nz/JkpbDO8uQ0nPfxrTlly6abp4Unf/kt+wjUI6j4wERcww5k+AxpyEpP3AbyZCe+vBYgvL8uxuwP6dra/k5hUCZwF6xhpjY03YazTMqFxc7n3HQigcD12ldQFWg62MoE0ltQJZVakV0EmN3f/HNSREfu8dE75RmPAY/LkiawtKYKoDmA8dyj9wsP8T9i0nJiVahPQI7P7a9ZaL7iqpMPQwlL9ZJPKwxqTHv9scHywur2PRrgS7NwQSmM6XV/km1kJdnx5jUPmMdnBIg24KXtxyWPDgvpOABtiVWZHxpnHX+bSRHQOApok5Cz/dTp954CdwIUIwZGsFviruBjC/f9zqDmunJceyo8wVmcjHMU3O3DoQSnC6c45OSX/yC6cvaEbTxSJ1EgPiuYeKh5l8fcw6csSclZQPCc6jm/zh6FSJ6mgX05uX+VD5/L8zyuA63haz7FyqlK4ECNsI9aS4Ro5jJHVsuis/jjelwZb78t9xQNQXOi8yZWtKlgO/zKxtUFe7EFxMJtGolJCqNlTSN7eHJvner0QEw+YI2CZrKsnU07L3NsNxIcWBLKeYUsc5ZM+2mVC5ixykKK+V07gDhvkc8339L5iHZq67Obk2W2aeQJSoSf4YbEbU4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199015)(31686004)(6486002)(316002)(478600001)(8936002)(53546011)(41300700001)(6506007)(5660300002)(36756003)(66556008)(66946007)(66476007)(8676002)(4326008)(2906002)(186003)(6512007)(26005)(2616005)(83380400001)(31696002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGRhNVN3RDFoTWhlTzgxWGdrS21vZkllWnZTV00xTDhydE9GZ0c2OGFGSEF5?=
 =?utf-8?B?V2pzSnZzQWl6NVMza0Jtc1IwWGViN08vMGZlc2EwNTN4bkZURWwwNGZsWnhS?=
 =?utf-8?B?SWhOUXVRbnk0Q1NPZ005aTIvQ3ZFcHhRekpmVFJ1NFF1NC9IWUQzRlFwWXJr?=
 =?utf-8?B?RWk4blEwaFRVdEpUTEwyQXZ4b3VzUGF6TjZSU0c1Y2RDUERocU9mRUpKaGRK?=
 =?utf-8?B?bzAyL3d3WnRjUVRpb1doVkQxOG1RbEZVV1AwN0Z2d1I3RzNHeFZ3bnlFN3c5?=
 =?utf-8?B?Q1RWeC9SYkhPUllMYXdCcWpCaGNReXY1ZXlJQWlDL1ozakFZSU4zR3hXOFBP?=
 =?utf-8?B?MWFra05MZkxkS1hmbFErQlN3cmliNjAzc3JJVGdSQmtvcTQvaHdMVlVUSmpz?=
 =?utf-8?B?d0NoRStmR3ZURTBmVUlSYnY2M3Z3NHJoeUVBckxpZzhQdFkwMXVWa2ZFQ0lY?=
 =?utf-8?B?ek1VcUZ4TUU0ZURIRnVJZjBDekYyRFdmTUxTclpORGlld1ExOEdxSm1NWEtL?=
 =?utf-8?B?N2tsY293WFFxSVJxd0t3ZU1VemNDODlBVFhRb0JIZ2lBeTNhWFJ3ZTRyVmx5?=
 =?utf-8?B?VXFkOHNsWk5QTXlnallDMCtRNEdiemdYZ1NSY09sSWpVVWduWFRiRVc1a01q?=
 =?utf-8?B?MmVqa09hRG9hWmtRb0ZjcXIvakM2TVF1MXlNRkJjN3VvazVRTG1JZmpWeW5z?=
 =?utf-8?B?SnJnMnRhK0xBUnpOZzFrdm1rU3REMG1YcmV0VFE0ajJ3eHlDRWduaDVSaEM0?=
 =?utf-8?B?enZhRGZuSldNUjBXQzlPOFUrT1pYSmRuejd5TmJHelVWRlkremlqUzVEOE8x?=
 =?utf-8?B?RzN2c2tTVnY2YkNRMzN2RTF5QkFHYnZDN2hTYm9WMUlhOCtXb2dhUmxlV2Zr?=
 =?utf-8?B?cnVHK0tLaEViVWpwQUV3NHE1RWVNc1ptbVd2L2NBbUVnSzlNdGZ4T0FTZUJ3?=
 =?utf-8?B?a3M3YjlqeUZWb05lM1pOa3hLUEFJcU1PbmV3empSb2sxRXZxU2N5SEUwYktE?=
 =?utf-8?B?QkV4Zi9vRE9XSGlsV01JcmVZYXBBYlZ1S21zRFdpZFRyZXdSZE5KbkJUL0sy?=
 =?utf-8?B?R2FRcThxekw5MWV6MXg5ZkdhYWVRUnlZVS9TR2V2UWpoYTM5WFVBTzJaN3Yx?=
 =?utf-8?B?T29rcDJGTGt2R1FXYmgzVGg0WVh2elVvZVFHWk5EdVkrWkN3bng0OUVuaTRY?=
 =?utf-8?B?a3lNbW5zSzVxRGxadmczTUZKd1FhYVBXVmVSalNuWGVmOGlXTFB4U1AzVzhN?=
 =?utf-8?B?dWRvRjNRVzJBYnE5YzE1K29FTUVjZk1jVmMrNXUwdmo2RUxhVWJiaWVyZHow?=
 =?utf-8?B?NERzclNxRVdYbWdZR1EwdDU4RmdtTXdUc1dZSUNERnFrTkJhWk9LUjhNdGZz?=
 =?utf-8?B?bWJ3SC9wN21iWG5wYWFrb3lZdWtQMmV1MWZ6ZlA1dkJIeURCUmRxSDN3eGE3?=
 =?utf-8?B?cEYyTWxlWXJLS05KNGhyYlJRREp6Umt1dks0SjhFMzRUYzMxRWY1a0k3TjAy?=
 =?utf-8?B?MWhnQ29JdmM3a05lS0dsWDdQQno4RHA5czJraGtCaDhGTEhGQm92amYva0Nj?=
 =?utf-8?B?c080cC9rSCtZc3hIcHpQZ2dWYjhGcEYwQmt2aGVJL2dZSjR4OTErcmFBRWhJ?=
 =?utf-8?B?MkZLNC9PMWV4a2FScGF1ck1MS1FUVWpYSm1MNlpkMEJIeHlvMHZuZk9ZTm44?=
 =?utf-8?B?YVdVa0lENjFieCtkT1UwQnJ6dnVVWHNWL2ZTMG9XTjRydUFwaGs4aWR0SUNQ?=
 =?utf-8?B?b3NpVVZORFp6a00yQk1RY1R6c1A4QllKWjlNR2tvTEcvbjl6S0Exd1ZtRTVF?=
 =?utf-8?B?YXp5ZU0yMGQwaTRPck45UEVlcjI0OUI4SUtxbUhEcURDc3ZVZFp5eGpDTlMv?=
 =?utf-8?B?WUpWUTl2bTQrKzk0YlI0Q3BLVW1LVzVHZks2ekVrUXlNVWJsaWhUc0J5a3lI?=
 =?utf-8?B?ZnBkSFI2WDFHR0R2NGRiSWxsV3AxUVk5VHNuMUpMS2lmOTlJTG5DOExpUXUv?=
 =?utf-8?B?NGhNK1VaNndsRGNvcnFLaUoxaFNXdW95SkF1WHI4dysxVGZDR01ZbndXTytR?=
 =?utf-8?B?UXRPQmNiSlJrMDJOUzBGbzVwZGNpTDRjeWdySi91WUpYQmd1QlpiZERQMzFB?=
 =?utf-8?Q?W5kOtagqTNQpa49nTCTGhus1i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad101344-4192-430f-0172-08daa00acb3e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 22:02:24.7864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/ZHKBM7otmlOGUUtOxfzn3YQJddLD7WIZVBxZAGZ5DgXYx4K2Q71XGMgyuZWIA/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6591
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/1/22 1:25 PM, Mathieu Poirier wrote:
> On Thu, Jul 07, 2022 at 06:39:55PM -0700, Tanmay Shah wrote:
[ ... ]
>> --- /dev/null
>> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
>> @@ -0,0 +1,1055 @@
>> +// SPDX-License-Identifier: GPL-2.0

Hi Mathieu,

I tried to fix SPDX-License-Identifier to GPL (same as MODULE_LICENSE 
below), However checkpatch.pl reports this as following warning:

"WARNING: 'SPDX-License-Identifier: GPL' is not supported in LICENSES/..."

I see that GPL-1.0 is under LICENSE/deprecated directory.

>> +/*
>> + * ZynqMP R5 Remote Processor driver
>> + *
>> + */
>> +
>> +#include <dt-bindings/power/xlnx-zynqmp-power.h>

[ ... ]

>> +MODULE_DEVICE_TABLE(of, zynqmp_r5_remoteproc_match);
>> +
>> +static struct platform_driver zynqmp_r5_remoteproc_driver = {
>> +	.probe = zynqmp_r5_remoteproc_probe,
>> +	.driver = {
>> +		.name = "zynqmp_r5_remoteproc",
>> +		.of_match_table = zynqmp_r5_remoteproc_match,
>> +	},
>> +};
>> +module_platform_driver(zynqmp_r5_remoteproc_driver);
>> +
>> +MODULE_DESCRIPTION("Xilinx R5F remote processor driver");
>> +MODULE_AUTHOR("Xilinx Inc.");
>> +MODULE_LICENSE("GPL");
> There is a discrepency between the GPL-2.0 in the SPDS identifier and the above.

Also, changing to MODULE_LICENSE("GPL v2") gives following warning:

WARNING: Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db ("module: 
Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
#1115: FILE: drivers/remoteproc/xlnx_r5_remoteproc.c:1034:
+MODULE_LICENSE("GPL v2");

So, It looks like SPDX-License-Identifier should be GPL-2.0-only and 
MODULE_LICENSE should be change to "GPL".

It this ok? Any other suggestions ?

Thanks,

Tanmay

>
> More comments tomorrow or Tuesday.
>
> Thanks,
> Mathieu
>
>> -- 
>> 2.25.1
>>
