Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9E765C175
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237760AbjACOG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237677AbjACOGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:06:52 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A41010578;
        Tue,  3 Jan 2023 06:06:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abmgR5FYTyiGOV5efpED9ivvnMHETqLe8u+4I0vscTFfPLs4/nkfYkaRAwIhJBwSL2fBy/tuGSErSOI9zJ9tyRLLApnv/3GVvVq3BDwCrgrguy0wvsv/2NVID+ZBgPiTxG1p+IqiSv7HTXAvOUR9p64WnVUpPxMyfov371TvEMiVSUl5xZ8tatt8+FfOVW2FmsLsiJkmUnvMs3Zqx3GUZ6soS4zQC7qb0PI1HmQ2dDNbe38CAeNAFSNR4dUXcSJkRRNEnT0iE/g03xQr9NHcylW9pIYH+tGuvJf/ViLK4EvQ9ZvtbpRbCyYM/TsnjKtVne4PJkMZMD/1OKGflf9owg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7owfVqobvi70YeDEc2zFjaddbzdgqID3RqyniBTwu0E=;
 b=mmwc1PI95T21L0eAeSxzYN4s6d/4Fg5qLJiZnnZf4dMsqUXvbnc2xuLkfbzi+vOnflXgN1CEvRzT03D52DdMh/A+2cd9ozY0KCxj0BNO2k6JHsHFvWFwWuv5BnQn6OKIslQ9ketN6lnEOE81RECQCTxYCAEK6xKC1SR+9k6P2zwxDIX9nW8kJWywX+03JaVbJilIfiYzvs2AFxxpvZeg/PhX31MRxnKv1N347hPuL9uFqmlkig/r4VsVylChW/YrwHDJL1F9so/RTc9k1q/Y2A55fG4+7bdqi1l+SI/nIUXTxMkmZQbYRqV1wPLPV0PyuTurY187MX8cqEazuhsH3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7owfVqobvi70YeDEc2zFjaddbzdgqID3RqyniBTwu0E=;
 b=ksRDusVSSPJUq7THypSyfaczRn61Xzcqz9MNyQWk7jgMJZ522D9t0WcqjQaOI4XkGA95UaSeAS0m92g3Oty9WLHUviT8xZgw4JsBkoi49Xi6sGtlDEa1D7Rbtp+w0sKkX/vfkJhSi5OEdIsO+GFLj5x5CC7VSRp5TfT/39cEF7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by MN0PR12MB6344.namprd12.prod.outlook.com (2603:10b6:208:3d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 14:06:49 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::45b1:34fb:e14d:96e4]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::45b1:34fb:e14d:96e4%5]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 14:06:49 +0000
Message-ID: <d37334f8-4c4c-467f-9ab0-a79914cbae3a@amd.com>
Date:   Tue, 3 Jan 2023 08:06:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 0/2] docs: Integrate rustdoc into Rust documentation
To:     Jonathan Corbet <corbet@lwn.net>, ojeda@kernel.org,
        akiyks@gmail.com, jani.nikula@linux.intel.com,
        rdunlap@infradead.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        konstantin@linuxfoundation.org
References: <20221207173053.1463800-1-carlos.bilbao@amd.com>
 <20221228174623.144199-1-carlos.bilbao@amd.com> <87wn64fq7d.fsf@meer.lwn.net>
