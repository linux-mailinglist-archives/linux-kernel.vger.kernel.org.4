Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560487247C4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238599AbjFFPcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238303AbjFFPbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:31:55 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E72310C6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 08:31:53 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-53fdae76f3aso5710699a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 08:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686065512; x=1688657512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fb93uIfCZb6rwnwNAQwabVrOWCYJJ49ebGpWxsvxKJI=;
        b=AgiVu6Sndwe40e93jTy9pnKUfE9+dNwzO+tyuNKoZE535xQPXIUDLmMiWxrqvIEC7e
         zvyr4BqTgd96a/Xr3zXliBxN3LMmoPWMkCOLrcy2Jofl3Nk8cTu0ivu6lbZFSb35iuXT
         3a7HOak6dBDcENxcV2zpbiZApa0pjyr6JoXX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686065512; x=1688657512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fb93uIfCZb6rwnwNAQwabVrOWCYJJ49ebGpWxsvxKJI=;
        b=fZs4yG+SLb6eBoq7/fQlVY+enQHPbPiLkYNpo3Ycj3+Om96QwV7r2peKXsLh0u763k
         EOZwwF17tJzRc4wX2WJZvr4RJX+sNRWvRg06dKcO1HAGu599538Tisqa5ScsqLrUCkzY
         f5e7D8s+JCihF/nmuwo5zJ9Zirn1NAxRUmo8GGu+MTvg7NoNerfHxKQY2TCXVuOg27sG
         RWwyR6YIG8MUr4qZ634aR2OB7t7/egIwzsFwKKCGl4RjhDTI2oer61mycpgHo4wJETOd
         Wjnl7E7pwi0MfOD9KTbXU95wjuLHPhDPTSJfS8Fz8/5rOv/gWEUb27Yb8lZurQc1/Fu4
         tfSQ==
X-Gm-Message-State: AC+VfDxknPcqiemS6IaXuqS8CaAwErNFXk+fVSkXyYmg7h471QkdUXsN
        9SbD3AU7CBE37qyt5Vlgu6BuBQ==
X-Google-Smtp-Source: ACHHUZ5wlvJWwEV0/FDPWI8fFDkLmsafPFg8iYtZ2JVd7FCNya8xEv09JXlqqS9TRLhRCO66HiFQJw==
X-Received: by 2002:a17:903:1252:b0:1b0:5304:5b4e with SMTP id u18-20020a170903125200b001b053045b4emr3408817plh.43.1686065512579;
        Tue, 06 Jun 2023 08:31:52 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db8500b001a4fe00a8d4sm8685551pld.90.2023.06.06.08.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 08:31:52 -0700 (PDT)
Date:   Tue, 6 Jun 2023 08:31:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        gregkh@linuxfoundation.org, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        ndesaulniers@google.com, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, paulmck@kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Lock and Pointer guards
Message-ID: <202306060829.C2FD998CF@keescook>
References: <20230526205204.861311518@infradead.org>
 <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
 <20230530092342.GA149947@hirez.programming.kicks-ass.net>
 <20230606094251.GA907347@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606094251.GA907347@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 11:42:51AM +0200, Peter Zijlstra wrote:
> [...]
> #define scoped_guard(_guard, _var...)                                  \
>        for (__ptr_guard(_guard, scope) = guard_init(_guard, _var),     \
>             *done = NULL; !done; done = (void *)1)

nit: Linus's example was "(void *)8" (instead of 1) because we've had
issues in the past with alignment warnings on archs that are sensitive
to it. (e.g. see the __is_constexpr() macro which is doing NULL/!NULL
comparisons.)

-- 
Kees Cook
