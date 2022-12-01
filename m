Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A48963F151
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiLANNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiLANNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:13:15 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E1D9E45C;
        Thu,  1 Dec 2022 05:13:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekDniIpfckkJkbQYE9zE+8/KETRYRXu1s+ZYchQwxEenI25Xwd/u9DeuHPcLyU6IdZsnX77tAoXQXl8VtLy18BPVN7KGWwPS3lJQqfvTekYE7lxvjz2AU9rAsCk50ufGQBRztDaQOyM+hFJUbwti5HMLtywhPXv4gF7c+lWHHDLzyA90fTnQVExbjChlJcn+ObuUndbjxIJhSFXe1Bs3F17UJd/NaHOuc9BQY/v3GxysalfDJshgLlisPicaEFQASDTH5hfiqddS2q76RejUg2goq+LI6+mxxVTBKAHNbK+gaI1w4gnQKNhpgSI5U6+KTrcBvFwOH8A3OyAF7152+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XG4GwZ4EvPoAGfTLfHRSljrxKIE3N8woq/hQNWURQCg=;
 b=OplAD1slDiW4NYtat8ZS7+iIeQ88ZEIaOYWDZ/z9U8/LixJNk/4t5CVklOSVArNZszPnwzBA1R7GsJfgRZpcQXoNG94W2c1lrtgGuO+dLIbBFEPXrk6MHLkI7t8DG1cEYj/+DydwFRWlH01zsVhz8KatL5IUFqhpuIVT5S+U/4lqwZJQ/5eNnpCyEegReDSiPSEDIvFsAY+RcR/B4YasxoVwxUm0F8AkJ97zNnddnrJGDOn/yPPz2BJ/zIgg2r4EHSppbW6zWepr/8jew2RGSXgyWYxP7U+x9mdWk/Dk766u9bsQZGP7ohN4UA+nA6r8vApVH00oM/pxgeVNIcE5gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XG4GwZ4EvPoAGfTLfHRSljrxKIE3N8woq/hQNWURQCg=;
 b=XsNF49X6hSn3y4Q37yg18dgkLdaJWtptF4o39Byz3bfquFHuf1MAbHWeuEovnh59POmXceJ6cpCA8iuBPFWp9I1YQATIKMM3+RWpD/6Vav+PFqvTAmAb3TgoVWHwm9utG1xbp2Xj2ZeRgDRrueaxaIXIlsdNuIE/7/ZutkclIO/ahEZHMxlAOh93OOSDyfKdBZOlA3neD8FkJl0YEJn1ftwDjNEn3sFYEeW96DYgXZ55zo9A+6KDSBtfYFWWY7Frm1KMLaX/eFqlGp79v+HWvd80MN4jMyHzcXpeGt/zqxOXcijA2qEWnp1s3PqquiWEVPKwdtKGliAvEe3FfKFCCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SN7PR12MB6957.namprd12.prod.outlook.com (2603:10b6:806:263::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Thu, 1 Dec
 2022 13:13:11 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f1be:5d:f297:e2f]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f1be:5d:f297:e2f%6]) with mapi id 15.20.5880.008; Thu, 1 Dec 2022
 13:13:11 +0000
