Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F79650A20
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 11:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbiLSKcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 05:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbiLSKb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 05:31:58 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B23B625D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 02:31:57 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id h10so6007236qvq.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 02:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wt1RBr25LOnXc4BczGcsScej9eUqJ1+Tj1lHRWHLLSw=;
        b=A4zmGxgRJNNmNzj8lquXuBsd14s8jIDeYpru/NS6b6sDNO1ozp9Xp0RghAOZtm/GwY
         9AxeLOuAYtanv/5lNbJIB/2unDyKwv6stRb86gmVfgtGvNJSNNKmhDANzH12WcQ1fdvw
         LshXniccmFsFKA1btgWqUUqbw6zNnizGYpGhCDUIVE+hCs8h2FKhZpDrR2aaypzgjlQr
         ggMunG5j6iEV1lk5JjRfR5KCurASdOTZUZok4p+usDkrSOiDvnYw+VcEk+pJtqAHIyua
         9i50jrs1iUqewrDcTU/s4cB/cj1yvSLSflg+4kVT7bl4mw6ek4DgfZuondTJtKRgoTD4
         qxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wt1RBr25LOnXc4BczGcsScej9eUqJ1+Tj1lHRWHLLSw=;
        b=Aju8tjXNQoR3zEPOgeVTKnpp/jOjMqCj7dFhSSe51BEuHW2xlqOav6WobAXZFILF0p
         2nSHg/qjGB7vbOzuEzEcbaTm6XqHzqSYpxOegUfxZfYbsdhChO55XeUJFvE8epa8KS7p
         YbB38ZMVjHyALWD38mhmr5RMsR/nWRzFLPDsA9uiM6jjuzrfHpo7eT6feIyst8KT1nhx
         l3UnvPHYH8enuPNndqxaB55X/G2K825QV0q8cXiV2Qxlg0MjN5STYSO/oHJxvGMprGF6
         O2bQLqFpzXyv7l/VXkaqrxHtex4xdonWo4KmN2PSkWpQeLgJA3Xew6HQmYAIj4352blP
         Zotw==
X-Gm-Message-State: ANoB5pnh6DGAl3UU07Rm9//sp974FhMai8rNAeQG271S49FiRx4eViU+
        Bpcb4fYuWhUry2Z/vzbkhKTQSIHyZ1KYedHPIY0UUQ==
X-Google-Smtp-Source: AA0mqf6p6ENDex/OnLeI5Fc3E/9RCFygsOlFU5V86F1OatQqqOq1eGu0CyO8iX/Koh3jiqKtCuJEUywGlrLlprl+bLY=
X-Received: by 2002:a0c:ebc8:0:b0:4c6:e82b:93e1 with SMTP id
 k8-20020a0cebc8000000b004c6e82b93e1mr55262028qvq.124.1671445916614; Mon, 19
 Dec 2022 02:31:56 -0800 (PST)
MIME-Version: 1.0
References: <20221214160856.2164207-1-peternewman@google.com> <c9bf21a0-3dab-5605-688d-d9de634e88c4@intel.com>
In-Reply-To: <c9bf21a0-3dab-5605-688d-d9de634e88c4@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Mon, 19 Dec 2022 11:31:45 +0100
Message-ID: <CALPaoCiO_ByaetFBAqSGK4_26jNsHD00gyx-u6aqfy9n_Ys7Ng@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] x86/resctrl: Fix event counts regression in reused RMIDs
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     fenghua.yu@intel.com, Babu.Moger@amd.com, bp@alien8.de,
        dave.hansen@linux.intel.com, eranian@google.com, hpa@zytor.com,
        james.morse@arm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, quic_jiles@quicinc.com, tan.shaopeng@fujitsu.com,
        tglx@linutronix.de, x86@kernel.org
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

Hi Reinette,

On Sat, Dec 17, 2022 at 1:59 AM Reinette Chatre
<reinette.chatre@intel.com> wrote:
> On 12/14/2022 8:08 AM, Peter Newman wrote:
> > When creating a new monitoring group, the RMID allocated for it may have
> > been used by a group which was previously removed. In this case, the
> > hardware counters will have non-zero values which should be deducted
> > from what is reported in the new group's counts.
> >
> > resctrl_arch_reset_rmid() initializes the prev_msr value for counters to
> > 0, causing the initial count to be charged to the new group. Resurrect
> > __rmid_read() and use it to initialize prev_msr correctly.
> >
> > Unlike before, __rmid_read() checks for error bits in the MSR read so
> > that callers don't need to.
> >
> > Fixes: 1d81d15db39c ("x86/resctrl: Move mbm_overflow_count() into resctrl_arch_rmid_read()")
> > Signed-off-by: Peter Newman <peternewman@google.com>
>
> This does look like a candidate for stable?

Yes, this bug is serious and reproducible. Every RMID reuse would
have up to one overflow's-worth of measurement error.

Should I elaborate on the impact more in the changelog?

>
> > ---
>
> It is helpful to have a summary here of what changed since previous version.

ok, I'll add this

> Thank you very much for catching and fixing this.
>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Thanks, Reinette!

-Peter
