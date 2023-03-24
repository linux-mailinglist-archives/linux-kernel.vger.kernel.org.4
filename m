Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE5B6C7E83
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjCXNM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjCXNMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:12:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7437233F7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:12:51 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679663569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m5SDxOoolUK9Wyj28+FiVDVLp5CYB42n63XNmD+YPlE=;
        b=ytMvk5KVgQRedv8mr4wFKR0DO5fmbSqb3ChOsdilvijfKLnIyYqSXS29UAI0WUosZYmzYT
        mFlFFlygRR7ApEpgezqlFhVFC8mAK0nDaF69BH0oqJbs096Gr6c3D+axw90drHil2Fgiae
        kFtprePDE1iyEAeIbSNU1/b40zSKhRcwZDvfXmU51YfJG1fiBqdhI7al3H4UH05F6zkJdo
        04koG4M37nZcNWoS0AARgUP+1zo7hz4mCdE3oC73wS45fUuxOCkonbiQOfU6qb63AdIpnW
        cYAgWIcsGXqjPlXOMOaBrFni1xAII2lzA0R27+3Qgnv7Nkt9g68FAzWAzr0TwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679663569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m5SDxOoolUK9Wyj28+FiVDVLp5CYB42n63XNmD+YPlE=;
        b=7CTYTqnV2ghA9YVCkgUVTCctt71Ga0GrdDjJGAoTxO/bzk4Wre+hWvrpqPd80hugL0Uw1f
        QiSkN0aDsLCNGnCw==
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode: move @microcode_mutex definition near usage
In-Reply-To: <20230324120019.GAZB2Q09ODVq0iYz5l@fat_crate.local>
References: <20230324114720.1756466-1-john.ogness@linutronix.de>
 <20230324120019.GAZB2Q09ODVq0iYz5l@fat_crate.local>
Date:   Fri, 24 Mar 2023 14:17:10 +0106
Message-ID: <87edpenvkh.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-24, Borislav Petkov <bp@alien8.de> wrote:
>> If CONFIG_MICROCODE_LATE_LOADING is not enabled, the compiler warns:
>> 
>> 'microcode_mutex' defined but not used
>
> How do you trigger this?

I was doing some tests with CONFIG_PREEMPT_RT. I did not think that
mattered, since the mutex is obviously defined but not used for
!CONFIG_MICROCODE_LATE_LOADING.

Digging deeper I see that initializing @wait_list in
__MUTEX_INITIALIZER() is what is allowing unused global mutexes to go
unnoticed. Since with CONFIG_PREEMPT_RT the mutex is different and
initialized differently, it is (correctly) detected as unused.

CONFIG_PREEMPT_RT cannot be enabled yet, so this patch is not urgent for
mainline. But at some point it will need fixing.

John Ogness
