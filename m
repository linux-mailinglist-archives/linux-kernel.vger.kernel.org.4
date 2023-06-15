Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9337731E14
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbjFOQo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjFOQny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:43:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A446295B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686847370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HZM2vtH55xi0S4vEAkx6S6svO24oEkr7PlvNJlkl05c=;
        b=NzozyBtubHOH/ggngcr8iL0KlhMXlZSYTBos2RQKwhIA+X18J2v8Oi+E43ZjzgOcEsmu0K
        hTSEYnWvKA7tT2MZ70WuRGBlFJvJt+ej6H4QHPtcgPSP9/WCt+Z3K/MqjcnLaceugsJwB3
        y4ER7AgjbNp/kHKlfjsfy4Yz8KMgXBI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-MOng7-McN6OOA6qtJv3kmQ-1; Thu, 15 Jun 2023 12:42:49 -0400
X-MC-Unique: MOng7-McN6OOA6qtJv3kmQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b1b44bec2bso18379441fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:42:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686847367; x=1689439367;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZM2vtH55xi0S4vEAkx6S6svO24oEkr7PlvNJlkl05c=;
        b=XuMU/Y8o9DY0CFVdKp8WtPLVS4w17f9KEICggdYONbF12Os1QOffVLHfLCoxhxqh5P
         TjLxs/XhB0JmtBmYxijYezM+L0T4/P2clS9ms/1LsAaAnrYWjbCtlz4FaaJGQCnjDyJB
         WKEQsFyz6V7vNx1PLQ0nto7s92wRClpdAc75Sjm1NtU/SrNWvP+COHOFE/zDwFL8bfNI
         tzbvTkizcMmbW1THf2Thng71d2/VfR2e/ssVowm7CSYFi2JQEFsMiFFXjN9ENVTbYtX2
         NyE8/jFz9zllaTWv7TZ605rO4yGbNa26VLva34tcyuVWJzSJKhFNanHYoncF/Sm2heNM
         +ocg==
X-Gm-Message-State: AC+VfDzq7VTAxvkJ98xTJG4N7uxqh7rKCNsp49XUTOaiR0iyCwl4hQ8d
        E4mgmV4AIcKcp/tcOa69vuNO2tk9b8D7sCXL+ALu/HpJfPG/jTayB+TBARh9fCN6qb0injhyFkV
        khYXxO79FWOA7o/6C+fKy/cUu
X-Received: by 2002:a05:6512:550:b0:4f8:4980:d006 with SMTP id h16-20020a056512055000b004f84980d006mr490823lfl.60.1686847367722;
        Thu, 15 Jun 2023 09:42:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6c1Dq0etvLoNH9774/Prm7CcFtZu8Y3f+rKibODYz7gbUeA1dNQmjfP9L4AqYhVkPPVSHUgA==
X-Received: by 2002:a05:6512:550:b0:4f8:4980:d006 with SMTP id h16-20020a056512055000b004f84980d006mr490814lfl.60.1686847367344;
        Thu, 15 Jun 2023 09:42:47 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id c2-20020a5d5282000000b002fae7408544sm21512116wrv.108.2023.06.15.09.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 09:42:46 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Leonardo Bras <leobras@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Leonardo Bras <leobras@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v5 2/2] trace,smp: Add tracepoints for scheduling
 remotelly called functions
In-Reply-To: <20230615065944.188876-7-leobras@redhat.com>
References: <20230615065944.188876-3-leobras@redhat.com>
 <20230615065944.188876-7-leobras@redhat.com>
Date:   Thu, 15 Jun 2023 17:42:46 +0100
Message-ID: <xhsmh4jn8y8vt.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/23 03:59, Leonardo Bras wrote:
> Add a tracepoint for when a CSD is queued to a remote CPU's
> call_single_queue. This allows finding exactly which CPU queued a given CSD
> when looking at a csd_function_{entry,exit} event, and also enables us to
> accurately measure IPI delivery time with e.g. a synthetic event:
>
>   $ echo 'hist:keys=cpu,csd.hex:ts=common_timestamp.usecs' >\
>       /sys/kernel/tracing/events/smp/csd_queue_cpu/trigger
>   $ echo 'csd_latency unsigned int dst_cpu; unsigned long csd; u64 time' >\
>       /sys/kernel/tracing/synthetic_events
>   $ echo \
>   'hist:keys=common_cpu,csd.hex:'\
>   'time=common_timestamp.usecs-$ts:'\
>   'onmatch(smp.csd_queue_cpu).trace(csd_latency,common_cpu,csd,$time)' >\
>       /sys/kernel/tracing/events/smp/csd_function_entry/trigger
>
>   $ trace-cmd record -e 'synthetic:csd_latency' hackbench
>   $ trace-cmd report
>   <...>-467   [001]    21.824263: csd_queue_cpu:        cpu=0 callsite=try_to_wake_up+0x2ea func=sched_ttwu_pending csd=0xffff8880076148b8
>   <...>-467   [001]    21.824280: ipi_send_cpu:         cpu=0 callsite=try_to_wake_up+0x2ea callback=generic_smp_call_function_single_interrupt+0x0
>   <...>-489   [000]    21.824299: csd_function_entry:   func=sched_ttwu_pending csd=0xffff8880076148b8
>   <...>-489   [000]    21.824320: csd_latency:          dst_cpu=0, csd=18446612682193848504, time=36
>

Nit: these commands now need a s/smp/csd/.

I played with those a little more and found out how to record the src CPU,
so feel free to update the changelog with this:

  $ echo 'hist:keys=cpu,csd.hex:ts=common_timestamp.usecs:src=common_cpu' >\
       /sys/kernel/tracing/events/csd/csd_queue_cpu/trigger
  $ echo 'csd_latency unsigned int src_cpu; '\
       'unsigned int dst_cpu; '\
       'unsigned long csd; u64 time' >\
       /sys/kernel/tracing/synthetic_events

  $ echo 'hist:keys=common_cpu,csd.hex:
  time=common_timestamp.usecs-$ts:
  onmatch(csd.csd_queue_cpu).trace(csd_latency,$src,common_cpu,csd,$time)' >\
       /sys/kernel/tracing/events/csd/csd_function_entry/trigger

  $ trace-cmd record -e 'synthetic:csd_latency' hackbench
  $ trace-cmd report
  <idle>-0     [001]   115.236810: csd_latency:          src_cpu=7, dst_cpu=1, csd=18446612682588476192, time=134
  <idle>-0     [000]   115.240676: csd_latency:          src_cpu=7, dst_cpu=0, csd=18446612682588214048, time=103
  <idle>-0     [009]   115.241320: csd_latency:          src_cpu=7, dst_cpu=9, csd=18446612682143963384, time=83
  <idle>-0     [007]   115.242817: csd_latency:          src_cpu=8, dst_cpu=7, csd=18446612682150759032, time=93
  <idle>-0     [005]   115.247802: csd_latency:          src_cpu=7, dst_cpu=5, csd=18446612682144441144, time=114
  <idle>-0     [005]   115.271775: csd_latency:          src_cpu=7, dst_cpu=5, csd=18446612682144441144, time=151
  <idle>-0     [000]   115.279620: csd_latency:          src_cpu=7, dst_cpu=0, csd=18446612682588214048, time=87
  <idle>-0     [000]   115.281727: csd_latency:          src_cpu=7, dst_cpu=0, csd=18446612682588214048, time=101

> Suggested-by: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: Leonardo Bras <leobras@redhat.com>

Other than that:

Tested-and-reviewed-by: Valentin Schneider <vschneid@redhat.com>

