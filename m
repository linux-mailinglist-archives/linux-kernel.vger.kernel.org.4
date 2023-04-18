Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3B26E5EB3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 12:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjDRK0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 06:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjDRK01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:26:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6AB7293;
        Tue, 18 Apr 2023 03:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yTYgBBFeDT8h7bLeYqw/kwbnda+Hc1PoEHbSEaD3hrs=; b=qEs+5oaoOO8N+QZGEIe1w5vR7U
        qol2vh9CDIMsIfLSCDbFFEZy6wipIV2NAHn+oWsFWmynYFfgYLLveS8EuW5mnEbSj8dM1mPT//aly
        Nc49PKyZgyIQ8/mf/xInf8YIm2pzGvEbEygIfe7nmj1Y45gC1HSYsBQ1eLZONTbATnb8UWVQWLW2b
        AOKbVcRd/8+D1QDNZKSnkZyqxbfwVmH0PkcC+igbR8IJSGBf3jNbic9f31c4Zo7RQeSRtNs1Goa7B
        2DUJjvT+o6Auh2n1kxxWoGteHMylo5I8g+xOBKJH9zEVfU1TCzhPnUAiXFTZ5cPmMbejsLfWCYj4t
        CdHmHcBg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1poiWy-000Qyf-22;
        Tue, 18 Apr 2023 10:25:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 52090300237;
        Tue, 18 Apr 2023 12:25:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1C0D02C541612; Tue, 18 Apr 2023 12:25:45 +0200 (CEST)
Date:   Tue, 18 Apr 2023 12:25:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/core: Fix perf_sample_data not properly initialized
 for different swevents in perf_tp_event()
Message-ID: <20230418102545.GX4253@hirez.programming.kicks-ass.net>
References: <20230412095240.181516-1-yangjihong1@huawei.com>
 <20230417114512.GK83892@hirez.programming.kicks-ass.net>
 <15805714-27c0-b8ff-143a-8f768704a673@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15805714-27c0-b8ff-143a-8f768704a673@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 09:35:23AM +0800, Yang Jihong wrote:

> > I'm thinking perhaps those flags that update ->dyn_size are the problem?
> > At the same time, Should you not also then clear dyn_size?

> Yes, according to the code, dyn_size should also be cleared.
> Maybe we need to change it to the following, which would be more
> appropriate?
> 
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10144,14 +10144,14 @@ void perf_tp_event(u16 event_type, u64 count, void
> *record, int entry_size,
>                 },
>         };
> 
> -       perf_sample_data_init(&data, 0, 0);
> -       perf_sample_save_raw_data(&data, &raw);
> -
>         perf_trace_buf_update(record, event_type);
> 
>         hlist_for_each_entry_rcu(event, head, hlist_entry) {
> -               if (perf_tp_event_match(event, &data, regs))
> +               if (perf_tp_event_match(event, &data, regs)) {
> +                       perf_sample_data_init(&data, 0, 0);
> +                       perf_sample_save_raw_data(&data, &raw);
>                         perf_swevent_event(event, count, &data, regs);
> +               }
>         }

That is certainly the safe option. I just went through the list and
while there's certainly a number of options we'll recompute for naught,
most of them are indeed either dyn_size or event specific :/

So yeah, please send the above as v2.
