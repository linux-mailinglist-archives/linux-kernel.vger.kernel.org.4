Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9165FBE39
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 01:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiJKXSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 19:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJKXR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 19:17:58 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F0225D0;
        Tue, 11 Oct 2022 16:17:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPChHDLEadM/jqWLxSkiLHdJDEhjnBHIAFuHnf2Wi+9KNRZR42KUKPuLOO0xJLt15bFFojEGb+WblbWx9s1VexcuQgrzAmo9vSWDDV6To0XKUv88ByW+PUtJsDYnSYc2sypXDVMjGWOe+6TqX/YKcIi5ynAGEY6Q/8Z8qS6Gm2uMqppRBY16mCpSDKK0M+080Dmi6mJ9v/LZrEmjDqa2xAVIUZFJk7Il5ZnOWCIjJkyz/REYeZlL/ZB4CQTmGuQfsR4/vkAvcEktaUvhdgVBlPckUiIfqmb+CWVaqtQG6R8DyAkdP/mi5HZXH5A0qzKvDEtIStihhXFmzNgZm08RpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOcIWQIz4uoiY3JEzHyJAs8FJVmdg3ZTcgPUITVL/uU=;
 b=lSvzCB5chdXs37UPD6wvixIVawBpShOrwDnntXlbyRk9GdiKv6An8xW6RokhU0t2Y3fuUy8BI8G/PNDmYUIpdsLeeKkGU8EmiwOMJDBFooFHhMmvEY7yPT/uEB6LpHRjRoyNQZ71xIMjw1+e6jpo3qVyG/aHxrLekIKWs9EOeVkxDbe1H/lPBHSRfJxtE+JUCUkEEBD5h/XmtMqw+HAs3OvvJsf3E/60/7TgXBOU9Q0t6e5RFfdnb62yQSna+vq+uGoMaaqrZ4cKQ4pbC1pt6mHJEuw6mqQW4f+iEaMKXc4yocpwvk7YS22dGXJtqIKlUlo+NNoUe//bn4roGTtaAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOcIWQIz4uoiY3JEzHyJAs8FJVmdg3ZTcgPUITVL/uU=;
 b=hdqcfTR9QTwyve4rcNkQyZ+4GRqr3op8l/eAkuI9tk/Na+wXBLu3UfIepXZd+L+kZKLN7uAQDWa9mzh9AaID8x/66VrsEQmXNzLRA1IbXNipmC2Ea2vv9GEW7N7p4xRFjivZVADtXJipMJSPHxv7U+QNLVxSDhjoLo4G4z9hYuQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by CH2PR12MB4119.namprd12.prod.outlook.com (2603:10b6:610:aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Tue, 11 Oct
 2022 23:17:54 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::2af1:f102:b108:13a1]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::2af1:f102:b108:13a1%3]) with mapi id 15.20.5709.021; Tue, 11 Oct 2022
 23:17:54 +0000
