Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D167066657D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 22:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbjAKVUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 16:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbjAKVT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 16:19:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED9C42E17
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 13:19:52 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673471991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tI04xp6F+K5cM/jshKX50AL1mZKfUcF4STD19M2ImEI=;
        b=bfZ/AeOnOg1un+tE9vkh+a34yIbQfAGz0oXV3YyyOI3IKorNqRT7PCGtGTuSjtdXwJgx0l
        3opTbGmVcBa/p8JAmQEXE02wwLZ0qTHYN0PeRoQ6zkTB/VMVueIYYhl7zRJ8n5Xbct7EqC
        25OpEwr4CEUlpBbkiwVjSWhBVePywVHqRSJgImZA+VcFJyYlEROoqpc36PzbbQJ7wNSKFF
        3yYfvNRdhXFo1Jq9a4hn9/m9Ecj1wAkAqFNjpyrQzcgn2+QjDI1t//Q7azV0FKvBPyg9C5
        Ks97M8+oPP4YuHQHkX7YpERCp90KEoc/FO82N+YxSBRtpBabp2pVbE/WeNq8jA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673471991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tI04xp6F+K5cM/jshKX50AL1mZKfUcF4STD19M2ImEI=;
        b=5sreYDAiOvuvmyUna0MsBsWukfn41AxgitHc87skphYG1DrK9itVJW0koqcP9LDbmmIVqM
        kMzfuNVYoZZ5ZxCA==
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        Waiman Long <longman@redhat.com>,
        John Stultz <jstultz@google.com>
Subject: Re: [PATCH clocksource 5/6] clocksource: Suspend the watchdog
 temporarily when high read latency detected
In-Reply-To: <20230111175056.GW4028633@paulmck-ThinkPad-P17-Gen-1>
References: <20230105010429.GA1773522@paulmck-ThinkPad-P17-Gen-1>
 <20230105010701.1773895-5-paulmck@kernel.org> <87r0w1ia65.ffs@tglx>
 <20230111175056.GW4028633@paulmck-ThinkPad-P17-Gen-1>
Date:   Wed, 11 Jan 2023 22:19:50 +0100
Message-ID: <87wn5sepl5.ffs@tglx>
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

On Wed, Jan 11 2023 at 09:50, Paul E. McKenney wrote:
> On Wed, Jan 11, 2023 at 12:26:58PM +0100, Thomas Gleixner wrote:
> Yes, if a system was 100% busy forever, this patch would suppress these
> checks.  But 100% busy forever is not the common case, due to thermal
> throttling and to security updates if nothing else.
>
> With all that said, is there a better way to get the desired effects of
> this patch?

Sane hardware?
