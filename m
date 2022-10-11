Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1435FBE31
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 01:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiJKXNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 19:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJKXNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 19:13:13 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615069E0D1;
        Tue, 11 Oct 2022 16:13:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gi6PLmevbfhxZt0fGEm1eaMFbj97aa1mUn27Uw+b5NQ9AskOeHbyH3A33Ne/M4m0CcD+umuuyaSaWtkWZ7dsspb9a8tHFW9XeD4Ic1OHlUeoX/OuTKV2XlkYh399rk+Ce7o46clbE+U9TuBFCbCOZZrHWr6IsCOhXzaPIDx/1LVintbrg9msCyNdcpqJzQB+7JCdjSd6wimuLwl2CFi4tbPmhegvwllifNNIHacm4TwBae8CQyiZAEmrDSdKHPRaLC5JMMd6dmNcqgS7dWl+0hrvJdd5Db4JkTRu0fL+VkC8P0qqgrKnwrkDOjbTTSrAlXVvpdWZE5OXHPc7l5BUgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nVmLiQsZDpOXZyAIm3HCfFrb+/zuGahySOFyqZWrVc=;
 b=QLO7TzJnUS8G3LfgjLfzcY8gvWAcRG6H4W41ItFfQhlsMeU8eHfobKfOsk7aDuGu6XH3iKI68FITkg/2NQfKHf3nUTONk626+/XU9CWQ3s38A8Rn6jkXXlPPlK0MCuFFrlSQ7+F938bWFjz5WWhVT6D+P50SGnOPOuz0xsyaFuj7aD9IcJF7pic9wW7jPMuHOG8SxIjROl9Jnh7uFCACCd5Zo2rXVPBhIbm46MG+k7GXQ5sf2CcwpL0jOe1Lkp/Vg6e0TENh51Xq0+Dgk6DwOgSoKwdvX3EP1Mgnughn9yPAqFLXr/dXnNxoiHPU2OiocVaLLH6QXlwzw5GMG7J1Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nVmLiQsZDpOXZyAIm3HCfFrb+/zuGahySOFyqZWrVc=;
 b=YLSCOh3Qq7jV6aw2T1TuZZ+U8YbO0lIYG3te8Vt86RttWRrT4f+Sxkg/PyZSKR2fmLlLA2ykY+KCMwMu+mAs8Zx1xISSEZHMXPIeV+upo7ITTeFsdpXsYoiVJVOnNqsESpu9Jc/3ggqlHD5NuwGAwa2sDFqdMYM6aT7Wsl1W89k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 23:13:09 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::2af1:f102:b108:13a1]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::2af1:f102:b108:13a1%3]) with mapi id 15.20.5709.021; Tue, 11 Oct 2022
 23:13:08 +0000
