Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2872E611B6E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 22:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiJ1ULC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 16:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiJ1UKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 16:10:37 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1B27333D;
        Fri, 28 Oct 2022 13:10:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAkWA1H8okbSTC9sNal3+mMtK6kapBbWCxk57YmwW9Lzm15pTrSm1h5jmbmXu3XhiMaBoOdNxerrxOQSSFaVsn9WhqxCKqER0vI0ZbVIvCwJA9Px77gCj/ySyNEiVfyg6CadU8Y6H3XoS1pfJmLYNjfRiKgiG/rXPx6FLMCG/SfBHRRWlY+XGr3OwRWc0cz2OCsCP+04tAxmzOKgNSsE5l2nN7KfPCYeiem/YFnxvDWFZ7TI4TUNdcJuF/NcB1ed1s/IQibc7fkDDbPkPurEcHumh2KLHKuBEo9XG8XxYY1BlU57VHyxcxvs4jOiI2noElDSmfb/o2zAHgL/rJ6tQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0J+RzN59Kqq28IHyBMNoHYGHm2jKlMQY/XIrnWD5dg=;
 b=MSQeAzwzKoLNVLtJzhQaRPBLFjSjm9cTxa0dCmJ03fyp54VIIghy/v+dH2LMOApYHDu0R+Mt+03zw/ZiUL1GygcMAu1YvHwPISgxkzhgnfP/8Z17c0PJ0i5a0I7upV6/JSrnYzkCWVn4fMyz0SerlB2n2q10S19pqIbG+IirUgMjdLzIf9Hge2hnhk+cyDpi/mjqwcI9HEriChbcQxmsbeKxy8TsPWv62xmEdWyiGVWk1se60Gytjhpx7/lYr0jCiX0apOgHuQ1LDP8wZn/2ordnC4uy1uMYHdtLJzITeFeCnH3sP7fkjIbGu0PmJ12P6+W4Tu2XPENS9vCa/+rXRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0J+RzN59Kqq28IHyBMNoHYGHm2jKlMQY/XIrnWD5dg=;
 b=CtUJHybtPjRNHOgSdyUcw5FT0q33fcHZCumFv+BeILqXjOl8zKtMKeLWRsHkJKKmKAFpQJtNQPM05JfESlifPQkFVOYholDNeSPf6kKS05wWczwIgYJqWJG8X4FajX8NPU2lnD9TGpHV8BEB8vZKbNYY75rF46zVdAZgcCQLIxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by MW4PR12MB6874.namprd12.prod.outlook.com (2603:10b6:303:20b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 20:10:31 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::ea23:1c31:9580:cca]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::ea23:1c31:9580:cca%4]) with mapi id 15.20.5746.028; Fri, 28 Oct 2022
 20:10:31 +0000
