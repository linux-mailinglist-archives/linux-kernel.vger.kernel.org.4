Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B6365F7A3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 00:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbjAEXgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 18:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjAEXgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 18:36:39 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA2C959E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 15:36:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6brgKhpJsQ7g9VmfGST9KbP8eUN57Am/4PnKZ67lVZPIivzvJP2QIRuhexy0nYA1/HKhgB1LOZiyWVGoVDd5rRK+cC4PPSUgDZhZf7a4r7y0t1Cx5JiPam5X+oE0Vh/QmjV5EFLdAHDamBZMrZye31ZNVYbl3DiKq+sdBh2BuoYcKFEOw69WUI69H8ZZ8IBTHhh8OepVQnlAwQKLChYaS1CThpVRHh/PHXzwVrs8JCRdHVyK5oVGaKKrHkDaEkaFIOf3+ZbV9AnuNRuKSTM7C6YvHrRLx7fqM/4NVlF+mfzvLhAgXwRqYQMYg2P8RmMp/516jPtV1X3mc22peDe+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NR3eKyRwc3llxiqUL3S6Bbzzk4GAkQXBWj8ka9Smif0=;
 b=bO+F2d4yKoZBAxNrCEZLn3K5ze1rFTpNH+NZJdSallLaVohi5/phGL+26aPnzBWh5oPVEAXO00jzN6A0sXITiRpaWJZTuj6UEmS23GAXL9YWXJmiIAmZF6BIlauoLwaDugTccpzIaN2XvB2tS2iydBJNsyfAet4CHitFYxEA84glwLYW+pD/tZU4et6E+ty0+WeUNpprQCsuWa8rSKwt+jQflIjA1W+5+6MQkxxPw0VS+i4Oa30vS1ZinNLHBH0tTQvgWmMku+fn7rcmOo8o6zQkVd1CDu4CdMA1UkkN7OgJpbvLcTzPC5O6JXmRDstVtWzCgx+0kyhHehAEE+aytQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NR3eKyRwc3llxiqUL3S6Bbzzk4GAkQXBWj8ka9Smif0=;
 b=VHZ5mbG7W6J5STyROoJiPUKxcCreZY+Z/LQPEiwMfvjTt0iJZq54btH0PUOyaFNozyobJdDFwpX6t7DubeYmuQjHJ2Xc8lHZ6RXfy+2dhjQ2FUa8H/dpfcNRUTWdk2joXhgXg1DwiGJZ0irOXzkOBYmkrpl/RGVJY4/SlOLNzgU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by LV2PR12MB5823.namprd12.prod.outlook.com (2603:10b6:408:178::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 23:36:35 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::7d2d:dc01:79cf:df79]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::7d2d:dc01:79cf:df79%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 23:36:35 +0000
Message-ID: <e57369d9-e4ab-365e-2d59-4a5f46d65283@amd.com>
Date:   Fri, 6 Jan 2023 05:09:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] ASoC: amd: ps: Fix uninitialized ret in
 create_acp64_platform_devs()
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, Syed.SabaKareem@amd.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20230105-wsometimes-uninitialized-pci-ps-c-v1-1-4022fd077959@kernel.org>
 <6bb126b7-1cb4-0c4c-d357-fadc3ffdd3f9@amd.com>
 <Y7cEra00F9PeFFcx@dev-arch.thelio-3990X>
 <Y7cKHZL8e+rfR66a@dev-arch.thelio-3990X>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <Y7cKHZL8e+rfR66a@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::9) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|LV2PR12MB5823:EE_
