Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33DA717A93
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbjEaIru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235104AbjEaIrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:47:21 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3AA193
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:47:13 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30aef0b8837so2338367f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685522832; x=1688114832;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7TO9Ladpb4eGEa20dlAq/EVgHDyPrCBaRGJh7KV6CMA=;
        b=Ri7dl6WaPXXS1yhRJ+GdwC8aqakX9L/o4fQW5gvP5PWNu4dlh/0g2vCrIf+bsWlS0C
         km1eV5xk1+ZWgJtQHe3kZa55w/XZUJ5f0LgClW4XMZrF8UubDiu/XvckVi4pK4+mFGkk
         DnMMCvqQZvAkEkAUNfDpQ79Et994BpHWHVlj9j06LHNxN8aQjVZP7JlJz4HMbrEmrGF2
         HjJGkanQ1ltmi5kL7E8lhs8jZlX6ul4s0tlO/6xS++7A/C7knKRJShlFi49+DFTsBlMc
         lcO2dWIw37kswPeEIBjr7Jrjd8RCb/4/1PrWNwtu0wWe38uO48PTz2hrhfv4PhfMMGDl
         6dcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685522832; x=1688114832;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7TO9Ladpb4eGEa20dlAq/EVgHDyPrCBaRGJh7KV6CMA=;
        b=QwXyrIPaM9gImkT3IgQG0dvF031FcZkfIDM6+j6qfJb+RVG2mZSrL/YwaBdBf9mng6
         CNoMF2rtLOtUt48167P9Zmw8KeVJ6bZDzXjLSaxqq2vmklbH0/FwM7fyKUQASCr97Wc4
         6uNK73d7UhU3DaKcHpsYt9AucHoOiUv5F3mkNda54ZQBKTK6kuZdK3GQhJjNuO3lDKqE
         72Ts1V7SGmW31sNNxw2oIa2gp7hV8yF6cCabGenG5c3rYUO4y9gGXQ0RC03PgnZ2DY3+
         lyh7XYRlGz89YSk02Q1bdSSGBJxdnh5ISM5/Z2KdpYf/En/3KoQDn1ZCgDXEFiusmxBz
         /piA==
X-Gm-Message-State: AC+VfDwXWAZzUdF+gIGeY2JL6MFUhwllqiYeacz9WAMzaPHcUYNb6mXU
        7cZ1jP7n379u2x13YdQ3BO3Dp+CpYLo0G0yEJGHwbA==
X-Google-Smtp-Source: ACHHUZ7HPhBHbOTzQhEb0gT3a23/8UJMQW9gqf2YVA53AQrjVRRgVvTEeNGKzL4Fd3lDLV9AgoSNDheRPjtoQhvQV0I=
X-Received: by 2002:a5d:470b:0:b0:306:2b40:1258 with SMTP id
 y11-20020a5d470b000000b003062b401258mr3225152wrq.21.1685522832086; Wed, 31
 May 2023 01:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230526184823.1230974-1-ericchancf@google.com> <ZHXF86CioMoyWD1d@FVFF77S0Q05N>
In-Reply-To: <ZHXF86CioMoyWD1d@FVFF77S0Q05N>
From:   Eric Chan <ericchancf@google.com>
Date:   Wed, 31 May 2023 16:47:01 +0800
Message-ID: <CADv+UJgbneWo7SAeXEaZZfqAxEy5ACSDPK3KKR8M4Y2D-AXq5A@mail.gmail.com>
Subject: Re: [PATCH] arm64: Fix 'lock held when returning to user space'
 lockdep warning
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Thank you for your detailed response and guidance. I will prepare
PATCH v2 promptly and resubmit it for review.

Thanks,
Eric Chan
