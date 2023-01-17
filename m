Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09832670B43
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjAQWI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjAQWHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:07:02 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECFA2716
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:15:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hx0Bx8atyrccTZZIU6Cs6jlWAhcENs1YxcGZ/cKkj9Wq/OJLj9ygX9ORIked9zJd08Rzbfg7HRYnweEo8RrI/ECUgNHJUYPzvKxBhmqab9xKLfZVx0mJol7vv7JSEdAu6QgEOKjUwbd44dCEHMK93w8PgfoUQexD20bw6mMb7bZWBPLR6Nh4fg7AQOVr9LCN3J0J0t8/tGpTUjR2o8OfEc6MRmMeqfBQej7AABvNbBn02vjggnIsFwd28cORBFCwsP8DJlk4LybTyzqKNSpoMcXHDEHQIlnQhC+EN2y4y/R2UXNQnH4KfD0x1xAcMytONY1b3BS/9LrCkddg2UYpfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cv9HkbC+tYi/oS9VBD89knJUvIJpzP1NuE+G3OAjVgQ=;
 b=US5DaQtX3nQV53AKORFxV52NJndEYFY53sIoyhw9jHJ2smPH4+WT3DMw5R0+ULlS+ZNGq1s4YlF0l8mA0oAZ10MkM0qChAl6YkBPa+TUMAUG8z/2JBoF2GJ/fFhHxCnxc11+tuSfrUtLE+nulQeMyx2O6et6BI04rv8v/FdCRHtEStgC31rkk/cY6RFDHWjqMLpH28TtOkCSmGAed0hh4MDsz39fRLIbM9v1XnwHPXs5XyEPYMdwD+cmVDv1cfk+K+EP52uJOopDyVcCpPcjSuT4rxfUe6e1MoqaW3taqqGj9zr5wYPsIZjet8Su83WhiziSZL3DvLjIcSBSXpyI+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cv9HkbC+tYi/oS9VBD89knJUvIJpzP1NuE+G3OAjVgQ=;
 b=WxC9xo+5malpi+5XuCTAV6sUHqMk081ZQ1sRxtzqmPCCrO26K4LicMp5Vzq/7vCIsB+iCSD+Goh+JWnzbH5HA9dcuV+SE4/+8XhqvDCIltJ6BCOOZpSUqVV8g8ZjL/KcV/ALOLV8DeU391BM8c5IMCUQO6iptV49YMC4n8BfctA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by SA0PR12MB4496.namprd12.prod.outlook.com (2603:10b6:806:9b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 20:14:59 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::3ddf:d47:b37a:5a7a]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::3ddf:d47:b37a:5a7a%3]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 20:14:59 +0000
Message-ID: <976dc694-5828-9975-8e87-ac0a850f75d0@amd.com>
Date:   Tue, 17 Jan 2023 12:14:56 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0)
 Gecko/20100101 Thunderbird/109.0
Subject: Re: [PATCH] firmware: zynqmp: fix declarations for gcc-13
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     soc@kernel.org, Tanmay Shah <tanmay.shah@xilinx.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Ben Levinsky <ben.levinsky@amd.com>,
        Ronak Jain <ronak.jain@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230117164133.1245749-1-arnd@kernel.org>
 <d6166b85-01df-405b-3112-d9bde16b6bd9@amd.com>
 <eec4d2fd-f305-452a-a47f-83203da494df@app.fastmail.com>