Message-ID: <ccecf5d8-0981-6fe0-fdea-bab0cb1f3ce1@amd.com>
Date:   Tue, 11 Oct 2022 16:17:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] efi/cper, cxl: Decode CXL Error Log
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Robert Richter <rrichter@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Terry Bowman <terry.bowman@amd.com>
References: <20221007211714.71129-1-Smita.KoralahalliChannabasappa@amd.com>
 <20221007211714.71129-3-Smita.KoralahalliChannabasappa@amd.com>
 <20221010153415.00004bc0@huawei.com>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20221010153415.00004bc0@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::7) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|CH2PR12MB4119:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b6411a-eaad-4fa8-81c3-08daabded37d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: arEiMyMDE/SzA28G07187ySdCyePXlos48J5NaXGaeU+njX6tCXEOsWE9e5uv4y+cCyJ9cjXJm/VQa151XH0uhVC29dHTguSjHEWqKIYiQ4+UlctSh/Fo54oIZ02O75u70+DR2hLcysCZy6n0w92lehh1bQiC+mZ+viiTRMl5aQnAAIAjmckYuhpmo/jw1zk02dEmJGD/QxfsVnRJHxWUfpVfdwFU0D7LFPCG/3ygKFUnGE8iJUuJL40yFRLbhcMDsgZa6PkKABeM81vaJ98L6FPB3YVmvhvS0TaM0fGjswsQtG3NMS+dJZ02rCr8ZYoVONRV1gysin63jRtoV/+80yR63nc78RRp4w4GD04Gv4yXxM6lQP+U2V6i2ScpRqL9iILicdrXtXRLjU8ogFWMGyv6kwAjG+lZxzidKD+/di/3Wm1QHp71+caH/9EMGcD0fM6DFQSqpfNGkHOb314oJ8hZU/VMmYeleJq21RUCnJndXaGjAcEmNPZyI7WCe9x2A+DZ7bpUNGjyYzTlAQCHRpd0l1U2LjGM5JqAJsWlIA5EYGHLj1zib4hNITp65iypBIDCrLJMTTIHga8r7recOiGnLMvdW6M43fQ4j0F9pJDlZV8FFULMPUu6NHbqscuD8SFsdb1FrsprwzQNr5JQTzZxr4Z9/QZTBawCV7czZFgU2tCM6awUchiZYywMWHA2CNGPj50DTMxE25aCb05vRU8KLYrypQWqvw1y6UoY4bxf2Gg+J0xouAgZK5mhtMIW+vesC9aIV2WZdX+kj3J7TOxOWHnsLQ8yYGYd6sS5I4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199015)(36756003)(38100700002)(6916009)(316002)(54906003)(8676002)(6486002)(86362001)(2906002)(8936002)(5660300002)(66556008)(66476007)(4326008)(66946007)(41300700001)(6506007)(53546011)(478600001)(31696002)(2616005)(186003)(26005)(6512007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VE9DVEFNWFlmZG9jY04wNjBsMTNRSjlnY2diOGJNbytlZldsV1Bla3kzZlpi?=
 =?utf-8?B?YjNZamI2RjFQWmd0R1QrdWlyL1VGSFBZbEJMR1lyblgvN0s5MGl2cnN4TXlY?=
 =?utf-8?B?SHpMVHVaOE1EZVNaOVQ1TUlrckxzM1FMMVlpOVpzSFpZOVYxZitacmVPeGVN?=
 =?utf-8?B?TzBnOHdLL2p4aUNTVTcwcTRNZzdYVitSNUVZWTFObGU5bWMvdFRSQ3RNNFdX?=
 =?utf-8?B?cUxMYWVvakdsVkR1NnhvT3FnNDFYRGFVbWhIMTU2ZmJ3bnl2NUJDN3ZPMS94?=
 =?utf-8?B?MkwwUXZNa01EWVBwU3BMY0JsUlFBUTkxa0tLRExNU203aHgvR1JqVS8ra2M5?=
 =?utf-8?B?VnFTYUZGYWczb1FZK21PS2lja3N3Ti82QnN3ZnNmVVpIYS84eG53T0FwOVFP?=
 =?utf-8?B?K2pxcnczN056MzQ3SlpTbk1nVkdiTkdmL2dWTnJHK05hYVVuaWJjelFxR0ZT?=
 =?utf-8?B?WTBVMHhZZXBHUEpkT05rUlFnNjdOSG9nYXFyM1lXK2Y4UVR5Q2R0bDF1S3d1?=
 =?utf-8?B?R204YzNoeG45Sk5Qc0w3TldVSGxxM0x4eUFvSE80eDVIRFR6cTVQQThIZUkr?=
 =?utf-8?B?ZXdxTWJxUS84ZklWeFRHNlhFYzE0MGFZWjFPSWM0bkZPN2F1N3ZnWlhRTW5Z?=
 =?utf-8?B?WFZEa1orWHhYbHZQUXkwdDZsR3VKUFRzVDlvWWkwUFU3VlF6RUc3RzRuZDdP?=
 =?utf-8?B?RWtHb2hGU3ZlRi9laHVvbkhsVk94dS9vQk1PNURMZ0ZTUVhXNFVxVmFIVUFW?=
 =?utf-8?B?dmhrZHVqZHhIWEVzcTM2eXNNTXZWWnlBTXV6cjZ6a29kalBEd3pXSUNjMUNt?=
 =?utf-8?B?ZHh2UjF1dVpaUndmeFhsUFpvUTJTOVhrNkdId3hmV2plOEhaMjJDVGtPWXU4?=
 =?utf-8?B?Qm5XaGZTL0J1L3ZMemdzdTB5Sm41RmxsS2htV0JqRUZvaWRuaEZmYldMWXB4?=
 =?utf-8?B?Vk9ueDlOb1RxZ2lIUEFKZjB2eVg0S0xmZk9YQThCQkYzQVc3aXdkbGZheVRp?=
 =?utf-8?B?MGsrSVZBT2c3YjJLUGZTQ1VDMHJNNGxHeGQ2aVppU05ob1RuRVZFdVNNSncr?=
 =?utf-8?B?UmlJUDdlR2N1RUU5Mkk1dFUwVklpbkFzeEQwRS8zQmo3THJSaWthSFZseVE4?=
 =?utf-8?B?WXU5MHc0ZTM3VFpVSldaMUw1bDZ1T2xOLysxVDYweTM0TXdYT09pb28rb21I?=
 =?utf-8?B?TEh2UHM5UlUwOGR2ZGI0T2EzOGVXK0ZydS81R0IxREcrZ2ZISmtmTGNtam5w?=
 =?utf-8?B?OU9yVCtOVTB4OVh5a1RGbDQ5QkZoamxHblhnMGpkVW4xRGwwU3dnUTFBNnhr?=
 =?utf-8?B?azQvS1NSYjc5K1Z6OUdCeTdiaUdqTTZ6dTQrTllOdHRhUlgzVEVjeGw0WHUr?=
 =?utf-8?B?Y0pMTm1SYUdQOUJGU3BvdFhEcUVGTXQvOHhueEZOMzJWbDNXcHRDa2lZRWF4?=
 =?utf-8?B?bkhZSCtoN09Ib2d6ckFLZ0RhbzlIeEM0c0xmT0hpdVhFazNTaVZzUWxhalNE?=
 =?utf-8?B?eXlzSDA3elV6M0xmVVFEdUlXU0IzRnJKMGh4b0RJRDVsVVd0c3oxdVhFNDBa?=
 =?utf-8?B?enlObjdpRmpyZFBPZ1RVd2hVYVRiY3dIWTROTm9jczM0RG1lb2xTU3B2ZUJS?=
 =?utf-8?B?dlh0cWdtcDhOYVlOV1ZuQzJZRy9UTWplQWFPN3hSNEhERURVb2srbDE5Yita?=
 =?utf-8?B?VHE5dFJIVDJtQXZDYWc5Yzh3Mk5TQjNrYUF5V3JTTDhJM21EWjljN0lRMlB3?=
 =?utf-8?B?Z1BtMVN1U0h2QURDMVdoTzN6OEFmM0JqMWl3cFRML29qaGwybGtDdkt4R3dU?=
 =?utf-8?B?aTljR29LK05RK3puU0psRWhvajVUWmd3Z1Q3YzBUeWVaaFcvQ1pGc1dvbXQv?=
 =?utf-8?B?dlFjaVlrb0ZqSWt6aURHOG0xbGdOak5VTGFJWWhQVnVkbFF2emZTNGpOZmg5?=
 =?utf-8?B?a1RiUVFwUlVnSmdwWE5rbmhSckIxUUxkelpFN1pSTjZFQTJjQUp4SWFQUjkv?=
 =?utf-8?B?bTZ4RVByZ1p1YWJuaUt3ZkI4dm9JNnBnTG03akdGN0FldUR3MCtjVjJkUkQz?=
 =?utf-8?B?aS9meWxYR3o3Yy96WEFpblhpWEFqVDh3cVJVbVZ5U1lDbmZaNW9qSXdhZ0Ft?=
 =?utf-8?Q?FZxv1qQ7tvceCE2tSiowGcVje?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b6411a-eaad-4fa8-81c3-08daabded37d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 23:17:54.7216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ajj81sm8lMRt0GkK6D5sSuhJ7oOaRMhWQbE6t2W3OldRk+MkQm/MLBfvvt4qiSzvQeO4A0ujVFpAuDwF33RD7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4119
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2022 7:34 AM, Jonathan Cameron wrote:
> On Fri, 7 Oct 2022 21:17:14 +0000
> Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:
>
>
>> +
>> +	if (prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG) {
>> +		size_t size = sizeof(*prot_err) + prot_err->dvsec_len;
>> +		struct ras_capability_regs *cxl_ras;
>> +
>> +		pr_info("%s Error log length: 0x%04x\n", pfx, prot_err->err_len);
>> +
>> +		pr_info("%s CXL Error Log:\n", pfx);
>> +		cxl_ras = (struct ras_capability_regs *)((long)prot_err + size);
>> +		pr_info("%s cxl_ras_uncor_status: 0x%08x, cxl_ras_uncor_mask: 0x%08x\n",
>> +			pfx, cxl_ras->uncor_status, cxl_ras->uncor_mask);
> Is it worth splitting these up, so that we get a human readable line with the
> individual fields broken out?

Will do.

>
>> +		pr_info("%s cxl_ras_uncor_severity: 0x%08x\n", pfx,
>> +			cxl_ras->uncor_severity);
>> +		pr_info("%s cxl_ras_cor_status: 0x%08x, cxl_ras_cor_mask: 0x%08x\n",
>> +			pfx, cxl_ras->cor_status, cxl_ras->cor_mask);
> Not outputting the cap_control register?  Some of that might be useful.

Will add.

>
>> +		pr_info("%s Header Log Registers:\n", pfx);
>> +		print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, cxl_ras->header_log,
>> +			       sizeof(cxl_ras->header_log), 0);
>> +	}
>>   }
>> diff --git a/include/linux/cxl_err.h b/include/linux/cxl_err.h
>> new file mode 100644
>> index 000000000000..c89dbb6c286f
>> --- /dev/null
>> +++ b/include/linux/cxl_err.h
>> @@ -0,0 +1,21 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (C) 2022 Advanced Micro Devices, Inc.
>> + *
>> + * Author: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> + */
>> +
>> +#ifndef LINUX_CXL_ERR_H
>> +#define LINUX_CXL_ERR_H
>> +
>> +struct ras_capability_regs {
> CXL r3.0 Spec reference plus prefix it with cxl_

Okay.

>
> Agreed with your comment at the top. Some discussion needed on where to
> put this - or whether to delay figuring that out until a later stage.

Yes, more discussion needed here though!

Thanks,
Smita

>
>> +	u32 uncor_status;
>> +	u32 uncor_mask;
>> +	u32 uncor_severity;
>> +	u32 cor_status;
>> +	u32 cor_mask;
>> +	u32 cap_control;
>> +	u32 header_log[16];
>> +};
>> +
>> +#endif //__CXL_ERR_


