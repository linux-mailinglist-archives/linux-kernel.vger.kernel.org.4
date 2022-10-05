Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE955F4D4A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 03:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJEBOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 21:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJEBOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 21:14:08 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8053A6DFA5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 18:14:06 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id bs18so15552750ljb.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 18:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ugwHEDQcF5VRN+4KCFZX1pbxbkZuWcWFPr79Ra+qDPI=;
        b=do+K2FKZlQ8TcKuvbRmDV+wUmqtG+O9ZHQ2AQs80qmIOF3Ndf/etuoxrXAtnR88Eky
         Ft1R3yunWStcGdXxedW6H3WxHi7Y/2LcCbQoKVvy910dO/gFWuk09itNyafbYYHEYC2n
         hpmlzZ172XZrdr7jpolEGuLd+0r3msrP3beff5UUfYD5WagkVQo3jjYD6tbqOdDp9OUP
         3Icyu2nnxdmoT3XRlHybLzEv+A90HjV9D8HnSjYVUyPSQCBJGcl6DvmjsKEtJdo594RP
         22ang0YRM72WZA/Yc+gPeJGqoMiOpNxSRfYSJmOyFPN8Bx7/oYERIqIIPKQRWEZ0Cu/K
         6BhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ugwHEDQcF5VRN+4KCFZX1pbxbkZuWcWFPr79Ra+qDPI=;
        b=JdjatSD2TANmokP5axZuRoZ9tbEEEdjwjakQ2t61ub82vnHlkYsyqNYdMyZhnAOFcR
         2vRXQB/CtHXrS08DynK/oU1V84lvw4bF2mS7JlD7sWV0jNjRaU38NP57/nzzXjQXLFdY
         uBMAOcmP3DNZrWllkbOYIS3a83g3vsriGCuDRKvVSfbRDZcoPWDvAdlU5vSpx03IIpsz
         f10yhsnY58kjyJTETSlWmBoXaJFCVZEwLuBcggKI7AtRw3gkoEitQEf+suNCT+Sa+vuH
         0Zfnl7/LksSTJBPegucyLzLQDh5JmIvXJ/O+pXKgLV5syMYws0i1H+FzPPkaR2yWKUuO
         asKw==
X-Gm-Message-State: ACrzQf0VrdYZ21zrZJrwdXTvNRx32je2xFcom/tUt5UVK1AGvlPm8Dx3
        Ps8lhrevS56ga43be788C9zKd61sEOtVVwCBJMLV
X-Google-Smtp-Source: AMsMyM4uwwNWAHUFkjOS8v4YCZr/nXwvqOlu921focmmgXpukWXHI/nXVpmmvFWPQ6QMi+fqImbpRUlKbxeRCgv7BC8=
X-Received: by 2002:a05:651c:1546:b0:26d:9459:1a69 with SMTP id
 y6-20020a05651c154600b0026d94591a69mr9827913ljp.209.1664932444752; Tue, 04
 Oct 2022 18:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20221003232033.3404802-3-jstultz@google.com> <20221004013611.1822-1-hdanton@sina.com>
 <CANDhNCoVzJ_MSyAigMkE-TMgfRQRkiK=G0_S3OwPfnXPuKu1iA@mail.gmail.com> <20221005002149.1876-1-hdanton@sina.com>
In-Reply-To: <20221005002149.1876-1-hdanton@sina.com>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 4 Oct 2022 18:13:52 -0700
Message-ID: <CANDhNCrGoWWaoYfsqVOqqNBsbZk5vXjsktrqKYM92-9LpD5P9w@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/3] sched: Avoid placing RT threads on cores
 handling long softirqs
To:     Hillf Danton <hdanton@sina.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        "Connor O'Brien" <connoro@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
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

On Tue, Oct 4, 2022 at 5:22 PM Hillf Danton <hdanton@sina.com> wrote:
> On 3 Oct 2022 19:29:36 -0700 John Stultz <jstultz@google.com>
> >
> > Why would ksoftirqd preempt the rt task?
> >
> For example the kthread becomes sensitive to latency.

Again, my apologies, I'm still not sure I am following. Could you
expand a bit on the case you're concerned about? Is it the case where
the ksoftirqd thread is configured to run at higher rtprio?

thanks
-john
