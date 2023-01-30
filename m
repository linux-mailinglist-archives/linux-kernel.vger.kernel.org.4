Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F51680A5A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 11:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236385AbjA3KEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 05:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235868AbjA3KEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:04:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F83D17CE3;
        Mon, 30 Jan 2023 02:04:11 -0800 (PST)
Date:   Mon, 30 Jan 2023 11:04:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675073049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a0rgwhNBwz1zmVKIFopBrkjfEiNmPstdPzB4K3GJeYk=;
        b=PCbqxA1hR6UX+2tiWELmUhqJ5JItSp+Fp6STEdmbLY9MQk9HffXlcQRrGQvJm2jBAN2fGI
        a1X75rVe30Hc3cd04sUPhtILSatyqz97Hgt+9kAloEhgkay+TKiaTMlFTkXK9u/3kMjpOO
        EOMrAPNd3VJx87JgPiR0/TX5piwCL+5NecuPaTmsVN00DNHJOGd5Hgu0HbovWdAEQ8ucA1
        PNZ7HFmgpFa0Q6CaLxVmLnMZbyQw1GQCccjhGPU2I1ZLC6y6e9sQEknLKdFepZ8ntSgAeb
        e7x/89+6XkNcKPHT343NtGNg9UQjZA5baiqkckGbi1N+1q502o+y+uQV/mDg0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675073049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a0rgwhNBwz1zmVKIFopBrkjfEiNmPstdPzB4K3GJeYk=;
        b=/ABjyPnYBzOTFLWKqtousAvN6ewOTrqdTMSVzmM1Uo5/nVkWv/xxHP/mhghQeKg7K7u5NH
        fpLvwDiCWK5tGUAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v3] cpuidle: psci: Do not suspend topology CPUs on
 PREEMPT_RT
Message-ID: <Y9eWF1wZe0p6Gzmq@linutronix.de>
References: <20230119184228.683892-1-krzysztof.kozlowski@linaro.org>
 <20230124153411.nwkbjgoqgkua2icm@bogus>
 <c247710b-369a-67d0-0637-b32192d25e4d@linaro.org>
 <CAPDyKFrS6OER2h3XmHMfbjBA09HT8LYN9A90TPjd0RPim3jMaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPDyKFrS6OER2h3XmHMfbjBA09HT8LYN9A90TPjd0RPim3jMaw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-25 11:08:04 [+0100], Ulf Hansson wrote:
> > It's the power domain sued for other devices, so we need it. Otherwise
> > other devices will keep waiting for this missing power domain provider.
> 
Ach this explains my other question I had.
> 
> And we are still able to use those idle states that are solely per
> CPU, which is probably nice to have. No?

If the entry/ exit latency is not known, it can be dangerous.

> Kind regards
> Uffe

Sebastian
