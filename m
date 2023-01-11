Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D1366579E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238657AbjAKJgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238479AbjAKJew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:34:52 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A976311C2B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:33:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fO4ZcTulD3juFXjE+/spDnuMToC4wW8I3CWKQRJqEDtPD2/WdcFM09K6sLu0kHdvRym1Z0RN/oq+9IwuA07icT0CtzF+xGIktAK/k6xBNAgfQvbC20iiYntVmqpUSkQG8DGSjIUEfyzGJL8E2FWX6YohYdHG528n93Xrb0ITC8y/vleNiP9wJRozhKhB2tXzFNVxLgd8UFFKQhNaW8AQ3rto9rzBuLzXHmnMrW03j6BUQXfuUMKIxFQEqesDtCZgsTHvtCpf8VLyKj8KntxmYVaOXutWKGFkWy5JaIe51NRm6hBi1R8Vv0D46dcYa0m5dmJ07ItjBfe//2wZpGVDZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6zxCaArxcBfXH1vPQa04bpbGz6jysmcicB2EtMBcQk=;
 b=mZca1FDleQIKVFK5QVX5UrQTV/wiSEF0J85zOyApGG5wrGDjm/Vqozp+eHIXzPEpnm7KA8gLjwNumuohVOo5xiSjJZvt45cFmuuI20ZfP2XTVuGSmSEplRb+isKSVDQeov0P6ivN5R6LDhTSPCgby0XUtDYpf0OQQy3xibcbE8hnOwc+ntQwV01bJX+iN1UBhbAhKk6TvdCt+r/j2L+Y5bQKfaPEPf6KpQ1/tKvIgnbOvkxF5sq6M/wnxuKrjp8YkLf7yA8Yp1/WG5AatkC55sSX5W0IQv9jF4HewAmR0SkhxtWnQUT7yfd3dBM4xWIqb+XniLvySHRS791Q0xxnhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6zxCaArxcBfXH1vPQa04bpbGz6jysmcicB2EtMBcQk=;
 b=QdmQuSlLWVERSertoghZsxh2FRuRNlvVVuHB4sbdQuhNO/WbxdHEgeMmVOYING/fTqNI1ww0lco94JzavcXGuHDdzcXyRx+MpOqT4UXrF0CD7M4p3QkYFhqAgeprvsOoK7MfelZ+O7m9hd06Ql+A+51hPj7ZWClGEvVpm5cL8WU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4171.namprd12.prod.outlook.com (2603:10b6:5:21f::18)
 by PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 09:33:23 +0000
