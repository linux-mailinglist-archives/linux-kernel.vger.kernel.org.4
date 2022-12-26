Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1217E65635B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 15:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbiLZO31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 09:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiLZO3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 09:29:02 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6E6647A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 06:26:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6fp1zL7BtlD7TRlTuuhByCAJOwmCVOTzGyrta+qYgaK8cINfMM7XaL9+kFBY1xe+p2XxL4/L9mqlALIMowIxp0E7p/6r5AakWUDb2M7DlHvGack4I7onBG8LVBotijwuUK+oWSg3EIdI9a9XTpKckp3UPIJYq+RWAoe9cOWp+LbeO0/587ri19QZtzNB9NnpwcAdmKLts0bOY4gBZAjhVRef4FHgWTSnycsJ6YIQTomFExgcqiklDTe872cWwC255IL36R8Q+TtahcPeUOhYVkYO9fPdDHWEcYupMFeARXsqNXli4hZRZYudeFzqJj5tENBMAT0DKjhexWGwaI5lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQtNR9NvGm+JMxSBZgO+HZlmZ6gdzpC/H5h15mXpmZ4=;
 b=a+FXJ5zVyCpOPQmatBOWpT/p9resbSuHYPWg1sImgN4gAcjPiCzB9cmHoqOFGvZdHRYmYYuhl3JAI2PA0Z/1YLcSdlvBX5FPnuqjZ8KngWdKDjWxC3CCidJKHvhFM6Bcu2MFn/wctq007QXlIsSj7R3tyfg/q6EEbA2K+wp6gGD568JHdTCKluYvMtF6u30TyTJXUzVF7CHUc8wl8YbZjX7vbIwUW4soJDgyr2M1fuhCs5X7fTGqco4WNkL8rTrpX6is7zqWzPlPUWunS3ZdYULLWJ9gsYgrznchpcm3Xef2AHHxnRIPnycV75aeZTS4ZcMPGugAec3MwawRZAlupg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQtNR9NvGm+JMxSBZgO+HZlmZ6gdzpC/H5h15mXpmZ4=;
 b=SseGQ8jDxzHAZCHLfgu7ZJjbK8AGr8UM6mKF6dqmCrNkv20zM+hQWNcqjiOV5fqTHERGovnA5mYD11O77eiIHinDg2K98ZIsu5SatbF2JMWrXJKyUQH4zDsCR1x7BF+Xvnbx7LbY+g8k4mgJa8j2QURQyLZrnczyc7OiWl9lTII=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12; Mon, 26 Dec
 2022 14:26:03 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7%3]) with mapi id 15.20.5944.016; Mon, 26 Dec 2022
 14:26:02 +0000
Message-ID: <9bffccfa-ed01-e1a0-8619-75670a340167@amd.com>
Date:   Mon, 26 Dec 2022 08:26:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v9 1/4] crypto: ccp - Name -1 return value as
 SEV_RET_NO_FW_CALL
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Dionna Glaze <dionnaglaze@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Gonda <pgonda@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirsky <luto@kernel.org>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20221207010210.2563293-1-dionnaglaze@google.com>
 <20221207010210.2563293-2-dionnaglaze@google.com> <Y6R4RC45WXs3Micd@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <Y6R4RC45WXs3Micd@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0063.namprd07.prod.outlook.com
 (2603:10b6:4:ad::28) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|MN2PR12MB4222:EE_
