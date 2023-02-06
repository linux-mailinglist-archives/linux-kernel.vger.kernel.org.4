Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6335E68C6B5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjBFTYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBFTYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:24:14 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D89E1B32E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 11:24:12 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id d189so7655612ybc.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 11:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BVazd58kum2M1pTJRpVOVODmHtrBqnbElti6UPp8PdY=;
        b=Xl3fMkj2m73lnBOF92izyHDKUYK6kGPpuMbNC7QoAtt8QrEm1/uJZOpT4Uj1mtXK8N
         U/TTStbZAb+IZavNREuKeGq60cgFPFsmr7iVUYJl9fKSpuBGPLheRHuMIPXlj+dYzE7u
         qPBKvHPvoTiQAKeQeiTorc3gW2CLZXarYF54IxJfa5l7qwJoEykxbrrrp8gs9c94+jwv
         tpVwmlJ9ij4o8LpRsfExhJDF0I7lmRgdTtzkIeh8CrPDVDn1EhAs+ZaxUr1Yhfi3GHCm
         L9MNKQGMe+hsmAeuTp7Wwzu+GrkDN4ghpr+XBZePbGzP6o3wK0OqpO/v0CNUjfTr91Pw
         Qw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BVazd58kum2M1pTJRpVOVODmHtrBqnbElti6UPp8PdY=;
        b=gqd9U+JHmiACy3kW8u3KYeSdo4Vxwt5EiQRiTcO+UkoW3McRPq3BrhIcN4aGu9v+Td
         nadDPSL9HEP0ll3RKyd+D4MJkXakMSMT6p6BOc7xmA98B7x3vaDzrOYn7nsPVaEzH6sR
         o5BXB0kLmalznIZ2/qwEHJo/hVRM0jZbhEM2HzK3nmSAwbMqbMX2RpU7yI5rqN9JOahU
         Th0x99O/eAlw64M9wk0PVXwUHwsoqoRm7eYDA5bH8+qglNtmRfRIAshyL1RoFjXPg1Ly
         rQBaiFLi6uaYkdaBYBDNJRwcAbkwaIUjRy+b9dgQR92jnMGMPWFRT/acPazySsCT2NIY
         swxw==
X-Gm-Message-State: AO0yUKXVZKTQgU2OEWiJ3lamQZbWcEbC9FwCcmypNZDMxQ1dbj4vhpiV
        coYFRplunikY7WVf0clTgAmX/DHqR2SfyUacAKFq
X-Google-Smtp-Source: AK7set+8PKF4HEUqt5XWLHVYxiPWC6II/btLz3XLiCqiRYUb0N0rG5cooA7PkjfKNNz3HCExMYitHrJc1kA4KVn4XBw=
X-Received: by 2002:a25:8585:0:b0:888:1a8:bb26 with SMTP id
 x5-20020a258585000000b0088801a8bb26mr100033ybk.49.1675711451467; Mon, 06 Feb
 2023 11:24:11 -0800 (PST)
MIME-Version: 1.0
References: <20230203200138.3872873-1-jstultz@google.com> <20230203200138.3872873-2-jstultz@google.com>
 <20230205190753.4sgvtxxaqcvr45ei@offworld> <20230206172029.GO2948950@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230206172029.GO2948950@paulmck-ThinkPad-P17-Gen-1>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 6 Feb 2023 11:24:00 -0800
Message-ID: <CANDhNCrZg3RoC2q=323FTvcVoXD1gfQgXfdGw-Tgt4V7G7vk9g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] locktorture: Add nested locking to mutex torture tests
To:     paulmck@kernel.org
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 9:20 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Sun, Feb 05, 2023 at 11:07:53AM -0800, Davidlohr Bueso wrote:
> > On Fri, 03 Feb 2023, John Stultz wrote:
> >
> > > This patch adds randomized nested locking to the mutex torture
> > > tests, as well as new LOCK08 config files for testing mutexes
> > > with nested locking
> > >
> > > This was inspired by locktorture extensions originally implemented
> > > by Connor O'Brien, for stress testing the proxy-execution series:
> > >  https://lore.kernel.org/lkml/20221003214501.2050087-12-connoro@google.com/
> > >
> > > Comments or feedback would be greatly appreciated!
> > >
> > > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > Cc: Juri Lelli <juri.lelli@redhat.com>
> > > Cc: Valentin Schneider <vschneid@redhat.com>
> > > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > > Signed-off-by: John Stultz <jstultz@google.com>
> >
> > Just realized I sent two review tags for rtmutex, one was supposed
> > to be this patch.
> >
> > Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
>
> Thank you!
>
> I will apply this to these commits on my next rebase:
>
> f5a632cbbbea ("locktorture: Add nested locking to mutex torture tests")
> 83743c9839f5 ("locktorture: Add nested locking to rtmutex torture tests")
>
> John, if you send a new version of these, please add Davidlohr's review
> tags.

Yeah. I'll respin to address most of the feedback.

thanks
-john
