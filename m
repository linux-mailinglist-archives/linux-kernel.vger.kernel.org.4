Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163D86A4C13
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 21:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjB0UNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 15:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjB0UNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 15:13:51 -0500
X-Greylist: delayed 1138 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Feb 2023 12:13:48 PST
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [IPv6:2620:100:9005:57f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26FDEB76;
        Mon, 27 Feb 2023 12:13:47 -0800 (PST)
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
        by mx0b-00190b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31RFMoe7026665;
        Mon, 27 Feb 2023 19:19:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=iNZObedCDsicuc2RfqyypFc9Ojp32ItF8uvq9uf+1Ek=;
 b=WvAiqT2YYSm7CmxLnsBGeKlqUNZ7D2YpLub1H+CE4PT3zun54zJx8BLXc1TYo5X2qyqm
 XbbW0CMP/DMmQR4Ph9zkpPQ/hgJE6bd2nnCFqwT68WVn/erj/7wKGxm298xDcU5PSzUk
 GxC+34OQkTgBI/LhS/0hFiLpA5/LnWvZYyVIGGKK+IYY4u7aSnq48bCNbzVO3MXEqokP
 szzi+ZhVsoPnsnNYpmvuqywDwv49jwmVvgsNGlm0MU2JfyFXMxGN0UBV2r2iAAP4QPzV
 8SrGrM41wv5GUwqnHCUOdCSX09oWgVMFW0q69KrVhYIkui+MzosgxyXZbR06KnNY/jhI tg== 
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
        by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 3nyav64t5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 19:19:06 +0000
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
        by prod-mail-ppoint1.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id 31RFVMJ4028605;
        Mon, 27 Feb 2023 14:19:05 -0500
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
        by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 3nyej3tmrt-1;
        Mon, 27 Feb 2023 14:19:04 -0500
Received: from [100.64.0.1] (prod-aoa-dallas2clt14.dfw02.corp.akamai.com [172.27.166.123])
        by prod-mail-relay10.akamai.com (Postfix) with ESMTP id 0B27C544EA;
        Mon, 27 Feb 2023 19:19:00 +0000 (GMT)
Message-ID: <d2a6b0ec-89a6-1a2f-d92e-c20a8d223d17@akamai.com>
Date:   Mon, 27 Feb 2023 11:19:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] psi: reduce min window size to 50ms
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        mark.rutland@arm.com, will@kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Sukadev Bhattiprolu <quic_sukadev@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Patrick Daly <quic_pdaly@quicinc.com>
References: <cover.1676067791.git.quic_sudaraja@quicinc.com>
 <CAJuCfpHWQ8NV=iR3BN+pt1c8FynCnRqyyriHb1gLxFgiNVrwjA@mail.gmail.com>
 <e944536f-a04c-5528-601e-d7f505a761e8@quicinc.com>
 <CAJuCfpGLkkS2yx0d9+2nYtEtxANSH5H3EgCmWZax4N-ieEBG7g@mail.gmail.com>
 <15cd8816-b474-0535-d854-41982d3bbe5c@quicinc.com>
 <CAJuCfpHihLgHCcsAqMJ_o2u7Ux9B5HFGsV2y_L2_5GXYAGYLnw@mail.gmail.com>
 <82406da2-799e-f0b4-bce0-7d47486030d4@quicinc.com>
 <CAJuCfpHrhO7_fMwNuu2hdQob=MPjZTW8eaJpNhEhPmDMqz2qTA@mail.gmail.com>
 <Y/ix53x8i/ViuBXf@dhcp22.suse.cz>
 <CAJuCfpG1c5v6qOotPV6t-o1T1p7EbOLs90eFnoEBjts+gafovA@mail.gmail.com>
 <Y/yxSqhpQh9yR7L4@dhcp22.suse.cz>
 <CAJuCfpHXwbtjdhH_K9r28-LUYtzC6+NaZ+RrKCtiNBk8PfXhLw@mail.gmail.com>
