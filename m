Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB04168863A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 19:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjBBSSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 13:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjBBSSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 13:18:18 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA8045BD1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 10:18:17 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id cr11so1824000pfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 10:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L7icPoQV0+1TADmGSuaIAYzPqVrS9LznmgHWsZ0YqHU=;
        b=S09i0i6E6NeqKHUKJRzq9SbeBUrkUks0KwsEdwlNV2s4XhoPD4a0u2/4V1ejKmAGt0
         8Dv7PJHssfMBI3x/lspBaI8qh0S1VBhqDgwWhGl69EUkYqxYgWrTPwlVjqLtObkdJlVs
         1hTyoMvRuvgNiXGPX8OSl2t0YL4nxh3CxxiI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L7icPoQV0+1TADmGSuaIAYzPqVrS9LznmgHWsZ0YqHU=;
        b=Iufvd7bJ0kughfHESBdfO/Og5i7N25bDmjKbCcQ2Yx9vk53Gkc7IbYrxaalGebNroz
         UlTA9y6RblVO7J4wo98sXKR5xUe4u0NS6dPxq0Xt585Rom8exMJAkseB4zssgSBO4MNg
         4J5axdu9JVz5bwzBUBui64DdqsedHBVsOWIXS6hEImGhFjZ9+k4jiAXgpbYraMBUZHdU
         bGY/JvoxYMWWV4rKcwx7IjkH7wIM0DQTcJ/UACbGBJoU9KvfXrsIsDkLD8U/gS3woJf1
         c2px7gq/LnUumPjosCk5z02pfEEWlqkgwpfMyiiYHBZQxbnGGZQ4a+WR3W2sPcTwfAhf
         0o8Q==
X-Gm-Message-State: AO0yUKVvrZFvHn+NlaPVli9/Ofi8ooF03LzCNQPf0ac93YkxdWLWQJsc
        M9oaXvgzwS73CsZYv85eodbOgBHRKr+iY7KNFyYuBQ==
X-Google-Smtp-Source: AK7set9q0tI/J6IQRKg4GVehPEW0rTa05ZubWhegS631JBzSLxYn4lgMk46uikvk3M9/sXKOpd4Gr5H00U0DKfR/vAI=
X-Received: by 2002:a05:6a00:1a92:b0:593:e2fd:ca4f with SMTP id
 e18-20020a056a001a9200b00593e2fdca4fmr1703061pfv.0.1675361896917; Thu, 02 Feb
 2023 10:18:16 -0800 (PST)
MIME-Version: 1.0
References: <20230201163420.1579014-1-revest@chromium.org> <20230201163420.1579014-6-revest@chromium.org>
 <Y9vcua0+JzjmTICO@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <Y9vcua0+JzjmTICO@FVFF77S0Q05N.cambridge.arm.com>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 2 Feb 2023 19:18:05 +0100
Message-ID: <CABRcYmK1ns1escBFa4edjZtbykms-sfhsTL3HKs+Ljx3xOUwWQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] ftrace: Make DIRECT_CALLS work WITH_ARGS and !WITH_REGS
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 2, 2023 at 4:54 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Feb 01, 2023 at 05:34:17PM +0100, Florent Revest wrote:
> > Direct called trampolines can be called in two ways:
> > - either from the ftrace callsite. In this case, they do not access any
> >   struct ftrace_regs nor pt_regs
> > - Or, if a ftrace ops is also attached, from the end of a ftrace
> >   trampoline. In this case, the call_direct_funcs ops is in charge of
> >   setting the direct call trampoline's address in a struct ftrace_regs
> >
> > Since "ftrace: pass fregs to arch_ftrace_set_direct_caller()", the later
> > case no longer requires a full pt_regs.
>
> Minor nit, but could we please have the commit ID, e.g.
>
> | Since commit:
> |
> |   9705bc70960459ae ("ftrace: pass fregs to arch_ftrace_set_direct_caller()")
> |
> | The latter case no longer requires a full pt_regs.

Sure thing, will do!
