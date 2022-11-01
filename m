Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6912861545D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 22:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiKAVkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 17:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKAVkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:40:00 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D0F1CB13
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 14:39:59 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id m6so14698670pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 14:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=siwkIyyuZG4xeCnv0VHeDjVH84W8UaMBkojoiy/guyY=;
        b=YF5jK69caQWmV8rcz8CcyGGg1pBFJHi5clEcGtY4Tsu88X8eF45VcArWfaq3qhBmus
         1VbOOCvBkQ1jmI/01o3/YQ2r38jr/IdGypjkEoMSLitJgzkmt4h70HcXtrIlu7iJdT/i
         HWl8GvMcWBVfbvqZIXyAPQT45jDdNWrweF8Ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siwkIyyuZG4xeCnv0VHeDjVH84W8UaMBkojoiy/guyY=;
        b=0CEtCRXbxRslp1zb4C6O4SsuqgBIfBkggbwvGeESwS++cU1ajLvCaMAv+p3ZtIB37a
         kQ5V6ZSwQuoTHNUrO0njhk+g1LTUGhQlvC27SixmrX2p3CApZyc8xxu+mrfFX5l6o0c+
         WbIM5dBdqhDVbuKFDAhvJgiWktLr+0qxGRr0Qo6f8WD1Hp7nw5HZpRjKb+DdsuyXLfiv
         0VytSLQ/tT238Fyo/tK3xwPFavW9YRwHh61gWZSgZ+qOET68hc6Rygdn/O5zeBbT8PrH
         bImPgb3PUwhaIiNdibQV9iSyB/WhQWTfde8OhQW1QQPCmK/fXskc+DyUCRfAE5noAOXL
         et8g==
X-Gm-Message-State: ACrzQf0qu2TW2x+UK7dQgMYubhOQcP6Fl6GEGENJw6xy6fsgvciVibpd
        TO04LDfRTxH/LukBlwjZoyQl5Q==
X-Google-Smtp-Source: AMsMyM79Dv12V/PlL6ujB51w7NGEwx5ww04Xk9xQS9Tr7l3gptDh00WXECEVvrdnTTrIoTGtguxPFg==
X-Received: by 2002:a63:1612:0:b0:461:4180:d88b with SMTP id w18-20020a631612000000b004614180d88bmr19284053pgl.434.1667338798650;
        Tue, 01 Nov 2022 14:39:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g5-20020aa79f05000000b0056d1fdcde75sm6872796pfr.170.2022.11.01.14.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 14:39:58 -0700 (PDT)
Date:   Tue, 1 Nov 2022 14:39:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joao Moreira <joao@overdrivepizza.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
Message-ID: <202211011437.F82B61B8C@keescook>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <202210181020.79AF7F7@keescook>
 <Y08H8zJ5lQ62jel5@hirez.programming.kicks-ass.net>
 <c561dd8ec384bfc77998a6db6ed824e7@overdrivepizza.com>
 <Y08M4+GxoqvuZ+bq@hirez.programming.kicks-ass.net>
 <d219d61420c48a90a2e8bdc29cb8a579@overdrivepizza.com>
 <202210182218.56AD2871@keescook>
 <baced047981ff5fce633156e3e374dfd@overdrivepizza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baced047981ff5fce633156e3e374dfd@overdrivepizza.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 12:13:50PM -0700, Joao Moreira wrote:
> On 2022-10-18 22:19, Kees Cook wrote:
> > On Tue, Oct 18, 2022 at 09:48:42PM -0700, Joao Moreira wrote:
> > > > > Is it useful to get the compiler to emit 0xcc with
> > > > > -fpatchable-function-entry under any circumstance? I can probably
> > > > > change
> > > > > that quickly if needed/useful.
> > > >
> > > > Having it emit 0xcc for the bytes in front of the symbol might be
> > > > interesting. It would mean a few kernel changes, but nothing too hard.
> 
> Should I push for this within clang? I have the patch semi-ready (below) and
> would have some cycles this week for polishing it.

Sure! While the NOP vs CC issue isn't very interesting when IBT is
available, it's nice for non-IBT to make attackers have to target
addresses precisely.

If it's really invasive or hard to maintain in Clang (or objtool),
then I'd say leave it as-is.

-- 
Kees Cook
