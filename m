Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2522C68BD84
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjBFNJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjBFNJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:09:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A615144B6;
        Mon,  6 Feb 2023 05:09:04 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675688943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K3nPz9+q4/7C6EI88CTICsEZBDsn6LekqjWFJbLJ6j0=;
        b=pq4j5maCCj/8vJzyRsgGTYJTpzH9DVI2EVrcl9dwliEGq04DolNhT+ydJZQTgOXxpK4blP
        /Eds3vEctyDKtP+rf/qe3YgPlsSTSE/pKqN/k7+Wif1lasOwkqa6jUg+LPKq4mDF5umVl/
        19dbkgJAa//vTWGR89joTOtqj4HkIYuT0VTvRqIDQ7b59PsiGzhLp1Bj4owPLuwUnMtR17
        VOQsUiGD1nc6sRLlmM9GeB003/OEbWS4qeoFj4eflDPKk+TEjsXGGSvE/kq5DMfVwTNts2
        twv3TBcjY75gXibJAQCheXJ5xW+CQ2RZVehbVNLFPpMSZhzB8Ex8BIIGT9NcLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675688943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K3nPz9+q4/7C6EI88CTICsEZBDsn6LekqjWFJbLJ6j0=;
        b=pWA3gd8FT2NxyX9+dxM7BnuxNSnxGCqJfF7pVY7up13yIORFckVEIPQY7ncimJF+Ti9Zjw
        7Fdt0rwVU7CD10CA==
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: Re: [PATCH v4 06/19] irqdomain: Drop revmap mutex
In-Reply-To: <Y8fv3KWoxmaykrP6@hovoldconsulting.com>
References: <20230116135044.14998-1-johan+linaro@kernel.org>
 <20230116135044.14998-7-johan+linaro@kernel.org> <871qnslut3.ffs@tglx>
 <Y8e6Us0Qgt0p5S4R@hovoldconsulting.com> <87r0vshu1y.ffs@tglx>
 <Y8fv3KWoxmaykrP6@hovoldconsulting.com>
Date:   Mon, 06 Feb 2023 14:09:02 +0100
Message-ID: <87zg9rx7o1.ffs@tglx>
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

On Wed, Jan 18 2023 at 14:10, Johan Hovold wrote:
> On Wed, Jan 18, 2023 at 02:05:29PM +0100, Thomas Gleixner wrote:
>> You can do this in a two step approach.
>> 
>>     1) Add the new locking and ensure that the lock is held when
>>        the functions are called
>
> But the new locking has nothing to do with these functions. They are
> added because they fix various races elsewhere. Adding lockdep
> assertions in unrelated function as part of those fixes doesn't really
> make much sense.

Seriously? The point is that revmap_mutex is not protecting against any
of the races which you are trying to protect against. Ergo, any callsite
which does not hold the irqdomain mutex is part of the problem you are
trying to solve, no?

The removal of the revmap_mutex becomes possible due to the overall
protection scheme rework _after_ you established that all callers hold
the irqdomain mutex.

Thanks,

        tglx
