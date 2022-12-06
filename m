Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDDA64476E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbiLFPG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbiLFPGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:06:11 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FE42934D;
        Tue,  6 Dec 2022 07:01:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMVIVOZfO18Luj3gVRPuPoxe5p7TtF4zbhfSsvPHpitSYJlfNVWJbUGv9KHxcbva092vGzqt/F4eLqKWLzbNCdQXJGBeETDY3kxZHOzJt+69Mj/bmMqdW0LJiwVqyehaDQhIXMoGmC1JU1/PG3sfWCxJQeqB/No7iMVm8Gslsfl4AfLw7xbgIim1sSFrTFdngHZ49OE1t6UyncCcMM8vGnuRkzpkYPyhu8yUSxixaa9y+LROBjRQrT4TU927tf+BGoA2dTQsgySQ3VMIj0vcwgVV5YmzQe0mi8lyR8Nt/9TAqHHMYEUg24cYFYvumRQakjWdKvC2BwBgGjPl2oi20w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mzet6x3hrnn/X7G5ydxWVnQuGr8GAWvlngxhGifLsRM=;
 b=D7jKJfOalKzpeq5Yyvsum1fd188J/LXIjZXiMSYxO34IKxxyMLtQW7W0uSD3145WMW4x+/mqGVbCLWBFLdoyUC0jDQJEMojifkVg4dvO+3k2d3L0Y4YUfBNjw/1sZ2CZCeXql0psZ2iF00jTa7NM6/onezFvosdaG9AkV6Rx/Q9xIsT454ZVCci7HHGbEpX2NvaaesNDyp2SHruhgXlbKszMSUc+hpVV91VA+i6PuEBoq0WlklsES0N0gpWkqdnZ0wWdAUcJLSXxlp/j173zsXZuPjnbgcvGAy8SknmxJ+ST5VHbTIQOnW45jv/l7SQ2jzJkxVgKjUoNE1+pYrVd8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mzet6x3hrnn/X7G5ydxWVnQuGr8GAWvlngxhGifLsRM=;
 b=Khug/7Z24wUtP+ug/nm/Kajf5i2A8Pq8FjqxYF996EtlYCsPKTvo5R4Xjakk7Ao+M2W5p/sVaGtrZDUpI+DO1ZUdMXk5P8xRcVBXJ1WIaXeR2Pt/mRTauGWXxY3DY4JVi/puqY3cX5zjC67RUsay2iXcMHxifE2clcI5qFTqGn8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by IA1PR12MB7544.namprd12.prod.outlook.com (2603:10b6:208:42c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 15:01:28 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::45b1:34fb:e14d:96e4]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::45b1:34fb:e14d:96e4%5]) with mapi id 15.20.5880.013; Tue, 6 Dec 2022
 15:01:28 +0000
Message-ID: <3b904a05-9faa-c7e0-f364-a80c1248a66b@amd.com>
Date:   Tue, 6 Dec 2022 09:01:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] docs: Integrate rustdoc into Rust documentation
Content-Language: en-US
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        bilbao@vt.edu, corbet@lwn.net, konstantin@linuxfoundation.org,
        ojeda@kernel.org
