Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61D55ECBAA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiI0RxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbiI0Rws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:52:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC8395E72
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664301156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vTXCL/aFlsahWsadKe+XhRADwg3WoAZR3yqJT/snh3I=;
        b=N/G0P7ZsewsB1PUbuOgwiD+U5GDhV2ly1VGc9NFjXHSql7iJOFBqpJ0tbVlSkSp2xfJbbX
        Pmv9BEIqRtktKgf7EzrUdwtCThIuczlBbSrQTxFAlbBtvDzSH+k8kp2H+J6ZyHrgYyNAPk
        YHiBGc3I7vpUq7VQpmPdSgcn3g+kXTI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-su196LE4PIOhchNIv-poMA-1; Tue, 27 Sep 2022 13:52:33 -0400
X-MC-Unique: su196LE4PIOhchNIv-poMA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E526185A7A3;
        Tue, 27 Sep 2022 17:52:32 +0000 (UTC)
Received: from [10.22.9.237] (unknown [10.22.9.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7AC8B1759E;
        Tue, 27 Sep 2022 17:52:31 +0000 (UTC)
Message-ID: <1ee8f429-bc79-c984-29a2-f131c750551f@redhat.com>
Date:   Tue, 27 Sep 2022 13:52:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [Resend PATCH v2] tracing: Disable interrupt or preemption before
 acquiring arch_spinlock_t
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
References: <20220922133158.1731333-1-longman@redhat.com>
 <20220922145622.1744826-1-longman@redhat.com>
 <9c798af6-aa2c-5f76-7a50-ef1983f9bdcd@redhat.com>
 <20220927131221.1b3a736b@gandalf.local.home>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220927131221.1b3a736b@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/22 13:12, Steven Rostedt wrote:
> On Tue, 27 Sep 2022 11:28:13 -0400
> Waiman Long <longman@redhat.com> wrote:
>
>> On 9/22/22 10:56, Waiman Long wrote:
>>> It was found that some tracing functions in kernel/trace/trace.c acquire
>>> an arch_spinlock_t with preemption and irqs enabled. An example is the
>>> tracing_saved_cmdlines_size_read() function which intermittently causes
>>> a "BUG: using smp_processor_id() in preemptible" warning when the LTP
>>> read_all_proc test is run.
>>>
>>> That can be problematic in case preemption happens after acquiring the
>>> lock. Add the necessary preemption or interrupt disabling code in the
>>> appropriate places before acquiring an arch_spinlock_t.
>>>
>>> The convention here is to disable preemption for trace_cmdline_lock and
>>> interupt for max_lock.
>>>
>>> Fixes: a35873a0993b ("tracing: Add conditional snapshot")
>>> Fixes: 939c7a4f04fc ("tracing: Introduce saved_cmdlines_size file")
>>> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>> ---
>>>    kernel/trace/trace.c | 23 +++++++++++++++++++++++
>>>    1 file changed, 23 insertions(+)
>> Ping!
>>
>> Any comment on this patch?
> You may have noticed (from today's emailing) I applied the patch ;-)

Yes, I saw it after I sent this mail :-)

Thanks,
Longman

