Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784015B6DFD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 15:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbiIMNJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 09:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbiIMNJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 09:09:16 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1DE558D1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 06:09:02 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id q17so412073lji.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 06:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=UFtD5M/leAKWSJsauM4L+rY2d6l+0yYTOQ146z3FD+g=;
        b=WKiFtYj7nnRHY3jatJLR4PJ0pVYQ9Y1vh0mJ968wJQxIi9jFl69bj0fievdGirkNB5
         rx4lt0aVQsB7fG2iJRBl1wN/Zdx2CC1y5yDhgSMxez+/abHL2DMjAsxcltQmKsUVlcu6
         ++1fIPHIMsOfSMZKfHQnWBwP8HOJng46ZtDjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=UFtD5M/leAKWSJsauM4L+rY2d6l+0yYTOQ146z3FD+g=;
        b=7Vd70FR2Wk+xgLr4DU3PCend9VLBLb6hfAItR2ZH5S2XJ1jlnP9un5WIKH7txNRFh/
         rhKUJRU9AbrpuNDDBZRBzthndAR7b9g+6/GkuBmoPhAo1SB39/Fs5ha46XwHizoOIffr
         9RoQa7eCIHRm9nLu18a3MFN5djmPwX4wvYGCzmPtYrptt7+nwzwig5mRxQ1IelqSq6Ml
         SP0rG9UdasVcDHIEAtR1iayq9On/vlK7zkH2cYrMcjCsvm6mQdgq4JBHtlsTAho0C/jm
         /NB5ddJaW9uy0xI2Sl9GKTLbT/NRu3+hgnC/AHiwsoFlEUhqRWYiM36XrA/b1Tp5aNV7
         hrug==
X-Gm-Message-State: ACgBeo0+UoSA1Lo3KUNCh9zI8z48U5zhyiAs26peAJafVZ9mNOArRELW
        2pKZ+gPxbMdT+2rAmOvfVSAotJS/20jkivFqsQQ=
X-Google-Smtp-Source: AA6agR77CObfIUyfyIWhO86v2jN2IlzrlydL05ZIgKgdtr5AE0SunahPnG1py5/IncWI7LJy7BjWmQ==
X-Received: by 2002:a05:651c:1791:b0:261:c72d:70b0 with SMTP id bn17-20020a05651c179100b00261c72d70b0mr9693704ljb.164.1663074540010;
        Tue, 13 Sep 2022 06:09:00 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id u7-20020ac258c7000000b004946748ad4dsm1704401lfo.159.2022.09.13.06.08.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 06:08:58 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id u18so19998212lfo.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 06:08:57 -0700 (PDT)
X-Received: by 2002:a05:6512:41c:b0:497:a5fe:f39f with SMTP id
 u28-20020a056512041c00b00497a5fef39fmr11349100lfk.291.1663074537263; Tue, 13
 Sep 2022 06:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220902130625.217071627@infradead.org> <20220902130947.190618587@infradead.org>
 <CAHk-=whdvPcHmH5eG+FUrbQw1e-05n__EWobMqbxcCTP7dtZAg@mail.gmail.com>
 <YxI+K8Y+f/FHSQCU@hirez.programming.kicks-ass.net> <CAHk-=wjRLehUO=u8HDJGRFv+wz7hakSc=z6eTg547pAmb0UKHg@mail.gmail.com>
 <YxXJswK9QjhCGmPN@hirez.programming.kicks-ass.net> <CAHk-=whRetwx+5Bjiee+T+Nyyi8EiZ17SM3AL8jJnXuA+WjQyQ@mail.gmail.com>
 <Yx+MBXvGLhbd7dHH@worktop.programming.kicks-ass.net> <YyA6gwtAKRwmJR53@hirez.programming.kicks-ass.net>
In-Reply-To: <YyA6gwtAKRwmJR53@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Sep 2022 09:08:48 -0400
X-Gmail-Original-Message-ID: <CAHk-=wh7f0focp2Wg-ePknkvU6Q0YkRBtDPJgn-804a7ZMu9wg@mail.gmail.com>
Message-ID: <CAHk-=wh7f0focp2Wg-ePknkvU6Q0YkRBtDPJgn-804a7ZMu9wg@mail.gmail.com>
Subject: Re: [PATCH v2 08/59] x86/build: Ensure proper function alignment
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 4:09 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Found it: https://sourceware.org/binutils/docs-2.39/as/Balign.html
>
> 7.8 .balign[wl] [abs-expr[, abs-expr[, abs-expr]]]
>
> Pad the location counter [...]

Very good. All looks sane to me then.

              Linus