References: <20221130220825.1545758-1-carlos.bilbao@amd.com>
 <20221201204814.2141401-1-carlos.bilbao@amd.com>
 <a019a3f1-7ff1-15b2-d930-e1d722847e0c@gmail.com>
 <dd0a67d6-0ba3-66e2-851c-7498b0bc99d1@amd.com>
 <3e5f2b84-a351-2e6d-f620-421876908aba@gmail.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <3e5f2b84-a351-2e6d-f620-421876908aba@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR08CA0006.namprd08.prod.outlook.com
 (2603:10b6:208:239::11) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|IA1PR12MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: 1844b1cd-d754-4c50-f4a6-08dad79ac0bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hqlHleI/WAB/FOm35s6AAzUnJvAj2tTzMGu6bIAkzqyVdGbSLuLIVquBdI7QjXZmlCjnaeS4g2tOuYiYUhrf9dwytK7lTB74V3Uc2BWZQOrzG1XU1ttqqoQJ4BRKXvTd9/LO9lnNO9RLS1P7fG+CCrJ6NJVAXA/hUz4Rh/hU7O+TGlAhVeEyU73Jj7LTIoQZ/gwOwputvB5DFHjBWAWZ3E4NP7Lmq9TrdWYM3+tEIiR3oNjkAaAk8mcL/ACwTHL+OoPzloXTHLX4N5ung4MDm3VzIBSAZpxrG4OjBtvmwGNaPabxe5NpqOekTv5u8dBoMYoCaclnI/+wh69rmjy2CVQ9ipu0qGo2asl7irKZPB8ul2wL8y109b+0V9FOFxJ74qXl9fLorzkNzhwB2m3A/p9EpLeBLh8K1o4nuIj3CT9n1xaRQKUihFuda6L4LQwRyde4V9DVDhs2j0yM+2ttwuGmXJKlinYLLFub/FUY1h2/0OOqZ0RgEwvhUcsATaPVsSkubKQPwV2TRVBUVjMkghLdgKYh1XT2h5k4MQ9KdrMULjzqrpKZJhjSOMf2HmIFkpBxBlqIQX2KprdCI3DBMHvWdmg5et8+yQvjMpLqOIKjcRCu1KcuUqZ0DfgAEJ1DK+mdD1Y7zyI/7IspT49LBFS7BoEYuip5vUcs4On8t5Y8vvgSZuGRMQKdrF8QZzEM6C3kkXmZF4luNrFypaYq8s6Cn4J5F/z7kdkzCuoFKKtrwndLM4290yRXNUu9kyWk68E/FXKJL14PvBg9q2ISAH3sOdRSG11adfaFqPBK2gmOGxhBjeH33/pmZhZadm4c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199015)(8676002)(6506007)(4326008)(38100700002)(83380400001)(316002)(6916009)(26005)(186003)(6512007)(44832011)(66946007)(66556008)(66476007)(45080400002)(36756003)(53546011)(8936002)(2906002)(5660300002)(41300700001)(31686004)(2616005)(966005)(86362001)(6486002)(478600001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVF5SXJoLyswWjlXVUFDbWx1M0VYNWJDaXp3dkdEQVRyWTJ2b1hQUU5rSFg0?=
 =?utf-8?B?cGtMdEFBSzU4WS8xTy8yaEpGajhYY2RGbVBENm81SUJ2aGdjVHpnKy9NTGN2?=
 =?utf-8?B?WGd2L1NjR29UN0Rid296VVpyZVE0WUFyak1IVXcrZk5iN2NDZjVKOEZ6Y0xl?=
 =?utf-8?B?OFI4RWE5MzIyKzFoemlUR0hTUy9Rb1RyQUQ2aEIrTTUvNFRiOTlKT2RONFJt?=
 =?utf-8?B?YXNWNEJsdElUdi9jMG1VRlk3Y0lHY0J3dlZEYmtnNmZYUG1YNXhGaUEvK0RE?=
 =?utf-8?B?NWFqYXllSXVLT3JBVFAvcUxjTlI1OVhIQ2dJM2s2VWlnZU5ySDVKUHNENVdS?=
 =?utf-8?B?ektsUXpqbTBTV3pwSlZ5WEYrcjE3Nmo5QVpwTDdpcSt3Q0t2REVhL2FaYWVY?=
 =?utf-8?B?QTZ5SzFYYnNiMUkzVHhKaS84UmFIU0svWkJiNklZc0RER09QYVZTSnE4UFNT?=
 =?utf-8?B?U3VxeDJsWTJObk9jTVhQbVNOd01HR25vRUlhb1l4SHp4UU94TDZnbjE3a2Zj?=
 =?utf-8?B?RHJrM1pZTmxMaVNHWkNZSGwwazZrM1lreGlERmhjSkY5Wmo2OWh3Z1oyWlNT?=
 =?utf-8?B?Nkp2bFNITUVRWGRwNkNrcGpMSGJkS3Q3RTZCUVkwY3NjdlErakFzbUdpdFNx?=
 =?utf-8?B?STNXQWVNaE1iNnpIUmFTMVBxRExFajY3bHdIaFBEaGt5S2xYa0xNVGVDc1dC?=
 =?utf-8?B?ajBWdElJdUV4V2Q4dEhrN1ErY3FZeFhVelpESzJUZGxCN3lvdVN3eUx2RXN5?=
 =?utf-8?B?Q0dxWnNWRHV4S1JRNkdsbGlRZ3VnZElMZlVrV1kxbC80NmdrNnlML1JtZndr?=
 =?utf-8?B?b1RYelFwbm8wUmZrTG14U29HMU4rdllLVzkxRmJmUGRSTVBJWG50dnZ2ajFX?=
 =?utf-8?B?SEJyRDNFakpaeW14VWRScm1DS1BoWXZjall1ZlA0UitEU1FLcmVvRGtBWkt5?=
 =?utf-8?B?RC9zODd5UWxPeGFQaHlwb2lYWUJNd1RSZUs3dFdrVHhBMG1VcUJOM3ZWNmc4?=
 =?utf-8?B?SWJqR2dkYnBXUXBsMWs1QjJENmY3TEN0R3RkdHRCUytwREt5N0F3WnQwMVg1?=
 =?utf-8?B?MTQxSHA0U3NKWXB1VFZxK09DTnp0U3pzc01MeXhkTmx4VTNXeTAyemUvTGls?=
 =?utf-8?B?aUZIMzlnUTV2ejZ2U0t6REJ0MTBvVVRCMzhEeU9kUXpaMmRHemxqUzBQb0pJ?=
 =?utf-8?B?ejR4RHNCTlNOOGQ5Mm5iSXp3L2NZcGRtaDZENENYTFp3ckJVbHRKQVhjem9l?=
 =?utf-8?B?MG9Qb1ZrNVR4Sk16VHFnSFo2UXdyRVdYTytCZC92TElYbEVrck5DMXpTRGp5?=
 =?utf-8?B?Z0piWDlHTnlQb01TUndrLzhTNy9mSjcybTV3M01mcklOSGtZeXkwZTlCc1NR?=
 =?utf-8?B?SG1wRVlTWjErZHB6c3p6RWVzeTRaUEJPS2RLM1phNDlEcUZzYlJ0bE1VWllN?=
 =?utf-8?B?UGJqak9jZUYxUk14MnZiVndrQWIweUgvTFVoN1lsQVdHTzVVc1E5ejA4OHFs?=
 =?utf-8?B?eFE1eFZQVFJ3eDl1MHZJbDl1S1NaZWd4bkx4L1IzcXM2S0NwazVJUXhyZWo5?=
 =?utf-8?B?aXdwTml2MmhscVp4OHIyNllQaTYyVGQ3d2pRak9KNVVyWmhUdTY3bURsN3Yr?=
 =?utf-8?B?LytTU1RLN0VoNjlsenhOVEMxSEN0YUc0L0V5aktNM3dEUGRUWWRzL3JJNlRJ?=
 =?utf-8?B?QUNPOEJvTHM2Yzg2Ni84ODB1QkNwQ094ZHZiNldqSnZ0T0lCL2xhcHZ4Nmxl?=
 =?utf-8?B?bXh5ZjNmTUxRZ09XZ05yS1orN1o0WmJjRXNGRm05RFRiWDNscVNZY2MrQWFP?=
 =?utf-8?B?amJiV2h0WFZQejMxK25kbmZiNi9NZ0ZyZkRiZllCdmNROUptbGVTSWZIbGti?=
 =?utf-8?B?V3RLUTh5WkxlbG1kZU9OUEhxU2JLWlJQYzFSZ3BCaS9IYm5IbzQ0Z1VNaVA1?=
 =?utf-8?B?ZDNSVWt1clhDeGc3OGRCQXZDUVRBQ3FjZVdGd29XTHBDNVAyWTdwQUVrdlor?=
 =?utf-8?B?aVkzcHpHdmp4cFpWcDVHb1RWZHdTMVpOWU05NzhMSzR3OGZXdGNjT0d2VFll?=
 =?utf-8?B?a0IwUHI1SjBOZEZhRmt6Mlg1K1NORC9CdUhZU3c3NENTVWF2WFRsbDhJUkNq?=
 =?utf-8?Q?f/DkduSTTN6RAkmVLvLPi5zP+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1844b1cd-d754-4c50-f4a6-08dad79ac0bd
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 15:01:28.5893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kAvkvqamuCu7yCBBPqsFt5RgLQPHSP2F+tAB6YhuVOOCXt4Phi4r4H0NiGSfcLColR9uEHsuZKUNAP6+InUB8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7544
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/22 08:22, Akira Yokosawa wrote:

> On Mon, 5 Dec 2022 10:36:11 -0600, Carlos Bilbao wrote:
>> On 12/4/22 19:06, Akira Yokosawa wrote:
>>
>>> Hi,
>>>
>>> On Thu, 1 Dec 2022 14:48:14 -0600, Carlos Bilbao wrote:
>>>> Include HTML output generated with rustdoc into the Linux kernel
>>>> documentation on Rust. Change target `make htmldocs` to combine RST Sphinx
>>>> and the generation of Rust documentation, when support is available.
>>>>
>>>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>>>> ---
>>>>
>>>> Changes since V1:
>>>>    - Work on top of v6.1-rc1.
>>> Thank you for the rebase.
>>>
>>>>    - Don't use rustdoc.rst, instead add link to Documentation/rust/index.rst.
>>>>    - In Documentation/Makefile, replace @make rustdoc for $(Q)$(MAKE) rustdoc.
>>>>    - Don't do LLVM=1 for all rustdoc generation within `make htmldocs`.
>>>>    - Add spaces on definition of RUSTDOC_OUTPUT, for consistency.
>>>>
>>>> ---
>>>>    Documentation/Makefile       |  4 ++++
>>>>    Documentation/rust/index.rst |  3 +++
>>>>    rust/Makefile                | 15 +++++++++------
>>>>    3 files changed, 16 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/Documentation/Makefile b/Documentation/Makefile
>>>> index 64d44c1ecad3..f537cf558af6 100644
>>>> --- a/Documentation/Makefile
>>>> +++ b/Documentation/Makefile
>>>> @@ -92,6 +92,10 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
>>>>        fi
>>>>      htmldocs:
>>>> +# If Rust support is available, add rustdoc generated contents
>>>> +ifdef CONFIG_RUST
>>>> +    $(Q)$(MAKE) rustdoc
>>>> +endif
>>>>        @$(srctree)/scripts/sphinx-pre-install --version-check
>>>>        @+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
>>> So, this means "make htmldocs" will require kernel .config if CONFIG_RUST=y.
>>> I'm not sure this new requirement is acceptable for kernel documentation
>>> testers who just want to build kernel documentation.
>>
>> This is already kind of the case for Rust-related business.
>>
>>
>>> You are doing three things in this patch.
>>>
>>>    1) Change the destination of rustdoc to under Documentation/output/
>>>    2) Add a cross reference to the generated rustdoc in
>>>       Documentation/rust/index.rst.
>>>    3) Integrate rustdoc generation into htmldocs.
>>>
>>> I'm OK with 1) and 2).
>>> Can you separate 3) into another patch and respin?
>>
>> Glad we can agree on 1) and 2). Why moving 3)? This is a small patch with
>> one overall purpose (Integrate rustdoc into website).
> Yes, I agree that 3) is a small change. I understand what you want to
> do. But there are a couple of options for _how_ to do it.
> My current position is that Documentation/Makefile is _not_ the right
> place for the change, as mentioned in my reply to Miguel.


