Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91640624EC1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 01:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiKKAOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 19:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiKKAOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 19:14:37 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EEE59867
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 16:14:36 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id r12so6070219lfp.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 16:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+oXVhnGb2jYR/2yfRREactGYhRFCxDg4Yp/NIk9q18U=;
        b=aKAzIlBDGhIl2wGbKq341q3oerjnczIP8H+Euz5Gn3W6mt8UWAVP+cZsKfQ10KBBtn
         qdMukrloPIWiXZbfJvk5F9Erlnrq/vginvrkPcscx8gOc97Fd6zAvMaHQyyAS4uyuY13
         GsFYgYN5aLCD+gTbSPa9qE2s7xZWiP9/+pz7BC7iIqQTG9IJO+49dxdm0aIrecImN3Lj
         t8snGC7/d+QOLrY+tEonholu9XcXWnAnMo+nF0D3v+E6o+jRQ7AxiN2DNpObpCrP3FFl
         rtZG969Ff6U2pPL/co5Um6X9WlV5318nYzGPc3ZodioIbH6ds0rkeCoj31eXX37zigZh
         +vSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+oXVhnGb2jYR/2yfRREactGYhRFCxDg4Yp/NIk9q18U=;
        b=X+ri96SEMwWjxD6KoX7xu5jayl/Bx+CRup1TTSD/e3j43TcSWmG9KF7n2nhvV/oKT8
         2ht8r8rzrms7joHLUSzJAbxBA+UMt+VLlY5rtabiU7ORkdeITd2OUnOxW+M9qC6PjaF0
         xZ0UWu0UzgRNiwDjJiqKwy5FueryiakZR077m+f6DZrBVYeoyOxusyN8e7ZWV4H4StR3
         lAYGI1VTf1VerbQmHlgLsZYYXEHTIQ5U/owm6mZxx4Wd/J2GPV+Ape6Vqn9Ryx0xISiQ
         ZxC8NuNKy49AlRPcKnQ3j0s+U4776rys/Qnw0twptlsM8HZNXGT09tqphcnk4Jr/OeKP
         GsWw==
X-Gm-Message-State: ANoB5plFqomFW2/ios6c9NBWbPfAIxZFeJg+qK+6X00Rd/cJXCGtItMv
        z9mhldfdMAFvCsNdWc5/holP46M45ON1jyEhdN5sFg==
X-Google-Smtp-Source: AA0mqf6/hZJc8cry/lcWbAynIqguR/0KuFgkAPO3grVIg3pB6zKw0Phi6qrm5n7rbw78llPsM7TnN7AefvHju+xzyhw=
X-Received: by 2002:ac2:44b7:0:b0:4b1:82c6:2959 with SMTP id
 c23-20020ac244b7000000b004b182c62959mr6319lfm.68.1668125674559; Thu, 10 Nov
 2022 16:14:34 -0800 (PST)
MIME-Version: 1.0
References: <20221026224449.214839-1-joshdon@google.com> <Y1/HzzA1FIawYM11@hirez.programming.kicks-ass.net>
 <xm26fsf3wtc2.fsf@google.com> <Y2ItG4BU21Pm0S/u@hirez.programming.kicks-ass.net>
In-Reply-To: <Y2ItG4BU21Pm0S/u@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 10 Nov 2022 16:14:22 -0800
Message-ID: <CABk29Nurt9r-1Nq3vcefCrbAmsqgqDeNLhmiXQz2bnnMVXhVoQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched: async unthrottling for cfs bandwidth
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Benjamin Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
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

Hey Peter,

Any other thoughts on this patch? Right now the only thing I have to
change is to eliminate the redundant list_head, per Michal's
suggestion. If the general idea here looks good to you, I can go ahead
and do that and send the v3.

Thanks,
Josh
