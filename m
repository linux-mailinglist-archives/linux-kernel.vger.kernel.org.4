Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801CD5E6EB9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 23:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiIVVoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 17:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiIVVoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 17:44:07 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584DFDF042
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 14:44:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/UqcmnX7BkLOsJAdDvWfiur3JQ1SM1SMsWnexUWcY/eyYj/D5qdkoXG1HKwz0LbADNfiDjwuaPLHrOGg7ndNvc5A2C856c0/WZuBvBZybAqi1QD1iQ/fc4mQXdY4EKi38u9MQ371Lb2vFKTsM61gahMWOIP7VX8+/2NO3jaWu8aR40LLPKbCL4gQ/AC+LubUSATp8mlYyEHUR8720FjpDWZZR1LZAJccuq9GG9r9T8cMRA7L+Qrpxe6YTH3NQJlI7SH7CtrsMDKM1Dt1ecKrXjJwWnMUYScwPmESX97lJ9+LVzK0XjB1JkZWElHoCWcJ1qi+eIivx1rREhpviyrQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+9/qnkmnGualSbWWuygU0Pbyxrmqdt6Qa8S4fJX4ho=;
 b=oVrnznrTrFpUmHHFL4AcnAZ/zVHMxnlvDyDJujpuPF/FMtZ+18DWEkjSyPtn1GB3sJ0vcGJTyr0d+11badJjlKjexwPcEGuyoANWeYPURO8INnn2HGrAOUpcAwxKlKSn1zMX/i++se+r8ZcQqUxsQxijJUQiEhWOjOCGm7aNzs5pEGxU9E3ttu29n3rAzqwUK/bAzqv5GLK6P9q42P1667LM21cIzrfRJUpEW6c+B5sEUTb+mDV9hrmE8kXfp5lFmXN+Ue9UYdYNmAtjlsGtvbYtKP0HomnzHQwo0Fn1xm+M7x/d+SAPGnbnKu1UmwWNFp1R/1Z8BOTL0A9hvGCCKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+9/qnkmnGualSbWWuygU0Pbyxrmqdt6Qa8S4fJX4ho=;
 b=FXOdoTxCpsknM5pVW+IGGzr/56sw2fea974oBSfsjeZLLRTcehiMTfCpWSXHwaP2j+c179/LikGXKLCDoNeU3LqKm/duEYi3UqUQdO3Ve18CnptbiWr91OnCHtg7BU/Kv0ectyGaxeJ4kVmOyY9C6K6ETSkmVvCEjXeBkH9ETDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Thu, 22 Sep
 2022 21:44:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3%7]) with mapi id 15.20.5654.017; Thu, 22 Sep 2022
 21:44:01 +0000