Actually, I originally used `make rustdocs` [1] but good arguments were
given to use `make htmldocs` instead, and I was convinced too.


>
>>
>>> By the way, is rustdoc's requirement of .config only for CONFIG_RUST?
>>> In other words, are contents of rustdoc affected by other config settings?
>>>
>>> If not, I think rustdoc can be generated regardless of config settings as
>>> far as necessary tools (rustc, bindgen, etc.) are available.
>>
>> Yes, but someone with the tools may not want to use them. Keep in mind that
>> generating rustdoc takes a few extra seconds.
> As mentioned in another reply, I'm convinced of the dependency on .config.
>
>>
>>>>    diff --git a/Documentation/rust/index.rst b/Documentation/rust/index.rst
>>>> index 4ae8c66b94fa..4005326c3ba9 100644
>>>> --- a/Documentation/rust/index.rst
>>>> +++ b/Documentation/rust/index.rst
>>>> @@ -6,6 +6,9 @@ Rust
>>>>    Documentation related to Rust within the kernel. To start using Rust
>>>>    in the kernel, please read the quick-start.rst guide.
>>>>    +If this documentation includes rustdoc-generated HTML, the entry point can
>>>> +be found `here. <rustdoc/kernel/index.html>`_
>>> This cross reference will only make sense in htmldocs build.
>>> Perhaps, you can use the "only::" directive [1] as follows:
>>>
>>> .. only:: html
>>
>> This I can gladly do on a V3. I will wait for an answer on issues above.
> OK.
>
> So if you split this into a two-patch series, 1/2 for 1) and 2), and 2/2
> for 3) (or an updated one), I'm glad to give my RB tag to 1/2 for Miguel
> to be able take it for v6.2 (timing is tight!). 2/2 will need at least
> a couple of respins, I guess.


