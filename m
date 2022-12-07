Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B81645AC3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiLGNXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiLGNXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:23:31 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEDA1A816;
        Wed,  7 Dec 2022 05:23:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChrdUDbeilLkOaYVzCfansiAUlLWsDLhNG5w2A+gvTms7fAJO+64qA2b+ViolIdhUxDQEgXarm1BmhUVuXCnIjgzjf4NrwmedShQ8RB7U8QwJaWJ2kG469lHUcauGUtBC6kUMSrLIJ+i2MpprRvKl67xdJhtkIT86uznSCZuDn99ZBuAKKYRhp6+i3Dq6WbNf0xu4W8RqPaYx8d2uacmqHY9Fw99sLgcSHgF7zIV6P/SS5pR0lPjVvHEMK8H+/XcWJJ9qvKXdsXazhEy71n9UYjhlUBTQqJKHK/rmqhOBYk0HOOTqyKb0pET/qwjmREfVc6qhdCUq9V/f1vCqFOs5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwfG8Q8osA/2LLHENDyWKUBktoXs7TnY/CPWgVANzAg=;
 b=mB4ofqKTm2C3598hjJFJKOoXjJqqgzLHViFrk30M6df+8bqRu4dnKS18ZgQg+VbV/qIhKf/fw12K9gnhc03H3+wsu2SJcPoy7/6OCkoQmwiFFJAI5rlYp+tzgokrpAQVmYMMRnJ4CzXMYfswhgJXjUYJXuiBivXoDHKc7FQMXkctEsJ7aJskKaOGoDkjmP3QZMk8CuE/W35/ED87cqCiqEuNT7M9M3S/KTf4niQLVk8zBzWnC83a+CZaRAamORgovumisn2wLdgYzJyJnlg3UjYyimpmO84YiswXRtLl3BXuocqzBpoQfODS5TCWZzo+HWDyqJr8qKNSUup7ifl2vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwfG8Q8osA/2LLHENDyWKUBktoXs7TnY/CPWgVANzAg=;
 b=DpVK+Ziv2EH7L0pE3+auSW0IJ+fxFLE1h2nWoInVEIITgeP0UXDIA1hekzcpZW/vGHdbIP/bwnTXeTBfiXmCFeJzGngHkr3/p0NlXWJqzzTLadUmEGgrC4eEKm4aGedtp+U4Vh1N58S4oZSoCZD4vkQ6Y+oW5dtFyAc7fX+fexiycPI6tHJG2hftw/7Q5MYvfSOsCmkOgPxxvldbsbq8e4SMqxHQrXkzyH7q8dKmSdZg8ccfOJsJ4D6qXz47Uf9YRfiL+Rzx6AW0sYUa5QPwCq8I7XLoIsb/vzCTvaa+8VP2XQnTR+CfUxVnfbR1ZfJR4fVLx3FdDQntsRa1QWP/Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3406.eurprd04.prod.outlook.com (2603:10a6:803:c::27)
 by PAXPR04MB9376.eurprd04.prod.outlook.com (2603:10a6:102:2b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 13:23:27 +0000
Received: from VI1PR0402MB3406.eurprd04.prod.outlook.com
 ([fe80::a207:31a9:1bfc:1d11]) by VI1PR0402MB3406.eurprd04.prod.outlook.com
 ([fe80::a207:31a9:1bfc:1d11%4]) with mapi id 15.20.5880.013; Wed, 7 Dec 2022
 13:23:27 +0000
Message-ID: <cb149b17-4bbf-71b0-424c-c4f3d1b96952@suse.com>
Date:   Wed, 7 Dec 2022 14:23:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Content-Language: en-US
To:     Prarit Bhargava <prarit@redhat.com>, Petr Mladek <pmladek@suse.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <YzdR0gRNQI2BGnJ9@bombadil.infradead.org>
 <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
 <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
 <d0bc50e3-0e42-311b-20ed-7538bb918c5b@suse.com>
 <Y277Jb9i2VeXQoTL@bombadil.infradead.org>
 <e070839f-c224-047b-9411-91143c1d8394@redhat.com>
 <Y3Jg8X7qv2AKPU1J@bombadil.infradead.org>
 <5467e66d-55de-ca8f-c1ae-ffe6efe7290d@redhat.com>
 <94cd5565-1058-2c97-57bb-0ddf12416cd6@redhat.com>
 <2ac0b871-60d0-c535-3fe0-bfaa0d9f7685@suse.com> <Y4opfN6MTsFhrYfu@alley>
 <2e8d862d-fa3d-0879-9097-215d17cb1fed@redhat.com>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <2e8d862d-fa3d-0879-9097-215d17cb1fed@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::17) To VI1PR0402MB3406.eurprd04.prod.outlook.com
 (2603:10a6:803:c::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3406:EE_|PAXPR04MB9376:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a05486c-fa36-47cf-3290-08dad8563950
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nIZKtOaLT9/0w9X34P1ZPTJm59fUtgfuk18Z0eW7O6HNRV/BAypQVd+gB4cvvuJ/imUzYa6Sgq6lBs9NUzCR+npWac4hNLGLDLYWCCIpiIulkRnbTzPj6nwiQOB9zTP7FTq7/9SdvSf85NVf1b+L4bXzY7YeYJi7IHl9LBralvskHpsvGCnqmhC9qXFko2ilPexTqq9s/H2d6apkHR2oVxMNQf/XJ4z154UzriTZp7RiT56C6gZFIM+S5wDlVnSll9tNKYcBwj1XgHxkGVV2FPZ1NxkbsmMJmoNQqhrcXAOsRfisSlaDwE6e5w4f8jdM0lvqyqQnZM2kell6WE2iG+QeQSnrCYgvYxTG2008tUFxog6Zih1tENb2dj5WD66U7spd6RelkfHLU3+Toy8x09G8xqD9lR3JVL3rXXZjUbcv4y7rYGYHhW9FqHyhbg82ZhAlTZuwXyaMZxM7dx313UPAb+B4vRk2GZGYTrl0Mdr/YiOu7TCmXsEMbZVoLrtZcBX8/TamN/8SrO0npx7MhwQXN4sCwb3plgfY4Okqizc5ZPj+CFGwZwtrTXrXYD//Mh5C4RWGebzzO27C6GmSMsSWFOyWkm9BZvzE0WpLZHz+mZj68xO8aKJLkX71sZ7t715Y6p9SKD99M4QI0Re0xvv6kLnyHiO8ljBA/m6VLPkatNPJSSpbwSGGwcKB2e8/h9vq2z5P+XFNHNi25ISaVZwgDJleHV3ap/tJKzn8Woj47B7PejJYf81esByfzE/J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3406.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199015)(4326008)(54906003)(6636002)(316002)(110136005)(8676002)(66946007)(66556008)(66476007)(55236004)(53546011)(478600001)(6486002)(38100700002)(36756003)(6512007)(186003)(6506007)(966005)(26005)(2616005)(41300700001)(86362001)(31686004)(31696002)(5660300002)(8936002)(44832011)(83380400001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHVIZzBidVlUUFdiQk9YMGxHM3lXSXAvOTJyQmdyV21kNlFGMENvTFJJQXVJ?=
 =?utf-8?B?dGtNN2locUJZV1RQQnBkeUU5V3VaVG5VQ2c0cjU2TWdCUmVuRUpGaFFCdFV3?=
 =?utf-8?B?RG52N3Z4WDhFd0lBU3Bqc3dsWVZFbXU0YTlFdDJ5T2pLVVdmdVRoTE9SOWJS?=
 =?utf-8?B?dHIxRExXNTZzd251eDROK1UydURKNW9TMHU1djlLa2JYaGR3QzZIenhJWTcw?=
 =?utf-8?B?MlZZZ0UyUzF0UkdDQ0ErUUszR0dhMXZRMzdlY3ZUSkNXc29tMWlKSGQ0U1o4?=
 =?utf-8?B?VzN0UjRQcHB3SUs5aGlMTkhjMXVDaUVPNkVzN3cyOTZ5elRjdVNSM0ZXL1Vy?=
 =?utf-8?B?YmFPZHEwWG81OEtFa1d1SFNjWXNGTGtpTjFPdVdaN3hKWHlLeWVJU2F1UUpF?=
 =?utf-8?B?WnBvQWlKZkRUUW83NWdLZGFid3BEVjcra243NmVCQXcwWnhuakV0RU13TmpO?=
 =?utf-8?B?VzJ4L3l5VTNBRG1mQSsxb0pZZjREMm1CS0t6NmRPd2Z2Nkp4cXdFanNaZ1h3?=
 =?utf-8?B?cmNXK21iVjhMWm10OE5Jc2gwVG10bFRqdWV1UGdiRGNmWnBHSFdpZVpQTnox?=
 =?utf-8?B?MjNTYmRRVTBYWUZSRVJDK1FucmFqN0hrVzRyZWJsU0hDbWwxTGwzemxHZFRz?=
 =?utf-8?B?Z2VTVHZiOGJ5Y2dJNXZuNjErUkFwdnhsYUNMTGNNS3NSeGpHSStXU3pjeERq?=
 =?utf-8?B?OGVYOVFmcWd4a2w0MTV4UXc0MTVFeG9oWEVUYUFEbTliMzZQUHZoN1dUL21q?=
 =?utf-8?B?SGF2ZDhDUXorYnhYTUk5dzBWODJ3MUFnT2pnNS9iREZSeG5tNUJ0VGNtRlla?=
 =?utf-8?B?RDFFWGNZWnRxcHJrRHkwekxINVkvbVNBWTdGVjJVSWtLM25xTjFOamtCczlK?=
 =?utf-8?B?Y2t2OEdCOCs4UHp1S0NLYWF0cjRhTDRWdEpaL2xpbnpTL0FCZis4T05tQkd5?=
 =?utf-8?B?b3pHNXJqSjcwN3UyLzVpcUV6SVVzR3RoKzZWc05qbzVQemtsaVJiV0QwckFC?=
 =?utf-8?B?UEduWEZZL2dZNWZqV1I4SVFDcExSM1BMQVJXbWsyUnV3bjFTQ09pbmVlWXZS?=
 =?utf-8?B?RTZBa3ZJT3Z3OVR5cE13RUNGV3pMbjBYcnRwNEZHWXZmRWdyN29ZaXdiVmRq?=
 =?utf-8?B?WG01Vys1dXVlelZYbndqL1VLSjJ6bVFCa1lQNDhVeTlKWkVra0hzMzJHZlZP?=
 =?utf-8?B?OG1NUmRWMnp4NHBramxjYUtIQXNWR0ladnpBZkxPTlBQQ0hWUEpCUk9jWVI1?=
 =?utf-8?B?R1VLSXRXeDJybjZxWWY0MlBpY3Q2TGk1Qk8xZnZLQXhHSUNWbGtucnY5TUc5?=
 =?utf-8?B?d2NRbmVVRTZYSlBZQnlLa090aWw4eDdZYzBPVWxzMjNRZGtTR3MrT0NVZEJW?=
 =?utf-8?B?bHpkanZwNUZuZHFtME9rMitHSE0rOGtNVWliZSt1OEpKNWlKbWxCdy9uTlNa?=
 =?utf-8?B?NDRVTFFoRVhGaFVBTG5xMThKQjd2ejR3ZEUrK3JoS1NOZmdqbmZYSUlQdkFB?=
 =?utf-8?B?Y3JmVGU0aWNLbnoxOVkxRDhmN0ZmYlovYUJOaXd2dllPa2huSXNqUnFaRkw0?=
 =?utf-8?B?a2JsMXpKU2FoVVBwMWJRMmluUFlQcXVyWm9ZdU5lM2JkdVR3Q2ZmVDNLWHVh?=
 =?utf-8?B?OFBDT01xT1VzNFdGTWdld0N6KzZFS29SQlpuTjFjVW5jU0dFNHNmTDZLK2l3?=
 =?utf-8?B?S1ljbDkvTVNSY0JMOEFTelMzOEVGaGd5TVBXZ0dmY1pvUk84RnN0SzlkQVBs?=
 =?utf-8?B?N2JlNXVIaFhqT2Q0VCs1ajFUMHRHOFZWaDl0MG83aDF0NmEwOTB5Y2ZVdWlX?=
 =?utf-8?B?bUZ0dmNQYnlwKzgrS0szL0pMaUtmQURuQlVOY3RXOFUzNFQ1SHpBVGFjMitq?=
 =?utf-8?B?OWJHTC9iU3ltRWkrYklQU2lHYmwrTWpuMEhodjBsRnVQQVdIU2ZzT2Jnejho?=
 =?utf-8?B?MFRGSHpVNWJnV28vNm1oY0YzSkxTaFZSVHVNMzdYNU11VkE0aHRKdVM1RUJn?=
 =?utf-8?B?MS9EV29VTXVuOTI5WW1yNnNNSXo0SWVkcmErZnBoOFVRcW1OS1NjaEIzdGto?=
 =?utf-8?B?dHpodjZJMXZ1UEZDS3F0YXVpK0JMemdacWZNV0tDbTBnTTJJc0wyK2c3eTFk?=
 =?utf-8?Q?/XCwynPZKqEAyiKg2EnqVaQae?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a05486c-fa36-47cf-3290-08dad8563950
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3406.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 13:23:27.0284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aI/k/42RPRgF5peBJL46+FLQa1o6ErKSMKBGUNSWBZGQWVjBF6qKy00D0hNNUXLSrNzP1s6Qo+4YBAcG+jjZDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9376
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/22 13:31, Prarit Bhargava wrote:
> 
>>
>>> Could you please boot the machine with 'udev.log_level=debug' and provide me
>>> logs ('journalctl -b -o short-monotonic') from a run with the vanilla kernel
>>> and with the discussed patch?
>>
> 
> Petr, I tried to in-line the logs however the email bounced due to its size.
> 
> I know this isn't a preferred method of passing information on LKML and 
> other lists, but here are links to the logs:
> 
> https://people.redhat.com/prarit/4petr/
> 
> Both outputs were done with, as requested, 'journalctl -b -o 
> short-monotonic'.
> 
> vanilla.log is kernel booted with 'udev.log_level=debug'
> with-changeset.log is kernel + patch booted with 'udev.log_level=debug'

Thanks Prarit for re-testing the patch. Both logs in this case actually show
similar startup times.

Vanilla:
[   68.108176] intel-eaglestream-spr-15.khw3.lab.eng.bos.redhat.com systemd[1]: Startup finished in 55.874s (firmware) + 25.646s (loader) + 35.793s (kernel) + 7.845s (initrd) + 24.469s (userspace) = 2min 29.629s.

With the patch:
[   68.064826] intel-eaglestream-spr-15.khw3.lab.eng.bos.redhat.com systemd[1]: Startup finished in 54.153s (firmware) + 19.947s (loader) + 35.965s (kernel) + 9.449s (initrd) + 22.650s (userspace) = 2min 22.165s.


The system has 192 CPUs. The vanilla case shows 144x inserts of acpi_cpufreq
and 43x of pcc_cpufreq:

acpi_cpufreq (the first and last recorded insert):
[   47.485621] intel-eaglestream-spr-15.khw3.lab.eng.bos.redhat.com systemd-udevd[1871]: Inserted module 'acpi_cpufreq'
[...]
[   53.052401] intel-eaglestream-spr-15.khw3.lab.eng.bos.redhat.com systemd-udevd[1914]: Inserted module 'acpi_cpufreq'

pcc_cpufreq:
[   47.515221] intel-eaglestream-spr-15.khw3.lab.eng.bos.redhat.com systemd-udevd[1871]: Inserted module 'pcc_cpufreq'
[...]
[   53.067917] intel-eaglestream-spr-15.khw3.lab.eng.bos.redhat.com systemd-udevd[2040]: Inserted module 'pcc_cpufreq'

Processing inserts of all CPU frequency modules took at least ~5.5 seconds.
It was likely more because not all inserts are recorded in the log, udevd
messages appear to be missing from ~53.1.


With the patch, both modules are attempted to be inserted 192x:

acpi_cpufreq:
[   50.107403] intel-eaglestream-spr-15.khw3.lab.eng.bos.redhat.com systemd-udevd[1817]: Failed to insert module 'acpi_cpufreq': Device or resource busy
[...]
[   50.438755] intel-eaglestream-spr-15.khw3.lab.eng.bos.redhat.com systemd-udevd[2016]: Inserted module 'acpi_cpufreq'

pcc_cpufreq:
[   50.110731] intel-eaglestream-spr-15.khw3.lab.eng.bos.redhat.com systemd-udevd[1849]: Failed to insert module 'pcc_cpufreq': Device or resource busy
[...]
[   50.579249] intel-eaglestream-spr-15.khw3.lab.eng.bos.redhat.com systemd-udevd[2016]: Inserted module 'pcc_cpufreq'

This shows that the patch reduced the sequence to ~0.5 seconds and its logic
looks to be working as intended.

Thanks,
Petr