Received: from DM6PR12MB4171.namprd12.prod.outlook.com
 ([fe80::b828:7c21:5e7c:5416]) by DM6PR12MB4171.namprd12.prod.outlook.com
 ([fe80::b828:7c21:5e7c:5416%8]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 09:33:23 +0000
Subject: Re: [RFC] Sound support for Huawei line of AMD laptops using ACP and
 ES8336 codec
To:     Marian Postevca <posteuca@mutex.one>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        syed sabakareem <Syed.SabaKareem@amd.com>
References: <871qo7fqjp.fsf@mutex.one>
 <598ca0a8-8aef-a030-7060-f76ba4700bbf@amd.com>
 <8349cf5f-1e26-f605-4404-978dbef9cee3@amd.com> <871qo2bmlx.fsf@mutex.one>
From:   "Reddy, V sujith kumar" <vsujithkumar.reddy@amd.com>
Message-ID: <ecd0bcaa-677f-aabb-2864-9f54a510f3e7@amd.com>
Date:   Wed, 11 Jan 2023 15:03:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <871qo2bmlx.fsf@mutex.one>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN2PR01CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::21) To DM6PR12MB4171.namprd12.prod.outlook.com
 (2603:10b6:5:21f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4171:EE_|PH0PR12MB5404:EE_
X-MS-Office365-Filtering-Correlation-Id: ca175101-b1a8-4973-561d-08daf3b6e246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wx7NbbJaCwdLkrZRgVIy9KeOkyx4b+7UQ/Xcsf2ENh1D2oybD2NYdmec8ByLBdEQjECeTj1YZmtoTb7KwgbtXW177rQqpVALIW3bi1nupwfKsggs9oDco7uwXL/pTJa5MEgUl9b1Cqxh7TNBxz9w7biIB9Z7IviJOj3nl32+VFy6sj7MoOKGMJq/QDlMroF211a0hewHEhFq8KOw6TLq8b/eSNO00hg8EZFeAqnRRLn2YNKMgTcG1sqLJjivAsZsQ8D+pXKvrZlj4+4KYuv0MsWTcyS7evv4ygtW1ybhWM5dP20Q+MJah3A0JS7Qx4FRYZBg6+we/jAe5aQiMrNKhy/2FKIMSHJJ3424Q+IXkc+cwjRaKBFcGGLSlXkbsliAvXcTX07CSAe5K5oHTpnfwFenqP7+IO5OwnvuxXc086vyWyU+08t7gFpNltCLaTZ2avP/AxVyw27puP8J7ezM5Di9xWQG9FC1Mxf7+K1B5uwI4dXpb4gGk9/FI0faQ+fpXa/4i9QhRsScM9tfEcB9wKiQTNEckhCWp5YC9Q856+zGLkiT7qbjy7xrqEIx2+e+5aDpFCQsAck/On5HuH5XOPvSVKFbvMxmSov2Itj/YzF89W9bfMz7/BAWiR5wBqlPg9k180fMYbkq2gbLPhxqLlVAFaWZlmH/kStxcaD/EWWGzb0y9DOmPFtfOdOpgiTAUTszDhXt+hgCpxILDLIJ8jxy+DWmN9nvYcv5kg+ZZPfNK4frlTrkToFkOXaFgzfVUJZpC6hGeNV2+kq0dEC+7NvfHytN/atOzut9Dms/Djw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199015)(6506007)(38100700002)(6666004)(84970400001)(31686004)(53546011)(2906002)(6486002)(966005)(478600001)(2616005)(26005)(186003)(6512007)(5660300002)(316002)(8936002)(83380400001)(36756003)(86362001)(31696002)(41300700001)(110136005)(8676002)(54906003)(66556008)(4326008)(66946007)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTJjZzZDbTNUcnVWMVphZk9xMnlTNDJyUUs3M3UvYjNXQWY1aGgvam1rTTg1?=
 =?utf-8?B?WHRYbnkxY3lqVFFEdVJMYzBwSCtnV1R4Z1BoRG5SSlBNTFd3L1U2OWNCdEw1?=
 =?utf-8?B?N0N6K21ISHBrYmVEUURCYlkxNS83emZjUXV5Z0VlQUxFdTd3Tm5hZXcyM3E5?=
 =?utf-8?B?OUZIZ0ZVVmFMQkdQSGpHUEk0dmtnRVhMdXl2blJyTFZnSWFpY1pMdHllTkp6?=
 =?utf-8?B?SmRqQmh1QWc4clFGN3AxQWdVWXhIWmZHYmxnT29GTHpJS0QxRk45WEV3eFk5?=
 =?utf-8?B?Zk9TNGUwaG0wT3dFbytwT2xqZWc1ZGVJQ3FnZW14dmRFMmtXY1I1dUJTdyti?=
 =?utf-8?B?VVJsUCs0OEwrKzc4b3hDQXN3SWhmYnhFaXpMN0owT0hrcXpRZzgvRG1Yckwv?=
 =?utf-8?B?UWtrQmdOazVkMmUxRzVCMS83ODg2a1NPbUdxekpFVW8vNEJoUzdQeWhyOEZI?=
 =?utf-8?B?TXBWWXVpS05uZE8rWXlsZjNYeE9LcXVKWU9zelNPTjJXYUQ4WisvMDhIVTE3?=
 =?utf-8?B?YU0xaytwdUZRd2gvaFE4bzJyNnlOMmE4NkFleVp1U1FHUXhYNVFsSGRWRlk2?=
 =?utf-8?B?UDhuVXhUWllER2s2cENSanR3OWJFeFdnVHk3UllVTlBGUjA3dHFSUUVRejJz?=
 =?utf-8?B?L1hJdTNESUhkVUFlRTNPQTZkdlJVUHI5c3ZjLy9ibVV1b3g1VGN0V2ZTMS9Y?=
 =?utf-8?B?akF4Y1JvN2duaHFsbWpDYW12RVdrQXYwbGc1ZEcwQUtHNE4xSW1xQm9BNjlV?=
 =?utf-8?B?TG1kUWdXSmJ6d3BIYmxOcFZpbmpOa1Q1aTA5T01abmhWS21VUG1vQW56cjVD?=
 =?utf-8?B?d1dldENCSTJ5N1BpL1VVcVQvUEJBQlRVd2RIWEhKY3pEK0w2L2IxTzJjUWlS?=
 =?utf-8?B?YjNZeUdRSWJFMG1PaVBHcm9RMUpvOGN4bUJiRTV0WjlpejNsQTFuZENsdzkw?=
 =?utf-8?B?OTYwU1o1YlhMWVFNRkJxUCtxQ0JPbG1xRXRZdlVSVC94b3VieWY5cGJiL0hE?=
 =?utf-8?B?WXNWZ01JQmI2dXpFYVAwNTUyZXVaRGJoNEw5dzJPTjA2czBCS1BQRDBsSEUw?=
 =?utf-8?B?Rk1MWHh5U3hwaTZmQjl6VnFKbGNVNjZOSXMvTTg3UStoaHh6VW9odlhVeENi?=
 =?utf-8?B?Yk9QRzRXdzZqbHFQMlB0RXVTYmFCMGlFRFM0N0h6SW1yKzU4cStvY0hXSWJX?=
 =?utf-8?B?MmpaTUdwVG54aWtmT204VktlaWtsMnVPYkVjd1pscnQydnh1eEN2QzYvY2lR?=
 =?utf-8?B?Uy91TS96U0kxeTNsQmpuSW1YWFUzanNoTXp4QnY4ZUhuTUJvS0syK1Q2Rldt?=
 =?utf-8?B?R25EejNVazN2UlgxdU5GSlFIWDFxTHh1R003Z1ltUHo3VjY0WHBydTNiOUVZ?=
 =?utf-8?B?Nld3b3hWcGJocWdpdVc2UUhQM2g3Q0I5Z0J2K2ZFajFmc1dDVXFwRG9Gekx3?=
 =?utf-8?B?VDYwcXJJVG9ZbUdYNE5JSStMejdRdjQ3QXlGbURnZVpwK1cxamxWSjIxcHVU?=
 =?utf-8?B?MFRna0x5eG9EMjAzRWRHSXU0ZkJ2UzIrM2preDhKZWxOMEliQSt4cVVISkRY?=
 =?utf-8?B?ZXJWV3JzbTVjSVVOcnZYOWtYeTFlbmRoek1MWmtHOXhVaDNIU1Z6ZU8rVzUw?=
 =?utf-8?B?OHBrRDF1V1VBMU9zRnVZM2VuNXQ4dGpWcFZmd0pGSWJJd2tnU2lidWhDS3dh?=
 =?utf-8?B?bjM1eHFpdUhESGM4enNJUzZqVnR6bUZYYk9GRzN3NXZsL1h6QUd5OU9zVnFa?=
 =?utf-8?B?UlpnMGp4NFRRaFZDeFB4dVRabWU1UWFjM25ZZ2Zta2Q2c3RQM1FKSXppMzhu?=
 =?utf-8?B?YkhQZmRKQ2l3MzIwUm8zQnVVWUFZcUJTMGpsOEdsWGtUR3I4bFE3TEM5bE5H?=
 =?utf-8?B?a3NlZnBVM25WeHlMNlhNcXBEOFBhR3UydjNhWjI1bm45b1A1WlpuWXdIWnlh?=
 =?utf-8?B?dC9UNVRZNjlKREhlQ2t6cFloMmRQVk5UY0g1V0pETDRSY3BEcXgvSlQ3TkZB?=
 =?utf-8?B?endYQ1JjVlhXeUNSckFnZHNpbEV5MG45ckJ6QzlaQmtnNmx0OVRPZ0lIc05K?=
 =?utf-8?B?cXBEYnpEWXFxR0pDbW0zZFhoNGVZS0FkWWpIeTNPWHNyWmZyVkI1SFN3cFlC?=
 =?utf-8?Q?ADRwWT2tkS5nDVJfu9k/63ZDy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca175101-b1a8-4973-561d-08daf3b6e246
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 09:33:23.3141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPpAlqV9pg4Zwo9ahC6mih8/mpLrpn8ujox+3Cz54GlT2niEE1xmy5KK0er7V/05
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5404
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/10/2023 5:57 PM, Marian Postevca wrote:
> Hello V sujith kumar, Mario,
>
> Thanks for the replies to my email.
>
> "Limonciello, Mario" <mario.limonciello@amd.com> writes:
>
>> On 1/7/2023 00:58, Reddy, V sujith kumar wrote:
>>> Could you please send  the error, we will check and let you know what is
>>> missing.
>> Just a guess here without seeing the error.  Is this perhaps because the
>> SOF F/W binary that was loaded was not signed with signature trusted by
>> the platform and the platform required validation?
>>
>> SOF on AMD was first introduced for Chromebooks which don't use the same
>> authority for firmware binary verification that general purpose UEFI
>> notebooks would use.
>
> So I compiled the latest sof firmware from main branch commit
> 90c14e56cb, and now it seems I get additional errors that I didn't get a
> few months ago when I last tried:
> [   38.251393] snd_sof_amd_renoir 0000:03:00.5: enabling device (0000 -> 0002)
> [   38.252944] snd_sof_amd_renoir 0000:03:00.5: unknown sof_ext_man header type 3 size 0x30
> [   38.252955] snd_sof_amd_renoir 0000:03:00.5: Firmware info: version 2:0:0-90c14
> [   38.252957] snd_sof_amd_renoir 0000:03:00.5: Firmware: ABI 3:26:0 Kernel ABI 3:23:0
> [   41.345068] snd_sof_amd_renoir 0000:03:00.5: ------------[ DSP dump start ]------------
> [   41.345080] snd_sof_amd_renoir 0000:03:00.5: Firmware boot failure due to timeout
> [   41.345085] snd_sof_amd_renoir 0000:03:00.5: fw_state: SOF_FW_BOOT_IN_PROGRESS (2)
> [   41.345137] snd_sof_amd_renoir 0000:03:00.5: invalid header size 0x7f841000. FW oops is bogus
> [   41.345142] snd_sof_amd_renoir 0000:03:00.5: unexpected fault 0x7f840000 trace 0x7f840000
> [   41.345146] snd_sof_amd_renoir 0000:03:00.5: ------------[ DSP dump end ]------------
> [   41.345150] snd_sof_amd_renoir 0000:03:00.5: error: failed to boot DSP firmware -5
> [   41.345266] snd_sof_amd_renoir 0000:03:00.5: error: sof_probe_work failed err: -5
>
> The kernel I'm running on is based on the asoc tree from Mark Brown:
> git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
>
> commit f8778e910cab179f5835386a0a70847921a8fbec (sound/for-next)
> Merge: cdfa92eb90f5 b11845893678
> Author: Mark Brown <broonie@kernel.org>
> Date:   Fri Jan 6 17:04:36 2023 +0000
>
>      Merge remote-tracking branch 'asoc/for-6.3' into asoc-next
>
> Let me know what other information you need in order to debug this.
>
As per the error in 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/soc/sof/ipc3-loader.c?h=v6.2-rc3#n204,

the firmware header was not proper.


Even the header parsing is done correctly, you will run into other 
issues related to signed firmware validation error as mentioned by 
mario.limonciello@amd.com .

So please Use x86 based implementation without DSP that is recommended 2.


