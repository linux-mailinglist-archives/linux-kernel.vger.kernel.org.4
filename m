Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BB15B9DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiIOOp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiIOOpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:45:53 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13D2578BC
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 07:45:51 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id i3so8666926qkl.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 07:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=a+C12tDZim7wp2ablr8hYx/dub7DfeudFph8mtNNWAQ=;
        b=lGxSbcWoqKgeGSI/J9m83CR0BZvckMsT5ltscsaqQ0O/s4tK3iXYNXTMNnwH1yfjZ2
         vPtPdOE50CSjOHi/Vbzf8wm/tft+BHjm8yNzepQkQ7YKZq6UTsJLcEiX3gHG0OLCBnH0
         zVbJ0HyCMp8zs4sy/ZqrgrsEBdy6jEYSZsvw9LXE0AcGqwhQ5zvkEL2YHjGD/0dIj0BT
         4hTi2qUTferKDitcNagpMa7Xsc+TdBipL3hsmNxIZ/veTvTFvWONjo0iWhtRw+ZWzrg8
         BvuMgKF3r7w9QxIZILFfMlSubhrfV4s8mfOD2Y8dkZS+/2eaXHbCsNs9IQNRXTqV7q+t
         BIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=a+C12tDZim7wp2ablr8hYx/dub7DfeudFph8mtNNWAQ=;
        b=DOpa9fEL/9NTai8O/9/VUBckeX5+u6Q0+73iQZlcivyKxvQ5fTj2EOU1cMNBQ2FAz1
         5sQ6LvVHRgduwxJsUmrhkmBK9ZPWGHosDFWhLbUflgsb710SsK3m8pZvruSyLZqaQUDn
         Rr0RUQpLX0XWzvPyuo5QBNWp8gAqewWIXO7Eu61/qGCyymVVrR0wStVCHSEi3YDkYEy7
         0lGMmpEFwpdg+F2/X1IyfRD0b5JHYtTcOkdCIY/V6dko02RyZDk9bisP5uCcUKyJtH4r
         xgo+U0XqdfEt47h6ZVeXVVvL/z1Ym3Em2l3KwvinHqX2dhX4TPji/GZnPpAX+vNWf7L3
         CoDw==
X-Gm-Message-State: ACrzQf2blJBa+jJ53tJ5I4ayfLyT1Q58LAR9N+n1uRKxGgCryTkyS3ow
        ClpmcmGHn6aOrN8qy9f82ueHUo58nhE=
X-Google-Smtp-Source: AMsMyM6FKWw6tB7vGvDBM/tGWtQ088cYIHSZXrj7SvmLtTNolL8IMfKqHy6Q0TWXKmrck/GoltSvTg==
X-Received: by 2002:a05:620a:448f:b0:6cb:b391:20c5 with SMTP id x15-20020a05620a448f00b006cbb39120c5mr296121qkp.103.1663253150666;
        Thu, 15 Sep 2022 07:45:50 -0700 (PDT)
Received: from localhost (96-87-29-153-static.hfc.comcastbusiness.net. [96.87.29.153])
        by smtp.gmail.com with ESMTPSA id x7-20020a05620a258700b006b929a56a2bsm4308093qko.3.2022.09.15.07.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 07:45:50 -0700 (PDT)
Date:   Thu, 15 Sep 2022 07:45:49 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sander Vanheule <sander@svanheule.net>,
        Alexey Klimov <klimov.linux@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v2 0/5] cpumask: cleanup nr_cpu_ids vs nr_cpumask_bits
 mess
Message-ID: <YyM6nVBE+AMaxvrO@yury-laptop>
References: <20220905230820.3295223-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905230820.3295223-1-yury.norov@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 04:08:15PM -0700, Yury Norov wrote:
> cpumask subsystem uses nr_cpu_ids and nr_cpumask_bits interchangeably
> despite that the variables have different meaning and purpose. It makes
> some cpumask functions broken.
> 
> This series cleans that mess and adds new config FORCE_NR_CPUS that
> allows to optimize cpumask subsystem if the number of CPUs is known
> at compile-time.
> 
> After some testing I found build broken when SMP is on and NR_CPUS == 1.
> This is addressed in a new patch #1, and in the following patch #2 that
> now declares set_nr_cpu_ids in cpumask.h (was in smp.h).
> 
> v1: https://lore.kernel.org/lkml/20220829165748.1008477-1-yury.norov@gmail.com/T/#mecbd787f8d1bff1454a4ec2fe46ad6dc168df695
> v2:
>  - don't declare nr_cpu_ids if NR_CPUS == 1;
>  - move set_nr_cpu_ids() from smp.h to cpumask.h to avoid errors in some
>    inclusion paths;
>  - drop 'default n' in FORCE_NR_CPUS option description;
>  - rebase on top of v6.0-rc4.

Any more comments? If not, I'd like to move it into bitmap-for-next.
