Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E960E617823
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiKCH5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiKCH4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:56:18 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2052.outbound.protection.outlook.com [40.107.212.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452E463F9
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 00:55:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUIM+FlOBq+JKMkUelMhpSNCADNA3cClsoTfHJ2P0YXhYaxs93imH96L01KRTwOddWiNxtpDLoqxhakHD/nCIqTyoe8VDfuOlRlxU9907FpXRY5VDFhpHRSSvr2Nf+bHzLaf8FcUa+su9DV7SB3+/Q1uaAkbpLpAqAz8h7yEkTOOfqp5EJ7Yc1I4b45St8MQGQlY8rkL545DS3NSs7nbxEXPefno6C/4jU+DHp8kjxcBcL8RIqk8a4Udgb0B+lReivisudSaQnfWEHCXTFWJG87IPOKlEPDoawIr77x9FjLbU8oJi6jGgbowBsOneV4zpg771i8sXS35/AvWfFhDug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abTTVLojRQNSolYRC3yQKQkksAlVBy9n5AAT/LTrYmo=;
 b=TKA2oJhQUpoG7ojJQvZuW64XALhm/R5z+YmFSsT1tHpiIT9dy7F8jJlY85mali1pXqNKATIj0WRKr4ldrlTPfMN9JYxdBBza6YB8pldhmNPfMLPm4Bhn/385Vzz/cGG8GTdlGcj3zFhIz0Bl7hK+70MBeefIE2/+HreUY6Ui0YdfL2KyqSkaOtElh5v+0rHS46+7FojuCgnYOG5NpIo3hM0HBAfFrtui4wRd+hLmMMGbsosS1vWq+crAEd+OYbNDGJCR/C5gWw+noKP2PVLDLUSxj4N2SvBkU+Dt+wDxpQPQmpnD7YEqfdWxU0jOncV7Bu5tmjSUHqfqM1BApuHNHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abTTVLojRQNSolYRC3yQKQkksAlVBy9n5AAT/LTrYmo=;
 b=1nKH1cinu2UYt9Z21i0dG4/mRG3SXzZw5OTN1V/URoA8958KmWHfAyFwaNU11pfYD2wUPp0/XglXv3dJ6Qa2U/IDdhCefgOWmHwvfrqNh1DBQ2gfehWQPrlUb4oTf1kYvA5Ky+qTWVy5QJ9pnRJhqtI7iBRJ7K3sHl94z6kPU8Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by CH0PR12MB5235.namprd12.prod.outlook.com
 (2603:10b6:610:d2::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 07:55:47 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::a035:7550:7327:3d10]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::a035:7550:7327:3d10%3]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 07:55:46 +0000
Message-ID: <0cbbe205-4573-2dce-14bf-f07c117ac7af@amd.com>
Date:   Thu, 3 Nov 2022 08:55:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] mm/memremap.c: map FS_DAX device memory as decrypted
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com
References: <20221102160728.3184016-1-pankaj.gupta@amd.com>
 <20221102130536.96c487d341544b7482eed038@linux-foundation.org>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20221102130536.96c487d341544b7482eed038@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::20) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0181:EE_|CH0PR12MB5235:EE_
