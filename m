Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F262724506
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237082AbjFFN5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjFFN5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:57:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFADEA;
        Tue,  6 Jun 2023 06:57:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F092362B56;
        Tue,  6 Jun 2023 13:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776A5C433D2;
        Tue,  6 Jun 2023 13:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686059866;
        bh=1XimwSdyXH2oglyzv+81BdF7NcczgquiFpGy/uF6ygA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dGCCBhIwBrVtp6x2lIqHh5e91Cd7rkMAguZcuDqKExD7WKm0loo/LZG4ZOtnr/C37
         HpztzSDkB+tMNwOlGZShCZoDpRtPG7r0cZa8wS62jmHgtCAYbMV3Tk38lS97zxKnoA
         7rdgMZG3FIjcgLwp2EaJ8snYe6Rp9HuHWvJz3faNRqXPXRcd3cW59lfG8zlgYHhjuJ
         qiLgf9xgZJ2phb6KDGJLaW+TYIvzfKriLTYytZ7w3UJ4EuoQ4wJZ3ev6xZNFmcDSD5
         J1m0v4yY3y5tAIk2V7Mywn189byaq57oteV+dkkCo5TzNFbB2s4FVhH7S+waHqPgSi
         GEL04xIRDOpXQ==
Date:   Tue, 6 Jun 2023 22:57:41 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Beau Belgrave <beaub@linux.microsoft.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Vernet <void@manifault.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dthaler@microsoft.com, brauner@kernel.org, hch@infradead.org
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
Message-Id: <20230606225741.a9d8003a22451db96545b5a8@kernel.org>
In-Reply-To: <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
References: <20230508163751.841-1-beaub@linux.microsoft.com>
        <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
        <20230509130111.62d587f1@rorschach.local.home>
        <20230509163050.127d5123@rorschach.local.home>
        <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
        <20230515192407.GA85@W11-BEAU-MD.localdomain>
        <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 16 May 2023 17:36:28 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> BPF progs have three ways to access kernel tracepoints:
> 1. traditional tracepoint

This is the trace_events, which is used by ftrace, right?

> 2. raw tracepoint
> 3. raw tracepoint with BTF
> 
> 1 was added first and now rarely used (only by old tools), since it's slow.
> 2 was added later to address performance concerns.
> 3 was added after BTF was introduced to provide accurate types.
> 
> 3 is the only one that bpf community recommends and is the one that is used most often.
> 
> As far as I know trace_events were never connected to bpf.
> Unless somebody sneaked the code in without us seeing it.

With this design, I understand that you may not want to connect BPF
directly to user_events. It needs a different model.

> 
> I think you're trying to model user_events+bpf as 1.
> Which means that you'll be repeating the same mistakes.

The user_events is completely different from the traceppoint and
must have no BTF with it.
Also, all information must be sent in the user-written data packet.
(No data structure, event if there is a structure, it must be fully
contained in the packet.)

For the tracepoint, there is a function call with some values or
pointers of data structure. So it is meaningful to skip using the
traceevent (which converts all pointers to actual field values of
the data structure and store it to ftrace buffer) because most of
the values can be ignored in the BPF prog.

However, for the user_events, the data is just passed from the
user as a data packet, and BPF prog can access to the data packet
(to avoid accessing malicious data, data validator can not be
skipped). So this seems like 1. but actually you can access to
the validated data on perf buffer. Maybe we can allow BPF to
hook the write syscall and access user-space data, but it may
not safe. I think this is the safest way to do that.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