Sounds good, I will divide for v3.


>
>          Thanks, Akira
>>
>>>       If this documentation includes rustdoc-generated HTML, the entry point can
>>>       be found `here. <rustdoc/kernel/index.html>`_
>>>
>>> [1]: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.sphinx-doc.org%2Fen%2Fmaster%2Fusage%2Frestructuredtext%2Fdirectives.html%23directive-only&amp;data=05%7C01%7Ccarlos.bilbao%40amd.com%7Cbed091b8fae74b3d314408dad7954fc2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638059333550278394%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=xGbmhYsge%2BoPo%2BRrsc6fCW8htY3yh0dHk4E8gQBQV9o%3D&amp;reserved=0
>>>
>>>           Thanks, Akira
>>>
>>>> +
>>>>    .. toctree::
>>>>        :maxdepth: 1
>>>>    diff --git a/rust/Makefile b/rust/Makefile
>>>> index 7700d3853404..080c07048065 100644
>>>> --- a/rust/Makefile
>>>> +++ b/rust/Makefile
>>>> @@ -1,5 +1,8 @@
>>>>    # SPDX-License-Identifier: GPL-2.0
>>>>    +# Where to place rustdoc generated documentation
>>>> +RUSTDOC_OUTPUT = $(objtree)/Documentation/output/rust/rustdoc
>>>> +
>>>>    always-$(CONFIG_RUST) += target.json
>>>>    no-clean-files += target.json
>>>>    @@ -58,7 +61,7 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
>>>>        OBJTREE=$(abspath $(objtree)) \
>>>>        $(RUSTDOC) $(if $(rustdoc_host),$(rust_common_flags),$(rust_flags)) \
>>>>            $(rustc_target_flags) -L$(objtree)/$(obj) \
>>>> -        --output $(objtree)/$(obj)/doc \
>>>> +        --output $(RUSTDOC_OUTPUT) \
>>>>            --crate-name $(subst rustdoc-,,$@) \
>>>>            @$(objtree)/include/generated/rustc_cfg $<
>>>>    @@ -75,15 +78,15 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
>>>>    # and then retouch the generated files.
>>>>    rustdoc: rustdoc-core rustdoc-macros rustdoc-compiler_builtins \
>>>>        rustdoc-alloc rustdoc-kernel
>>>> -    $(Q)cp $(srctree)/Documentation/images/logo.svg $(objtree)/$(obj)/doc
>>>> -    $(Q)cp $(srctree)/Documentation/images/COPYING-logo $(objtree)/$(obj)/doc
>>>> -    $(Q)find $(objtree)/$(obj)/doc -name '*.html' -type f -print0 | xargs -0 sed -Ei \
>>>> +    $(Q)cp $(srctree)/Documentation/images/logo.svg $(RUSTDOC_OUTPUT)
>>>> +    $(Q)cp $(srctree)/Documentation/images/COPYING-logo $(RUSTDOC_OUTPUT)
>>>> +    $(Q)find $(RUSTDOC_OUTPUT) -name '*.html' -type f -print0 | xargs -0 sed -Ei \
>>>>            -e 's:rust-logo\.svg:logo.svg:g' \
>>>>            -e 's:rust-logo\.png:logo.svg:g' \
>>>>            -e 's:favicon\.svg:logo.svg:g' \
>>>>            -e 's:<link rel="alternate icon" type="image/png" href="[./]*favicon-(16x16|32x32)\.png">::g'
>>>>        $(Q)echo '.logo-container > img { object-fit: contain; }' \
>>>> -        >> $(objtree)/$(obj)/doc/rustdoc.css
>>>> +        >> $(RUSTDOC_OUTPUT)/rustdoc.css
>>>>      rustdoc-macros: private rustdoc_host = yes
>>>>    rustdoc-macros: private rustc_target_flags = --crate-type proc-macro \
>>>> @@ -141,7 +144,7 @@ quiet_cmd_rustdoc_test = RUSTDOC T $<
>>>>            @$(objtree)/include/generated/rustc_cfg \
>>>>            $(rustc_target_flags) $(rustdoc_test_target_flags) \
>>>>            --sysroot $(objtree)/$(obj)/test/sysroot $(rustdoc_test_quiet) \
>>>> -        -L$(objtree)/$(obj)/test --output $(objtree)/$(obj)/doc \
>>>> +        -L$(objtree)/$(obj)/test --output $(RUSTDOC_OUTPUT) \
>>>>            --crate-name $(subst rusttest-,,$@) $<
>>>>      # We cannot use `-Zpanic-abort-tests` because some tests are dynamic,
>>>>
>>>> base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
>>
>> Thanks,
>> Carlos

[1] 
https://lore.kernel.org/lkml/a019a3f1-7ff1-15b2-d930-e1d722847e0c@gmail.com/T/


Thanks,
Carlos

