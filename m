Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2912B60B34A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiJXRCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbiJXRA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:00:57 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE02EC51B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:38:15 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id g7so17361779lfv.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uNRDUP9ouWlmlPu6POZXr/UqktEd3BwTrOrVcJ1HXpQ=;
        b=Zre2CJjpDPgZ3ML+5uYe3oKtSH6m3xLiU4J6QrCHDDpo5kZY8xjs2ItrKKTfLcDYht
         TVO4nENelYErdKgDYpqW6aR729OTlE/NHjfrcLDV8Crl51KvdX2Wyl3dH2Jegc8K29VM
         lRVPQ90tlZl8N0YSyJgTFvwLm3nRrtNjasWxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uNRDUP9ouWlmlPu6POZXr/UqktEd3BwTrOrVcJ1HXpQ=;
        b=sgXB0l2qgrIblvzP3bH/UXk3ypwutP6mdeYwpEGvncwI6aqeFVFWqUWALMwwnFOxuU
         gvgdfA4gQWJ52WUhW+e8b0MxZRz4C9UiOdQ+AhEyCCGOnihr6JaAE48QpmzW5I0BTg9r
         jU9kSTS++bI47Tzi7MUNBMrmvmUGDnSsHPM6M9i0RXwh0B528tquduLkdwBtHovPROlx
         hAM9bFgTjvWc2YKbVTGwCFy5SWhnwq+XAd892hRLvZJtn8G7Kq7cD2FuWCtYiBfj8/WL
         GON6/fki+fxszk3hA6Q9dK3LS1ZQgChebic/SEqELTU+B24eXlIcrxHsYSegtWjSuy7A
         tppw==
X-Gm-Message-State: ACrzQf1jE5dgP2T5/ZbAwpiaQhaHkrxk5YcMfQ4ov4wg7idzMCV1cs6C
        nMqmrd/aPI3POOSm2t8Jb20zXZI5XIBgfe+QMkY=
X-Google-Smtp-Source: AMsMyM6GLxv6YpStCWiwlAyLglFzeiLykSKUvCjuukVmFp1jXb2lI1FAJdRQEzwFTD2k7tzPsely6w==
X-Received: by 2002:a2e:b11a:0:b0:26e:4c9:f7f7 with SMTP id p26-20020a2eb11a000000b0026e04c9f7f7mr11624761ljl.522.1666619290405;
        Mon, 24 Oct 2022 06:48:10 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o20-20020a2e7314000000b0025ebaef9570sm4954322ljc.40.2022.10.24.06.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 06:48:09 -0700 (PDT)
Message-ID: <814496ae-4007-9a4e-0466-a0386aec6316@rasmusvillemoes.dk>
Date:   Mon, 24 Oct 2022 15:48:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] clk: imx8mp: register driver at arch_initcall time
Content-Language: en-US
To:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20220928124108.500369-1-linux@rasmusvillemoes.dk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20220928124108.500369-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 14.41, Rasmus Villemoes wrote:
> We have an imx8mp-based board with an external gpio-triggered
> watchdog. Currently, we don't get to handle that in time before it
> resets the board.
> 
> The probe of the watchdog device gets deferred because the SOC's GPIO
> controller is not yet ready, and the probe of that in turn gets deferred
> because its clock provider (namely, this driver) is not yet
> ready. Altogether, the watchdog does not get handled until the late
> initcall deferred_probe_initcall has made sure all leftover devices
> have been probed, and that's way too late.
> 
> Aside from being necessary for our board, this also reduces total boot
> time because fewer device probes get deferred.

ping

Rasmus