Message-ID: <4a7ee633-037f-9064-7e95-9fdcdbfb5fe0@amd.com>
Date:   Tue, 11 Oct 2022 16:13:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] efi/cper, cxl: Decode CXL Protocol Error Section
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
 <20221007211714.71129-2-Smita.KoralahalliChannabasappa@amd.com>
 <20221010152415.0000113b@huawei.com>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20221010152415.0000113b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::22) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|MW4PR12MB5667:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a014c5-de0b-46cd-fd85-08daabde291f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LTCobG2Hbgdq/iievYZlHJC5uuk95Me4o0Q57QkP9BagaPuJ2VjdCUgrcoqtzfytriJv7VPUYae2C8bXbKuW0KV9F1779bLwpnCsmZX5dRwifr6N6eHGPI5h9JnBfW8GT2RKCo1EWZfWcAkRGSHL/AZcQJtTRnwgHeSOHZV+Nsy4GQkFRdBGfQ59A0nl+v0eiIjTyxsaID+Ew45z2YFpFIoJ7IlkEviouQD62Rk8E9eMOT5cgXxFdFbrVwaLc9Sr5YbTs2jdIzvoP7IXJZ/mXGwt6HT+555+Yp3fTL8D4rUF71CM+H8q37r+qTFYxj58bsuK0ZQ3w0i/m9734AUHtYWb6baQ4ctR0s+I6mfDiNwIsKqMjKXv54FXJLUpG1oBYLO7dobETauNcEj5XhzKDQgv4/6HloJLNWLj74ZHBhqpJ1eApqzvd3mUAaoBgPwdIOpDNxYRIc7WCO6oYRDSY50DhAlFEuFT9df1Y5z+S9CYVWFrvoP/9Lx883kfMhvt5mnwkdfQBadIlhOYUk7tj1pqXPOPjkxmzruedSYbXXnvFWamcGZzTwo90B//ZI5Xmi7JemFSSZCKqiUSsbMoYYLT4HYKbDa+eXdznznXFUF+055Tt2VOE9KSTI/Lo/SPR4mb3kUPqILjtjsih9pnNlPDDaq44F5aYaTCqB8zjwJt1F8SsQq44x3RAD6EHX2Qx8Gq6PWOoMW1Z283C5LBLkrmfx+TUq4U0rLOP4+7NzbL08oByQN17AAo5hQqL2uQWjIXvr17TCeLDrowKXawC1kckQHMopy+rTlfhX+FF0TqSus0KhTsp5LcpCF21XDg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199015)(31686004)(2906002)(66556008)(5660300002)(66946007)(8936002)(4326008)(66476007)(41300700001)(8676002)(6916009)(45080400002)(6486002)(966005)(38100700002)(478600001)(86362001)(31696002)(36756003)(26005)(316002)(54906003)(2616005)(6506007)(83380400001)(6512007)(186003)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkJmVkNUOWZPYitwSmZyZlJTeUp6Q01wOVJtSlVQNldrMmYxOU9BSHkyb1RX?=
 =?utf-8?B?R2I1ZUZtTlRvbEVUWlpTV0xQT1hUaTBWU0RsVUNQZzhFUC9xMGZYeGNJV04z?=
 =?utf-8?B?TW1VU1c1TmM4ODNlVlVQMVZ6ejFWTFFpNHE1cXJPS1RCampPTEZnR1lacmlr?=
 =?utf-8?B?QS9UcWs2NDFrVDh5VmpIa0Fxb0dGZ1JhRzlZU0RVcyttRms5YVpFSEZKZ1NF?=
 =?utf-8?B?YmtYWlVTcCtKTUVFWms1TlFRZ3JrMGhoM2VZR1hJdDZxMXFjYldqSGpwZEVT?=
 =?utf-8?B?RGFzSnc4Wkl3RENjQUFEZjRFWUpDRmlvc2h1Y3BrdFVvZEUzL1FyZUErQTVP?=
 =?utf-8?B?Wm8wa3hwWDcwM0R2NkpkRGE5N2JFYUZ3eW9ucWJJOWlHZE1sRi9PcHAxS21N?=
 =?utf-8?B?OXM2d01ITmRGVzIrVDRtMlBKY0NueWc3WktDZ05vaDJUTjRLV0FENmROS0Zw?=
 =?utf-8?B?VU1kUVI2L01yYkl3dnAyVTBYMmFRdUhVSVphbkowR1EwZ1FNU1Y4SWNjc29P?=
 =?utf-8?B?eDZLUW13UFhnaDBNOHJJeFJ4NURyOEtYUzl0QzNXWUV3TTVNdmtLYVMyQk5v?=
 =?utf-8?B?MklPbHBBNkh3bllaaFIwTHB4bHhjM0xMTTY5OCtzRmI4d3l5eW9jT0c4VzZU?=
 =?utf-8?B?WFV3TE1JZHVwTjBBc2xGTXR3WUU0U0xuaDYwWm9TTU5Id3RxSUNLamRyNEpJ?=
 =?utf-8?B?SXZvbjZqL2N2eWFhajVOTmRpSWdMRFpObTR3Z28vemx0aFAzRjBRRG52aGVZ?=
 =?utf-8?B?ZU43czl2NGJLTXRKTitpYkh0bUo5TjhQc3FiYjlaMFZpd1FiVVF2LzBTRjlC?=
 =?utf-8?B?YlJSZ2FhYkozekcrMWtBeVMzMmpFUG13Y2FSTEhtVDk1cHBQOTU1NVV6dWky?=
 =?utf-8?B?OEdZMjBhMDVnRlZIOVc2dUNXMitLUkUxU2lpZllHZks1aURJcUs3aEtCNDFX?=
 =?utf-8?B?OFpSWkplSkVLNkgxeWxGRWRESUNOTmhTVm41bUp5Vkdyd2ZwczNpVGFEZFdE?=
 =?utf-8?B?Smg4RE44VGgwQWVHeVdCTFk2alZYRXBETDhxbWswK05oMzVJRkQzWmxjOWVt?=
 =?utf-8?B?TVhBYTBQWVRRelM3UkFMY3VqNVFnSnd3ditUbzdTdkp4OGxaRHdaK3ZsOE1Z?=
 =?utf-8?B?Y1Z0b212MVA2ZjhDWEptSU9LZXhUNWYvVHgxOHZuUEl6Y2ZtY2dnd1VRNWtH?=
 =?utf-8?B?S3owTCtNVzVaeVZZVEZKb0VRT3E1THE3N1g3MlZOeHZjNXJiYXVSbXd3SzFJ?=
 =?utf-8?B?cVBBeVdJUUtMK0hYM0tQZzRrVW1HSDZRNGExVU9wUTZPMlFlcjRTd29mdkUx?=
 =?utf-8?B?WENtVmU1Y1ZFakN6WVhxRU1BcllyRkFNMFNqZ29Bb0NickhSWm1VSXFkSFpY?=
 =?utf-8?B?Lys3ZzBDUmh5WjcxVUV2S1VQcXBKMTdCd1prWW1pRkFLQW8wRk92ejFyblI0?=
 =?utf-8?B?di92YXlDTGl5L2EycVhSQ0NyUmdDNGpKK21BQmMzMUNXc3pWT3Nkc2hVaFNC?=
 =?utf-8?B?d3JOeGwxeG84czZNaG8zZ1RBNThETTR0TkUwMnovQmtJL3hXVXBnOUVCbmhu?=
 =?utf-8?B?ckJ1eTg3dkl2ejlPdERmZ3AyWjhqMjN3K05nQ05vSVdIeEJkUWxZdHRERXdI?=
 =?utf-8?B?UGhUeklSdGFXT3BmMGtYVWFqME85TElTVVlrUjVkTDMwMUUrS3BrY1VYYm52?=
 =?utf-8?B?UjcrZE1YVkFERElzd1pEcUEvWjJveEs3dEJHZGRHRFlKSVNOTTRMR2R2OEZS?=
 =?utf-8?B?YlpweEJpTEpqcEw5NWtJeFFLUzhWQUxKR1FDNzZ3eEtNdy96dUFWMFNXb1JU?=
 =?utf-8?B?Z0lsSy9nRkRSQzRWRmdHME5aZ1o1cjlMbG95dS9PTnpIMjlUWFJmdUthNWJw?=
 =?utf-8?B?dFZMa0tqbWVnSHIzWTJKRUVRM0J4azBJVjdpdG81Zm4zVmJzckpSMGNjdTFx?=
 =?utf-8?B?Q3pMT0V0NDhNeFR2ZXREYTFnMU9vQXAwRytvTkFFUWNvT1ZXWDROcE9mblFL?=
 =?utf-8?B?YVNoazdkZ3R1bGo2MmZKZlF3WHQwQmlyMWFldDVpQ1R0V1VkYk8zQ1NPTDZk?=
 =?utf-8?B?K2gxeHVISGdLZ0h6by9MYlplSmJTSHo5NElXUXNidkpITUFZbWcrMU92SXgy?=
 =?utf-8?Q?SCBRcnS1PjvPuKQO/5Cc3OvNI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a014c5-de0b-46cd-fd85-08daabde291f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 23:13:08.8804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oTbVHVVyHGvBBxDej6B3i4rhm+g46DUg4hSlpfgwHNB4k3sRFNHV/S7rcQa6Vl89kg90SU6BhfUeqUlS26WeNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5667
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2022 7:24 AM, Jonathan Cameron wrote:
> On Fri, 7 Oct 2022 21:17:13 +0000
> Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:
>
>> Add support for decoding CXL Protocol Error Section as defined in UEFI 2.9
>> Section N.2.13.
>>
>> Do the section decoding in a new cper_cxl.c file. This new file will be
>> used in the future for more CXL CPERs decode support. Add this to the
>> existing UEFI_CPER config.
>>
>> Decode only the fields that are useful to parse the error.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Hi Smita,
>
> A few comments inline, but this looks pretty good to me though lots to
> build on top of this (trace events, any in kernel handling necessary etc).
>
> Jonathan

