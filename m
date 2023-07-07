Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1702F74AC04
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 09:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjGGHgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 03:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjGGHgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 03:36:48 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2056.outbound.protection.outlook.com [40.107.96.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE2B1FCE;
        Fri,  7 Jul 2023 00:36:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFy1vUD5Wb2iNT/OAzvxtDwMWGCAOZZNn9l1Kie6fBryll19bOLB/YdM4l+oGcxd9XMP5PECDnSsmo2BlffQpkkJWz7i4jGbyJEmqP8d7DYLzwjpOyRjfkZ/5p7CTlBurOygxT0MO+6WA+SOVpM8cY53dVVi65gv4KM5IUZx9qLxdlqoPWN9ZqbYDsOb88cMlFHtLoEyNmO5+NPiBG9Y79PVO5JoqaFX+ShE8ZsMzkRZLDmt8p5fBTm9ib1RWC8Tj+KMVnZybdbSW3JxTVQLf8wONnqXWEm3edOHwr5ymKLfyn8AYnOknYUm8rpmZrtjHqj96kPu/+DehsHIvadrhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Io0DUSEnSt8wAAkRQm8EqBLbCK7MNAGjygi4YeaSSw=;
 b=Kv42v5023DNOeotn9wrWZsDIvA0tmAikAEKcUu87VtafBZy5h/emeNhQ3aqkTNTVCY/4+CpmwOsnGA5O0pp/7xyg8PhbG0EDSIn4auD88ruMcmbRYbeQ+eB8JIhwkAgKPt0FvE3O8CCF9v8OUldgMShH6yK5OwrQNFzsTzsjzr0ZbAvAaKJt6eOJp9gcddFrRgE+9SMZx/fpFjZ2WgEsXsWKyuIcC55I54uEHQzPOpVt7EHC7PdRRUH5tKRh6oE84VN9itJ91h7pqOA600r9+T/hk5HL6h1ONH5mzY9XdrS4G9FE7TxC/QQ82ruNSxtPxH35seQmsYzKqYa8jufx9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Io0DUSEnSt8wAAkRQm8EqBLbCK7MNAGjygi4YeaSSw=;
 b=sfzikSV2QmjAcZiOO+q5g5mdY3xAI9hnKaSXK5rJsyJbzHg53aXeaKRkptwg0zssO/dPf7mxeuwnNG3THDUzHWpmOZmMm5ABTgZq2YqBDfclz2rHWI+tOCNRHU+Z7+eyEKYYFCoNm9GqDhPgXA0xKRhNGabhplt2Vl/5+5RtLkU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SJ2PR12MB8831.namprd12.prod.outlook.com (2603:10b6:a03:4d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 07:36:45 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fe3:edc2:ade4:32ea]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fe3:edc2:ade4:32ea%7]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 07:36:45 +0000
