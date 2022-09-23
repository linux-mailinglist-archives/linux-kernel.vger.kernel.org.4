Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DB35E7E13
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiIWPQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbiIWPQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:16:35 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4691C139F73
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:16:29 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1278a61bd57so691948fac.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=pfqzhxoDqZ2/NYD5A7pwGfa+JPITfCvTXCsSvsUAv5s=;
        b=QxnkDTuqoJwr5/HCeQYNaAwi56BjaaM2etnE6calfD/OGQZlqUW7HnfWz6U3vDLKvB
         we2lFUG44Eh+zp1w1zGOwpcDy5mOyHEMQrG4gy56nJD25yHBQ9MEju8eE+rDMbN0XL+b
         MBwjMhwFuzWc/KFIU//WvB7vdj8NgUN2SZ+6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=pfqzhxoDqZ2/NYD5A7pwGfa+JPITfCvTXCsSvsUAv5s=;
        b=Qkm4K7SAvQJe1PIOhJMdM9sJlyf73jvxNwsvgqIslSUMd0IHnJJJ171eAgoxMVxCJa
         EhC4e1dDsJvFV+t+lrpXF+m+CEk/nie3PWpQcd8b9los+fjA472t1mffRlvcw+qH4Otn
         Lk+bWqY/Wni/hjmBwYlheTcRLBoBr140SBUpXfflNHRQZLkwflBoXYbKqlSLRVD5EqUR
         F04f8YfFfjmujI9OVc8L5+eKvb7v8uz96UpryV9igW5OeiZrr5GTjZeSir2IImKj4N0X
         vkV48JgUbqhBVsb+/Ha9lhC+2Ke0zDGna2SrG64FeFlXqyeZuVYDWQdt2OHiVMWq6yA8
         u/Yg==
X-Gm-Message-State: ACrzQf2GxdDSQUcKJyiV7B3G4V1WKS9e84hxpU23B/FtHnAaxQW3o2jY
        wAlFhHIot9SfA4Xo6pr6PgqeeTy/a8ovUQ==
X-Google-Smtp-Source: AMsMyM5zrIEJdp0odG23wNRBWScEOQwBlx1IYjii9tNPktY4oTjWpmht2ID/AoymmT0eSpixRTkoLA==
X-Received: by 2002:a05:6870:1494:b0:12a:fadc:c6ce with SMTP id k20-20020a056870149400b0012afadcc6cemr12243013oab.283.1663946187333;
        Fri, 23 Sep 2022 08:16:27 -0700 (PDT)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com. [209.85.160.51])
        by smtp.gmail.com with ESMTPSA id l5-20020a9d7a85000000b00638ef9bb847sm4055580otn.79.2022.09.23.08.16.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 08:16:26 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-127ba06d03fso715736fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:16:26 -0700 (PDT)
X-Received: by 2002:a05:6870:c0c9:b0:127:c4df:5b50 with SMTP id
 e9-20020a056870c0c900b00127c4df5b50mr5247692oad.126.1663946185877; Fri, 23
 Sep 2022 08:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220910221947.171557773@linutronix.de> <87h71cr1gb.fsf@jogness.linutronix.de>
 <875yheqh6v.fsf@jogness.linutronix.de>
In-Reply-To: <875yheqh6v.fsf@jogness.linutronix.de>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Fri, 23 Sep 2022 08:16:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wieXPMGEm7E=Sz2utzZdW1d=9hJBwGYAaAipxnMXr0Hvg@mail.gmail.com>
Message-ID: <CAHk-=wieXPMGEm7E=Sz2utzZdW1d=9hJBwGYAaAipxnMXr0Hvg@mail.gmail.com>
Subject: Re: printk meeting at LPC 2022
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        John Kacur <jkacur@redhat.com>,
        "John B. Wyatt IV" <jbwyatt4@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 7:49 AM John Ogness <john.ogness@linutronix.de> wrote:
>
> - Printing the backlog is important! If some emergency situation occurs,
>   make sure the backlog gets printed.

Yeah, I really liked the notion of doing the oops with just filling
the back buffer but still getting it printed out if something goes
wrong in the middle.

That said, I'm sure we can tweak the exact "how much of the back log
we print" if there are any real life issues that look even remotely
like the demo did.

It's not like you couldn't do a "skipping lines" message if there are
thousands of old non-emergency lines in the back buffer, and
prioritize getting the recent ones out first.

I doubt it ends up being an issue in practice, but basically I wanted
to just pipe up and say that the exact details of how much of the back
buffer needs to be flushed first _could_ be tweaked if it ever does
come up as an issue.

                    Linus
