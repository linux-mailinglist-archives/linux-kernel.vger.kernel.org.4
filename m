Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1577704477
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 07:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjEPFKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 01:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjEPFKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 01:10:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1779173A;
        Mon, 15 May 2023 22:10:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 735406298D;
        Tue, 16 May 2023 05:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7F8C433EF;
        Tue, 16 May 2023 05:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684213832;
        bh=u8Y2f4n10KnprdRg9KnWZid4H6uSUjozETMEXBKEsbY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y2iQpsFIET1oRKmwR8Jo+fs/oUtNa1g3ar6V/YM9cpNrB3twVL8Vn4xNBd0JN0aVs
         53vqNLhRsiFc8EI6xwZuTZzJqmwJQ8XG20/K7ZfPnncSaORAND10oAcO8I9oRu1qeg
         kwQXLVgZRRwRfGNJXBY+xMLY2mZ0LWZnCFIF7BvOBy/duUaJx4KPpLdf1Gnd9foN0T
         pl5X+7mfqNzx+GgKP0n6h/O4rnBdyFMV04iJLaHSrUM5LDTnhI7IoTNue4nPlLjfEO
         2NkAt6bV6sb+ujrfQmBI51PVh3UGMJP2XbIav1KiXHZAT4WvF9UlS2MxzNBn3rPi+f
         5wqtxb/KTjSkA==
Date:   Tue, 16 May 2023 14:10:28 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Yonghong Song <yhs@meta.com>,
        Ze Gao <zegao2021@gmail.com>, Jiri Olsa <olsajiri@gmail.com>,
        Song Liu <song@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Ze Gao <zegao@tencent.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: reject blacklisted symbols in kprobe_multi to
 avoid recursive trap
Message-Id: <20230516141028.d3a9cb541bf1b7ef0deb79c3@kernel.org>
In-Reply-To: <20230516133153.9627751457e0050159f077ab@kernel.org>
References: <20230510122045.2259-1-zegao@tencent.com>
        <6308b8e0-8a54-e574-a312-0a97cfbf810c@meta.com>
        <ZFvUH+p0ebcgnwEg@krava>
        <CAD8CoPC_=d+Aocp8pnSi9cbU6HWBNc697bKUS1UydtB-4DFzrA@mail.gmail.com>
        <ee28e791-b3ab-3dfd-161b-4e7ec055c6ff@meta.com>
        <20230513001757.75ae0d1b@rorschach.local.home>
        <20230516133153.9627751457e0050159f077ab@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 13:31:53 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Sat, 13 May 2023 00:17:57 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Fri, 12 May 2023 07:29:02 -0700
> > Yonghong Song <yhs@meta.com> wrote:
> > 
> > > A fprobe_blacklist might make sense indeed as fprobe and kprobe are 
> > > quite different... Thanks for working on this.
> > 
> > Hmm, I think I see the problem:
> > 
> > fprobe_kprobe_handler() {
> >    kprobe_busy_begin() {
> >       preempt_disable() {
> >          preempt_count_add() {  <-- trace
> >             fprobe_kprobe_handler() {
> > 		[ wash, rinse, repeat, CRASH!!! ]
> > 
> > Either the kprobe_busy_begin() needs to use preempt_disable_notrace()
> > versions, or fprobe_kprobe_handle() needs a
> > ftrace_test_recursion_trylock() call.
> 
> Oops, I got it. Is preempt_count_add() tracable? If so, kprobe_busy_begin()
> should be updated.

OK, preempt_count_add() is NOKPROBE_SYMBOL() so kprobe_busy_begin() should
be safe. The problem is in fprobe_kprobe_handler() then.

Thanks!

> 
> Thanks,
> 
> > 
> > -- Steve
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
