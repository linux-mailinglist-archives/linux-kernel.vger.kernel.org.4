Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DA5714883
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 13:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjE2Laf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 07:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE2Laa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 07:30:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAE6CF
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685359783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6jQOvr1FoT9F+vm6bP7o3spkjulMXlkn4v1chopkl7w=;
        b=JP15gE94jLq083d36mk2y1Jk2N2wXaT/gkx94HKjd2I3SWZNr6+rsdrJqIJgq1SncXZKN5
        1XwpDXA6anwN7HFjmKVSzKaCpFyShmgxhcPYFPmcXN/cEwPYvRnoqB/fp9NU19+0hzkpYA
        aS26FOlFgOEBh8BTvDvWPmdi3e5HVVU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-x9b3VYAZPGeiRWr1xXTSUQ-1; Mon, 29 May 2023 07:29:41 -0400
X-MC-Unique: x9b3VYAZPGeiRWr1xXTSUQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-96faa650a3fso372503666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685359780; x=1687951780;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6jQOvr1FoT9F+vm6bP7o3spkjulMXlkn4v1chopkl7w=;
        b=jVWvTw2ZcwAY/JIFPuT6GhxxlnJFKdbGhOUO55KmYCpeSC8k9aNTu6XK6/qYgnLxQa
         bgXIMu4njemu0u4fasSpXJCQ9ZDVh+pmcHK24TNkNK85xqHLNkvwDTxPqwrPkUCzBoeN
         gwtL4DqsZ0fxsS7BfiC0rCWXT/FtXrRx9BwqUAXGmAXjW34vHszuu/uHZ1zAVJCjopJf
         RITAFdaf27NTeW71EnbXMfKmRZCLs0q4QW+NvOo/ZMbjSb3ygnfMBUsYdMxrAduLA6Ct
         CXyu51XZHFcesqJJnlV+wupdT9bwW7V1GbQkQfHKCwGQmlEz33e3mbs95iU9ZsWIIHIl
         mN0g==
X-Gm-Message-State: AC+VfDzmski9WR8C8Mp32Sb6N+BRnHK1FSJ0Vsaz2D08c/5VgJlZwLFJ
        Z6+ncFzNox45PSTVvJj/HbuyYyAKesNZBPWiGErOJ5No0BR25t9Ym+pMkSTKASKveJSkqbcMXRS
        VTubJ75c9ComggOyOLK51rEYWpUcmn4XN
X-Received: by 2002:a17:907:701:b0:965:6aff:4f02 with SMTP id xb1-20020a170907070100b009656aff4f02mr11397834ejb.41.1685359780545;
        Mon, 29 May 2023 04:29:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ44NKXoCyFgN0hex48Ea3hLzLVI/2blAe40TjmmmtaVCWA1memQAsehlhyyjwO22MVQDW+uqg==
X-Received: by 2002:a17:907:701:b0:965:6aff:4f02 with SMTP id xb1-20020a170907070100b009656aff4f02mr11397814ejb.41.1685359780194;
        Mon, 29 May 2023 04:29:40 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id gr10-20020a170906e2ca00b0096ace550467sm5885210ejb.176.2023.05.29.04.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 04:29:39 -0700 (PDT)
Message-ID: <bed45ea4-12e0-5a96-6196-9903b45178f2@redhat.com>
Date:   Mon, 29 May 2023 13:29:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC][PATCH 0/2] Lock and Pointer guards
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        torvalds@linux-foundation.org, keescook@chromium.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, ojeda@kernel.org,
        ndesaulniers@google.com, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, paulmck@kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        qiang1.zhang@intel.com, rcu@vger.kernel.org, tj@kernel.org,
        tglx@linutronix.de
References: <20230526150549.250372621@infradead.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230526150549.250372621@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/23 17:05, Peter Zijlstra wrote:
> My initial (failed) attempts tried to combine __cleanup, _Generic and
> __auto_type, but the compilers refused. I've also Googled around and found
> (among many others) the QEMU and Glib guards. However I don't like them because
> they end up relying on function pointers/indirect calls.
> 
> Hence the current pile of CPP hackery.. no indirect calls in sight.

QEMU's guards in practice also compiles down to direct calls, but yes 
that's only after the compiler inlines everything in the vtable.  I did 
it that way because the polymorphic locks already existed before, 
otherwise your solution with Linus's tweak for "bool" is as nice as it 
can be.  I like that it extends to irqoff and irqsave sections.

Paolo