Message-ID: <29b68182-cb58-6a3f-0fdf-b919851e5524@amd.com>
Date:   Fri, 7 Jul 2023 13:06:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] HID: amd_sfh: Increase bitwidth to avoid
 shift-out-of-bounds
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        basavaraj.natikar@amd.com
Cc:     mario.limonciello@amd.com, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230704081724.2308195-1-kai.heng.feng@canonical.com>
Content-Language: en-US
From:   Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20230704081724.2308195-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0133.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::15) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SJ2PR12MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: 517ba5e7-d1d5-4f57-42f7-08db7ebcea53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vxsrv4PL0hCCoqZIeKwFfCqorva+MALCWqHBy+l7ZRFxKmxVAGaDNwwDHvBc+ybarQ6Q8I5LN7zWPM1xpUXQ6UXQ0Fk7O+4goQYgToo+5+MKbrd2gNpKRRL2GSycP7I994Ml2lLECiUgiavShNKSA00YHSDcLvLdq9AIF0sAxet5EdPQmeockeD2o40JUY7UBmpwwgla1LMfHbeGFRzwTU0BukheLbOd4AS7eiYVN5f7h9GUbPXfMBA9BF8B/RqZQ+T60Oy02NexaIfaliXb/0sIAiQpbd7EE94UrJ+/eX0dNIUTOwD+wDZOxVd+Fvs6wGQxYoVoWYeJc+HAJ3xSe1ZE5vamDZnu0YCT8pTSs3ZNPHrLrUoXUOEX1NgXKoizQSb5S/8ZjdP4UGqieM8Zxjd9dCbgDxiTLS6Ua8M+K8tqb4IsLkrI/2NDuYreJtAWlSvDQs2cg1mTFcGw723aglKFO+ayA3thNy2A8R6gPxGVr232DOY4etZhQTZJx6g7xGSsxZT3TTmbQK7/OjvE93M+bdHYiyToyVeu5puGfrud/W2PjICcNhgTnsZAJGYT2hSIqHkX4ris0rTCEb/MXYFYKms//Ktsof8wGtAu+WNipgPXtbRIs7T2MsDVPPuERE3br+zGrJ8HyoNw6tgne5eVkvkqrpo+x6VKOoTksTI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(478600001)(66946007)(66476007)(6512007)(38100700002)(6666004)(6486002)(54906003)(66556008)(41300700001)(8676002)(2616005)(8936002)(26005)(316002)(4326008)(6636002)(83380400001)(186003)(966005)(6506007)(53546011)(31696002)(5660300002)(2906002)(36756003)(31686004)(3903001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWVJWk1VVEVuaVhaTElkQnFhUUoxWE9tcHRSMmFodm1DbWlVUWhVM1VLSEpD?=
 =?utf-8?B?Mi94Qnk0SjVaQ3hRVkxWVlY3Y1FOa1dvZkUrTUVjaEhGV1hLL3hkS3Z0QVBL?=
 =?utf-8?B?aTJUc1QzYlBGUExrT2sxZUR6T0lJTEJ2Y3pOSGIxdDd2TUhiRG9XaW9scG40?=
 =?utf-8?B?Q1oyVXVCS3AxRTVQd210bVNtY3RCMEg3akxCK0liQ0hDeEF2VGFXMFkyam9B?=
 =?utf-8?B?ZHNJZGtWVTBUR3BZTXJ2SDBxY3RudE5zRThjL3gwU2JPY2h2SXIxVS9ackln?=
 =?utf-8?B?WlEwMDJwb1JQdVZwanJJeEZMWTZTZ2R2T1ZYSnpMV1VnRTg1RzBpQmRhcWs2?=
 =?utf-8?B?UkJ3cDIvRkg0SUVyQmhHdnFvcjgxL2E4VFEyQWN4SFZod092NWFTbGtRYTZo?=
 =?utf-8?B?VjN2c2Vaald0VWd0Mk5DUU93VkM5OHVIeUFwN0ttcGtEakhqelZNckEyRTBG?=
 =?utf-8?B?OU1QTEN4dVppK2wybE45SDZwOGF3aGQvVWhjYU5qYklmekp2NzI5eG5MaTBp?=
 =?utf-8?B?V0VNc3pNZWVKN0c5OEFEbW9aaWNvcG5RNmJDUGFFVVhNZXhROVRjTFR1aXF0?=
 =?utf-8?B?UnAyOWpsd0R2bDJNdGlrZ1F0NENrYnFEdVlVa3o2RnM4aG9nZ1FnczJNeDBV?=
 =?utf-8?B?ZkVQY25NYjh1ZTJ6OE9aRDNVaDZZTjU1YkJscFU2eUpnYVBQM1lnMHppMWFS?=
 =?utf-8?B?SzIvQ295WktIZFp4WW1XQjdJTUc2ayt3Vk1NczdwT2ZURjJ0TDI2ZkIxTkVN?=
 =?utf-8?B?YTArcFd4aVR3TlUxVks3ZWhZN1JCZFhidFhpOWhVOXFvRXpvSmplVllSL3FB?=
 =?utf-8?B?bkZwOHJaV3d1elZ0QXlIQkh0cW1YR091dDJpRDE1b29VTmppZjhPWVYveWRx?=
 =?utf-8?B?ek9PbHY0N0RrNDVtTGxmNW9UQnNiK0ZqTlVpSFFRQ1VRR3BKVTdnSzJzVHcw?=
 =?utf-8?B?Z2d3REs5VS9naWJ3Unk3MDdrQWtmTWRFMndzbjVhd3Y5bVRrWXZiUDlsZHJs?=
 =?utf-8?B?bHFkYkgwQ2pJQW1zOCtSTlJaNXc1cUxIa1YvajhjTVFaMy84V3FZWTVrTWRq?=
 =?utf-8?B?YW5LKzVuSGdqWlUvemwzbzN4bVdrMnc1eG9LeVN6bjFHblp5ZEZFS05kZTZF?=
 =?utf-8?B?U0JKZUNTazVzc3hmZlZLWjR5RWQwNHRPUjB6K1N6T1BvTUUrY2xVM251V0Vu?=
 =?utf-8?B?YnRQZzREMDN4ejU1dlp3V2ptUEJDY1JEZktOSjdtNmVicHNpb3EwWW1vODJi?=
 =?utf-8?B?QUs2MEgwOTh2UWwxNTErc3Z2SHJpdUx2N2ZzZlJsekErNzFnR0hZcEhPaDhm?=
 =?utf-8?B?Y3lOeFcxa1FnQjA4bmx0bUw1NDdmcmdtZ2J6azVvOGVNQ0YxM0M4Wi90UjBD?=
 =?utf-8?B?VXp2ZFR2ejNHT251Y003UlNtb045RXR3eDNtaWU3K0JFN3RnU3NqOGhWWk1R?=
 =?utf-8?B?bmwrUW8rbmVyc0pGUTZ3SU1tU2g3bDVVaXpIMUNOT2Y4cG5BVVhEM0J1cmVi?=
 =?utf-8?B?YUlIKzFtVlB4RHAwWDlHYjZabFZmb2VYNmF3Y05VQ2dOQmo1cmlub2lvZ1Zn?=
 =?utf-8?B?U3lHL3h4UjBSTytSZGt5Z24wRmRtT2dsb000bHVJaVYxd0dwSEdZUm5ESVRQ?=
 =?utf-8?B?OHBvdG1iTFFZa20zUkRIR2ZoNHRTWWRJQnB6eVdnQ3ptRkxNZnJBdEs3ZVN4?=
 =?utf-8?B?bytaUXJFdDNJVlk1WFhURHZKQWV4bnZ4NTcwejE2ZklORHcwWVRHK2JXZjkv?=
 =?utf-8?B?VnN1MDIzODFyM1lESHp0QXB1b3JGdGttbFhiTWI5aGZ1RksxcnoweVFiekFz?=
 =?utf-8?B?QlZqbmRaQ1ltOFoybzRFVnF0OVFKKzl0NDJjalZreWFnMTFSSWhtcjNvLzNy?=
 =?utf-8?B?QSsyajg3emY4Z1dMRDh0LzJtdDVkTUtQWmt2ZDhacEJnM1NxMWd5Tk5KWjVE?=
 =?utf-8?B?ZXlvdXdHNnNmMzZteVhSbGVUNU5ZMW9WclEvMTIyMEZkOEVXSFVNTlhOcDFO?=
 =?utf-8?B?ZUJsazRFYWowYTJucjlLQ09BRldKMUNhUDZvbkNOd0xxZ0FSRmpwRGFJa2Mr?=
 =?utf-8?B?NFBlLzhaTXJRUmpsaDRPL2xQMnVlejczV2dEdlptRkI0czZIdnFXSFRMK3NI?=
 =?utf-8?Q?q1E/JApeEjqM6zyZazh4qBp5G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 517ba5e7-d1d5-4f57-42f7-08db7ebcea53
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 07:36:45.5147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zHk53xRpTwDU5wx/GpamOvrZgmcPHdyUerVG8HuuVSDwcYD/mVbv+aIMchcgY02r2wt9tZA7NjNaSh6q1dMs3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8831
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/4/2023 1:47 PM, Kai-Heng Feng wrote:
> UBSAN complains shift-out-of-bounds on amd_sfh:
> [    7.593412] input: SYNA3105:00 06CB:CEA3 Mouse as /devices/platform/AMDI0010:00/i2c-0/i2c-SYNA3105:00/0018:06CB:CEA3.0001/input/input11
> [    7.593541] input: SYNA3105:00 06CB:CEA3 Touchpad as /devices/platform/AMDI0010:00/i2c-0/i2c-SYNA3105:00/0018:06CB:CEA3.0001/input/input12
> [    7.593625] hid-multitouch 0018:06CB:CEA3.0001: input,hidraw0: I2C HID v1.00 Mouse [SYNA3105:00 06CB:CEA3] on i2c-SYNA3105:00
> [    7.664537] ================================================================================
> [    7.664540] UBSAN: shift-out-of-bounds in drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c:149:50
> [    7.664544] shift exponent 103 is too large for 64-bit type 'long unsigned int'
> [    7.664547] CPU: 5 PID: 124 Comm: kworker/5:1 Tainted: G        W          6.4.0-next-20230703 #1
> [    7.664549] Hardware name: HP HP EliteBook 835 13 inch G10 Notebook PC/8C10, BIOS V83 Ver. 01.01.09 06/05/2023
> [    7.664551] Workqueue: events amd_sfh_work_buffer [amd_sfh]
> [    7.664562] Call Trace:
> [    7.664564]  <TASK>
> [    7.664567]  dump_stack_lvl+0x48/0x70
> [    7.664576]  dump_stack+0x10/0x20
> [    7.664578]  __ubsan_handle_shift_out_of_bounds+0x156/0x310
> [    7.664584]  ? sched_clock_noinstr+0x9/0x10
> [    7.664589]  ? sched_clock_cpu+0x12/0x1d0
> [    7.664594]  ? raw_spin_rq_lock_nested+0x1e/0xa0
> [    7.664597]  ? psi_group_change+0x237/0x520
> [    7.664600]  float_to_int.cold+0x18/0xcf [amd_sfh]
> [    7.664606]  ? __pfx_get_input_rep+0x10/0x10 [amd_sfh]
> [    7.664611]  get_input_rep+0x241/0x340 [amd_sfh]
> [    7.664617]  amd_sfh_work_buffer+0x91/0x190 [amd_sfh]
> [    7.664622]  process_one_work+0x229/0x450
> [    7.664627]  worker_thread+0x50/0x3f0
> [    7.664629]  ? __pfx_worker_thread+0x10/0x10
> [    7.664632]  kthread+0xf4/0x130
> [    7.664635]  ? __pfx_kthread+0x10/0x10
> [    7.664638]  ret_from_fork+0x29/0x50
> [    7.664644]  </TASK>
> [    7.664652] ================================================================================
>
> So increase the variable bitwidth to solve the issue.
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
> index 6f0d332ccf51..550639ef8bfe 100644
> --- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
> +++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
> @@ -134,7 +134,8 @@ static void get_common_inputs(struct common_input_property *common, int report_i
>  
>  static int float_to_int(u32 float32)
>  {
> -	int fraction, shift, mantissa, sign, exp, zeropre;
> +	int fraction, shift, sign, exp, zeropre;
> +	s128 mantissa;
>  
>  	mantissa = float32 & GENMASK(22, 0);
>  	sign = (float32 & BIT(31)) ? -1 : 1;

Could you please check below patch which covers more scenario's and corner cases
for UBSAN: shift-out-of-bounds.
https://lore.kernel.org/all/20230707065722.9036-1-Basavaraj.Natikar@amd.com/T/#m67e0b7aa6a288ea074b3bfa61e7f085f7e036172

Thanks,
--
Basavaraj

