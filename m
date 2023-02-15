Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30BF697EEA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 15:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjBOO5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 09:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBOO5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 09:57:16 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B79639BA6;
        Wed, 15 Feb 2023 06:56:52 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id hx15so48764416ejc.11;
        Wed, 15 Feb 2023 06:56:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YzJ38UVa1QlbEaWg7++SNkszXftLM99B+OQOUJhEcoA=;
        b=bj9rTFCEvRBN38mKCFBcXXw29iiA4giSUAVSsRwpfnAMSRfDpo2fviMJGHacTnAS7Q
         XdjgH8oz9ln3BPeYJs1GjpQC4v46Rym8n4Rz1hTLvQ4tlu71jMxr1GA+PwLTHZWiL5lJ
         f48h+fhqS6atFVoEafe1LtMPuVC8o1SXkTXNEv0crpiCXnAwU5ssc3VmrpFdQw0tZu8q
         lI6NvCcqoQ5LINKeS/qBiPIcq+B3UkQS5U7NMZzyWyoQ5lyiZD2sH40n84AiTyNmr8xM
         lIBpMSm4SYS4IYvafj/ZFpe+XyBsX3GJtGtlshpt5nQRXZgwTB1JkUaPJmU9F3PRK6ds
         PJEw==
X-Gm-Message-State: AO0yUKUG5eEdhxUNggxSbPqEZ2twzXwPKKdtgGX6VGB5EZQ3TEP7Z09P
        EFfwkGoVmsNjycyEMwNn2bf/alNgdYu4PWThbq+Cj/2u
X-Google-Smtp-Source: AK7set+TZWeQEGbnjulWYVoBJRmJQ5hRyrS2cndXm6SKocCBmmMXFdKTD7FXeMbzOjC06ynqLCkfGz43qxzO7z6F0T0=
X-Received: by 2002:a17:906:590a:b0:8b0:7c88:e869 with SMTP id
 h10-20020a170906590a00b008b07c88e869mr1215778ejq.2.1676472944305; Wed, 15 Feb
 2023 06:55:44 -0800 (PST)
MIME-Version: 1.0
References: <20230214075811.23644-1-wyes.karny@amd.com> <Y+zRXZ4nHdFOFRuN@amd.com>
In-Reply-To: <Y+zRXZ4nHdFOFRuN@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 15 Feb 2023 15:55:33 +0100
Message-ID: <CAJZ5v0gtn4UCEu7tafO7AXfD6TOm7m7keq0RO2CR8QX3vEC30Q@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: amd_pstate: Fix invalid write to MSR_AMD_CPPC_REQ
To:     Huang Rui <ray.huang@amd.com>, "Karny, Wyes" <wyes.karny@amd.com>
Cc:     Rafael J Wysocki <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Yuan, Perry" <Perry.Yuan@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 1:35 PM Huang Rui <ray.huang@amd.com> wrote:
>
> On Tue, Feb 14, 2023 at 03:58:11PM +0800, Karny, Wyes wrote:
> > `amd_pstate_set_epp` function uses `cppc_req_cached` and `epp` variable
> > to update the MSR_AMD_CPPC_REQ register for AMD MSR systems. The recent
> > commit 7cca9a9851a5 ("cpufreq: amd-pstate: avoid uninitialized variable
> > use") changed the sequence of updating cppc_req_cached and writing the
> > MSR_AMD_CPPC_REQ. Therefore while switching from powersave to
> > performance governor and vice-versa in active mode MSR_AMD_CPPC_REQ is
> > set with the previous cached value. To fix this: first update the
> > `cppc_req_cached` variable and then call `amd_pstate_set_epp` function.
> >
> > - Before commit 7cca9a9851a5 ("cpufreq: amd-pstate: avoid uninitialized
> > variable use"):
> >
> > With powersave governor:
> > [    1.652743] amd_pstate_epp_init: writing to cppc_req_cached = 0x1eff
> > [    1.652744] amd_pstate_set_epp: writing cppc_req_cached = 0x1eff
> > [    1.652746] amd_pstate_set_epp: writing min_perf = 30, des_perf = 0, max_perf = 255, epp = 0
> >
> > Changing to performance governor:
> > [  300.493842] amd_pstate_epp_init: writing to cppc_req_cached = 0xffff
> > [  300.493846] amd_pstate_set_epp: writing cppc_req_cached = 0xffff
> > [  300.493847] amd_pstate_set_epp: writing min_perf = 255, des_perf = 0, max_perf = 255, epp = 0
> >
> > - After commit 7cca9a9851a5 ("cpufreq: amd-pstate: avoid uninitialized
> > variable use"):
> >
> > With powersave governor:
> > [    1.646037] amd_pstate_set_epp: writing cppc_req_cached = 0xffff
> > [    1.646038] amd_pstate_set_epp: writing min_perf = 255, des_perf = 0, max_perf = 255, epp = 0
> > [    1.646042] amd_pstate_epp_init: writing to cppc_req_cached = 0x1eff
> >
> > Changing to performance governor:
> > [  687.117401] amd_pstate_set_epp: writing cppc_req_cached = 0x1eff
> > [  687.117405] amd_pstate_set_epp: writing min_perf = 30, des_perf = 0, max_perf = 255, epp = 0
> > [  687.117419] amd_pstate_epp_init: writing to cppc_req_cached = 0xffff
> >
> > - After this fix:
> >
> > With powersave governor:
> > [    2.525717] amd_pstate_epp_init: writing to cppc_req_cached = 0x1eff
> > [    2.525720] amd_pstate_set_epp: writing cppc_req_cached = 0x1eff
> > [    2.525722] amd_pstate_set_epp: writing min_perf = 30, des_perf = 0, max_perf = 255, epp = 0
> >
> > Changing to performance governor:
> > [ 3440.152468] amd_pstate_epp_init: writing to cppc_req_cached = 0xffff
> > [ 3440.152473] amd_pstate_set_epp: writing cppc_req_cached = 0xffff
> > [ 3440.152474] amd_pstate_set_epp: writing min_perf = 255, des_perf = 0, max_perf = 255, epp = 0
> >
> > Fixes: 7cca9a9851a5 ("cpufreq: amd-pstate: avoid uninitialized variable use")
> > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
>
> That's really nice catch! Thanks Wyes.
>
> Acked-by: Huang Rui <ray.huang@amd.com>

Applied, thanks!