X-MS-Office365-Filtering-Correlation-Id: b74be5dd-2164-47a1-c72d-08dabd70d0d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wYmelXDxVLATMtNpgCuPNwntYMySBLtg4xZEnw5gL4QI8pj05CrfkYshw8c65bRkyvnVxOd4Oz+vVrGilPIe7P+rMJPvpDnxchJzai2IJkfDEZKasg6JagwTOIG+4S6sSJDPErOq6Di9CT4NJKxjq5QFJsd1E3ErVq6xVDZRsZl5HBu9rFN7yngOwFyPOokmTLdgufmVlvBgnc4746W5Cncekpkxhyz5Z97t+XDoJyK7rrhB2KrajSjzr4aXgBq05uGRJiVB1/DySXQXdI3DRBqHX19Vrp2ogkG0BMJVs2PWrLj74QKew6x9j9A7xIe8Ecv5mOZb8X4RLTtDGokBc9IEVHnd/8wePyQDt5VxkmgHMzidZnNcOw8JYgaeXkUApBd0vtY6NEUROwEIJDabLs1NH1EQSrI3YYz6GdlV/JfTyWyCrRrACxQmFfDqLfgZ0gLlVEtymm/rJ4qY9vM6Wv3OfaR+y6qrb3sJT/D6HavkkX+tqBItvJoN1FT2iIDR6HBMaxHz88C35LNmqrDL/qE3jOa/cUuZcFnnPVzVnAqhmdBBO8Sh8UoHVM0s8EkSBK96Dka1Wuy59qXSdsR/CR3eDeqI9uIRUloAF5I6X1cInHJZnzuTKghOhnqeOZWZmFPPRBK4rTzRRCOFcVv4p7U3cRUM/YxQ0VRdOwQ/xaoSXurjwn2G+bZzqKugL0WPKcwF1hxqduReDNVv32GurPsegjQz6SvvRN9qpsFOFqV7f9u5SGoFeGuoLGBZtGS++1q205p+xq73WJRZew8uqR6K+igbgW+YdiQW2eEsp1w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(451199015)(86362001)(31696002)(36756003)(38100700002)(31686004)(316002)(8676002)(6666004)(66556008)(2616005)(6506007)(478600001)(66946007)(6916009)(6486002)(66476007)(8936002)(2906002)(5660300002)(186003)(4326008)(41300700001)(6512007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWs4VGlWN25IN0hiTDJIaFJmTFNYRWwrY1Q1blVmVks2UGhTanZKTVJaRzVW?=
 =?utf-8?B?akFxMEtzSnMwSklmOGdLaVdkWlh3aUFIcmhlcVFYTEYxSkhkZjNFTTFOMi9z?=
 =?utf-8?B?bTZwWGtWUXF0dU1oWml5dnJCNUE3YVZBeEcwRU5DbGs4OHBNRmd3K1FGekxW?=
 =?utf-8?B?a2F1aEZOc0k0VVRNUzc2aUhWWHZCcmRNYy95VklHVlFTVlZSUmRaUGxxV0tM?=
 =?utf-8?B?aDJnWjFJOWUxUXE3VnlqbHVyMTV6dzRodnVBWUpBNFNCeW5kektjTTZpZC84?=
 =?utf-8?B?SEhRN1FiRkQ4NXZwQ0dhdTFidFIzVGhNdjJCVFdmeHVXZ2NDK1ljbURvdkZh?=
 =?utf-8?B?YWl2ZjJUQXloQndnVVZqVXRXRGVQTEdoNDdiQ00vcHp6R1d3WlJpUHd5b0Zy?=
 =?utf-8?B?WXlvc29pQkpNUzR1ZHhrR1pkOTRGRExreXZrV2RZb1BIMlQ4L1Q2Rzlyb2I4?=
 =?utf-8?B?ODhmRDRpY1BtSUo2TTE3bnUrVG5VRTRtM0pLSk5VU0Q0VklGbDBjZy82Q0Nn?=
 =?utf-8?B?MXRaOXZ0bFlrWDFwTmJheE54TlN6dURONUR2SEpDM2M5NGo1TjlYNHo2Snh3?=
 =?utf-8?B?RFZhaXM3N0xNVnpvVmY1ZFlJTVVGYmNRcGYzWFkwSmtDVXBCQ3hER05NbVph?=
 =?utf-8?B?SUFoZWZMcFh3N3Y1L1ZQRldISkZ1NXpTcm40dFFsUnVqVThuV0wyclRFNzJ1?=
 =?utf-8?B?NWROa0Q5VUlWSlVLMFc0QnVzaW9VdjJMVXRLWWxQSUpiOWQ2czY2VXZZbzZF?=
 =?utf-8?B?cThpbnVMZk4zbVlHSzJ6bGVXbWJOSVozRkRWWVZpa1FEdEVKajNrOVdqZElu?=
 =?utf-8?B?dmJReGlHZ2FOeTZ2dkw0QlFwV2V4SXVRclpwQW90cyt0OGJPSzFtUUNIVTgy?=
 =?utf-8?B?ODk5akpRRzBlTU0yNVQxNkQvcVFWcE5jandicXNSU0llT1JqK3hJUllJTnpX?=
 =?utf-8?B?ZWhYend0emRVeE5qQTNpNUxCSFNiTi93Zm5mNGh2bDEwaVJCcTdnVlRwVmJR?=
 =?utf-8?B?RXB0S210NEdicmVQay8wMytRZ2FwRVR5RjIyV3dWYU90NnQzSHduRDZEek9D?=
 =?utf-8?B?LzFTSUlndFRTTHZzUkllZFduNmhGdGNvSk1lR1crTk5WaVJHNnBXSFFDYVJC?=
 =?utf-8?B?eVdEbHdqZ0JpR2llZ085WUdXQ2RJU3A4bG5ndVZIWVBEWU5PcXJGaXlOQ0Vv?=
 =?utf-8?B?d0d6TDJtSFpNUXlqakpsL0YyZi9lNFZXaTBneElJN0RQUlI3RmdRb2I2Tnln?=
 =?utf-8?B?cURvQkVBYWlzMytwRU8veU01VjRpTWpCWjRvdlU5T0JJLzZmN2dPQ1VKaW5z?=
 =?utf-8?B?MXpoNW1JSEptaFZPbTNPME9yb0t1bjd2czU1Q0FMa3R3SlRhaVRSSWZrQ0Na?=
 =?utf-8?B?L1hYMVRybzd1RTNCeWxDSDhaVWJFaG15VXYybVhMQmowOHNMRTBnOS9QcS9Y?=
 =?utf-8?B?cTNuendibnpNQU5xYVRuY0I5M2lvUTdXbVVxWnA4TUxRQ3BQQzhReEozZ1FU?=
 =?utf-8?B?ZGpCVzZEY0VobWY2TWdEbkdlSVZuMXlHd1hTRzNlanloSnZCR25IcENIandv?=
 =?utf-8?B?QXFqeTc0TUFMN3dlOFJVSFNNTDhFWjkxRTNRU1RxSVZyWGdoVmtjNVlydnAv?=
 =?utf-8?B?djJvdXl2UmJCRjl2cTZ3TDNTUjFPMnRJWjc2R25kMnlKa0dPRTVXN3hKM1VQ?=
 =?utf-8?B?L3c4cWxzZnh5RnpjVFVyazVzcXVaVjVuUUFtN2t0YzlUMUJsTXVLaEY5a0U4?=
 =?utf-8?B?QUYzNXZWRWFxcjdUMm4wY1BpelJuYzhVTDl0TzhUVFVPRFFkTVRmRzdpWFpF?=
 =?utf-8?B?Z2dVUWlSOXJ6YlpYYWlBT0hvbGduSmxXWDZHeVpaT29iemZsNmVmNktqYklS?=
 =?utf-8?B?dnNjUlo0Yi9CQWNjdWJqZm9kbE5qYkk0bENVWjNMVnptSFMrZzhKelVkbUZa?=
 =?utf-8?B?eDBra3c4Y2JZZXFmR3pyYU9RVEgzNExBbG5ZRGRCaFNqTFhxSzVnQndtMlI5?=
 =?utf-8?B?UlJhZW9JWXRVbG9yRWFnZDl0WXoxRUJ3U1BEdWx4S3lZUU5WNzNJTllOSi90?=
 =?utf-8?B?SGxuN2cxQXpKd3pQUlh2Wk0zYWhnYVhWdklsS1o4VERCb0tsRkdPTzQ4aDds?=
 =?utf-8?Q?qLwifmsqxYfM1eIOHb/LclvQI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b74be5dd-2164-47a1-c72d-08dabd70d0d9
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 07:55:46.6766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxrPKjiIYbDs669AT9jwkMeeanYiwfffRWc48lAsDpD6Bo4JJBfzNCpo627hwoCGJHuu91tYsR40cb0FpMg78A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5235
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

>> virtio_pmem use devm_memremap_pages() to map the device memory.
>> By default this memory is mapped as encrypted with SEV. Guest
>> reboot changes the current encryption key and guest no longer
>> properly decrypts the FSDAX device meta data.
>>
>> Mark the corresponding device memory region for FSDAX devices
>> (mapped with memremap_pages) as decrypted to retain the persistent
>> memory property.
>>
>> ...
>>
>> --- a/mm/memremap.c
>> +++ b/mm/memremap.c
>> @@ -335,6 +335,7 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
>>   			WARN(1, "File system DAX not supported\n");
>>   			return ERR_PTR(-EINVAL);
>>   		}
>> +		params.pgprot = pgprot_decrypted(params.pgprot);
>>   		break;
>>   	case MEMORY_DEVICE_GENERIC:
>>   		break;
> 
> Should this be backported into earlier kernels?

Yes, kernel >= 5.10 for clean back-port as it contains the below commit.

> 
> Is b7b3c01b19159 a suitable Fixes: target?

Not very sure. But seems like the right commit for fixes tag as the 
target code is moved in this commit with multiple range support addition.

Should I send a v2 with fixes & stable kernel fixes tag?

Thanks,
Pankaj