X-MS-Office365-Filtering-Correlation-Id: 41a4b54e-c371-4f07-4e62-08daef75aed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O3fU7Jdlz0ksw5v3y4x7rZkeHmBacE3FR/q2HspVElbZyApx48hDyBCs46EYd0p8Tze2+wD1fV1lLHWEiYdS/DB27kVsK7jBVJEhospNo+A1AjLoHlaRHLSf4gssTwl8dak/0LuHsvc6QBWOh2i+aywCZVW3KDt9VYbdJ5P1ZTSHPVVvzD99haGNy9bOk2F1z0TTxsM8Qr/F7JlPG0m26rZZmqo/Sr/BsK793QOiUXozLw8AwM7m+/IHpVMwwXK2BLYdudj3QHwsqWHdrx2wzAH8Emj7ngj2YFu9p06VISsywtRVFUYFZC97Fl/Ior8STecL2pPg/Vt6swWA/yG8NuI5pUcSeYbTsoL6P4AyJb2SV9U1N99wUXFk4WbG3Mh6MXahg+oH1cSzSeZjDVt66t3gveC+3bPsvHbGuSDwbbbr2hlcsTE5MwGdgmicLvGyKKA+oROl1vB4462sRVtwqJAl+pUmfYiMZoyqZcyPDlxIryq2ngsjkhpWvpdG2VLgWo9W1S+CGpmalL14U674NFR1mNZJz/CX2ydzIM5yZRggJltClX/jAsZ46sIZ6JUfX81sMS5B+junLPhKqGAtdiZJWchIdsFtBikP1PfTntCZdFayHlgvRM5euWonb8DIUDGjk652dJc42g9OCbL/TwdqGZLe6c/1dPLih7f+be9EW7FmgsibWhFouqDkU+bKq44faEjQeCIWnrsaz58i6BxDZP35syYTe726euqDXdt22oDyhg3fvGkW+1fbDSFuTvwqjJcsvfUwSXIYOgeAXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199015)(8936002)(41300700001)(66946007)(5660300002)(8676002)(2906002)(6916009)(66556008)(31686004)(4326008)(966005)(53546011)(6506007)(45080400002)(6486002)(6666004)(316002)(478600001)(66476007)(86362001)(31696002)(26005)(186003)(2616005)(83380400001)(6512007)(38100700002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VE8wdmw3cG4yVE5SRkVTa0RGa3lRdmNsOUs4eVA2OGJkZE82VUZpakE4U1Yz?=
 =?utf-8?B?di9yMHI0bjI0MmtXZG12aGZScE5kUVI1em0yVk1lWEw1QmxhdnhjL3pqT2o2?=
 =?utf-8?B?dVdwaDdpMkRjMXRuQjNTRVN0OC8yTHhZL1RjVVFVUmlqTkVOZmd0TkZ6UWx2?=
 =?utf-8?B?ckRObXBDYmd5Vk14Tm9FQ1FDVTZ1b1E2cDJ6Z0gvRENnbDcrQXhkTFBrSXlP?=
 =?utf-8?B?TitXcE0weDZwa1VPVkthS0o3NWVqOXlSRHp4VnNhdXhxRVlEZ1FkQ0YzWW80?=
 =?utf-8?B?dmVFTlV5Qk9NVExJSXQzMGxmRjI2dUhtT0o1azlTTzNmWlRrams5OHFRN0VD?=
 =?utf-8?B?eFIwUDAvNnZmS3V1QllBYlJCbFQ4cFNSdmRpNjNtOGlySG5nSkFRUnN0b2tr?=
 =?utf-8?B?TVk5UTZMVWRJWU0rZCs5dnBXcDNMR3RId0F6MGpwd3dTUm9sTisrN1lZSHA1?=
 =?utf-8?B?UndzOFc3UytsbVV2VWx3TVNabGhXejlxcnc1UFNGeUczNEszV1FlUUZZSlB4?=
 =?utf-8?B?K0xoYzdBZzN6V2hZT0R2b1ltaUI3RURDUzVtUEVIOUVGbFFyRW9lRm15bHIr?=
 =?utf-8?B?UzVOR0FqNUYybUIrblhRa203d3hvMmVKcnpVZ2JpcUNZWUdudmJBUnV0K1J6?=
 =?utf-8?B?UzIrNXZUeEdOYkhWZWcvVXJLbW1QaTY2U0VlK2xHRndnNHhEV3BIb3ozL3dz?=
 =?utf-8?B?NWVnS1E2OHBiNjV1YVc3WlZEejF2bmROektQSGdCM2hEZFNZMlcxNUFIK2V3?=
 =?utf-8?B?bTlPdEZwVVZ1eE9VVTMxOVRCeFZSU0k1K1ZPKzJwb0I3Nlk3VzVkNUs0Um5v?=
 =?utf-8?B?Qmk5Y1Fwc1VHMUxWTzVVSFNSK2dNQjFERjduQ2t5eXFVMmpLbVQ5czhXMXdC?=
 =?utf-8?B?ZGhENUNzc2x0bUJPZ21UbEk3MmhCdW9GNEhITTN6MFZmOW8zOFBCellyUnBp?=
 =?utf-8?B?RU03MmFSTERJOWZsOUluaUtJMVo2QVVUTVR4YlovLzRaOUQ1SG5YdmtBeDZn?=
 =?utf-8?B?T1c5WFNZUVlhMG1VY0hadWY5MTVpR0NrNlpIdFgwOU85Tm9mQkUxd2dSZ3h3?=
 =?utf-8?B?QWY2MFRNWGRiSldjeVFxMEUrdTgrYlhLSDVtNG1aVHlHd1VmK2gvbDYwYjd1?=
 =?utf-8?B?cXBoWG41NklpL0EwdWVqeVI4aHFGZ3JEMEZmNmFZbzdlNEpaOFFnRTMrYjlx?=
 =?utf-8?B?SzRqbE85a2pUYUh6ZG5NNGZ2aWljUWpkVElhQnVMU0xDMWZsWHN1bllxYS83?=
 =?utf-8?B?cHBITDdvU0NHbTlvMTNHOVZhejJpbFNzb1pyZXZaeUU1Unh6YnJ3WS9SU2Y2?=
 =?utf-8?B?Q1gycXpxaG5SNUNnT0FUVW8wOUg1aDBPVHhreXdVQWIrZXp2N1dQblplTFE0?=
 =?utf-8?B?cUxxWHlrdmlxM3hOWW9RQnVLbUVLZUxZYWtUL1kzUFpzZ2NGcmx2UUtPd053?=
 =?utf-8?B?RVpGb0RKN2t1V3JYYis4VHZISDdkeDUzbTQ2MlBGYVljb2h4S25wM1hWMjFZ?=
 =?utf-8?B?TS9jRDdySGFSRzNsVS81VU9CamxwR2tHWHhBMXUxcnpwZGhDVlZlcTFtdnpB?=
 =?utf-8?B?WjFqbG9DNHBoa0Ixb1JkTGovTE81ZGwwQnh5dXZZTlRWWmtUdkxEeERTZ0dh?=
 =?utf-8?B?RmM4Y0FWVnBsRmlQOStueWE5djRPd0pSc3R3ZW4vdnN4cThBS3ZPNmJLR0FH?=
 =?utf-8?B?ZlFrVFhRSisrTWFod0c0eFdCbXRrTDFHYW80VVJ6ejN2Q0s4cDRiR0dUMlJE?=
 =?utf-8?B?YnFSMGVoQ3R3eUdpZFNuUVo2M0pPY3llUC9tT044YmI5cmNRRGF6TkFTTlht?=
 =?utf-8?B?eFd3VklwT3VuUDU4UlU0S01pY0Q1RzBZcGdBMHJRN0dETHBMMkZLT2pTL2t5?=
 =?utf-8?B?bk5FNERPMXdwTXc5Rkl0U1JtNENpY3BkMk1NV0ExY3U2MG9xcDVJQWJxRVps?=
 =?utf-8?B?d2ExK2dZNGN1VVBGUEtENnhwQ2pPOW9mdkIyUWtPaUcyQ2dXUUlmYW1DNGhV?=
 =?utf-8?B?V0QxdmFyZkpIMUR2RkRDK1FTR3pHak95a1Y0MUxhT3BVb0Z0dERqOS9zRkZC?=
 =?utf-8?B?UmlOYzdNVWlzYVNGVWV1K21JUE54ajQzUmdFSnIxQ2U0dEs2Wk5sT0g2WnBP?=
 =?utf-8?Q?l1Lr7/Qc+O4f5fzSwVop3EoZx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a4b54e-c371-4f07-4e62-08daef75aed8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 23:36:35.4500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E14jIJPcZPzeFfBaWDbB9z9dg7nSY5N9fSz9ecdRcIzVFZlMN6v8EkY1SR6/nNtoja9RgHUnX59kPJvWUaHgEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5823
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/23 23:04, Nathan Chancellor wrote:
> On Thu, Jan 05, 2023 at 10:11:09AM -0700, Nathan Chancellor wrote:
>> On Thu, Jan 05, 2023 at 10:34:10PM +0530, Mukunda,Vijendar wrote:
>>> On 05/01/23 21:23, Nathan Chancellor wrote:
>>>> Clang warns:
>>>>
>>>>   sound/soc/amd/ps/pci-ps.c:218:2: error: variable 'ret' is used uninitialized whenever switch default is taken [-Werror,-Wsometimes-uninitialized]
>>>>           default:
>>>>           ^~~~~~~
>>>>   sound/soc/amd/ps/pci-ps.c:239:9: note: uninitialized use occurs here
>>>>           return ret;
>>>>                  ^~~
>>>>   sound/soc/amd/ps/pci-ps.c:190:9: note: initialize the variable 'ret' to silence this warning
>>>>           int ret;
>>>>                  ^
>>>>                   = 0
>>>>   1 error generated.
>>>>
>>>> Return -ENODEV, which matches the debug message's description of this block.
>>>>
>>>> Fixes: 1d325cdaf7a2 ("ASoC: amd: ps: refactor platform device creation logic")
>>>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FClangBuiltLinux%2Flinux%2Fissues%2F1779&data=05%7C01%7Cvijendar.mukunda%40amd.com%7Ce9133748553c4463824d08daef4317c1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638085368693977265%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=nDmZXCJR%2Fwt%2FautwTwcZostLvRtUrEbYV2l7M2W%2FTD0%3D&reserved=0
>>>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>>>> ---
>>>>  sound/soc/amd/ps/pci-ps.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
>>>> index 401cfd0036be..f54b9fd9c3ce 100644
>>>> --- a/sound/soc/amd/ps/pci-ps.c
>>>> +++ b/sound/soc/amd/ps/pci-ps.c
>>>> @@ -217,6 +217,7 @@ static int create_acp63_platform_devs(struct pci_dev *pci, struct acp63_dev_data
>>>>  		break;
>>>>  	default:
>>>>  		dev_dbg(&pci->dev, "No PDM devices found\n");
>>>> +		ret = -ENODEV;
>>> ACP PCI driver supports different configurations. As per design , even  when no child dev
>>> nodes are created , ACP driver probe should be successful. ACP PCI driver probe failure
>>> causes power state transition failures when no child device nodes are created.
>>> We should not return -ENODEV in this case.
>>> return 0 is enough in this case. No need to de-init the ACP.
>> Thank you for the review and input and sorry for getting it wrong! I
>> will send a v2 replacing 'break;' with 'return 0;' shortly.
> Actually, I re-read your message and looked at the code now that I am
> back in front of my keyboard and I am a little confused by your message.
> Should 'goto de_init' be replaced with 'return 0' to avoid the call to
> acp63_deinit() or should ret just be initialized to 0 in this block so
> that the call to acp63_deinit() still happens?
>
> Thanks again for your input!
> Nathan
'goto de-init' should be replaced with 'return 0' for default case.

-
Vijendar
>
>>>>  		goto de_init;
>>>>  	}
>>>>  
>>>>
>>>> ---
>>>> base-commit: 03178b4f7e2c59ead102e5ab5acb82ce1eaefe46
>>>> change-id: 20230105-wsometimes-uninitialized-pci-ps-c-3b5725c6ed31
>>>>
>>>> Best regards,

