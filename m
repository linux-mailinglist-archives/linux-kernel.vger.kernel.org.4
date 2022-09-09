Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF1F5B32A0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbiIII7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiIII7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:59:12 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B610311E6E3
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 01:59:10 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b5so1608813wrr.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 01:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=5WlnBB4XpnEReTODutDj2ZW7HQbMxkdht0TI84bTlHQ=;
        b=L4qaaQP0Vo42jGNSjwiEBH63IqqtB+/r3fp38w0CNYZ6FZ54H3Qx6sFc5dGgsjPZfa
         N8xnnPnZnrTamgYz3czva7fs4kdWOPL2ZgMUF6So7UvqNcJmiDhM9GuhFi0OVsnF5ReG
         P7baLG7J/lR9VxGZV4+kfxc3Kp2FAJSHdPcub4qLQHHnyAyYJng1DC6tJxtwgINZp7/J
         weXtb4JKD81zAuyM38vzx7QXt2ee4VRPTXUrickojkAhje3vaiZ2Op2DVpFSifomb9fl
         VzXYOICm2Vccq1ZyxE32kOdwj59BuvCOp/K0ZjLdr6aYVrgcG+0ny8p1l4SEympZ42A+
         4b1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=5WlnBB4XpnEReTODutDj2ZW7HQbMxkdht0TI84bTlHQ=;
        b=Xymvjyf8dV39hCQVJ/S0QoW/G+DqSbmdQuqCRL4JXdUtbxV3lZlVNkjWoNzVgLPnXU
         +nUWQ+yFdCUZkI+HRLh1Q8bbE9hn6SWBcb+KU6U/pjE4Xt6LQNBHXHaWbHvyMFNTaqmW
         wn6cGxp1TEKVBHvfsO1TJryRZ48VHXi5+xqNB0NfbK8L5nNSblk2qtfpsE717s+zaicd
         DDJErr8Xp8W89bpGi4X/J/tArmmMkjtzxgOz/OgFrouqXblYKbc5QY1uf4ZFraqey2DB
         +Gi8s+KWiGFArRgjLvKhozwJKtKnIUoSP7piVjBHnO61r3DqCkRuX79ZCsiJ/v64+OkB
         LlUA==
X-Gm-Message-State: ACgBeo3Q9ie1FpebDlydreRx3y6ojSvik3kF0WbdE+u63HmjMj4/AQds
        Z9zAcMhPrpG1G9Cy/hxeJ8QuCA==
X-Google-Smtp-Source: AA6agR7NIHsOLGkRDmLYOcciOPD6KzeuMZ5q9DeMaupwLQjwqtsy3HhFlO71hTPW6pESTByCFbXxOg==
X-Received: by 2002:a05:6000:1f8d:b0:22a:28c3:47be with SMTP id bw13-20020a0560001f8d00b0022a28c347bemr5529997wrb.485.1662713949309;
        Fri, 09 Sep 2022 01:59:09 -0700 (PDT)
Received: from localhost ([95.148.15.66])
        by smtp.gmail.com with ESMTPSA id s14-20020a5d4ece000000b0022865038308sm1357257wrv.93.2022.09.09.01.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 01:59:08 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     Song Liu <song@kernel.org>
Cc:     Punit Agrawal <punit.agrawal@bytedance.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        zhoufeng.zf@bytedance.com, Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [External] Re: Re: [PATCH v2] bpf: Simplify code by using
 for_each_cpu_wrap()
References: <20220907155746.1750329-1-punit.agrawal@bytedance.com>
        <CAPhsuW6+D0bfoPZdQ0j-NtCvgMED4YF-LyqXTQQHo+x7tw3yug@mail.gmail.com>
        <877d2ecffy.fsf_-_@stealth>
        <CAPhsuW6fUuc6E7_EoY1h-cikDAT6AuLYCwb89JnaTeOcdrsNFw@mail.gmail.com>
Date:   Fri, 09 Sep 2022 09:59:07 +0100
In-Reply-To: <CAPhsuW6fUuc6E7_EoY1h-cikDAT6AuLYCwb89JnaTeOcdrsNFw@mail.gmail.com>
        (Song Liu's message of "Thu, 8 Sep 2022 13:21:04 -0700")
Message-ID: <87leqsc49w.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Song Liu <song@kernel.org> writes:

> On Thu, Sep 8, 2022 at 3:45 AM Punit Agrawal
> <punit.agrawal@bytedance.com> wrote:
>>
>> Hi Song,
>>
>> Thanks for taking a look.
>>
>> Song Liu <song@kernel.org> writes:
>>
>> > On Wed, Sep 7, 2022 at 8:58 AM Punit Agrawal
>> > <punit.agrawal@bytedance.com> wrote:
>> >>
>> >> In the percpu freelist code, it is a common pattern to iterate over
>> >> the possible CPUs mask starting with the current CPU. The pattern is
>> >> implemented using a hand rolled while loop with the loop variable
>> >> increment being open-coded.
>> >>
>> >> Simplify the code by using for_each_cpu_wrap() helper to iterate over
>> >> the possible cpus starting with the current CPU. As a result, some of
>> >> the special-casing in the loop also gets simplified.
>> >>
>> >> No functional change intended.
>> >>
>> >> Signed-off-by: Punit Agrawal <punit.agrawal@bytedance.com>
>> >> ---
>> >> v1 -> v2:
>> >> * Fixed the incorrect transformation changing semantics of __pcpu_freelist_push_nmi()
>> >>
>> >> Previous version -
>> >> v1: https://lore.kernel.org/all/20220817130807.68279-1-punit.agrawal@bytedance.com/
>> >>
>> >>  kernel/bpf/percpu_freelist.c | 48 ++++++++++++------------------------
>> >>  1 file changed, 16 insertions(+), 32 deletions(-)
>> >>
>> >> diff --git a/kernel/bpf/percpu_freelist.c b/kernel/bpf/percpu_freelist.c
>> >> index 00b874c8e889..b6e7f5c5b9ab 100644
>> >> --- a/kernel/bpf/percpu_freelist.c
>> >> +++ b/kernel/bpf/percpu_freelist.c
>> >> @@ -58,23 +58,21 @@ static inline void ___pcpu_freelist_push_nmi(struct pcpu_freelist *s,
>> >>  {
>> >>         int cpu, orig_cpu;
>> >>
>> >> -       orig_cpu = cpu = raw_smp_processor_id();
>> >> +       orig_cpu = raw_smp_processor_id();
>> >>         while (1) {
>> >> -               struct pcpu_freelist_head *head;
>> >> +               for_each_cpu_wrap(cpu, cpu_possible_mask, orig_cpu) {
>> >> +                       struct pcpu_freelist_head *head;
>> >>
>> >> -               head = per_cpu_ptr(s->freelist, cpu);
>> >> -               if (raw_spin_trylock(&head->lock)) {
>> >> -                       pcpu_freelist_push_node(head, node);
>> >> -                       raw_spin_unlock(&head->lock);
>> >> -                       return;
>> >> +                       head = per_cpu_ptr(s->freelist, cpu);
>> >> +                       if (raw_spin_trylock(&head->lock)) {
>> >> +                               pcpu_freelist_push_node(head, node);
>> >> +                               raw_spin_unlock(&head->lock);
>> >> +                               return;
>> >> +                       }
>> >>                 }
>> >> -               cpu = cpumask_next(cpu, cpu_possible_mask);
>> >> -               if (cpu >= nr_cpu_ids)
>> >> -                       cpu = 0;
>> >
>> > I personally don't like nested loops here. Maybe we can keep
>> > the original while loop and use cpumask_next_wrap()?
>>
>> Out of curiosity, is there a reason to avoid nesting here? The nested
>> loop avoids the "cpu == orig_cpu" unnecessary check every iteration.
>
> for_each_cpu_wrap is a more complex loop, so we are using some
> checks either way.

That's true, indeed. While putting the patch together I wondering about
the need for a simpler / optimized version of for_each_cpu_wrap().

> OTOH, the nesting is not too deep (two loops then one if), so I guess
> current version is fine.
>
> Acked-by: Song Liu <song@kernel.org>
>

Thanks!

[...]

