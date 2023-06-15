Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91222731E12
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbjFOQnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbjFOQnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:43:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A4B2711
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686847362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rj+HZrGceh1/5T+xxc4svlJVZP7112zLUTsVEWs0gK0=;
        b=aSEEE4SEwpMPLB8GMloJ8193FCXEB3fb6uHAYnUy1c8uqxa3GTxKYs52cO6MpbXwLFj8Ps
        XZBwtGD5b7MsyiLnGREn36Hvmc3eleggDOl7qVF/kxHk92dKO87/KO0Ael4S822sw1kzzb
        cFTD6shNXUX39Jhr4y9bJUQZuACKLtI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-FAMA0aw8NICTg3T5oAVoOw-1; Thu, 15 Jun 2023 12:42:39 -0400
X-MC-Unique: FAMA0aw8NICTg3T5oAVoOw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3110f149dd5so819232f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686847358; x=1689439358;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rj+HZrGceh1/5T+xxc4svlJVZP7112zLUTsVEWs0gK0=;
        b=JNKTXq1uozVgPhEGONw+tHREe5q1ONBkXhM08Wq7gNDbS53yekJOiyte6YXa2vYe2Z
         nAHENYXE9QLRqTbL2Rj2nohJ2dEhh2N9mbSCXq9AdpFc2EJsZ+yIHwdROyADROgFdYzS
         Yl0Rfr73SmfZDscc7QuefAv6UCx6gSatJDhpL6cWtMcld78D27o1zqg6sKCgX/C/5K/X
         OyGPznrHYbzTimUfWxcd6yAmS8LtyPoSBl9pc0YFpvmSjgW/jsJPbOlMA+aoxNBS7NFD
         0qXSMAaaCDRcpt0yUl02Ag/p/5UrhzAvvBsDufyOFZXAKFfWrY+P+QHVine4HUo3fvLW
         Lw6Q==
X-Gm-Message-State: AC+VfDwk84S4bYPIHYXuThhNW0aPnMfu2P0VMYm4/ROOyKBc72p9TqQE
        dKXaeCZRcAJtfiVtcmn+w5EaYbbeU89tYvJI4B+LA5+XfcylPCrXwvv+R2mkKSFgyNmaVmrGnL9
        VueheRGYdBSfqtCp22ZKxfGgt
X-Received: by 2002:a5d:6949:0:b0:311:101f:6c17 with SMTP id r9-20020a5d6949000000b00311101f6c17mr3191745wrw.2.1686847358414;
        Thu, 15 Jun 2023 09:42:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6huGVDbjkL6h5ZmquE64pBw+y8CBHR4bn2cBEEEyfJXfF0yPF+idvDgy8YSHCA8GN8yo54TA==
X-Received: by 2002:a5d:6949:0:b0:311:101f:6c17 with SMTP id r9-20020a5d6949000000b00311101f6c17mr3191731wrw.2.1686847358091;
        Thu, 15 Jun 2023 09:42:38 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id q7-20020adff947000000b0030af72bca98sm21375624wrr.103.2023.06.15.09.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 09:42:37 -0700 (PDT)
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
Subject: Re: [RFC PATCH v5 1/2] trace,smp: Add tracepoints around remotelly
 called functions
In-Reply-To: <20230615065944.188876-5-leobras@redhat.com>
References: <20230615065944.188876-3-leobras@redhat.com>
 <20230615065944.188876-5-leobras@redhat.com>
Date:   Thu, 15 Jun 2023 17:42:36 +0100
Message-ID: <xhsmh5y7oy8w3.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/23 03:59, Leonardo Bras wrote:
> The recently added ipi_send_{cpu,cpumask} tracepoints allow finding sources
> of IPIs targeting CPUs running latency-sensitive applications.
>
> For NOHZ_FULL CPUs, all IPIs are interference, and those tracepoints are
> sufficient to find them and work on getting rid of them. In some setups
> however, not *all* IPIs are to be suppressed, but long-running IPI
> callbacks can still be problematic.
>
> Add a pair of tracepoints to mark the start and end of processing a CSD IPI
> callback, similar to what exists for softirq, workqueue or timer callbacks.
>
> Signed-off-by: Leonardo Bras <leobras@redhat.com>

Tested-and-reviewed-by: Valentin Schneider <vschneid@redhat.com>