From:   Josh Hunt <johunt@akamai.com>
In-Reply-To: <CAJuCfpHXwbtjdhH_K9r28-LUYtzC6+NaZ+RrKCtiNBk8PfXhLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_15,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 mlxlogscore=741 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302270150
X-Proofpoint-ORIG-GUID: xJN1buAQh7I4_vaGy36yr7IrfGhVkiF3
X-Proofpoint-GUID: xJN1buAQh7I4_vaGy36yr7IrfGhVkiF3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_16,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=717 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 clxscore=1011 adultscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302270152
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/27/23 9:49 AM, Suren Baghdasaryan wrote:
> On Mon, Feb 27, 2023 at 5:34 AM Michal Hocko <mhocko@suse.com> wrote:
>>
>> On Fri 24-02-23 13:07:57, Suren Baghdasaryan wrote:
>>> On Fri, Feb 24, 2023 at 4:47 AM Michal Hocko <mhocko@suse.com> wrote:
>>>>
>>>> On Tue 14-02-23 11:34:30, Suren Baghdasaryan wrote:
>>>> [...]
>>>>> Your suggestion to have this limit configurable sounds like obvious
>>>>> solution. I would like to get some opinions from other maintainers.
>>>>> Johannes, WDYT? CC'ing Michal to chime in as well since this is mostly
>>>>> related to memory stalls.
>>>>
>>>> I do not think that making this configurable helps much. Many users will
>>>> be bound to distribution config and also it would be hard to experiment
>>>> with a recompile cycle every time. This seems just too impractical.
>>>>
>>>> Is there any reason why we shouldn't allow any timeout? Shorter
>>>> timeouts could be restricted to a priviledged context to avoid an easy
>>>> way to swamp system by too frequent polling.
>>>
>>> Hmm, ok. Maybe then we just ensure that only privileged users can set
>>> triggers and remove the min limit (use a >0 check)?
>>
>> This could break existing userspace which is not privileged. I would
>> just go with CAP_SYS_NICE or similar with small (sub min) timeouts.
> 
> Yeah, that's what I meant. /proc/pressure/* files already check for
> CAP_SYS_RESOURCE
> (https://urldefense.com/v3/__https://elixir.bootlin.com/linux/latest/source/kernel/sched/psi.c*L1440__;Iw!!GjvTz_vk!WtI61poYlZk9kg5P1sX19RdYnUNGvBJRjnOpu8hL6IOZ_NKhuw2qZ_tAdNRwzZoQVlO4jEObYN6x$ )
> but per-cgroup pressure files do not have this check. I think the
> original patch which added this check
> (https://urldefense.com/v3/__https://lore.kernel.org/all/20210402025833.27599-1-johunt@akamai.com/__;!!GjvTz_vk!WtI61poYlZk9kg5P1sX19RdYnUNGvBJRjnOpu8hL6IOZ_NKhuw2qZ_tAdNRwzZoQVlO4jAVqIVDv$ )
> missed the cgroup ones. This should be easy to add but I wonder if
> that was left that way intentionally.
> 
> CC'ing the author. Josh, Johannes is that inconsistency between system
> pressure files and cgroup-specific ones intentional? Can we change
> them all to check for CAP_SYS_RESOURCE?

No, this was just an oversight in the original patch at least from my
end, and did not come up during code review. Fine with me to change them
all to use CAP_SYS_RESOURCE.

Josh

> 
>>
>>>> Btw. it seems that there is is only a limit on a single trigger per fd
>>>> but no limits per user so it doesn't sound too hard to end up with too
>>>> much polling even with a larger timeouts. To me it seems like we need to
>>>> contain the polling thread to be bound by the cpu controller.
>>>
>>> Hmm. We have one "psimon" thread per cgroup (+1 system-level one) and
>>> poll_min_period for each thread is chosen as the min() of polling
>>> periods between triggers created in that group. So, a bad trigger that
>>> causes overly aggressive polling and polling thread being throttled,
>>> might affect other triggers in that cgroup.
>>
>> Yes, and why that would be a problem?
> 
> If unprivileged processes are allowed to add new triggers then a
> malicious process can add a bad trigger and affect other legit
> processes. That sounds like a problem to me.
> Thanks,
> Suren.
> 
>> --
>> Michal Hocko
>> SUSE Labs
