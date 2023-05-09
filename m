Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274E76FC9B4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbjEIO6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbjEIO6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:58:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C1C3A91;
        Tue,  9 May 2023 07:58:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE4AB612FB;
        Tue,  9 May 2023 14:58:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A0FC4339B;
        Tue,  9 May 2023 14:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683644317;
        bh=Ffwc6yixBA33c4FR7+/arec40SIAgdtCi0uPwyVdUPw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dTjlHcy2vPjOYK+z7CuW6mjbAVHR4pqQC532Cci6uSBkF9uKW6M1znrhUlNDV+WiI
         RiII5z54WktPe25hk1T7nVFk2StDsneZaUfqUmOQC1nkzY9jqe9Eoz6iAzWUFGZoT4
         Mf0EvUTFlMia42cvqvhKzI/++N7R6F2HDvBZzCN/Ebwc2Fw71LU8vEzGdPe6xsL83d
         sSwqHEih+xl6JBaSG1J1Gojvmsfr6SopW2SNEzkgDVZlQ6/87ODrOT2DsYSiJcTorU
         anz8vfOr2FOyuix0Bl9aVTsJsb0lI0tfZYanuBOrysCsRuvJRxdWqA7WtZELl1bdmJ
         wSNIjoKMajaCg==
Date:   Tue, 9 May 2023 23:58:32 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v9.1 11/11] Documentation: tracing/probes: Add fprobe
 event tracing document
Message-Id: <20230509235832.3499572829aa62b414082693@kernel.org>
In-Reply-To: <20230505112026.6a46bcec@gandalf.local.home>
References: <168299383880.3242086.7182498102007986127.stgit@mhiramat.roam.corp.google.com>
        <168299393654.3242086.4099482065080890890.stgit@mhiramat.roam.corp.google.com>
        <20230505112026.6a46bcec@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 May 2023 11:20:26 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue,  2 May 2023 11:18:56 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > + # cat events/fprobes/myprobe/format
> > + name: myprobe
> > + ID: 1313
> > + format:
> > + 	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
> > + 	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
> > + 	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
> > + 	field:int common_pid;	offset:4;	size:4;	signed:1;
> > +
> > + 	field:unsigned long __probe_ip;	offset:8;	size:8;	signed:0;
> > + 	field:u64 count;	offset:16;	size:8;	signed:0;
> > + 	field:u64 pos;	offset:24;	size:8;	signed:0;
> 
> git complained when I pulled this in because there above lines is:
> 
> <space><tab>field...
> 
> Where, the space should be removed.

Ah, OK. I just added a head space for each line... (hmm, checkpatch.pl may not check it?)

I'll fix it.

Thank you!

> 
> -- Steve
> 
> > +
> > + print fmt: "(%lx) count=%Lu pos=0x%Lx", REC->__probe_ip, REC->count, REC->pos


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
