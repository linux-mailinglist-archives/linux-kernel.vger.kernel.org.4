Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14837671E25
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjARNka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjARNjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:39:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94F066FB8;
        Wed, 18 Jan 2023 05:09:56 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674047362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/6TzDShPYUNhKSU2xPYdtTZMZX/aEdeeSUD3KZBBydU=;
        b=ZhAjyVrqwVngYKwtheIJfVNwxQmS9uVXWR0gRK08TYomkEtNgb3u3+LN/9zg04hgZ6clfq
        MRReHEto9s5y6J/buGPwvTWEgh4qEOOTk6Msb8h9y1oK0eljwB5p8hhkGtv9KSOntnxXhc
        NAtgSUNCPh0Dm63vb2EVbREry3gKEcJ0SfSeygbQP1UbqC9g3/S766hX7R5tG1cuxVmTV5
        QBJbbv770/wNOKgLI954c9YNaJV194Xl4iacOUTCAV+8SazK50/Q320e6LbOGlwSKSoGmt
        OE9EmM+7ZA8TsxLXROdt3Ssm9Bn7QeOKtUI2zCuLyyCjs2Pb16UHfsXH7YyBoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674047362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/6TzDShPYUNhKSU2xPYdtTZMZX/aEdeeSUD3KZBBydU=;
        b=/qObata+kcBzO4TB56IOdgKgFcxEk9ZLP3fzlG0WDJgqiEKiI+uZ2uJ8XvMscADLovljyh
        6N4opwSGTDvnWTDg==
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: Re: [PATCH v4 19/19] irqdomain: Switch to per-domain locking
In-Reply-To: <Y8fBL+h2l5Wsiq2Z@hovoldconsulting.com>
References: <20230116135044.14998-1-johan+linaro@kernel.org>
 <20230116135044.14998-20-johan+linaro@kernel.org> <87mt6gkez4.ffs@tglx>
 <Y8fBL+h2l5Wsiq2Z@hovoldconsulting.com>
Date:   Wed, 18 Jan 2023 14:09:22 +0100
Message-ID: <87o7qwhtvh.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18 2023 at 10:51, Johan Hovold wrote:
> On Tue, Jan 17, 2023 at 10:50:39PM +0100, Thomas Gleixner wrote:
>> On Mon, Jan 16 2023 at 14:50, Johan Hovold wrote:
>> > The IRQ domain structures are currently protected by the global
>> > irq_domain_mutex. Switch to using more fine-grained per-domain locking,
>> > which may potentially speed up parallel probing somewhat.
>> 
>> Does it or not?
>> 
>> If not then why adding all this churn for no real value?
>
> It probably doesn't make much difference, but Marc wanted per-domain
> locking:
>
>     > I'd really like to avoid a global mutex. At the very least this should
>     > be a per-domain mutex, otherwise this will serialise a lot more than
>     > what is needed.

Sure it serializes more than what is needed, but the real question is
whether it matters. If it does not matter then I prefer KISS over a just
because we can optimization.

Thanks,

        tglx