Message-ID: <7df26319-f4ee-6dd1-a1b8-1caaf595528d@nvidia.com>
Date:   Thu, 1 Dec 2022 13:13:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] HID: bpf: enforce HID_BPF dependencies
Content-Language: en-US
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Florent Revest <revest@chromium.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20221130101021.1868764-1-benjamin.tissoires@redhat.com>
 <20221130101021.1868764-2-benjamin.tissoires@redhat.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20221130101021.1868764-2-benjamin.tissoires@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0532.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::14) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|SN7PR12MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: c01c3d72-a691-4f2e-34d1-08dad39dcbf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VIQHRCmjYEjCKTI24qcyJawm8OmLYjWH4F9/J4u8+b5mu/cs3sHB8n89rY+ReghdUUq94P991tsPwnla/GfVOnTD2RDKGga7T9ML6387YCqaQlFREIcjopVx1MuoX1Wz7C2w5vP/izfYGMJWRMjcF5HHvAC4Gte1RJ2zI5ewOpEPLWveaz7vEBDyttdnWEb8+P0r9h35ZFzp7sZq12Zcr4jMpL3V3b3EXIQzjbx9HT2UeRcUwqGAexBmgHjAl88/DaZG0JHD/qUo6mrRRvbKISx3yWMATVBLFuxvJBBWDUR1grXx4y3tO8GLn1xriTpzyc0bl1eemh4ny1AiY14N1ivNpvO7FTex+aj+1v/6Hmu+xJ2DF12EaIHlIZV2lxONL14cSPCa8G6JacCw23dIsGxNyyD2pqieRDWTd7IeJn22lj9eoJQee5gFvkDg+No4k9hwoMYQtzpjCBI+5T++1oGUm+7bDWgmupxWclGm/xDMGdNLnspbNvAixnbc82NEVR6XViBXylhDo3sTK4Nk0Hq6OfTm+7W/HfRYakHhsRTRyQMfskL/Ppfw4J8a7YIxfLBTxTgUWphJxzwmnO/A0kjA04VmzSnlC9DsEWAp9tbfmGVJZJLQ4Id9Y7Evfx45QKum9biBHgQo61gAGTMyNLuXzh+zgA/Xkl0yvIKl54xC58cz/7os0hy7ApL0Ec0wYPtZb05qffwFKFB7L1Ha1R2wuDd8fqhmN/DAyw3agiird/bugsTzVwtluhphXrUD1kLI928B4ziFidwyuszA21gJ3r0+pZIuqLlRkplAWHESklsmjhHQVzFyyKUmcDoB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199015)(31686004)(86362001)(31696002)(6512007)(6506007)(53546011)(55236004)(110136005)(478600001)(6486002)(966005)(36756003)(186003)(38100700002)(2616005)(83380400001)(6666004)(41300700001)(5660300002)(26005)(8936002)(66556008)(66476007)(66946007)(4326008)(2906002)(8676002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1Z0YVhGS0ExNjhUR2F0OFpNYWNMc28vZW45bldDMi9WRkZMNXlGUXVJQ2Zh?=
 =?utf-8?B?dWQ3MmE0MmRPQ2tDK3pZS3VPSC85ZG80VGh5VEx4UW1yRk5lc0ZEQll0UmFG?=
 =?utf-8?B?Yy85d1Arbkk3NjYrSkRCMEN0SjVkSTdMSkpXUTI4Q0lLcEl1M01Od3YvNVRT?=
 =?utf-8?B?a0I2TnlBQzVvOFRLTktIaFViOTArRkEyclovS2Z1c2g4djdidk9TendxSE9k?=
 =?utf-8?B?K2RCR1E0QVhJUkdZY1RTajBvWCtIZjV0bHRXNFZrM2czWDFIYjg1U1BSVmVS?=
 =?utf-8?B?NDNaU3B4cngrd3AzcWo4TnZvRnFHRVRFTUxoSXFpcEIxMi8vSk9aUFI5YitF?=
 =?utf-8?B?UTZCcjVVd255ejUvUTZwUXlTZmlrTU1pTlhHWVU0UnVGczdNUEcwTkNXOEVH?=
 =?utf-8?B?dWdnNjdCKzkvc0tRdExpb3Q4clJZQ2hic3c0SWRWQm05NHlRaDdJNE8rNTJK?=
 =?utf-8?B?Yi82aFVCMzBDd21lc29pcjI2bW92a2w1dVRpMnhoUnMzeUZHenpBQzgyMGQr?=
 =?utf-8?B?YWRsUGErQUt4ak9qVHgrMmVzSy82eVpPazdMNDN6MWNpa3lML0N3TVAvSmN6?=
 =?utf-8?B?Y2xwTXB1NUpDa2pBd05XWjl2T3VQZGp2ekR0T3hUNXk3YldUcUx5RDhIeGVs?=
 =?utf-8?B?MUREeERzQVhUb2RVQXJrVXdhWnpMSVBzckEwTUpDS3FkcVVKVndjRVBBRnQv?=
 =?utf-8?B?VTlVRUQzUGVOZjBjUEdTTzNKaXBqNC9KOW4zY0tjL1Fqb0wyVTdFNkI1ZUR1?=
 =?utf-8?B?UDNLQ05HOHByVWtTcGxGVTBLL2svbVlicDY5RzN6bldvM1JGWmZ3OTllaXR2?=
 =?utf-8?B?eC9XNHBLYjg3K0dDeHY0M1BSOTFZSXJ1TjF0aUMwTzIwZC9TREVUbml4bEU0?=
 =?utf-8?B?cW00c1lzNDlUbTBVTTBtQ0VWNW9QYXJJWHpTKzFMbjhyVSsvbEg4TDY1UnNR?=
 =?utf-8?B?SzUvNG9IL2YyMEVPamtFZ1pycklEaUNTMWhyL3kwc1dja3V2Tmh3VUVnUHp3?=
 =?utf-8?B?UTllYWY1RzJzbGtyRjBiV2FqTUVJbk4rMWp5L2NnZWxONjBvNFNaSUZ0aEZy?=
 =?utf-8?B?b0hGZ2VFcXM1MFZxcnc5WWhEd203cUE5ZGdEVitWcmsxR1U3U1laMDAyUDBJ?=
 =?utf-8?B?dlJuZzBHOS9NM3VCa2xKNFpjOTZabmpoSHpucVlSQWsyeEw4YVR0Qlp2L2hE?=
 =?utf-8?B?QTQ0MVhsOWxuZ3UvSUlRL21Mb0NiTXcvb01zRUlPZm42NytPTk1xR0hpVW9S?=
 =?utf-8?B?QTFNTlN4cDVqbFEwakluS1pzL2RJVksxdStMaEJBQW9rMXdzMDZKSU5VMS8x?=
 =?utf-8?B?Mkd3bVdHVkdlSEdaL0p4V1JoWUs1WlZJMi91ZXRaTng2dUJGTlh1WFBrekRG?=
 =?utf-8?B?cVNmaVJRd3BHS0tGTlp6V1RLeGVoWFl6NVFzWGtoZzJSM3FiOUVlYm9OYkVo?=
 =?utf-8?B?eFU3eXdXaC9peWo1VGFjQTU5Ykw3aEo1Q1oyWkcvNzRiVHpWTDViRTBJM2Fh?=
 =?utf-8?B?K2s5b3VJUDBrWmk3UzFaYzZFSm5ZcnVmTGk1YVdOZ0dlU3BCN2RqbGNrU0VX?=
 =?utf-8?B?MUw4eHh2cVg2VDQ5Uk9mZXhwT0NoSnFGZDFGUFV3enk0a1FqVDhjRXo4MFph?=
 =?utf-8?B?R3p2cklFSk1Zc1pLQ1h2TnBEamVLUUxqQmhrZzdmS2JvSE1tQ0NxMEFMcG5i?=
 =?utf-8?B?NlRHOFZSMFg4NUtUcWR6dDcwSHM5b0QyNkRpS1lOc2c1K0V5eUxxZE5NMGFW?=
 =?utf-8?B?MVQ2TDNESzdrSllyWmV6VlM3K0lzcEpUaGZLb3RLaFcvTEhZWjVUNGMybUhW?=
 =?utf-8?B?SzRQNzNyaHBOUXFBYWJ5WUs3NThUbHp0MWZEaVcvaVpkMEVGUFVwVTVLZ3pB?=
 =?utf-8?B?Wk9iSG9hWVpsVWppRjZUenhmUURtVXVFTzJjcFRvODh3QXJLN0JiY1RZTmc5?=
 =?utf-8?B?Y0l1Y2tmUXl6UGJ5UUM5d2RjbDErYllFVXUzU292QkNlVkhMR3NKd2s3UGJ4?=
 =?utf-8?B?U0ZxNXE0bTdESGdlQXk4TDY4NFdiNjltV2pzdE50ak5rampkR0V2aHlXM2xr?=
 =?utf-8?B?YUNwMTFTaE52Sld2OW9vaHY5a1BaOTFpL1BuZ0ZmRjhHaGJrNGpNTkZZdzdN?=
 =?utf-8?Q?JEO5pRSA5/5M01dqdJAWyYQOQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c01c3d72-a691-4f2e-34d1-08dad39dcbf9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 13:13:11.5372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WgDYPN0Vx82SbRmAMXuHDeaDQBMWZw7U3gdd9XT+1q3XoqDBqdY1JRu51by+ox/pTC0qY3mN02iDaYK2fBtUIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6957
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/11/2022 10:10, Benjamin Tissoires wrote:
> As mentioned in the link below, having JIT and BPF is not enough to
> have fmod_ret and error injection APIs. This resolves the error that
> happens on a system without tracing enabled when hid-bpf tries to
> load itself.
> 
> Link: https://lore.kernel.org/r/CABRcYmKyRchQhabi1Vd9RcMQFCcb=EtWyEbFDFRTc-L-U8WhgA@mail.gmail.com
> Fixes: f5c27da4e3c8 ("HID: initial BPF implementation")
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>   drivers/hid/bpf/Kconfig | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/bpf/Kconfig b/drivers/hid/bpf/Kconfig
> index 298634fc3335..498232f9faa9 100644
> --- a/drivers/hid/bpf/Kconfig
> +++ b/drivers/hid/bpf/Kconfig
> @@ -4,7 +4,9 @@ menu "HID-BPF support"
>   config HID_BPF
>   	bool "HID-BPF support"
>   	default HID_SUPPORT
> -	depends on BPF && BPF_SYSCALL
> +	depends on BPF && BPF_SYSCALL && \
> +		   DYNAMIC_FTRACE_WITH_DIRECT_CALLS && \
> +		   FUNCTION_ERROR_INJECTION
>   	help
>   	This option allows to support eBPF programs on the HID subsystem.
>   	eBPF programs can fix HID devices in a lighter way than a full


This fixes it for me!

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic
