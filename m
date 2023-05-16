Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7888170446A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 06:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjEPE55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 00:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjEPE5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 00:57:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08326273D;
        Mon, 15 May 2023 21:57:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D1746340C;
        Tue, 16 May 2023 04:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263EFC433EF;
        Tue, 16 May 2023 04:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684213072;
        bh=roPPF/l5deYBtgHegCGcLhbxMkvBll9sulvxuXqKaFY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VmxHZspzVQeVLluQit84ClMt/qVSLQgK2igjHIpDnAsDnsUxJBRt+wHotVupCtYgQ
         lHxIcmBEopzMSFJAQKoBKnav7DSU8VD3J/LR7GRq2wv0W2PTq0A/HUQj4SviKN0XSi
         oFicsooV4jZHKhrYA8iqpF4FyRjEMrh6iH+zVCfZSE3yExUd2wIEVwtD3u3Z9Cwjjq
         Uap/mOrkNH5pcp4h9CUY8OPIw8dY/QdoxhDZSbYyKLpao4ToesmZ1OR/vZqMO1n8VR
         UA3laCGvTRCUkTHpDRWBkbNS+TkRQrYYOiOa4EbadOp3VtTL7zIcsOBHb4bB0gZqNi
         dPfz5w0b34D7A==
Date:   Tue, 16 May 2023 13:57:48 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Ze Gao <zegao2021@gmail.com>
Cc:     Yonghong Song <yhs@meta.com>, Jiri Olsa <olsajiri@gmail.com>,
        Song Liu <song@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ze Gao <zegao@tencent.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: reject blacklisted symbols in kprobe_multi to
 avoid recursive trap
Message-Id: <20230516135748.9368303c5b092722cdd37601@kernel.org>
In-Reply-To: <CAD8CoPBzqih=0YxumRtywvSLs0aHwEbzpbehqKvpb18GzntVqA@mail.gmail.com>
References: <20230510122045.2259-1-zegao@tencent.com>
        <6308b8e0-8a54-e574-a312-0a97cfbf810c@meta.com>
        <ZFvUH+p0ebcgnwEg@krava>
        <1195c4bd-ef54-2f1d-b079-2a11af42c62f@meta.com>
        <89159b33-3be4-487b-7647-0cbbd20c233d@meta.com>
        <CAD8CoPBzqih=0YxumRtywvSLs0aHwEbzpbehqKvpb18GzntVqA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2023 09:24:18 +0800
Ze Gao <zegao2021@gmail.com> wrote:

> Thank yonghong for your sage reviews.
> Yes, this is an option I am also considering . I will try this out
> later to see if works
> 
> But like you said it's not clear whether kprobe blacklist== fprobe blacklist.

Just FYI, those are not the same. kprobe blacklist is functions marked
by __kprobes or NOKPROBE_SYMBOL(), but fprobe blacklist is "notrace"
functions.

Thank you,