X-MS-Office365-Filtering-Correlation-Id: b05dcc79-4a5d-46e7-cadc-08dae74d1df3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: huA08iMvLxfkUCp5uhT+0+QLHOzqOn6IX2fqKw06462YWDPEeXi+ya50QJHV0LDJx0cDO3px5ON/VKgjY5FN59+d9veAm/1SSh96WPL8HaskJCI+h0m9sv7tTiy9kPcZoIjPtOukToLGdxZFFtihrz19bca7e1mIWxlAA50KfoXh+Df1N4jVsILKCsxqzVSGZSlylL/89sWRcUxOyEd37a0qqKHKKKqre8r2QIFODucGhpXT20m143gjpI+1Mw54DYraaBePC0IiE9zSG8w6T0dzs2KWI6YBukdHaB2JhHmUUhVJFArTXIzpInv6zW8nLZqcDEFN6JMWweIMyE6OtR9+ri3hhV0QWeMmfN5+IsI0sckqbdNZJbxFR+HDPLo6unQ7mJ+j5HE25otpJ6r38tBiKSlIlojyE9s9cn38bwCzrrAvFy9L/78KPjCsWjR27kda6oo4kkce7WhisZC/IiKHTkq753ayEjfrWn5iLpJvtmVovzVJwaOpIvoq+pW7oX+Qg+QxuboMJrZPMhJ3psvSumVZte+6VdudJe9Z1ba+Zm9iQVlXTXN/RwUhY1fmSHK+AGohJOCNr8dyQYajoVyZh0KWVm6T0IGAjcnEqNr0exB6oQ/9nvTER/u1tJuk5nOxv7jBLLDQKjoCwxWlzXEYeceLBGyf3Xai2PiMktr750ZOTMgkQEeivctWbZKu908e09tAia5MU478cFZUTOc+l5k47ZANnMYEIua2YSA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(7416002)(5660300002)(41300700001)(8936002)(66946007)(83380400001)(8676002)(38100700002)(4326008)(66556008)(66476007)(31696002)(86362001)(2906002)(36756003)(6506007)(6486002)(478600001)(2616005)(31686004)(53546011)(54906003)(110136005)(6512007)(186003)(316002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmZ5RWxjZHh2MmkwdkprUG5MN2grWVpVaWZOR25FbjI4YmJkOWlnMnA2RGl5?=
 =?utf-8?B?bS9uYlVrUCtwRFdTNUFsbVgwQXg2N2FKZTU0ZUIwUFJwcGcxQTJpYmdCeGVo?=
 =?utf-8?B?TTRnNE1EMVJNOEtOZDVUa3MxV2JWdGtOSVFnN3RxbmJrL3o2bnZVUXpDeWVz?=
 =?utf-8?B?VG54RXBPaVRHdFZqK2dtUWEvYXJHSFNkdi9qd09vMFp2VUI5ZnlYTEZ3OWtj?=
 =?utf-8?B?aUxKYm94WU5kam51bkxpZVA0MW1sM2YyczVHMU5UdXJYb2lxS3F1cCsxWjlk?=
 =?utf-8?B?N3VWdmkxNnNhc29VcVVrQ3hzNHJ2SjN1OUpDelJnYXZDUklzRDhHZEY2amNt?=
 =?utf-8?B?N1FIcFk4MkxCMWg2WDNkSE9TVGtJQkllYnpTb1I0TXhDUk1OVlJwSmJDMWhr?=
 =?utf-8?B?RHdZL21TcS8raTBHNk4xM3FXU0lhREUvMVVNTFpkcXBiSE1CYUI1U1dtQmZV?=
 =?utf-8?B?Y3VkTDhjTmY5WVpxMmRtNU9DYzRJSHdjN0NJNXBIQUtRcVRYVHEwRks5bEtS?=
 =?utf-8?B?NHp0NVVKUWI3dHNxRHh0MTFoQ0dYK1V6QW1YVUViQkRnU1kvK1RicEh3dElL?=
 =?utf-8?B?TmUyRjN1Zyt6Y2w1OWE0aDhlS0d6UlJEdlRmNjhEZU5wKy92MkVFNnZCNkIr?=
 =?utf-8?B?WVVjL1hKK2RSMGlkMmtzVkdrczZoMExGREdnd0lINVVUWlcvb3F4SkpzbDZX?=
 =?utf-8?B?VDBPTFUzWWhQYURBYVIyTHRmNEVzcnc5QW43MFA4ZForaGlMR2FhS0RQL1dK?=
 =?utf-8?B?UXNvQzE2Nnh6TUh5RGZreTF2eWtaeVo0ZXpTb0k0eWlkNGE1d2hpc3QwNGtl?=
 =?utf-8?B?NEVTYk5iUXVWVzFGU2oweFlxNnlDbHlZd1FkR1o1UkV0T0Z3eXk4V29IcDk5?=
 =?utf-8?B?dk93azhYbTA4UkI4d2dmb0xzcCt0eEh3Y2RNYWxnS2Z0YjZqeDV2b1RtMGdQ?=
 =?utf-8?B?azdqcnhYamZ1d1ZTb2Z2aGdpV21FOUdXZDBVczhNODZ3S0FFQUhWNmp3Wlo1?=
 =?utf-8?B?ZlM0bE9abU9SN3dXM013VStOVngxWU5CR3k0L09SY1hlazE0eGc3MmVKTllF?=
 =?utf-8?B?QWd2TnRjTXRiMGo5KzNMUktwME1lV1Q4MzI5Um41YVhweU1lSHo3QVZWMWtk?=
 =?utf-8?B?ejlFTW5XcnpJWkh4Ri83R09OeGpCTjczaHdOVFlKUWFMWE5sMDlnbmR4UnQ1?=
 =?utf-8?B?VGR3WTV6dWN5SlQxU09vME4xeCt3YzBlTkRlU2hlQmJVb2swK1BheWdRdzBX?=
 =?utf-8?B?OUV4NVBEdFNyUU9aS0l3MVN3SWplV2pBY2liVHMza0ozUGtna05QU2JwWk9D?=
 =?utf-8?B?bXUzaUtTOFNncEV6bndGUWc2THNPWXAwL2prNGJWSkpYcTdTNFJnK0l3OCtx?=
 =?utf-8?B?c3VYOWxVSFNZN2lpUXJFakUxcFM5d3dLNmUvTUVVYkR5QldEdStzMmxadExG?=
 =?utf-8?B?UWkzWkpvT09Kam1OMGNvNWtmcU1KNWZYMTZNMVVtMlJGa29pZXN4bXR0Ym1K?=
 =?utf-8?B?Uy9rd2NLMDVWTWg5dVJ0QUNDdUlObno5VHFDVmV4aktuUTFHLzlGYkdyZEpV?=
 =?utf-8?B?cVlxZGVMckpMT1BpejI4N3VDZ3RzZWI5cm5Kc2ZnNTQ1WC9qQTM5SUUyZjJC?=
 =?utf-8?B?elgxbDF0UGlmMDJXeXpkVXFRZW1xMHBHR1h1VjR5eXZ2bDJOWGs0ekRCamFZ?=
 =?utf-8?B?V0lCckVtaDFvUUZISVdRQ3BNZ05SalptaHNoeUEvKzhyVkZzVTRoQURueDlR?=
 =?utf-8?B?WmYyRkw3c2hSQXFvYmNBN0cra3FlSkcrdXIvNzQ2OS9TeHNCTUowcGR6UFd0?=
 =?utf-8?B?SDh4c0cxRWJlSlZ0MCtEZ0xBNHJsZnJaU3NqcmwrcklEbC82TFozT3lzS3o5?=
 =?utf-8?B?N0dYQVZTV1dEVlJtZzZWK1M4R2NydGZMNlZRakdFZWhqYnU0QTZTdEVlcWx4?=
 =?utf-8?B?bnM1aXRtVEhJOWZydXdteW5LTTdFaVU1eitMdVVkZGIxZTRCTGYrcGpQQnhq?=
 =?utf-8?B?bXE2Q24wKzVkSzZnN0RiVHZ6UXdGMk9ybmpTcWx1R3NEQ21wemlSMzZSeGRC?=
 =?utf-8?B?V2M4MEdpcnB4NUhkcy9QOGJ1T1pTWXdQeVhZVTRUenNnTXp3K2FhMy9Hd2tq?=
 =?utf-8?Q?gXRjc5/bO1eVuHoktqLtmx9iR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b05dcc79-4a5d-46e7-cadc-08dae74d1df3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2022 14:26:02.8610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fMJD2Gk3CTwZ1GKJhq/daT4mJKirE/AtVrE/iYgcsYD2r9WeSHIYdpEUDLTQifF6gu4gIXfft7ZPdMU1jKNwCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/22 09:31, Borislav Petkov wrote:
> On Wed, Dec 07, 2022 at 01:02:07AM +0000, Dionna Glaze wrote:
>> From: Peter Gonda <pgonda@google.com>
>>
>> The PSP can return a "firmware error" code of -1 in circumstances where
>> the PSP is not actually called. To make this protocol unambiguous, the
>> value is named SEV_RET_NO_FW_CALL.
>>
>> Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Joerg Roedel <jroedel@suse.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Andy Lutomirsky <luto@kernel.org>
>> Cc: John Allen <john.allen@amd.com>
>> Cc: Herbert Xu <herbert@gondor.apana.org.au>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Borislav Petkov <bp@alien8.de>
>>
>> Signed-off-by: Peter Gonda <pgonda@google.com>
>> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
>> ---
>>   Documentation/virt/coco/sev-guest.rst |  2 +-
>>   drivers/crypto/ccp/sev-dev.c          | 22 ++++++++++++++--------
>>   include/uapi/linux/psp-sev.h          |  7 +++++++
>>   3 files changed, 22 insertions(+), 9 deletions(-)
> 
> Looks good, did some minor touch ups ontop, see below.
> 
> @Tom: Ack/Rev-by?

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> 
> @Herbert: ok to carry this through tip?
> 
> Thx.
> 
