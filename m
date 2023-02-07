Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CF768DDD5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjBGQVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbjBGQVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:21:17 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995633E097
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 08:20:51 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id ee13so9790137edb.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 08:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y88Utef6qJHAS4wQ2e647m3TQ6BM/POf4UQBE8RAnlo=;
        b=KqTmBsTMJrmVDliiJIIlIflPhloLMYAGI9DGS5JGeWj2g9GOBGVJgutaNy8RJEmTwr
         +dkqv0nADBQ6ZGCLnFpR9YLTb4lokI0E+mrnkzgXusasUJZqpQKoihEkJHqa48rbQfSS
         48+fyxjS6qESomYnIRY8LDUhpDj31asJ+zUIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y88Utef6qJHAS4wQ2e647m3TQ6BM/POf4UQBE8RAnlo=;
        b=gNIyx+2VkyDuJCvOiTnQnkBsR/L0cVB2wg7f3WhNaXUsb6yTZ7RpwVEeG1um6nLeQh
         BSIf1GlP9FAzzSRgomhrSsuRdGaX8qDze3J4nXkbnlrH0gfO3G3vhsGUrtGvfuGQ+YbZ
         qjU7DP28ETpXH6T0ijeefPIXFpYFd39kfeaBpQlmMqFsBcHJIA/1jpAw0Jih+N7lJE9y
         IXLPhhAjsruqQbo3yf5U9S6AQXVLnCIsaALVDDkrRNTjMkv8mYhA9sgadCIN1DnKoZpl
         +pnB95FDQVnw7uxoRagFWCFZ2kNhhRat+AL6BTT1hYei61slGa7jBe0tow6h/y87uwxS
         Rl6g==
X-Gm-Message-State: AO0yUKUbh0d+5dSntb2pewwbJYvgQsfBZ0Ds/rwkdlxbo424TQ2I9RMf
        348GALJ79X9On6oToOfMpBF7vPozTycfoCFR+MRRsA==
X-Google-Smtp-Source: AK7set/4ZHgmHuzPhT5EgRWeTKdILexRTbXINaYfV9E6MRrMGQooyLjv44Cc/ZhBDcZxRhO37EBZRg==
X-Received: by 2002:a17:906:4995:b0:89b:6048:85d2 with SMTP id p21-20020a170906499500b0089b604885d2mr3648293eju.15.1675786849573;
        Tue, 07 Feb 2023 08:20:49 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id kf15-20020a17090776cf00b0087bdae33badsm7057237ejc.56.2023.02.07.08.20.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 08:20:48 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id v13so16342119eda.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 08:20:48 -0800 (PST)
X-Received: by 2002:a17:906:4e46:b0:87a:7098:ca09 with SMTP id
 g6-20020a1709064e4600b0087a7098ca09mr878988ejw.78.1675786848396; Tue, 07 Feb
 2023 08:20:48 -0800 (PST)
MIME-Version: 1.0
References: <20230207072902.5528-1-jgross@suse.com> <20230207072902.5528-5-jgross@suse.com>
In-Reply-To: <20230207072902.5528-5-jgross@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Feb 2023 08:20:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi53OX86-yLBp4rCHOH67XhVbzV78qa63mh4-rOhxQSLw@mail.gmail.com>
Message-ID: <CAHk-=wi53OX86-yLBp4rCHOH67XhVbzV78qa63mh4-rOhxQSLw@mail.gmail.com>
Subject: Re: [PATCH 4/6] x86/mtrr: don't let mtrr_type_lookup() return MTRR_TYPE_INVALID
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        lists@nerdbynature.de, mikelley@microsoft.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 11:29 PM Juergen Gross <jgross@suse.com> wrote:
>
> mtrr_type_lookup() should always return a valid memory type. In case
> there is no information available, it should return the default UC.

Why isn't the second case (ie MTRR_STATE_MTRR_ENABLED not being set)
returning 'mtrr_state.def_type'. That's what the hw does, no?

> At the same time the mtrr_type_lookup() stub for the !CONFIG_MTRR
> case should set uniform to 1, as if the memory range would be
> covered by no MTRR at all.

.. but you didn't do that for the CONFIG_MTRR, so now they return
MTRR_TYPE_UNCACHABLE, but don't set uniform=1.

              Linus
