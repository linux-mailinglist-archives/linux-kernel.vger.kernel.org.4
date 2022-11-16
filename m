Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A71C62BD87
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbiKPMUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238704AbiKPMTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:19:54 -0500
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB460DFA6;
        Wed, 16 Nov 2022 04:17:59 -0800 (PST)
Received: by mail-qk1-f175.google.com with SMTP id v8so11422783qkg.12;
        Wed, 16 Nov 2022 04:17:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vIWijkKIIG3mmZeimTFZ3ib2SY8A+L/da/B2JGwwAfI=;
        b=IzOBQCP3BwuT1fObM5IXUBjRAuVvWWf7hZ2Yjye1Anz1hZTHEtzx76WSUQC6F8Kp41
         h0EUdrirpEPyYrPq9fsVSUy6pCiuU+bTozffw2HoDW7FEifs0fywAl6wL65A5AV3v2do
         UlwMUzU7bnEgeo2DEOAWZkQ2ZYjbceTGfdAImEMfJUVl4BUe4UnT0eb8Xazvh+UTjVYw
         oOFEzHBihJtXKZp7QU7mLGdwYv6A8VuwVn97POvLsL88MdMKqpkdiFLBfAM1Mg3O7K3v
         B2DBlEGr82jbGwrpX28fdsLqMuVseflO6yUzErjD64B/Fzh1KRgL2ybPUQridkKdecD0
         krMw==
X-Gm-Message-State: ANoB5pmnWoFhNDlYke5fFTEjXxUeIF3cR+tyoihdTyc3bvrPw+fzmMBB
        anvD6TR3ZMubHMkmrrM4NdNFqIjTdsGm19zduOo=
X-Google-Smtp-Source: AA0mqf7K3C/o1DUvfHnSMEjjLphPhRxKiD7X7ByAz7w+sygk5m+oeteM5ukh2P167QSsx4go5gPPbAr97gf9PXgb/Z4=
X-Received: by 2002:a05:620a:f0f:b0:6fa:df0:f326 with SMTP id
 v15-20020a05620a0f0f00b006fa0df0f326mr19212259qkl.23.1668601078911; Wed, 16
 Nov 2022 04:17:58 -0800 (PST)
MIME-Version: 1.0
References: <20221110195732.1382314-1-wusamuel@google.com> <CAGETcx_aAynvykDSL4aue3zf5Pv7+hELUHQ=MWOzBbyZBPySDA@mail.gmail.com>
 <880b7332-562c-4934-4e92-493b112568c9@arm.com>
In-Reply-To: <880b7332-562c-4934-4e92-493b112568c9@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Nov 2022 13:17:47 +0100
Message-ID: <CAJZ5v0hpDiQUoWZO7YzhU2ymyyNK4uwZrS8nuwyrs2rjNOO4SA@mail.gmail.com>
Subject: Re: [PATCH v1] Revert "cpufreq: schedutil: Move max CPU capacity to sugov_policy"
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Sam Wu <wusamuel@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Isaac J . Manjarres" <isaacmanjarres@google.com>,
        kernel-team@android.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 12:43 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 11/15/22 22:35, Saravana Kannan wrote:
> > On Thu, Nov 10, 2022 at 11:57 AM Sam Wu <wusamuel@google.com> wrote:
> >>
> >> This reverts commit 6d5afdc97ea71958287364a1f1d07e59ef151b11.
> >>
> >> On a Pixel 6 device, it is observed that this commit increases
> >> latency by approximately 50ms, or 20%, in migrating a task
> >> that requires full CPU utilization from a LITTLE CPU to Fmax
> >> on a big CPU. Reverting this change restores the latency back
> >> to its original baseline value.
> >>
> >> Fixes: 6d5afdc97ea7 ("cpufreq: schedutil: Move max CPU capacity to sugov_policy")
> >> Cc: Lukasz Luba <lukasz.luba@arm.com>
> >> Cc: Saravana Kannan <saravanak@google.com>
> >> Cc: Isaac J. Manjarres <isaacmanjarres@google.com>
> >> Signed-off-by: Sam Wu <wusamuel@google.com>
> >
> > Rafael, can we pick this up please?
> >
> > Lukasz, no objections to the idea itself, but it's causing regression
> > and we'd like to revert and then fix it.
>
> If you see this in mainline kernel, then I'm fine with reverting it.

OK, I'll wait for the confirmation of this.

> Then I will have to trace why this CPU capacity value can change over
> time in mainline kernel (while it shouldn't, because we register the
> cpufreq policy and the governor later, after we calculate the capacity
> in arch_topology.c). Maybe something has changed in mainline in the
> meantime in this CPU capacity setup code, which caused this side effect.
>
> I know that android-mainline has some different setup code for those
> custom vendor governors. I just want to eliminate this bit and be on the
> same page.
