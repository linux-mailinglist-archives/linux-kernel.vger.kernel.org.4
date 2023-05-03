Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EAE6F5B90
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 17:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjECPyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 11:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjECPyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 11:54:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A371B4EEA
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 08:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683129238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zaXOdx5RzMMt9je58DC++0q1DfDYxLeLjbzEKbIDLkc=;
        b=SerW/ehLW142TgPjUcKxEmAE5txnR/RPaljXFjOGoiTIkWYRxSakZ55Pbp1zUjbsjzoGwc
        YAUql+SkGn2RT8W5DSca/W7QEkZBY56RiSbhAyo0DvsrHJa95InuBlWE3LyTJvLPXYzuDA
        i26sZyPA+bH4pIL6FHChY9TsoTgAchs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-5P-_Gko8PtuhfeppkxJNqQ-1; Wed, 03 May 2023 11:53:58 -0400
X-MC-Unique: 5P-_Gko8PtuhfeppkxJNqQ-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f17f39d3deso68594151cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 08:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683129237; x=1685721237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zaXOdx5RzMMt9je58DC++0q1DfDYxLeLjbzEKbIDLkc=;
        b=G1ZQ6jJGCJlTNomwoHIEtHwBAgRzL6aVbxzhKeYkz32oGmY9bLE68dro8pUtiv+S1i
         YnJ9a/6rRPbNrb2ClVn7gRpXsmX/QRy5cvb641hl8B4IhLKBc8tnKM6497azVHApiSkW
         5DKEESoC6xGVZF7U079pqpmntKK9Hg+xT7zdZerGyx5CGQbzp/2CarUSmdYvA5eTzemF
         4jnEnYatCHfpZ4pr61Td3Fg1upXUtf+rZMvt2YfpWvHjQEB328e9IkMiLsb0py14ALHA
         LbMc+JVkWK5I1EZC7TQxeWEt+BDnUXIF978LE5LC1Auk7myM/ORsl0cx/BpSiDhMDvuK
         CQuQ==
X-Gm-Message-State: AC+VfDyL83dkidLOOu3apyzPylFGZMOxhKuNwx1Ocw5OM5TV2QL59VNk
        MuOSjHA+4gpqVj8sQUUmu2P0HYLvb+AvRWjYIHG18DnAKkgNik3qesk0TXGzpmFidj8GQTL4e33
        dc0RyrhrCc/YZoJg7krll0AXBZg4y73S1+qvVqK0Z
X-Received: by 2002:ac8:5e50:0:b0:3e6:459c:1312 with SMTP id i16-20020ac85e50000000b003e6459c1312mr920208qtx.11.1683129237589;
        Wed, 03 May 2023 08:53:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6rvaqv1WbZEfZYS183wbZtAC3JfsVneO2IeD3Z+R1CbnjLfvSWoJ/+hTw9/OwgxWpY1iS8Akingxz9eUoCZBk=
X-Received: by 2002:ac8:5e50:0:b0:3e6:459c:1312 with SMTP id
 i16-20020ac85e50000000b003e6459c1312mr920183qtx.11.1683129237340; Wed, 03 May
 2023 08:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230406075718.68672-1-leobras@redhat.com> <20230406095519.GG386572@hirez.programming.kicks-ass.net>
 <f294a74cd17bf932621a6a746d592f49770d25ec.camel@redhat.com> <20230503145900.GC1689514@hirez.programming.kicks-ass.net>
In-Reply-To: <20230503145900.GC1689514@hirez.programming.kicks-ass.net>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Wed, 3 May 2023 12:53:44 -0300
Message-ID: <CAJ6HWG44mSBBVK28rH4WyG4777iAnwWE5KqWaPemj8SSpohJ9Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] smp: Add tracepoints for functions called with smp_call_function*()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yury Norov <yury.norov@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 3, 2023 at 12:17=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Apr 19, 2023 at 12:45:08AM -0300, Leonardo Br=C4=AFs wrote:
> > On Thu, 2023-04-06 at 11:55 +0200, Peter Zijlstra wrote:
> > > On Thu, Apr 06, 2023 at 04:57:18AM -0300, Leonardo Bras wrote:
> > > > When running RT workloads in isolated CPUs, many cases of deadline =
misses
> > > > are caused by remote CPU requests such as smp_call_function*().
> > > >
> > > > For those cases, having the names of those functions running around=
 the
> > > > deadline miss moment could help finding a target for the next impro=
vements.
> > > >
> > > > Add tracepoints for acquiring the funtion name & argument before en=
try and
> > > > after exitting the called function.
> > > >
> > > > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > >
> > > How are the patches queued there not sufficient?
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=3D=
smp/core
> > >
> >
> > IIUC the last commits add tracepoints that are collected in the
> > requesting CPU, at the moment of scheduling the IPI, which are also use=
ful in
> > some scenarios.
> >
> > On my scenario, it could help a little, since it makes possible to filt=
er what
> > all other cpus are scheduling on the requested cpu. OTOH it could be al=
so be
> > misleading, as the requested cpu could be running something that was sc=
heduled
> > way before.
> >
> > The change I propose does exactly what my scenario need: track exactly =
which
> > function was running at given time in the requested CPU. With this info=
, we can
> > check which (if any) remotely requested function was running on given t=
ime
> > window.
>
> I was thinking you could simply (graph)-trace
> __flush_smp_call_function_queue() with a max_graph_depth or so (Steve
> says that ought to work).
>
> But even that might be too specific, your use case sounds more like what
> we have the irq-off latency tracer for, and that thing will immediately
> tell you what functions were being ran.
>
> > (An unrelated thing I just thought: We could even use the commits you p=
ointed
> > together with my proposed change in order to measure how long does it t=
ake for a
> > requested function to run / complete in the requested cpu)
>
> I don't think you could actually do that; the send tracepoints Valentin
> added don't log the csd address, this means you cannot distinguish
> two CSDs with the same function send from different CPUs.
>
> To do this you'd need to add the csd address to the the ipi_send
> tracepoints and your own (possibly replacing info -- because I don't
> think that's too useful).

Sure, I will improve this in my patch.

You think I should rebase it on top of tip/smp/core in order to add it
to the set?

Thanks!
Leo

>
> Valentin -- is any of this something you'd also find useful?
>