Hi Jonathan,

Thanks for the review comments. Please find my responses/answers inline.

>
>> +#include <linux/cper.h>
>> +#include "cper_cxl.h"
>> +
>> +#define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
>> +#define PROT_ERR_VALID_AGENT_ADDRESS		BIT_ULL(1)
>> +#define PROT_ERR_VALID_DEVICE_ID		BIT_ULL(2)
>> +#define PROT_ERR_VALID_SERIAL_NUMBER		BIT_ULL(3)
>> +#define PROT_ERR_VALID_CAPABILITY		BIT_ULL(4)
>> +#define PROT_ERR_VALID_DVSEC			BIT_ULL(5)
> Bit 6 has been defined by 2.10 so would be good to add that here as well.
> As below, could be a follow up patch.

Yes, as you may have noticed, I have added this in the next patch of the 
series.

>
>> +
>> +static const char * const prot_err_agent_type_strs[] = {
>> +	"Restricted CXL Device",
>> +	"Restricted CXL Host DP",
> Values up to 7 now defined, so good to list the ones we know...
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fuefi.org%2Fspecs%2FUEFI%2F2.10%2FApx_N_Common_Platform_Error_Record.html%23compute-express-link-cxl-protocol-error-section&amp;data=05%7C01%7CSmita.KoralahalliChannabasappa%40amd.com%7Cbbc0e9642a314f875d9b08daaacb283f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638010086801792139%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=ZM0zOEVtdxsQtvAxHYrTEW%2FnIBttTK48v2x%2F5VdfQ0U%3D&amp;reserved=0
> even if they aren't going to be generated by your firmware.

Yes, I'm sorry that I missed it. I started my development with the old 
spec..
and did not pay heed to go back and check the latest spec again.

Will add the remaining agent types in the next revision.
Do you recommend adding all of them?
>
> I've hacked qemu to poke out appropriate records in the past
> (for CCIX a while back) and it would be easy enough to add
> them for these cases if needed (obviously that's a dirty hack
> but it works for testing these flows ;)

Yes that would be of a great help to verify all the fields I think.

With our hardware support, I have just verified for CXL 1.1
Downstream Port.

So, I haven't really gotten a chance to verify how Device ID and
Device Serial Number would look like..

>
> I guess I can send a follow up patch if you aren't happy jumping
> directly to the 2.10 version of these structures.

I think, I can add them in the next revision. But I don't think I can 
test them
though :(

>
>> +};
>> +
>> +enum {
>> +	RCD,
>> +	RCH_DP,
>> +};
>> +
>> +void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err)
>> +{
>> +	if (prot_err->valid_bits & PROT_ERR_VALID_AGENT_TYPE)
>> +		pr_info("%s agent_type: %d, %s\n", pfx, prot_err->agent_type,
>> +			prot_err->agent_type < ARRAY_SIZE(prot_err_agent_type_strs)
>> +			? prot_err_agent_type_strs[prot_err->agent_type]
>> +			: "unknown");
>> +
>> +	if (prot_err->valid_bits & PROT_ERR_VALID_AGENT_ADDRESS) {
>> +		switch (prot_err->agent_type) {
>> +		case RCD:
>> +			pr_info("%s agent_address: %04x:%02x:%02x.%x\n",
>> +				pfx, prot_err->segment, prot_err->bus,
>> +				prot_err->device, prot_err->function);
>> +			break;
>> +		case RCH_DP:
>> +			pr_info("%s rcrb_base_address: 0x%016llx\n", pfx,
>> +				prot_err->agent_addr);
>> +			break;
>> +		default:
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (prot_err->valid_bits & PROT_ERR_VALID_DEVICE_ID) {
>> +		const __u8 *class_code;
>> +
>> +		switch (prot_err->agent_type) {
>> +		case RCD:
>> +			pr_info("%s slot: %d\n", pfx,
>> +				prot_err->device_id.slot >> CPER_PCIE_SLOT_SHIFT);
>> +			pr_info("%s vendor_id: 0x%04x, device_id: 0x%04x\n",
>> +				pfx, prot_err->device_id.vendor_id,
>> +				prot_err->device_id.device_id);
>> +			pr_info("%s sub_vendor_id: 0x%04x, sub_device_id: 0x%04x\n",
>> +				pfx, prot_err->device_id.sub_vendor_id,
>> +				prot_err->device_id.sub_device_id);
>> +			class_code = prot_err->device_id.class_code;
>> +			pr_info("%s class_code: %02x%02x\n", pfx,
>> +				class_code[1], class_code[0]);
>> +			break;
>> +		default:
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER) {
>> +		switch (prot_err->agent_type) {
>> +		case RCD:
>> +			pr_info("%s lower_dw: 0x%08x, upper_dw: 0x%08x\n", pfx,
>> +				prot_err->dev_serial_num.lower_dw,
>> +				prot_err->dev_serial_num.upper_dw);
>> +			break;
>> +		default:
>> +			break;
>> +		}
>> +	}
> Nice to pretty print the cap structure and appropriate DVSEC and Error logs as well
> if valid, but that could be a follow up patch.

Hmm, I have added the Error log decoding support in the next patch.

But, I did not include cap structure and DVSEC though as I initially 
thought it might not be
that important to parse the error. Do you recommend adding them?

>
>> +}
>> diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
>> new file mode 100644
>> index 000000000000..f924d96e4bb2
>> --- /dev/null
>> +++ b/drivers/firmware/efi/cper_cxl.h
>> @@ -0,0 +1,58 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * UEFI Common Platform Error Record (CPER) support for CXL Section.
>> + *
>> + * Copyright (C) 2022 Advanced Micro Devices, Inc.
>> + *
>> + * Author: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> + */
>> +
>> +#ifndef LINUX_CPER_CXL_H
>> +#define LINUX_CPER_CXL_H
>> +
>> +/* CXL Protocol Error Section */
>> +#define CPER_SEC_CXL_PROT_ERR						\
>> +	GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,	\
>> +		  0x4B, 0x77, 0x10, 0x48)
>> +
>> +#pragma pack(1)
>> +
>> +/* Compute Express Link Protocol Error Section, UEFI v2.9 sec N.2.13 */
> Given 2.10 is out an expands on a few corners of this. Perhaps update
> an switch the reference over to that to cover that.
> I haven't checked, but assume the additional Agent Types were added in 2.10.

Right, will fix the comment to refer to 2.10.

>
>> +struct cper_sec_prot_err {
>> +	u64			valid_bits;
>> +	u8			agent_type;
>> +	u8			reserved[7];
>> +	union {
>> +		u64		agent_addr;
> Perhaps useful to add a few comments to say when the different union
> elements are relevant.  Perhaps also name the field as per the spec
> which would give the overall union the agent_address.
> I admit that is a little confusing with the union element having
> the same name for when it's treated as an address.
> Perhaps call the union element rcrb_base_addr?

Okay, probably something like this?

     union {
                     u64                rcrb_base_addr;
                     struct {
                                     u8    function;
                                     u8    device;
                                     u8    bus;
                                     u16  segment;
                                     u8    reserved_1[3];
                     };
     } agent_addr;

And change printing from prot_err->segment to prot_err->agent_addr.segment
and so on.. Please ignore my indentation/alignments here..

>
>> +		struct {
>> +			u8	function;
>> +			u8	device;
>> +			u8	bus;
>> +			u16	segment;
>> +			u8	reserved_1[3];
>> +		};
>> +	};
>> +	struct {
>> +		u16		vendor_id;	
>> +		u16		device_id;
>> +		u16		sub_vendor_id;
>> +		u16		sub_device_id;
> This is always fun.  Far as I can tell not all PCI elements
> have subsystem IDs - so who knows what goes in these..
> Also, there is wonderfully no such thing as a PCI subsystem device ID.
> It's just called subsystem ID in the PCI spec.

Thanks for correcting this. Will fix.

>
>> +		u8		class_code[2];
> Why treat class code as two u8s?  If doing so, shall
> we name them?  base_class_code, sub_class_code?

Just followed the PCI CPER decoding here.. Will name them if that makes
more sense..

>
>> +		u16		slot;
>> +		u8		reserved_1[4];
>> +	}			device_id;
> I would not align device-id structure name with the contents.
> I'm not personally a big fan of aligning structure elements
> because it often goes wrong, but if you want to do it, drop
> the alignment of device_id by a few levels.

Thats true actually. Will just drop the alignment for all elements in next
revision.

>
> 	} device_id;
>
>> +	struct {
>> +		u32		lower_dw;
>> +		u32		upper_dw;
>> +	}			dev_serial_num;
>> +	u8			capability[60];
>> +	u16			dvsec_len;
>> +	u16			err_len;
>> +	u8			reserved_2[4];
> You could add a [] array on the end to make it clear there are more elements.
> That's not a perfect solution though given there are two different variable length
> fields on the end.  They aren't that variable (as defined by the structures
> in the CXL spec) however the complexity comes from the fact that they may not
> be valid / lengths will be 0 (I assume lengths will be 0
> if not valid anyway, the spec doesn't seem to say either way...)

Hmm, I probably got the idea to do this way by referring to "efi/cper-x86.c"
(N.2.4.2 IA32/X64 Processor Error Section in UEFI spec) and probably at few
places under the APEI tables.

Also to note, defining the new variable array member the parsing needs 
to be changed
accordingly in the next patch.  Add dvsec length to this new variable array
member to get to the Error Log field. Am I right?

>
> Either way, adding a variable array element gives a good way to address the first
> one, and provides a good location for a comment on what else might be here.
>
>> +};
>> +
>> +#pragma pack()
> I would push the structure definition down into the c file and provide a forwards
> definition only in the header.
>
> struct cper_sec_prot_err;

Okay will do that!

Thanks,
Smita

>
>
>> +
>> +void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err);
>> +
>> +#endif //__CPER_CXL_


