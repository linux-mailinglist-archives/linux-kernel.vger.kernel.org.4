Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC016017AD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiJQTaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiJQTaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:30:13 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482A642AF9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 12:29:14 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id i6so11662931pli.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 12:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ue0kyx6qz2rMzedIasmuG59X+gNZQpN5B5kyFPGaXUg=;
        b=oOeaOD87UL2DSnr8xg5//MuTm6Ca4Z/mdwBBsvzWSUvaaMwLs8me7s7u5ZJAh9v/8o
         lIWnxMrIw7DNbIMCfqGDiu/CAgA/awQQBjBnyLi6OFQ+uhI1Azdkhwc/yvAgXAIwJcIR
         mf/ua8KOS2zyteADmTTlwd5FuFrycq4SyIers=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ue0kyx6qz2rMzedIasmuG59X+gNZQpN5B5kyFPGaXUg=;
        b=5j2FR3wzfnhJkhTMRvdxYRzlniCnRNzHQFUMieS9dZnEMWh0H8jobAYcFkvEjt/QZE
         ZcNnQVaBecFUKmjkZinUXg0Iq/XQ9ldB+CA+tVkGmcgcn4viURakxNcgn2D5pge5q1xN
         lro6YA8jSXDGQhIIZ2JNrBIvrTsBKCafSW8AlHmMcRjT2DnOyJQ3u3avvblKgUVBqE0+
         OzAlLkhmfaUB12ObvdnA3QpCzwhenTajnu/aBj9CBTMtwRIay9rQv9Jx75s/OqJAGqLI
         x9z1ER7WeLREtVKftyk3MHgyBhG1VTCZ/JVBsQvc7TCMmE/NJl270DXsT1fb0dHue0fy
         GRvw==
X-Gm-Message-State: ACrzQf3tgasK9dRHEYtOH6tPViqzUoeao4uvqzhbC1qhsqnSTu1Kys/x
        irpuUpymIeUNgSdWvo8tzQhz1Q==
X-Google-Smtp-Source: AMsMyM4OJzcEEUtsXl5r3zGxULcRHVgJoJaAAFQewD9ZximZ4WPi42mFeqNa3oj0U2XedlYFE7o7Kg==
X-Received: by 2002:a17:90a:b00b:b0:203:a6de:5b0f with SMTP id x11-20020a17090ab00b00b00203a6de5b0fmr15162750pjq.134.1666034945278;
        Mon, 17 Oct 2022 12:29:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m10-20020a1709026bca00b00181a0e61ce4sm6976066plt.6.2022.10.17.12.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 12:29:04 -0700 (PDT)
Date:   Mon, 17 Oct 2022 12:29:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] pstore: migrate to crypto acomp interface (take 2)
Message-ID: <202210171227.35ED875219@keescook>
References: <20221006234138.1835739-1-keescook@chromium.org>
 <191ec24d-35d4-e4e5-85f7-d7301984e647@igalia.com>
 <202210171100.5BAC4A5CC8@keescook>
 <CAMj1kXHzrRTVcxb5+hgUPV3tjekPcDWzVf6cG_Mc9JJmYBz2Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHzrRTVcxb5+hgUPV3tjekPcDWzVf6cG_Mc9JJmYBz2Mw@mail.gmail.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 08:14:14PM +0200, Ard Biesheuvel wrote:
> So once we use the same size for input and output, I was curious
> whether we could encrypt in place, and get rid of the big_oops_buf.
> And the answer is 'yes', precisely because we have this horrid per-CPU
> allocation which serves as a bounce buffer. And this is not specific
> to acomp, the old comp algorithms get wrapped in scomps which receive
> the same treatment.

Ah, in the sense that "in place" is actually happening in the per-cpu
allocation, and only if it succeeds does the input buffer get
overwritten?

> So at that point, I wondered what the point is of all this complexity.
> Do we really need 6 different algorithms to compress a couple of K of
> ASCII text on a code path that is ice cold by definition? Wouldn't it
> be better to drop the crypto API altogether here, and just use GZIP
> via the library interface?

Well, my goal was to make the algo "pstore doesn't care". If someone
picks deflate, do they still get all the per-cpu allocations?

-- 
Kees Cook