Content-Language: en-US
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <87wn64fq7d.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0326.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::31) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|MN0PR12MB6344:EE_
X-MS-Office365-Filtering-Correlation-Id: addd4550-d38e-42f6-e9d2-08daed93c1ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X1qOvCih2nqk3YjGLh3I4DBu/r+Z47mf2gMJKv/PHysdgzlqPlL1Ca15Q5B520nMHWEiP1syADO4Fjstb5OaiA0SkmZcORmFX37dcnq3BkK2ESz5gGR/sFBaF8udA1VFF7h+/SoWwAD+zujrGWlL96IlkCvSY+tNshfen7ymt+QJB9q5ti8D8UYDuXoZMpxu89Egjq2zHt4Abv49w+QXce2JG+ycO+RUIvOhPL9KXg/92tKHpH7ScGLh59fO161HdQIFFpiME/Pd1ETFexsh9Q0Co4zysyfXHFpCFW+8PU8YrEwdNHWqnuRajm2O5YQp3IYXyImD/SmIN8RRSfqcHeTbnOFVW8njfYtcV9HhkRAuHPo4vCEsWkjPSFv//UvjFv4JknShrpP8JeP7FSYvpfVSZTKc4ETtWVumI/mM24ptq7man0Aw4MMU6Rb4waBZ72j7Od6KIa0k3tMcXwofpL+u9WdLWe+ev0rNPlwWQSvFkeM4+4F66YDfFUGMJESQyRNcIFzaKNvnkz06zRTp6TLfU5GFfPkWBhmufW4pzH6ToX9RCMBeWTeWf35s+CxvJt2olO3t7Nmeca0MNIIpEcZKpN14b8m1kDqN/kMqH3WaSDegzI+TX6nFBqX2EZsRSvdd0Evl1v5K4uA1Mr/OZ8JylVo+AqRBRngSwnpZ455L13TFHTc9x2VOJSzHQutYNiAq0gbhfa93x3m3JjFEWK6QpLu3LADYCvGde2+wIFZh5HbjG3IlwIso4UCPlSokGamhDoGSWckCDZ/lCDg1rOtWCZhTIcZGgQbbzO7SkXo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(451199015)(8676002)(4326008)(66556008)(66476007)(66946007)(41300700001)(966005)(478600001)(8936002)(6486002)(316002)(31686004)(5660300002)(6512007)(186003)(26005)(6506007)(2906002)(53546011)(2616005)(36756003)(44832011)(83380400001)(31696002)(86362001)(38100700002)(22166006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3VkaVE0ZThuTmZjbDFtWUQ0T1RON2ZuUDY1Yi9rbEpBZnNiRGljRitjMjRy?=
 =?utf-8?B?UURRWkVZVTUyZjZiSXJjbHZIODBoNWllZEZ3TXVCRHBranVJa2FjV1pLUXpl?=
 =?utf-8?B?SlF0ZzQzSG5rNmpSSmlyVDZhSXBCa0wrbHF1SUFQbTErT0JmeksvaWZPNkxT?=
 =?utf-8?B?dXBrbGhybS95OHUwb0YrR0dBcFZPMVlJb2R5MUE4cWcwU0xZM1RiWm9pWm9X?=
 =?utf-8?B?VmpZci94T1dES2RMRDFNVWNuTjFrRFMrcW5RVVFKVGF3MzhXRnNMRUdaWTd6?=
 =?utf-8?B?V2ZMbjQ1RWRtL3luL3o3NHJKNFFxSENTRnM1VXpTNmpYczBmTkJ1cXdWN3dZ?=
 =?utf-8?B?T2NHSXlWYUZFanhzM2dyRUI4b2RTbkwxMUNDM0IyK1ZERFZYQTZLQS9FSU82?=
 =?utf-8?B?ZHZMaVlqWmlibERYMUtCYTNsT1pNRU90Q1d4ZmlpWlArT3czNEhlWFBJMEhS?=
 =?utf-8?B?c1FNNUhrcGhBMGEwRDh6VEVReVpqNE13RzRlZFIxM1BxV1V2b2NjMktlRXBn?=
 =?utf-8?B?aFVNdEhNUEs2aHhubDB6OVdPdWluMnlVVm1DdkVENjZwQi9sOVpyY0NlMGF1?=
 =?utf-8?B?eEhsTU12bmp0QWRWM3RMQkd3cy9iQ0VmS1NPYmFzL0NPNTdGRGp6NG9PVlhG?=
 =?utf-8?B?OEV0MDBCOElhR1RzU0Y3MmpOY2lDODBBWUR5SlJvakp1WXBMU2IwelYxdUZW?=
 =?utf-8?B?Rjk3WDBicHJGYWtUcXBwTG9lVlZ2KzhreHYvaCtHenpyYWlyNEJEM2cvdS9W?=
 =?utf-8?B?cVhvRTkzWnhBV0J6Sm9iWHNkUGo3bk1YNDZYQmVCaXlHaDRrcW8wcjRtaUJz?=
 =?utf-8?B?V1c4L1NVYVNRSnpJQTQzZEZOTVZyZVZ0MjR4TmswNTJKV1FVRE9odXVlR0Vq?=
 =?utf-8?B?MWlkYVBVWkdSRm12ZkZTOW5ONUQ0NklDaXduVGkyRHFuVCtrWEppYytUbWRI?=
 =?utf-8?B?ZGo4S2NzQlhBZVRQeWpSdDRzVkRiekJzTDBmQmw0bmIxRDVYU08vS2xmS3V5?=
 =?utf-8?B?b0x4Z255Q3NOTGhOQVFCdWJJdUdqSll3UDJDZjg1SHNudlBLWkYxTHZtc1Ba?=
 =?utf-8?B?YXBzaVlkYXN6d0JPcjBHNVo5N3c0QzAydDgycHFaZWhEWG0rVHd3LzR3Nk5B?=
 =?utf-8?B?cXlZbUk5eDFtUTZZWFhuUjdmMHZ4NTRGZ2FqMDdOYlVkRHJ6bGtTa3ArUVRj?=
 =?utf-8?B?NDhWYjJBa0J5ZzU1bkZ4cHJORzlHWEYzRjlrbnArZFY0MktaQzI1czY3QVo0?=
 =?utf-8?B?enkvdWlpOWNzYW9MVFZDY2ZMcEUrT1I0YTFJZUp1a0p6R0l0dldRRm9laDFG?=
 =?utf-8?B?cTZ6UHJza21sOHIrdmdQN1JtcTJ1STVPTzJibWFsRURjTmNuL0g1eHA0NzNH?=
 =?utf-8?B?bzZORCs1WWJoSEhuOEN5bjM0bVVaRGtyNEtYUW1iOHgzam45bXpLMnN0YWpl?=
 =?utf-8?B?ME9qbElRVzNudXVrNTFmWDZ3Q2dEVFc5RkZWUVl5aU8yK1VTVTJoMy9mTENV?=
 =?utf-8?B?Q3orZDRxeGdwZXBUcmdkU2g5aE9mMi9tNWNKRFJmclZLM05FaFQ2a0w0enhG?=
 =?utf-8?B?QWF6YXNtS1pKaFExa3FKK1R4Q1dZN1l2Y1R6cDQ2Wm0zZmFzR1dIN05JbnZN?=
 =?utf-8?B?TVpKYWFTQWtQTGlFWmNhM1VFK25Hek41b2tlUTNjYjBkTzlOb0JkeVArWTBO?=
 =?utf-8?B?Qzgwb29zVjVTWXZDbzhaSVBndFZVbVpOdXlYMjNiTzJRZ3BxMmg5UTFseUhR?=
 =?utf-8?B?Z05lc2lrY2hYdC84c25YUmluR1c4TlIxalVBUzgyZnJLK1N2SkZrMFcwbUtI?=
 =?utf-8?B?bjFnWlQ3RjBBQmM3S01kR2JDdWlNdnhpQXpCV2NCTXV0VzBOM3R3ci80T3Q3?=
 =?utf-8?B?bllzeExyeXJmbTVOMGg0QlZiT2Y0VC9zMDM4dklTeVRNRlM4dnQrb1I4VTZi?=
 =?utf-8?B?Mi9RWVVJSFlyWS83OG16TEdjWUJHaklFTEtZZk1FN1h2cGc3S3JXdjgxM0J2?=
 =?utf-8?B?bnp4MEJ5WFdrTlhYRHJPRy83YmNSUURieXNyNlVTb3ZhTHNWN21ua1ZWY1hl?=
 =?utf-8?B?Y2p6RjlSWk4vakhlMlpnSmFydkRrK0paTlBvbzQrRnBxVUFjelF0QkNFd3FL?=
 =?utf-8?Q?CuNjuuP0ZXocx40lBSYbcQliz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: addd4550-d38e-42f6-e9d2-08daed93c1ce
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 14:06:49.5447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bejYSoAbvxARZ/YVFcMyXaMolwLiDiiZodI0l3jUsb92PmtJI6BsKSakcbGv86mFUyOTYKisspTIfre5BTjzSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6344
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/23 17:53, Jonathan Corbet wrote:

> Carlos Bilbao <carlos.bilbao@amd.com> writes:
>
>> Include HTML output generated with rustdoc into the Linux kernel
>> documentation on Rust.
>>
>> Carlos Bilbao:
>>   docs: Move rustdoc output, cross-reference it
>>   docs: Integrate rustdoc generation into htmldocs
> OK, so I just gave this a try...
>
> - It forces the generation of a kernel configuration, something that the
>    docs build has never done until now.  What are our changes of
>    eliminating that?


Yes, this means "make htmldocs" will require kernel .config, but only if we
want CONFIG_RUST=y. AFAIK this is a limitation of Rust in the kernel at the
moment, not something particular to this patch.


>
> - It did a bunch of other building, starting with objtool - again, never
>    needed for the docs build before.


Yes, building rustdoc requires building new things, no way around that
either, IMHO.


>
> In the end, it died with:
>
>> BINDGEN rust/bindings/bindings_generated.rs
>> Failed to run rustfmt: No such file or directory (os error 2) (non-fatal, continuing)
>>    BINDGEN rust/bindings/bindings_helpers_generated.rs
>> error: Found argument '--blacklist-type' which wasn't expected, or isn't valid in this context
>>
>> 	Did you mean '--blocklist-type'?
> Perhaps this is because I ignored the warnings about my Rust toolchain
> being too new? (Rust 1.65.0, bindgen 0.63.0).  I get that only one


Yes, it is important to have the expected Rust toolchain. You can try
running:

rustup override set $(scripts/min-tool-version.sh rustc)

there's more information about this on the Rust Quick Start [1]. It may be
annoying but you will need this for any future Rust-kernel work too.


> version is really supported, but it would be nice to fail a bit more
> gracefully if at all possible.
>
> Anyway, I've unapplied these for now; thoughts on all this?


My two cents is that these are limitations of Rust in the kernel, at least
on its current state, and so adding rustdoc to the Documentation was
going to come with them. But if someone has any ideas to make it less
painful, I'm all ears too :)


>
> Thanks,
>
> jon


Thanks,

Carlos


[1] 
https://github.com/Rust-for-Linux/linux/blob/rust/Documentation/rust/quick-start.rst

