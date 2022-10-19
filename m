Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF71E603940
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 07:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJSFcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 01:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJSFcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 01:32:12 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0227733F1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:32:08 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d10so16219339pfh.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=anrzvwqvfhQAst0P6tYGgAW9i0wdW47/jhNxqEEYWDw=;
        b=gIsCyeKmYfkLG7tWZlC+hY2BVP6eyEj4kDopxn7zBXM8dOZIf1GS3OW2SchSWIVUBa
         7UYsnZPFKapUzoPI9fcQlGzQ/dZJVAxB+/WFv2M7OYuIcoQK/5doncQcM3MZK55kipE5
         j435VfachyFKqyVNPobTHpE4Qiqa7hw0enOuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anrzvwqvfhQAst0P6tYGgAW9i0wdW47/jhNxqEEYWDw=;
        b=3kEF4EP9XglpUtcmztdB+uWbEGj0BazduDa62UEcNy8QpPTg27hDpEprXvWCL4yRaz
         5I0c7E95U1f+/9QPJFHF7cY3cjAePl5hiduHnKG+DbJ5MBIYgW8R4qDuuS/+cTBvFN2s
         hF6DGrUl15ESgWTozh/H77eMsdl06bLnFo2hNNZIGFKVWdXaSuA7CAhlkpMoGPZMK0LC
         2KIZQiJZooUlUTQdqxz3SXd0yYnuhwBLQU2qXtNGRW6IBI9RU1pqeYy5NsAjmi2OsE8z
         vPpRAJOCp9LhVXbbs6mbMZzOe0Ry2/s4QYGzIIzcvrQLwIB/TyGTmeekG9v3CYroYsU/
         7XaA==
X-Gm-Message-State: ACrzQf1JbCaewvzNgl4P6WEk2zMzYw46a+pkHiUCdtfDjrs2agAaEgiq
        6gX+VCOwFsUOh4TfS+j50WHjgg==
X-Google-Smtp-Source: AMsMyM4pdUMQ32B/7SdAynxwG561I+J30C0V/h+K0TRNWb97K7H/mwxoNPhM8E/3ILdciQJBS+yqQw==
X-Received: by 2002:a65:6bc7:0:b0:44a:dcee:18a5 with SMTP id e7-20020a656bc7000000b0044adcee18a5mr5665720pgw.413.1666157527816;
        Tue, 18 Oct 2022 22:32:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l11-20020a170903120b00b0017f74cab9eesm9755946plh.128.2022.10.18.22.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 22:32:07 -0700 (PDT)
Date:   Tue, 18 Oct 2022 22:32:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joao Moreira <joao@overdrivepizza.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
Message-ID: <202210182222.64C2D87E0@keescook>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <202210181020.79AF7F7@keescook>
 <5094174a77cdc44cf50c346bf1617555@overdrivepizza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5094174a77cdc44cf50c346bf1617555@overdrivepizza.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 12:59:42PM -0700, Joao Moreira wrote:
> Kees said:
> > I still think it's worth noting it does technically weaken the
> > "attacker-controlled executable memory content injection" attack
> > requirements, too. While an attacker needs to make sure they place an
> > ENDBR at the start of their injected code, they no longer need to also
> > learn and inject the CFI hash too, as the malicious code can just not
> > do the check at all. The difference in protection currently isn't much.
> > 
> > It's not a very difficult requirement to get attacker-controlled bytes
> > into executable memory, as there are already existing APIs that provide
> > this to varying degrees of reachability, utility, and discoverability --
> > for example, BPF JIT when constant blinding isn't enabled (the
> > unfortunate
> > default). And with the hashes currently being deterministic, there's no
> > secret that needs to be exposed first; an attack can just calculate it.
> > An improvement for kCFI would be to mutate all the hashes both at build
> > time (perhaps using the same seed infrastructure that randstruct depends
> > on for sharing a seed across compilation units), and at boot time, so
> > an actual .text content exposure is needed to find the target hash
> > value.
> > 
> If we look back at how well ASLR did over the years I think we can't really
> rely that randomizing the hashes will solve anything. So what you are
> suggesting is that we flip a "viable defence against SpectreBHB" for a
> randomization-based scheme, when what we really should be doing is getting
> constant blinding enabled by default.

I don't think any of these things are mutually exclusive. The
randomization means an additional step (and possibly additional primitive)
is needed for an attack chain. Since we get this from a one-time cost
on our end, that seems like reasonable value.

> At this point I feel like going on is a bit of bike-shedding, but if this
> really matters, below is how to use randomization on FineIBT. Maybe with lot
> less entropy, but just ideas thrown that could be improved over time (don't
> take this as a serious proposal):
> 
> Assuming we got 16 bytes padding to play with on each function prologue, you
> can randomize between 0-11 in which offset you emit the ENDBR instruction.
> Caller/Callee would look like (hopefully I did not mess-up offset):
> 
> <caller>:
> and 0xf3, r11b
> call *r11
> 
> <callee>:
> nop
> nop
> nop
> endbr // <- this position is randomized/patched during boot time.
> nop
> nop
> ...
> 
> And of course, you get more entropy as you increase the padding nop area.

Oh, I kind of like this -- it'd need to be per matching hash. This would
require roughly 3 bits of entropy exposure of the .text area. For X^R,
that becomes annoying for an attacker, though likely once close enough,
multiple attempts could find it, assume panic_on_oops/warn wasn't set.

Anyway, this sounds like an interesting idea to keep in our back
pocket...

-- 
Kees Cook
