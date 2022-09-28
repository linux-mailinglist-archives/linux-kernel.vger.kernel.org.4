Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71885ED8BF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbiI1JVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiI1JVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:21:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF196BCFC
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 02:21:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35F2F61050
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:21:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545A9C433D6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:21:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="n3OG9rbe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664356868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6rVf8wH7RZDuCclbukv9444Z9EdiOPIQ5wTS8Tmpm+8=;
        b=n3OG9rbeD92HquhcpO1goej5XkG9AFXQXMpr7mAQa0bIBfYDtdtm5TjJK1oMk/dI7OBJZJ
        B65OfEp0NfnsXKMMvuNTIFXgMtJ0nNoZ8Er4iJ85gowX+keBL5KxkSJhqzBxPYvRhV0R+5
        xj45oP6uhOqvMmjwapNNxwe56ZONLVk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8b5333d4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Wed, 28 Sep 2022 09:21:07 +0000 (UTC)
Received: by mail-vs1-f43.google.com with SMTP id j7so12074070vsr.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 02:21:07 -0700 (PDT)
X-Gm-Message-State: ACrzQf3el0b3As1zWj3RhKyTI6zrkzSfJSVND2ObDq0jCqz/XEWu6gl8
        yY1zTV11doJwiClBJ2Cmkx7ufKm5T1zaj8rW0N4=
X-Google-Smtp-Source: AMsMyM5obY/4n2tvDkRbMJ7i7pFpcmP4cB8vbFynrWASegAQPTzmzHDBEC+gsy0Dq489vPAuz3DgN3d/Dql7wCDUKbc=
X-Received: by 2002:a67:c289:0:b0:398:cdc:c3ef with SMTP id
 k9-20020a67c289000000b003980cdcc3efmr14599588vsj.76.1664356866430; Wed, 28
 Sep 2022 02:21:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7551:0:b0:3d0:3d83:834a with HTTP; Wed, 28 Sep 2022
 02:21:05 -0700 (PDT)
In-Reply-To: <YzQP2OEVKgWtwsD4@linutronix.de>
References: <20220927104912.622645-1-bigeasy@linutronix.de>
 <20220927104912.622645-3-bigeasy@linutronix.de> <YzMnb8NWlCpqsqSG@alley> <YzQP2OEVKgWtwsD4@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 28 Sep 2022 11:21:05 +0200
X-Gmail-Original-Message-ID: <CAHmME9qzBRDfUh1vN6qW6BFuFz_qcuaEOR13Ojx2CzC_+CHxUw@mail.gmail.com>
Message-ID: <CAHmME9qzBRDfUh1vN6qW6BFuFz_qcuaEOR13Ojx2CzC_+CHxUw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] lib/vsprintf: Initialize vsprintf's pointer hash
 once the random core is ready.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/22, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>
>> I could replace "system_unbound_wq" with "system_wq" when
>> pushing. Is anybody against it, please?
>
> so schedule_delayed_work() then?
> I don't mind at all. I used that one just because serialisation is not
> needed and neither is the CPU important.

Indeed, given that this very much is unbound, I think Sebastian's
original patch makes most sense.

Jason
