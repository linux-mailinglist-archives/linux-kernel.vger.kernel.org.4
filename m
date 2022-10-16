Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3985FFEC1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 12:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiJPK4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 06:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiJPK4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 06:56:42 -0400
Received: from spamfilter04.delta.nl (spamfilter04.delta.nl [217.102.255.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D141532EFB;
        Sun, 16 Oct 2022 03:56:41 -0700 (PDT)
Received: from host-xbmmyvj.static.zeelandnet.nl ([217.102.255.196] helo=mail.caiway.net)
        by spamfilter04.delta.nl with esmtp (Exim 4.92)
        (envelope-from <8vvbbqzo567a@nospam.xutrox.com>)
        id 1ok1Jg-0000t9-VD; Sun, 16 Oct 2022 12:56:34 +0200
Received: from smtp-out.lan.xutrox.com (189-082-045-062.dynamic.caiway.nl [62.45.82.189])
        (Authenticated sender: gv47feqf@mail.intern)
        by mail.caiway.net (Postfix) with ESMTPA;
        Sun, 16 Oct 2022 12:56:11 +0200 (CEST)
Received: from [10.1.16.159] (unknown [10.1.16.159])
        by smtp-out.lan.xutrox.com (Postfix) with ESMTPS id 06B14FC02;
        Sun, 16 Oct 2022 10:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xutrox.com; s=2021;
        t=1665917765; bh=zP9C+iR9M2mBQvJCxGkCZbRB4IFH1LFxL5Hm27pQvaI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pBqRFPZrRoUfDMV3hw90WgggTFX1TkVyNLbuChxg6+FeuOA4D+rCWfBOrls1bYXdv
         WYERqvnYFck30/3u4lR1nlF3yhFss5uaWKIVI7yjvp/0AGtHvNSkPwdkVr/28vcb5P
         d6KqUwgpPfx2A4FqoQVzgLgtAXAq2pEsmElJtMlSWRVlW0MewpRRvE/OpqSFpr+1qm
         Zu4+obi7yOwEdinj4rj3h7cAqGthKR5WmDQ3FmU9Usru8ffkgr/heRQD4NPEdahMms
         NH/o22AUcWeLXkRipQiDIYGAFxBvbSlNPYJOtgC9irIb8tRN22HnvbfYH2yMm1Glnr
         0IsTt2zzLFN1w==
Message-ID: <6922d19a-e441-65fe-2e87-ade5e9113277@nospam.xutrox.com>
Date:   Sun, 16 Oct 2022 12:56:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] x86/perf: Fixed kernel panic during boot on Nano
 processor.
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, shyaololo@163.com
References: <20210607013109.7870-1-CodyYao-oc@zhaoxin.com>
 <Y0gpsTiUqa/ZbvRh@hirez.programming.kicks-ass.net>
 <b38ecb38-2709-0c75-fe08-375dd4a87d5f@nospam.xutrox.com>
 <Y0vWFXQ2vLBaM3Ki@hirez.programming.kicks-ass.net>
From:   8vvbbqzo567a@nospam.xutrox.com
In-Reply-To: <Y0vWFXQ2vLBaM3Ki@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: 217.102.255.196
X-DELTA-Domain: out.caiw.net
X-DELTA-Username: 217.102.255.196
Authentication-Results: delta.nl; auth=pass smtp.auth=217.102.255.196@out.caiw.net
X-DELTA-Outgoing-Class: ham
X-DELTA-Outgoing-Evidence: Combined (0.10)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT9NTwqdw11yuGMGmXnP7tbRPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5yc/ZmA9xtuv+B4ejtZ8Y/XuPlWyU6WxHGGYJjeNxb2qsSt
 0Cf6BPNJWEBZ4JVsQN2Mj8c81Cqq49L7i7V2/TcPuK4qf9MvYgQQjDkqI/9rxZYoT8DGBXy9+Yr+
 O7G/xc58iEjXbHIdUQr1yb+WzViLwOkTB5HjLhmTNASxhQlKkawLonlImQFKvyumeIUlInTJUFW9
 jMbE4Gan+bbHWts97JtuyuUsa+UkJaUpT81goTMcT+7lBOhaiNMPjogKlwA2Vz6Xcl+tcewiMUdS
 9dKp8n/ecEa8Dg/FYK5/AG7c3Xw3coVFbzLPseyHEBSmYPf2enzXTs9rqT37lCgCUdR3idMlhCno
 /QsYaTlhyywkGTkQIfeYgYqBXZFMF+hHi7rcf/ofBF/wWxzMV48oEn/pBKAyQrzAeq3AeWqWb9gf
 nNSk8+fgc+o5Xu+07CcwiU/nx8yeplRO3sLIqUlSH7OG5Y1hl2V3UfpLpVnqeYDS1SLy45WFlP1s
 Jr1+aex/Ulqzb7beJqcDdedf/LVjvJjpMPQw6rYJUjBdUqy7NS7xoewFtfVVDzXuysvWqTcyMRt9
 1f09nJD3yg+oBfxpbYvfTGZuBauiiXH+MoQKv9h76xT3qCw0qWynGc+BWaIiOu6A3lV+lhocEHQ0
 PjO14DBYwmF578wdp7e2A6J2TUpPWVpyEZwbVtLZYxQDSIoH6UkYYcqhrf5qdUDTH5YV+nfYV9JL
 MT13YzYOQg+G3VktopIdvVKvl+zNtsZrfRsJ1WF3OPXHG4SbWjx+4EBZ/M4eQzI+VWRIUOXf76LZ
 UkuYHFln2rbOTkjceu6n1fWs6/68Ksk+aedMfNWSnJswrtlNEbMFZ3LQyB8BYH65wI06pE4P/v3j
 2fQPzWeM0PLAIotUU27PTl4PhGkfKkdwRPwXKTjECb0PwpN4olPuA0AI9xgKi3JjYOitVarZxvNA
 3zEDu1OU4Z5A/IM4Z+8Zw6HSA5WVCaia6rYH8f6JpjT6Upq9fQK/ahaSV3pmdriqsceUauBjibsM
 iJ9NNzHCn7T37XKUVwMsizQtX7MxXUWMPQrk+5nPq4ShnVkY5eK1QHW/T7yyF9iyDkXdm7JD/Ez0
 vjqxoOZqkWGxfxD0CdnepUXBa624AzErpkPOBlXfSYFFjIDiBY12YB3czFfWwM5N5TuJmdMOzMdI
 6V/fdhx9DTeQxZOMN0qPHQJerTl02W0ccBIk1Sag4dKiqCrF8eZZQi4byosIiIxf7SOSnPao1QAr
 OF2gOFlz8YvMMXQtx+Q3RfcEkZ0AM2cY3GPCCPKKCp7Nk31shGPXjpZmlXBXLRTX83UFjI/oJNK8
 W4H+K9vRGcwkqtQFrmraBf/ptA5r3ahIWgiSheepBoImtwNHFeZjyGG344mqveFYBDzUmmZfX2KV
 3kHpTIQ90Y0jwR6J
X-Report-Abuse-To: spam@spamfilter03.delta.nl
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-10-2022 11:59, Peter Zijlstra wrote:
> On Sun, Oct 16, 2022 at 11:53:14AM +0200, Arjan wrote:
>> On 13-10-2022 17:07, Peter Zijlstra wrote:
>>> On Mon, Jun 07, 2021 at 09:31:09AM +0800, Cody Yao-oc wrote:
>>>> From: CodyYao-oc <CodyYao-oc@zhaoxin.com>
>>>>
>>>> Nano processor may not fully support rdpmc instruction, it works well
>>>> for reading general pmc counter, but will lead to GP(general protection)
>>>> when accessing fixed pmc counter. Futhermore, family/model information
>>>> is same between Nano processor and ZX-C processor, it leads to zhaoxin
>>>> pmu driver is wrongly loaded for Nano processor, which resulting boot
>>>> kernal fail.
>>>>
>>>> To solve this problem, stepping information will be checked to distinguish
>>>> between Nano processor and ZX-C processor.
>>>>
>>>> [https://bugzilla.kernel.org/show_bug.cgi?id=212389]
>>>>
>>>> Reported-by: Arjan <8vvbbqzo567a@nospam.xutrox.com>
>>>> Signed-off-by: CodyYao-oc <CodyYao-oc@zhaoxin.com>
>>>
>>> *sigh*.. so this email address doesn't exist, as such I can't apply this
>>> patch. Consider it dropped.
>>
>> If it's about my email address: The address exists and works.
>> If the nospam part bothers you, that part can be left out. You may leave the reported-by line out if you want to.
> 
> The SoB address (CodyYao-oc@zhaoxin.com) bounced for me -- since that's
> the patch author that is somewhat important.

It now bounced for me too.
It was still valid when Cody submitted the patch in 2021, because we
exchanged messages while debugging and testing the patch.
