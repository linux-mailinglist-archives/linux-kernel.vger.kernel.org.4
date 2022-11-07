Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D0C61F3A4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbiKGMqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbiKGMqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:46:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6E61C10C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 04:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667825115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oK45OaAkGR1KRTULH1k/dIxY0MgfTziop51VTUwFgQE=;
        b=ArD3ONdl/HDHj0m1WNP2kLFqyLvhhQVuXh4Js22kzMe0BRH8YTGl4DddjqiOU4ZPk6SzGE
        cm19xk04WuL1MJC2m2ZmpSYW69wOx/qWFIWXfvCbNTRNbGjmX6LRPw3Umd0jEFVoCXUSI8
        j+FxWIxZ+aAxEwGeCLciQnuWz7hvt4k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-351-KiKaXNsAOfK9_J636mLOdg-1; Mon, 07 Nov 2022 07:45:13 -0500
X-MC-Unique: KiKaXNsAOfK9_J636mLOdg-1
Received: by mail-wm1-f71.google.com with SMTP id c130-20020a1c3588000000b003b56be513e1so5794034wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 04:45:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oK45OaAkGR1KRTULH1k/dIxY0MgfTziop51VTUwFgQE=;
        b=D2G06OF5a5UpNNB5O7Qn2De2w7Ew8Rm0ZMBTBOjrOaJAwqpgLSWM1zZ8kAGoTJNYLM
         sObRzb6NKSa9tWOnVE6EHWeUBQuL/3ZQLeUXKEnMYsya2BuAli168NVtir3r8nXmv7zh
         z6yUlUhVVcCbwa/O1rBTnZS0EP0ZwITx7oVSHLSKkE/x9srfMn9KjXvr2faWdt2s0LbI
         eJDhESovyIU5Z2q2KoiUy0+l3edqeyTgwJDtcnpWw5r2Pqkkpix9Q15zBzBpTBd9uenz
         YHJPnlkAAIcHsWyMtAsVgsE7zgFUn3uS/j5MB1gY2X57sX4m8hSQC6XRfozHzO8Lvxek
         p+sg==
X-Gm-Message-State: ACrzQf1Nlu7FpTFbi/Fr778YvVzx+SuN3Rw3X+CJjLIfG0zbWw6P2Ve4
        078Qdcpv+1tDwkRK1Fb80WHglO7AbrZXsVhOPIRN4NQVOl/+sa/oWTF5KdigS7RnWNhdHM/6J7/
        rl51fRb2DsgQ3S4Sl3Yi8z+AE
X-Received: by 2002:a5d:52ca:0:b0:236:e9ac:3c3f with SMTP id r10-20020a5d52ca000000b00236e9ac3c3fmr21153599wrv.53.1667825112773;
        Mon, 07 Nov 2022 04:45:12 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5LE+lG4lNiW5lDjV1Ml+7bvtcsk4FrYZGy6Oa9UZ9e+MfnrMpkZnFEWkAlYeQxNBT+ks1GNA==
X-Received: by 2002:a5d:52ca:0:b0:236:e9ac:3c3f with SMTP id r10-20020a5d52ca000000b00236e9ac3c3fmr21153585wrv.53.1667825112594;
        Mon, 07 Nov 2022 04:45:12 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id z11-20020a05600c0a0b00b003b4868eb71bsm12813429wmp.25.2022.11.07.04.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:45:12 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sander Vanheule <sander@svanheule.net>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v2] cpumask: limit visibility of FORCE_NR_CPUS
In-Reply-To: <Y2WT5qVi+YU2VEXU@yury-laptop>
References: <20221019225939.1646349-1-yury.norov@gmail.com>
 <xhsmhtu3evcme.mognet@vschneid.remote.csb> <Y2WT5qVi+YU2VEXU@yury-laptop>
Date:   Mon, 07 Nov 2022 12:45:10 +0000
Message-ID: <xhsmhzgd3lyqx.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/22 15:36, Yury Norov wrote:
> On Fri, Nov 04, 2022 at 05:43:53PM +0000, Valentin Schneider wrote:
>> On 19/10/22 15:59, Yury Norov wrote:
>> > +choice
>> > +	prompt "Number of CPUs detection method"
>> > +	default UNFORCE_NR_CPUS
>> > +	depends on SMP && EXPERT
>>
>> What about moving the 'depends on EXPERT' onto FORCE_NR_CPUS? I find it
>> makes it easier to figure out the requirements for that option, and is
>> similar to how e.g. CONFIG_PREEMPT_RT is handled.
>
> In case of PREEMPT_RT, there are some other options to choose. In case of
> FORCE_NR_CPUS there will be a choice with a single option, and it would be
> weird that the option is never used.
>

True, this would have been neater as a single config, but AIUI it's a
required "trick" for allyesconfig. I would have expected other configs to
have hit similar issues in the past, but didn't find any.

> I'd prefer to hide this choice for non-experts entirely.

Sure.

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