From:   Tanmay Shah <tanmays@amd.com>
In-Reply-To: <eec4d2fd-f305-452a-a47f-83203da494df@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::29) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|SA0PR12MB4496:EE_
X-MS-Office365-Filtering-Correlation-Id: 37da5199-ffed-45ef-f586-08daf8c781ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4X6NcNfHOuUqKcTvvp37a3KDbgQ+Td+WNGTmS3hsgGRJX2maLcCmPR0b30v6nsqpnqCNnff+JDOlDr1ANNcbmXSCEfMbF9sdymiyzMeLx2TuUUfZ6cE+pK+1+todvWh7j/KY09l2CU4CJVEl2osDs+UMKdTFGEXDHKjkR49LF7IE69U58/2+AKGazUeP2zEhhlNRAOfUmjuzpUCLwno2tUXDnZEs/DE7MgLyzZZSxt6XE2nvZ7yOa4Vvub5/2tJUyLS7WzyE4KiNXlj3mQx1MI9673lIGkHgrJNwo4w1n0sIrdLdg54UsSf8qQs771EQoYqU2zezpJnjxUK3gGvbI4acFbJxzP8rMW5B1tv0CVoAkip4ZV3JOpZ2LUmi2I0KVLVjje6mokfI3uUupdinyhuY9bUR1+dHa/ikTEDcNCdn4wJaihuMaLfr1u+yNujT+26FgL1bMKkPbQaKoX9rgrWN+li073JDODRcNcny/M56yrU2P/cJMD4ETnZ7prvBTgnbLAR/pyBB/7MzzEMREKVezb4pfe1WVwHZVmyiMPKL+5on14aBCunJef3pIJ33SZwLvrh/X8O+qKR4PZGIlPzUsU7XwPRyEjJySKZ8eXi7j+h6LApMC8d3IYZCKG4AswkkYC0LjjgIe0G9Rl/vPR033RFIJEYhAPmwlb5rnzoUlMM+Fo9qZD9ofBMTKiXbjIWBFnwfB73QHoinldNxxBA5wIO9rdTHnva6mse9CZI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199015)(31686004)(31696002)(5660300002)(4744005)(41300700001)(8936002)(6486002)(36756003)(38100700002)(110136005)(54906003)(478600001)(66476007)(6512007)(6506007)(6666004)(186003)(8676002)(53546011)(2616005)(4326008)(66556008)(316002)(66946007)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkdtS1VaZHVMVFU0bVBWTklqOVZ0RHJRTFg4KzlGYTh1Q3R1RUMyOGkvby9G?=
 =?utf-8?B?am1ZRjk1VUl6ZUx0N1RUdDhKRHduNlhFUWNEN0ZCT0ZZcGs3SDl2cC9remd1?=
 =?utf-8?B?N0hLOWxlZy83Y20rODdLVld2VUFzaTJMNEpENzNxMzZxQ3MzdjhIU1FhMTJO?=
 =?utf-8?B?K3gvTXllaU0wdzJsd0xUaEVoRWF6bE1nNlZ3ek85cS9CMDZPR3R2Z2tRczNK?=
 =?utf-8?B?Q1lJVkNCa3V0QVFKOEtxdXFWc1BMbUpGV2NsZER1MGpOaEtOemdaV2tPbDd3?=
 =?utf-8?B?Z2hDUTZCb3VPNGdEa2NPR0pZaXZYYS9tNkdTMEdKMlBUNDZQSVhuUkMrV29J?=
 =?utf-8?B?Ulh1R1ZVMGM2MG45YlFNWlpQQko5L2hmY2JWdXlqbHpQVnJBZWErMXh2YWdT?=
 =?utf-8?B?MzJFWTI3VlJmRXZSNDE3K0JwaVYwYlUraENFanMxWThKeEw4dFlWZmpvY1hy?=
 =?utf-8?B?Ry8vYnBqSnNyUk5vcHQrcFpzRmxjaFVLZlZoMWg4aU5rVHl0bUs5a3Z5K1E0?=
 =?utf-8?B?dVphYzFGaWxwb3lFSXNJdnpnc1p6cWJtdmtxMFErSUhKcWNHNTVEOGZLaUpt?=
 =?utf-8?B?REtFZ1lSVnpBV05GZFZaK0k1R3pxNUFZdWpObEo2OEljcEp6cEh4TERTNy8v?=
 =?utf-8?B?bVVsZDljOThJanNxcEQrcUszaWcrRFRGallHUlZiU2xoRlY0eHhmOUxnSmJh?=
 =?utf-8?B?d21JNGxqNmJHczV6Q1lSaWZnODdBb3hvZ3RrR1U1YjljR1ZoYXVEYUlCN2p3?=
 =?utf-8?B?RnBLVHBjOUxRcmpnYUVTRm5VampPbS9xNEFLZFhJNmYxbnNsODdwRjlEdmpq?=
 =?utf-8?B?MUdEbzhpVzhWemcrODVnZGVIUUFXSXppWnlDSTBDZU45aFFyVDBQQ1EvTVox?=
 =?utf-8?B?ZHN3VnZ3VkNUSnBBQTBFaHNIM1JBTU04SnMyaDViV29DUmFPc0xISyt4alBR?=
 =?utf-8?B?Wmp1WEd4ak1YbzZoSW1qSERmVGRPWmgzbHBMdzNMQVFzcVUxa1lIUXEwb2Za?=
 =?utf-8?B?S1ZpbTZXb1JZSVVNZ2N3RG9NTDFUdXZpWHJEa3lXMStBaFRtWWpSZzJIMFdj?=
 =?utf-8?B?RkFkMVdPK2R6cWxrUkdVc1p5NkZzc05GRStFRG12Rm9YMnN6VTBpcUNld2xF?=
 =?utf-8?B?aW4xZmtmTFI1WVRhRVp3TlB4UXZPeHllUjJDMkNweFpXTXRjSDVLMGxyTEtK?=
 =?utf-8?B?SUVwZE1VYXQ5TkkwSHhWeUFxRm84cVcxSzRBMzQzVkpjT2d0NVh0UEpUL05u?=
 =?utf-8?B?dTJISUJ0NVlOWEtkYXZWRHhmMFRPbitCVDdQdE5UZkYxbk45elc5KzhCSUNl?=
 =?utf-8?B?dW1YWVZ4V2JpdFBBeFVzN1lBY3lSR2xCM3o4OW5lK1c2WlZqL1NhT1dXcG1F?=
 =?utf-8?B?ZmUxRDVnbFZETTNzYW90eFRJZk9xcU1EdEFqWTNSQk04U2tOdis2MVJVNzdL?=
 =?utf-8?B?cjQ3UnVtc3RCcHhHMHVIUGlEcDNEcmJoY0RNQkFIM2xtSllqbytUYTRNWVVX?=
 =?utf-8?B?N0p2OTU3SUJPbk5vSk9TUUZpNE4xZ29ybldOU3owbGZYc3pQU0JOd3VVQ3BD?=
 =?utf-8?B?TmxPUVI5ME8xcTJNYzc2MGUxTlVpUnpIMWpWY3QwMXRZbWxDTDZVNXdwT1Bn?=
 =?utf-8?B?WWNib1BDcVlYb2wrMWxSdFdWL21CcUVJRzEwcVRHTndsYkVTcWNnMGJsOWVp?=
 =?utf-8?B?bklmeWdzbVZiZ21UNHBURzRyNit5TkVEU2ZxK2FOYkMvdCtrSWNhbGxpREQr?=
 =?utf-8?B?K0hDNDBUOFVaNWxVUkY4dy95N2VoWWxqUVhkWjdvNVJBQ2lLWHBaVTZjUUYx?=
 =?utf-8?B?RXc3NHdDcVVTajFhbHVWSVN5TE5RTWUrS3lmUWgvK21LR3ZFb0FndlJyMWU4?=
 =?utf-8?B?bi9yRnZ5dlFJMzNldVRUaitvOHpNT2F4SWhVYWdWK3ZpOUFMV1MyQXRDRUh5?=
 =?utf-8?B?ejFON29sYWJZcUlsZjBaTXZxb3ZNWkdCS0EvRitvbFpDV0l3dVhHMnR1cjU1?=
 =?utf-8?B?ZHdYdjkwWVgxYWFQd2VsVXJRNzJnZEdnUVQyQ2EvWkx1TVV4SDNNaVJjdXRo?=
 =?utf-8?B?UkM1OHlvYUNHbkNJbVFSZWFtRVNzcXZ4cEU0RU9mYXpYZWRybGtrTFA4N2h1?=
 =?utf-8?B?TGxtbitBNHNqMGFiSldpQ1lIVTltay9sWlROYXNvOW1GOXFpZVNrbDFoMHRi?=
 =?utf-8?Q?3DopqVkT3pX8gvTbRoawOyavT8zEvZ/FbWn4pGW9bIEv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37da5199-ffed-45ef-f586-08daf8c781ef
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 20:14:59.0076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkcCavnBCTRHV4y47eV1UAkTK4myxqFUdzKrXPYK+VjAROG9jFwO4IpYIqCkfOJg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4496
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/17/23 12:03 PM, Arnd Bergmann wrote:
> On Tue, Jan 17, 2023, at 20:53, Tanmay Shah wrote:
>> This looks good to me. Thanks for fixing this.
>>
>> Something must have gone wrong when I ran sparse check on this patch.
> I don't think any of our previous tooling caught this, only gcc-13
> changed some of the behavior around enums.
>
>> Just one question, does this patch need "fixes:" tag?
> Probably a good idea:
>
> Fixes: a5e56980cfb7 ("firmware: xilinx: Add RPU configuration APIs")
>
> I can apply this directly to the soc fixes branch if you like
> and add that line.
>
>       Arnd

I am ok with that.

Thanks,

Tanmay

