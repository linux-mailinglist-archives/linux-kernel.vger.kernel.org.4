Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D66E600B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiJQJih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiJQJi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:38:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A73610B49
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665999494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k0+ObVJxjYz4R+98id/22xus1zUL9oOsaqVo4TwLi2Q=;
        b=XyEcxn3t4IGCDO2GajbgL7h/vKvLo6gBWq5cFpMZ4iJlBC/gEoj0lM2i/Z9rj/Sw6EAlCW
        saYUqd68Byqy1PzR7QcyDBHnvelUXDnjWpIT87FRZ6ZRHbXK/K9sOyMMLTkispTopnYbqt
        DKWtm/NGoTXRNrJlNwzdYBt2PNR3tuQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-402-a0xwzdScMqu9zUG99k7GOQ-1; Mon, 17 Oct 2022 05:38:11 -0400
X-MC-Unique: a0xwzdScMqu9zUG99k7GOQ-1
Received: by mail-qk1-f198.google.com with SMTP id i11-20020a05620a404b00b006eeb0791c1aso9150595qko.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k0+ObVJxjYz4R+98id/22xus1zUL9oOsaqVo4TwLi2Q=;
        b=2FzX8/sj87x+B7MsKHRSNxvVrjgH/OF25Z1ohDjxfsoaueCvSAphYdM77yVIWD0EQ4
         zBrdD2UENGSHvWw9/dhOgi1LbRZSn9SlC5o24kW8RKWNupAyeSvtBz4F4E7VeML3CCSC
         CScrwv4pLB7w74Lo1bbc1xqqrPtfnbqm5R5knTwAPIYxA7Swn/VnnOuhR+EPmxBlMdlZ
         jmb/vf4Uaepk3c+OW45bAUD0CMiuQUxx33cefYhEstkoDiAeBBR8lj/QBh1mj2JLO8Jl
         rCPo04X0xH8sdLx09ItlrGJxS7hsSPQfb/596N6Z0is3nr0mf1Ae5O2GX7PMwBcNHwO2
         HrTA==
X-Gm-Message-State: ACrzQf39ikm73YcIsEkZxYZU4ku4ZX1XhcT6ehBIXI5JNIrcPAUtGNbD
        nJu9B9GmTP1CFBuOAAuY5CRi1yXLuotZWobhCEC48+DCLojlBK4tKOHoNa8k6airqm1wnVEgUZc
        ZayMjsn2IvU9Ygb5L+MbmZOR5
X-Received: by 2002:ac8:5a45:0:b0:39b:ef52:ac1d with SMTP id o5-20020ac85a45000000b0039bef52ac1dmr8003341qta.419.1665999489951;
        Mon, 17 Oct 2022 02:38:09 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6CTUfAw+X1zZrOOrrHIDQ+ebHrvDwt6nhTQ3OFGV6cY8bEykWerO8WeOdYfwyKCkJEGbp/jg==
X-Received: by 2002:ac8:5a45:0:b0:39b:ef52:ac1d with SMTP id o5-20020ac85a45000000b0039bef52ac1dmr8003336qta.419.1665999489757;
        Mon, 17 Oct 2022 02:38:09 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id t200-20020a3746d1000000b006cbcdc6efedsm8788935qka.41.2022.10.17.02.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 02:38:09 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Douglas RAILLARD <douglas.raillard@arm.com>
Subject: Re: [PATCH] tracing: Add __cpumask to denote a trace event field
 that is a cpumask_t
In-Reply-To: <20221015071416.00369347@rorschach.local.home>
References: <20221014080456.1d32b989@rorschach.local.home>
 <xhsmh8rlixqvu.mognet@vschneid.remote.csb>
 <20221015071416.00369347@rorschach.local.home>
Date:   Mon, 17 Oct 2022 10:38:07 +0100
Message-ID: <xhsmh5ygiyem8.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/22 07:14, Steven Rostedt wrote:
> On Fri, 14 Oct 2022 18:21:41 +0100
> Valentin Schneider <vschneid@redhat.com> wrote:
>> 
>> Thanks for spinning this out so quickly! I gave it a test against my IPI
>> tracepoints, it's working OK with one (expected) change:
>
> No problem. It was my "While traveling I pick what I want to work on" project ;-)
>
>> 
>>   [ipi:ipi_send_cpumask] function __get_cpumask not defined
>>   CPU 0 is empty
>>   CPU 1 is empty
>>   CPU 3 is empty
>>   cpus=4
>>             echo-173   [002]    11.859745: ipi_send_cpumask:     [FAILED TO PARSE] cpumask=ARRAY[02, 00, 00, 00, 00, 00, 00, 00] callsite=0xffffffff81121013
>> 
>> so libtraceevent is going to need updating - I'm happy to do that (if you
>> haven't done it already!)
>
> I have not done that. I'm happy to take a patch from you.
>

I'll go do that and try to mess around the pretty-print output as well.

>> 
>> Lastly, given all cpumasks have a (usable) size of nr_cpumask_bits, we can
>> factor out the size argument, see below. Regardless:
>
> Seems reasonable. I can fold that into my patch and if you reply back
> with your signed-off-by tag, I'll include you as co-author.
>

