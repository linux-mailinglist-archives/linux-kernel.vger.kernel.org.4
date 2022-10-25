Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60B060CB9D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 14:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiJYMQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiJYMQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:16:16 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0368B13643A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:16:06 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id e129so11281463pgc.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/KgTDJbu9kceJ87fDG0z1/JNyJnydfDMeo/Ku7vP02g=;
        b=nlkRHlvp7P8S4cQwvyuo5l/InN2rzZunIBVG3Ack3fjNAhhidrztq1fu5CoJSKwG1/
         zAwGA/6BUdfjgj9xGj5/HqUc/gAfmVJH0TOXpBI1SORP1LtoyHIDlYQyIUDHcYIMsr9G
         vTmO2G71o8cr4bRNnTuqQ0ndGIn4pWmRIIyGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/KgTDJbu9kceJ87fDG0z1/JNyJnydfDMeo/Ku7vP02g=;
        b=oNnDlgIGFGyBOKertr+rNCzSuDF2Zi96pj20AxnMFXmdBJMbV6QIouUpD2MA69mWk9
         EjidqatVHLuOq6JyYJ+wtLxu0LzYj+jjjwKCSVsU8IxUJsEhTrXBTs35GCUO4wl2vxID
         xzflLB1Ao9X7jPGTh7I53AVF/pqjUu4vJNOAv0PDpRlj/DIt6Nmf8JgCGKlVQaNAsvAo
         s3nOI6k2Ev+fwx6TvO/+stM0GVhCSdPaBgt81EInbwYKt2DWda9OFynMCEtiWKUq1yfq
         5t83W5JEQX+N8z/HxXUiPs5GQJNo9FNeQK7mF4X8BEJtdLeitqg3bdmn4nq9+51rLhDF
         s80g==
X-Gm-Message-State: ACrzQf3aDvwWRVsNTXbAty/X++BjEQi0y1dKdE0fq+5/GaF30HeDX/Qx
        rZfnFuKn1UZLMWR2jOMRx8uLwz6CoXNy3pkR0Z7iaH8Tn66OyQ==
X-Google-Smtp-Source: AMsMyM4v0SoT3648Fk9bppqAEczfR988JwUbMcTfiN8K45db7nLNxwTtGMq6Cx2LqiCUzfXAddb02u3b+7vZKADTy90=
X-Received: by 2002:a05:6a00:807:b0:563:136f:a4fe with SMTP id
 m7-20020a056a00080700b00563136fa4femr38379900pfk.36.1666700165860; Tue, 25
 Oct 2022 05:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221024140846.3555435-1-mark.rutland@arm.com> <20221024140846.3555435-2-mark.rutland@arm.com>
In-Reply-To: <20221024140846.3555435-2-mark.rutland@arm.com>
From:   Florent Revest <revest@chromium.org>
Date:   Tue, 25 Oct 2022 14:15:54 +0200
Message-ID: <CABRcYmKffjy1FoK4_rFhyOxU5f5NMRPXWOZeeMS5Ae1d7V+dMg@mail.gmail.com>
Subject: Re: [PATCH 1/4] ftrace: pass fregs to arch_ftrace_set_direct_caller()
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, mhiramat@kernel.org,
        rostedt@goodmis.org, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 4:08 PM Mark Rutland <mark.rutland@arm.com> wrote:
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -2487,14 +2487,13 @@ ftrace_add_rec_direct(unsigned long ip, unsigned long addr,
>  static void call_direct_funcs(unsigned long ip, unsigned long pip,
>                               struct ftrace_ops *ops, struct ftrace_regs *fregs)
>  {
> -       struct pt_regs *regs = ftrace_get_regs(fregs);

Was this ftrace_get_regs() the only reason why we have
config DYNAMIC_FTRACE_WITH_DIRECT_CALLS
    depends on DYNAMIC_FTRACE_WITH_REGS
?

If we no longer use it, maybe this should be:
    depends on DYNAMIC_FTRACE_WITH_REGS || DYNAMIC_FTRACE_WITH_ARGS
?