Message-ID: <3af8dc72-e5f9-af07-f26a-4f90728de5a5@amd.com>
Date:   Fri, 28 Oct 2022 13:10:28 -0700
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
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0104.namprd03.prod.outlook.com
 (2603:10b6:a03:333::19) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|MW4PR12MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c4459c4-f26e-42dc-5926-08dab92076b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M07M52yEVu+iTcvAkW31AUJ/dSDxe635gY10XbKLEMCeqklh9iRoPFhZwCgAqtb8E8SO7vSmRCj5uxt1+kf1GfotrKxZbyaKuC/SWSYLCMzwF7qjR2zUQAYiVPnCbbBSzG/WERmXINcaEWyIcSIfkLa9AyQgXYEumeW9ksOGPMRRsx/RQiXjxEfk891YNuQwB2fAtlGtUU3ytEgD7M8HtxtdS4jJez4g7JMPJV/E/kgGNEPH5PLXoas9J9sb0LmWbuzraUUZia+oB1uXtphXRguQ3dqh6KmK0bpWqu9fNsbLV7WQx3OUcHsqf5fHAx2O6DwY34m4VhrfUnHjBhb8zF4XLSVADMMXjLar06AbEzuLWDHvVcsrDxFhc9/areECb1iQE+irdVK6vxaAq4W2SovJ2JbS2mYta74WbD9/7bVGmYKCqXD/VFgNmypD7TtrFF3ASRsUumRLGZdfk5vs7n/WFswg9TskcrM839imskMOWoY87o88fm1EH98HnBImsikyYSEAsa+LErcDFQw3lVDVSlqwdvll3Nbv7DNDdRijO92SGqnkJmy7CKkD68sx6YuvF6PI1x5yXb2uhZEr/D2T6MsCLsR1qFqoyAf/xm7ltgBk50BPabBA9/bpLBJx22Ao2pWqhxIqsi/gYtWjA05teJtFBQDAaW/Dauid9LtqRVrqaTBiZI9N0NXgaCYnOe72u2NJujWSlP4Bes5fvnS1YoOvFQDMb0r0qyf8SerPJKsRkNh4fcOr3FhZe/kyqvB5iROd7Vwh1QsXeJ/rzXvZXP1osVcW+4K76HUCQsU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199015)(478600001)(8936002)(41300700001)(2906002)(5660300002)(6916009)(54906003)(6486002)(66476007)(4326008)(8676002)(316002)(66946007)(38100700002)(66556008)(6506007)(53546011)(6666004)(86362001)(31696002)(6512007)(26005)(2616005)(186003)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVA2R280cFNkYW5vNzFoYXo0elZJSlJjTklCWFQ5RXVXaEdVL0w3MGlhcXVl?=
 =?utf-8?B?OGV6cEMrV2c1WUd3M3ljZWVXZDQyVWRqS0lxNDVwOW5hNDUwYnl6Yy94bHpF?=
 =?utf-8?B?SUFWdmdnay84M09GTXZ6QURFWExsTUs0ODZ4QlcyNGo3VUU2Q2x1bE5NYzFk?=
 =?utf-8?B?VHVXQVAwbnV1NmwvdDQydXgrR3grWnJSQ3p1MnpSUjl3SWdXckdHM05wVklh?=
 =?utf-8?B?ODJHNTRPOEE1K0RTVk1jS2wxQk9WYW5HWi9OeWRLN1JDQUoyQzMxUU5BeFhs?=
 =?utf-8?B?QmtFbFRhVk9pZDVuTHpsZlRCZ1NkS2ZnM0dmSXlINlg3MDdLdkpVK25qRG5Z?=
 =?utf-8?B?K0F1eDNZQjhjMytPMnJoaVRmekxUVGduMCs3amJ5aFhPRlRLb2xjR281VDBn?=
 =?utf-8?B?RkM4NzgvV20veFg1aGdaeE4waU1wenJEekViNFZDY2Z6Y3d3R0cyVlhCT0ly?=
 =?utf-8?B?UlJ3Z0lmTmFEbDRMdDAwM1RROWRKenVuZUt2eHVHTlZyR0xta3FxeW10UGh0?=
 =?utf-8?B?QkFxQ0ZwSjZtTFp4dndWSStNNG55MTVuRytMajRUL0NxSzNlUkVvYXFaN0Nw?=
 =?utf-8?B?RldBeFhUbUN0WEhpVWVkeWs3SzNGRWgvZTcrNEdDRzUzMjJMd3NrVS9Oczh5?=
 =?utf-8?B?dXF3T0ZIa1hKNWxFRWU5WTR5bDJUZGl6OGl6aGlicEk0TVBuTFh6RlFJN1Z1?=
 =?utf-8?B?SVRlSUhUQzllTXkvRWxlam9HbkRWSElzN1J4YWZyM3lXdCtYUnlEd0d3Mi9m?=
 =?utf-8?B?Zk5iVUxnSHBuQ3lTNnhSWXMrdENkbFhSTmZkOUs3MWFMeXFDcHMxSjJkdk9G?=
 =?utf-8?B?bUtrR0tOUUVnR2pnbUQzcDQvc3NlRnI3UFpaQ3VxUmh0UkZoeHd2elJJczNo?=
 =?utf-8?B?cmFnQmpTN0Y2MVFNVGVTd1dqTVdsRWtvT01URCtOSUE2OFE3T1pjOHVHQllr?=
 =?utf-8?B?MVVuOURiY2xreCtCazVpelNhdkZBWDQ0Y0ZKTXl4NW1VTVE5MFM3TS82Um4w?=
 =?utf-8?B?WEthQTBMaTY4Z003S2lYdUpEOCt4MmpaTUh1SjhLZ2t1OFFoWm9xYWR5cXBW?=
 =?utf-8?B?Tmhra1FZb28zUnVCNDFYdHFRTVB2S3NMWXlpcCs5T1RCMUtJd1BiM0lYazE1?=
 =?utf-8?B?ZkVZSEkzam42NFhiVWt6T0NJb0FHWFFZbkV1blNHZU1jOFdkL0xHRTErRjZB?=
 =?utf-8?B?ek9OaEZ6Z2E4ZVZpK3F2b0JOTy9acjJQQVB2c0pCRWJyZmhna0ZPcnlEMGdZ?=
 =?utf-8?B?VThsVi9veXNpbzBrVGhpM3hlVDN0bm9lMjNkMlA1bUtZdVVNTW55RkE1S2s5?=
 =?utf-8?B?K3VZeGo3N1BFbzE5bVZxcWRaV3dEM2svNGJvVlRvRDg0cUQ2VnZNQk9KNE5L?=
 =?utf-8?B?SmdWZVFoSUZBS1JmZ0JnZU0xOWdsc3Y1WG55ZWhwUmdWSDFNSFhrcUtKWGRV?=
 =?utf-8?B?MGhFeVRWRkVkb2R6YjlEakIwSTZ0bGlBYVdlemhUWXpJVUE1dmp0UU9FREgw?=
 =?utf-8?B?WEdpbXpGanV6K3lZMUxhaWF5VytaRXNTMU5LT1JpSytjU3ZMaHhWUUc2dTBK?=
 =?utf-8?B?emwxT3IxOHJtOTNxazNzalE5YmE3TWF6Ni9SSEk2NjFFZTF5cTRmcEF3MFl0?=
 =?utf-8?B?c2ExakFiNXU3VDR5MHFqSDh3ODBQWE0wcmxCZVQ5c205Z0Z1ZHFlSlkydWpp?=
 =?utf-8?B?NUlQdkR1Q1NQdEdEcGt5NllnQzcyQ0xORlVzQWpvNEJJb0ZZSm4wMkRWZ3ZR?=
 =?utf-8?B?Z1hyNk1HUzhEak04ZjF6MUE3eXJrMHFUeGl2T3E3SlBBRVJqTzN1N3Q1bVlQ?=
 =?utf-8?B?MGV6cS85VmhmbTcrOFU3NFhUOTY5T0pKSmVXcFBpaWVIS0UzVmgyS2VTdjRQ?=
 =?utf-8?B?bGxocVgwZFB2WURwV1FGVDNXeEMrSFo1M2w3VHZqMyt4Wmh1dElnK2htMjlr?=
 =?utf-8?B?RnRnSWJHQUJnN0cwaENSNDEvMkp1YUVDYWxjWjJzNG9xc3lIdXFsMVJRdTNh?=
 =?utf-8?B?b1dIcW9DSHdFS0NVSnZFTWQ1YjVjNytCZGF6Z0VubjdGOXhyQWlEbjZGTHlX?=
 =?utf-8?B?UkZGUi9zaXJQK2dxaTBzRHoyTk0rMG0xTkM0N1ZJeHVaQXpVTnBBdEFmd0Jr?=
 =?utf-8?Q?l3e0Je5wDSYdB9HU7A3i5PK1K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4459c4-f26e-42dc-5926-08dab92076b2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 20:10:31.3306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IN+vq9uWAMIPbJMuRRkc20+tZhzotqeBfV3UxO+dcnNFmo89IeH9puP8N5aVlJU0ccxc1DGJRGLIyk6JspMBPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6874
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
>
>
>> +};
>> +
>> +#pragma pack()
> I would push the structure definition down into the c file and provide a forwards
> definition only in the header.
>
> struct cper_sec_prot_err;
>

I haven't done this in my v2. In efi/cper.c, I'm calculating the size of 
the struct. I think forward
structure cannot be laid out there as size isn't known. Please correct 
me if I'm wrong. I can
incorporate changes accordingly in my v3.

Thanks,
Smita

>> +
>> +void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err);
>> +
>> +#endif //__CPER_CXL_


