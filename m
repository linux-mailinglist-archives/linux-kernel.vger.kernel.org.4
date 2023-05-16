Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B42704458
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 06:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjEPEcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 00:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjEPEcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 00:32:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D344A3A9D;
        Mon, 15 May 2023 21:31:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53397622E3;
        Tue, 16 May 2023 04:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23A2C433D2;
        Tue, 16 May 2023 04:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684211518;
        bh=e4YAJmKsuD89fgedecS6L/gt/qymF1Yj4L5b7+rCXs8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tqHQrw0aEtEuGx1eXuk9tcITR9fU9OjaNSphg+HVldMiiiS6fOw/r8e+o1eKPTWFL
         bvmWKNuX4yGRFSVIzBXBO197YEK+mXJIkgs2XfHE9Ye8SxvxRmZE69pjcZvDJCh3Si
         CXX5raEHLtUI06ZEdO/Kg3X8o7Pyq62kIAAWUwe76RbDXm2arQ/7rDZke2XnA4xz7K
         yRwPuZpuAYjfcMhN4EhxbhFzZZ/SPSDvrQgJ6andW7doIvygO1zh+j26pj/WYUQXjI
         epzXKh+LFDWZDB2gT0CLNRJ7GPH4hgQjWqkrNpYYoUE6cM7DN9KgU4oTkYy1v1jgfv
         Ku3d9x2uXeWCw==
Date:   Tue, 16 May 2023 13:31:53 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Yonghong Song <yhs@meta.com>, Ze Gao <zegao2021@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>, Song Liu <song@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ze Gao <zegao@tencent.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: reject blacklisted symbols in kprobe_multi to
 avoid recursive trap
Message-Id: <20230516133153.9627751457e0050159f077ab@kernel.org>
In-Reply-To: <20230513001757.75ae0d1b@rorschach.local.home>
References: <20230510122045.2259-1-zegao@tencent.com>
        <6308b8e0-8a54-e574-a312-0a97cfbf810c@meta.com>
        <ZFvUH+p0ebcgnwEg@krava>
        <CAD8CoPC_=d+Aocp8pnSi9cbU6HWBNc697bKUS1UydtB-4DFzrA@mail.gmail.com>
        <ee28e791-b3ab-3dfd-161b-4e7ec055c6ff@meta.com>
        <20230513001757.75ae0d1b@rorschach.local.home>
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

On Sat, 13 May 2023 00:17:57 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 12 May 2023 07:29:02 -0700
> Yonghong Song <yhs@meta.com> wrote:
> 
> > A fprobe_blacklist might make sense indeed as fprobe and kprobe are 
> > quite different... Thanks for working on this.
> 
> Hmm, I think I see the problem:
> 
> fprobe_kprobe_handler() {
>    kprobe_busy_begin() {
>       preempt_disable() {
>          preempt_count_add() {  <-- trace
>             fprobe_kprobe_handler() {
> 		[ wash, rinse, repeat, CRASH!!! ]
> 
> Either the kprobe_busy_begin() needs to use preempt_disable_notrace()
> versions, or fprobe_kprobe_handle() needs a
> ftrace_test_recursion_trylock() call.

Oops, I got it. Is preempt_count_add() tracable? If so, kprobe_busy_begin()
should be updated.

Thanks,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