> And also there are cases I need to investigate on, like how to avoid recursions
> when kprobes and fprobes are mixed.
> 
> Rejecting symbols  kprobe_blacklisted is kinda brute-force yet a straight way to
> avoid kernel crash AFAIK.
> 
> Ze
> 
> On Thu, May 11, 2023 at 7:54 AM Yonghong Song <yhs@meta.com> wrote:
> >
> >
> >
> > On 5/10/23 1:20 PM, Yonghong Song wrote:
> > >
> > >
> > > On 5/10/23 10:27 AM, Jiri Olsa wrote:
> > >> On Wed, May 10, 2023 at 07:13:58AM -0700, Yonghong Song wrote:
> > >>>
> > >>>
> > >>> On 5/10/23 5:20 AM, Ze Gao wrote:
> > >>>> BPF_LINK_TYPE_KPROBE_MULTI attaches kprobe programs through fprobe,
> > >>>> however it does not takes those kprobe blacklisted into consideration,
> > >>>> which likely introduce recursive traps and blows up stacks.
> > >>>>
> > >>>> this patch adds simple check and remove those are in kprobe_blacklist
> > >>>> from one fprobe during bpf_kprobe_multi_link_attach. And also
> > >>>> check_kprobe_address_safe is open for more future checks.
> > >>>>
> > >>>> note that ftrace provides recursion detection mechanism, but for kprobe
> > >>>> only, we can directly reject those cases early without turning to
> > >>>> ftrace.
> > >>>>
> > >>>> Signed-off-by: Ze Gao <zegao@tencent.com>
> > >>>> ---
> > >>>>    kernel/trace/bpf_trace.c | 37 +++++++++++++++++++++++++++++++++++++
> > >>>>    1 file changed, 37 insertions(+)
> > >>>>
> > >>>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > >>>> index 9a050e36dc6c..44c68bc06bbd 100644
> > >>>> --- a/kernel/trace/bpf_trace.c
> > >>>> +++ b/kernel/trace/bpf_trace.c
> > >>>> @@ -2764,6 +2764,37 @@ static int get_modules_for_addrs(struct
> > >>>> module ***mods, unsigned long *addrs, u3
> > >>>>        return arr.mods_cnt;
> > >>>>    }
> > >>>> +static inline int check_kprobe_address_safe(unsigned long addr)
> > >>>> +{
> > >>>> +    if (within_kprobe_blacklist(addr))
> > >>>> +        return -EINVAL;
> > >>>> +    else
> > >>>> +        return 0;
> > >>>> +}
> > >>>> +
> > >>>> +static int check_bpf_kprobe_addrs_safe(unsigned long *addrs, int num)
> > >>>> +{
> > >>>> +    int i, cnt;
> > >>>> +    char symname[KSYM_NAME_LEN];
> > >>>> +
> > >>>> +    for (i = 0; i < num; ++i) {
> > >>>> +        if (check_kprobe_address_safe((unsigned long)addrs[i])) {
> > >>>> +            lookup_symbol_name(addrs[i], symname);
> > >>>> +            pr_warn("bpf_kprobe: %s at %lx is blacklisted\n",
> > >>>> symname, addrs[i]);
> > >>>
> > >>> So user request cannot be fulfilled and a warning is issued and some
> > >>> of user requests are discarded and the rest is proceeded. Does not
> > >>> sound a good idea.
> > >>>
> > >>> Maybe we should do filtering in user space, e.g., in libbpf, check
> > >>> /sys/kernel/debug/kprobes/blacklist and return error
> > >>> earlier? bpftrace/libbpf-tools/bcc-tools all do filtering before
> > >>> requesting kprobe in the kernel.
> > >>
> > >> also fprobe uses ftrace drectly without paths in kprobe, so I wonder
> > >> some of the kprobe blacklisted functions are actually safe
> > >
> > > Could you give a pointer about 'some of the kprobe blacklisted
> > > functions are actually safe'?
> >
> > Thanks Jiri for answering my question. it is not clear whether
> > kprobe blacklist == fprobe blacklist, probably not.
> >
> > You mentioned:
> >    note that ftrace provides recursion detection mechanism,
> >    but for kprobe only
> > Maybe the right choice is to improve ftrace to provide recursion
> > detection mechanism for fprobe as well?
> >
> > >
> > >>
> > >> jirka
> > >>
> > >>>
> > >>>> +            /* mark blacklisted symbol for remove */
> > >>>> +            addrs[i] = 0;
> > >>>> +        }
> > >>>> +    }
> > >>>> +
> > >>>> +    /* remove blacklisted symbol from addrs */
> > >>>> +    for (i = 0, cnt = 0; i < num; ++i) {
> > >>>> +        if (addrs[i])
> > >>>> +            addrs[cnt++]  = addrs[i];
> > >>>> +    }
> > >>>> +
> > >>>> +    return cnt;
> > >>>> +}
> > >>>> +
> > >>>>    int bpf_kprobe_multi_link_attach(const union bpf_attr *attr,
> > >>>> struct bpf_prog *prog)
> > >>>>    {
> > >>>>        struct bpf_kprobe_multi_link *link = NULL;
> > >>>> @@ -2859,6 +2890,12 @@ int bpf_kprobe_multi_link_attach(const union
> > >>>> bpf_attr *attr, struct bpf_prog *pr
> > >>>>        else
> > >>>>            link->fp.entry_handler = kprobe_multi_link_handler;
> > >>>> +    cnt = check_bpf_kprobe_addrs_safe(addrs, cnt);
> > >>>> +    if (!cnt) {
> > >>>> +        err = -EINVAL;
> > >>>> +        goto error;
> > >>>> +    }
> > >>>> +
> > >>>>        link->addrs = addrs;
> > >>>>        link->cookies = cookies;
> > >>>>        link->cnt = cnt;


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