Message-ID: <a0e87571-3157-71f3-a489-be69f7d23656@amd.com>
Date:   Thu, 22 Sep 2022 16:43:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: linux-firmware signed commits; does anyone care?
Content-Language: en-US
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Josh Boyer <jwboyer@kernel.org>
Cc:     Linux Firmware <linux-firmware@kernel.org>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Peter Robinson <pbrobinson@fedoraproject.org>,
        Takashi Iwai <tiwai@suse.com>, contact@laurentcarlier.com,
        mpagano@gentoo.org, Jared Dominguez <jaredz@redhat.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <CA+5PVA5ymJ-ghhhCfEBPxBynucF3gD+nHVNwcZkC5bsVotatDQ@mail.gmail.com>
 <CAO-hwJJY+sRiHX9KWqTAuR7Q8=3J8vu=FneusRago87uQYSxfw@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAO-hwJJY+sRiHX9KWqTAuR7Q8=3J8vu=FneusRago87uQYSxfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0016.namprd18.prod.outlook.com
 (2603:10b6:806:f3::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4286:EE_
X-MS-Office365-Filtering-Correlation-Id: 6571548c-163a-45f0-63a8-08da9ce38fb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 99jBKtsHX6/702Z4Aw3cUGj4Xmu7Ra4HuoBQa3gSYuE7qgoXIeRGbpybyK+jBXsL8ousFfx82hmj01/Dbk9W3cBv3KJfvtLeKJns7Xx54vzVzA/8qb2xbVFWYIv7g9ugaTvw3BY52ukPZYxAShn+E57Sixjkbm2D5tPScYaamj59d7s0dgAwMfBTjcPZAIpJtGldcDLjWdrPAOjV5zArombiC5rj30YjXCztZ2Ylq1NIRnkijaikiKjO9QM2hZ0J6WZ65utliOzCwPp9E5+tWkjuTV8D3NHCKuXSTjUrWF1hbe59D5J6W8N//8Es8YqApP83bMIslXxeXdlhpxnNSvQ7a/NZFsOSvIqPmVz9HzimbU59/E8L9Cv5jILqmd30zvnc+93uKZMOzqp+1NvaaKuZyXQC6VyT8vJdIlf2gE1kCLBvAhzXTiXxM6PnZkmqBve8S24Q9M72KRWORLth5/7ORyF8KNaboeKMkjKIQye0dnooy3rvZZJIk5NnFRIxchXzR8MNhVkh7ATsR86CepIrMvwsQh5TEwrWymwPYwuOkAWCSFFTRvZ0BG7T61kxEMDz6IucwXdpWS3vUALMbgY5Hf7m70dvtMxjl9GaVdb2SSM1SSE+lyuNENzhltwRStfQGjqNJGbbADNOfv6cQC2yiHpueRpmKUS2OKgjbPGoI26EXp1T05GWpHWnr/gpJUHw1GpxFdZP8g4KH4fdpBoqAwzantNcrJG4HY6XdnY2wl2C2BgXND9jdiPXKcDPAuNNxHxVg3GXg5lv1pcEt+VIgoGNiCYXe1duhyVh8YU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199015)(2616005)(38100700002)(8676002)(186003)(31686004)(83380400001)(6512007)(8936002)(26005)(6506007)(5660300002)(4326008)(36756003)(53546011)(66899012)(6666004)(2906002)(316002)(41300700001)(7416002)(66946007)(110136005)(54906003)(66476007)(478600001)(6486002)(66556008)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzY5OTBnRDNoRTNCQ2xUN1hkWXdQdFdnN1c1Z25rcjRjQzV3aDhvRzBQejZS?=
 =?utf-8?B?YmI4d1JiNVdWRUxCdzNuNHFZWkVEUHRtMXY2MzNZZ3VzYjhhTC9Ca3Z5WExu?=
 =?utf-8?B?cVQyV3pzaDJqSGphZ3k2Q2Y1VjJKd0VZUmRaUzJTbkhzSzlaaEx5TThDSzVX?=
 =?utf-8?B?MHFDYnBtdzIxTjJZcXVBbXgzdWJUUVpma2VpZ3JwbnJ2TU9hanZDN2w3Z2JP?=
 =?utf-8?B?OHFtRFRiT1Rnb0RlN0tKaUZVb2dRWUxiemoyNHk0aVJzZ3ZIeU9aVmJOQTZJ?=
 =?utf-8?B?bWFOWVlmYnNQOU5qUEZMVnJnc0lGUkcrMktiMjFmbEVycFh3dUZpNHRSQkx6?=
 =?utf-8?B?MFo5RDh1UmcxY2k1dlc0ckR4SlhTejdSVmZwNk80cC9jc1BTb3VCZGdJMFBU?=
 =?utf-8?B?bDdSVGMvbHM0bUpjeWJVR253NnZxcjVSZmU4cHZEVVNhb203VWpxUHFMSUk3?=
 =?utf-8?B?czZjMWo3STVCMXkvRkVqTjNCMUZPTzUrbEwwOHMrMmtIcGVRL1pkRVZ2T0tq?=
 =?utf-8?B?bm83djBmL2IrS2piNzhQa0VNeC9leGtqSm02Smp3Q3hyN0R3T2xqTmpFSm5M?=
 =?utf-8?B?U01ISTEvTDhoTmk3cGZ5Q2RXUFo3cWgrOVpVSStrVUdnRHBJam42N3ZEcGIz?=
 =?utf-8?B?WldPU1FTYm1DTE5JQ0E0YXlZNCtoS05rbWpiby9SVmhDNE5LWWhwRFJMZ1Fx?=
 =?utf-8?B?RDFoclU1UkI3VkVGQnpQd1ZBQWNYVWFFZzl5RDg3RUdSNnd4bzBKUThuVWRR?=
 =?utf-8?B?SURxb1Zjc2ZsOCtHTjZqV2pYQTRjWURxeDZTUE1IeTA3VHFiMzdyNHpRdnoy?=
 =?utf-8?B?T0hkV05GaWhzOVROb2EwZ1J4VThxL2FZdE9LRTZHa3JqWC9nN3g4SGN6djMz?=
 =?utf-8?B?RzlwenhKeDZiOXNjTXRmRVV2cFRNRDRqSVV0QVNxamdmN3ZyVVIvZC9XMkJs?=
 =?utf-8?B?UkZJZ1JydVVRTjNRYklQUmtpN29yV0c4NldVQmRJVi9maXRFMDdMWURHeWQy?=
 =?utf-8?B?dVN0NWVQK1ZYVjM1c2tid0RodUVNSWM3L2dvMkNOOE8vNGZTa09VME1KZFh1?=
 =?utf-8?B?U3g2bnloTlJrbThLc0lET2NaMFV5bFJuQ096ZlpmaHZkVWwzRmIzUFVlQ3Ey?=
 =?utf-8?B?czlUNURTeWtuOExXSFJoNEdaNWRQNG16Y1l6RmNHaERDNHh0Y0N1alNrQ0d1?=
 =?utf-8?B?ZFRzbE4vOG8yK1ZRT0xTK0lVV3ZoZGFSVEsvZXhoSXVWZDJLSEpuVlRZTUds?=
 =?utf-8?B?amtLNlN4azIvdXN4Q3JUZ3lLbGNzSGhiV0J5UjFjaWlaUG9hZ1hLYXJOQys2?=
 =?utf-8?B?VHNIaWVrU1FhNmRuVXE1VFYzZDc0Q3VsOVBUMEVoTnE2UU45c3VZOUdIUWVJ?=
 =?utf-8?B?TWZTNFBueFV4YnpQTTU3MTcwamZmbnhHQkZvamVEa01rSzFRSmhabEJNVzA5?=
 =?utf-8?B?eUE0bDNQbmwvWGs3Qjk4WG91cTVCSkxLQkZvWTdCR1JhRjVRNks3TDlZYmFk?=
 =?utf-8?B?T0xBcy9IMGdwbDR0Q2puUE5nRFlNalM4NG9RK1oxbzFnVnZYYUVNeVZIMDZo?=
 =?utf-8?B?L0lGc2ZhdmorMndaa0kzWVdXTG9lRytNOEdROVJIb2hXSGlYUzRXSS82Q01D?=
 =?utf-8?B?M3grV1JZN1FWcnJ5UjVqMTFsN2pZU2JKcG5IUTFHRGhJYk5yRWVJdFdKL3hh?=
 =?utf-8?B?VG9SS3FLNDl1YXdtV3Exa2hQd0ZNVTgvT2F4QkFMc3p4dzE5OTlIVXpOR2Jp?=
 =?utf-8?B?N0pHZFU3WU1kSnU1d1pac0tzVWViZmZ4U2JPbUZScm9CTDEvR0NrajU4bEhu?=
 =?utf-8?B?UzFPTWlpMGFmZFhuSkloaXRjbWZUcHJtdVptRElEVFduaVByWnNGU0RqUWxX?=
 =?utf-8?B?ZzZJMnlKdDRQOSt1R0h6MkxFMks0Zms5d0tJaVpsSjZJNHhUNmtRQUlUN3V6?=
 =?utf-8?B?NjcrUDV1U0hnUFFlaU5MUUQ0NzhSbXFRNGZ4Wlh6cEN6TVA3U1hSbTlvSm4y?=
 =?utf-8?B?ZkxvUEVJSzdJTjlOMWxHYWJzSVIvSlN0TG1tbzV4dlQxeXZ6QzVORU1BYTAy?=
 =?utf-8?B?ZUxUR2kxRXdBbi9QdnlxRWdWVEJZQWp6VzdZL2ZDbzRlZDhic1NNdWVEdUYr?=
 =?utf-8?Q?UaTPIPv42NACupK01R18lFdBk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6571548c-163a-45f0-63a8-08da9ce38fb0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 21:44:01.0119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JfZkJQO/3mJmWdkChPILrSneMSwXGGMRRay+O0oDuT+JMU9P/fyi9TKmfB0H+mS2Fv6wX8B2uFZUe8LMhmH4Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4286
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/2022 05:17, Benjamin Tissoires wrote:
> On Fri, Sep 16, 2022 at 3:33 PM Josh Boyer <jwboyer@kernel.org> wrote:
>>
>> Some time ago, we went back to doing ~monthly releases for
>> linux-firmware primarily to help distributions package firmware in a
>> simpler manner.  We GPG sign the tarballs, as is good practice, but as
>> part of reintroducing the tarballs we also started having a
>> linux-firmware maintainer GPG sign *every* commit done by a
>> maintainer.  The intention there was that because we're dealing with
>> binary blobs we really have no recourse to see changes unlike a source
>> code repo.  The signed commits at least provides a measure for
>> interested people to ensure the repo itself is only being committed to
>> by a recognized maintainer and it isn't compromised (in theory).  The
>> downside is that pull requests are merged non-ff and we wind up
>> signing the merge commit.
>>
>> The question at hand though, is does anyone care about the GPG signed
>> commits?  It's not clear to me this practice is even noticed nor if it
>> is bringing any value to this project.  Since we've started this
>> practice, I am literally the only one committing to the repo and while
>> it isn't hard to do I want to know if it's actually useful to anyone.
>>
>> I ask for two separate reasons.  The first is that a group of
>> interested firmware submitters is looking at modernizing the workflow
>> for the linux-firmware project and moving to a merge request workflow
>> instead of submitting giant binary blob patches via email.  This would
>> allow us to put some CI in place for simple checks to the WHENCE file,
>> etc.  Doing this while still having GPG signed commits isn't
>> impossible but it certainly complicates things a bit, and would likely
>> require a trusted bot to sign commits.  That has implications on
>> secret storage and changes the dynamic on trust levels that make the
>> whole thing even more questionable.
> 
> People already are saying that they do not see value in GPG signed
> commits, but I'd like to add a few bits here.
> 
> As Josh said, the idea is that we modernize the workflow for
> linux-firmware by automating what can be automated.
> The first thing that seems to be possible is automatically merge
> submitted MR assuming:
> - the general CI tests are passing (Mario already has a few sanity ones)
> - the commits do not touch WHENCE (so we have a reference on who is
> responsible for what)
> - the commits are signed by the maintainer of that said blobs (which
> would be matched against the WHENCE file)
> 
> The idea is that if a maintainers of a blob submits a commit and signs
> it, there is no real reason to not merge it ASAP, given that we can
> always say: "well, it's the fault of X who is responsible of this file
> and who signed it, so we know it's actually X".

But as a counter-point, you can accomplish a similar-ish outcome just by 
the fact of using Gitlab.  If you're using Gitlab, all the blobs will 
tie back to a Gitlab user ID.

IDs can be added to an allow list of contributors that are allowed to 
merge directly.

You have the possibility to worry about someone's Gitlab login ID being 
compromised, but that could be mitigated by requiring everyone on Gitlab 
to use 2FA to interact with the project.

That at least to me feels like a good proxy of proving someone's 
identity without the pain of GPG signing, verifying GPG, and the 
logistics of the bot.

> 
> Then comes the question of maintainers signing commits. If we ask
> submitters to sign their commits to have a fast track, it makes IMO
> sense to also ask the maintainers to sign their commits to show the
> way it is supposed to be done. I wouldn't care much about the
> automated bot that would merge the commit. If we need to have it sign
> the merge commit, we can do it, and this will only give the
> information that the process was followed.
> 
>>
>> The second reason is that even if people are validating the GPG signed
>> commits, it's not exactly user friendly.  I've been looking at
>> sigstore and recor and that might be a better solution in the long run
>> if we do want to utilize something like the current scheme.
> 
> TBH, do we ever need to validate signed commits besides in the CI case
> or if something wrong happens?
> 
> To make a parallel, Linus requires people to sign their PR, but he
> doesn't need to sign his commits. Because whatever goes into his tree
> is from him, obviously him. However, he requires maintainers to send
> signed PR to ensure this is coming from a trusted source. So he is the
> only one caring for signed PR, and we just trust him.
> 
> So in our case, if signing for maintainers is not too much of a pain I
> would say:
> - to automate inclusion of blobs, we should ask vendors to sign their commits
> - to show the way, maintainers should still sign their commits (even
> if no one cares)
> - the CI should verify who signed what and if the signature is valid
> - end users only care about the signed tarball, that they trust the
> maintainers will build from a tree that is trusted
> 
> OTOH, dropping the signing of the merge commit from the maintainers
> would allow them to just hit the merge button in the UI, which might
> be a simpler thing than having to forward that MR to a bot.
> 
>>
>> I'll still GPG sign the tarballs, but I'd like to propose dropping our
>> current self-imposed requirement that all commits are GPG signed.
>> Thoughts?
>>
> 
> I hope I didn't add too much confusion :)
> 
> Cheers,
> Benjamin
> 

