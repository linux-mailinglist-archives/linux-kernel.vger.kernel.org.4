Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A36712EBE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjEZVLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjEZVLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:11:01 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5FFD9
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:11:00 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64f47448aeaso1082179b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685135459; x=1687727459;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YP3yyXP3BrPlOcLWQwfs7ftvYdUlxaat2PcZaN8PaI=;
        b=RbRIdItk3rmUWpwAwHhkJBkxJ7HNbzZYOvHUAlEgyDRDkzzXl6tEVqCWjaDWGvqVT4
         HW7ZQd7F+HR2d1PvqI+BwzbMXiy7vMs2/kZQvXwktCc+fre+9ThkPR3Vdbpf5YohD7Oe
         +7E/iI/sQzQ0U0VQm4X9Gaa0O8UNWmL3U9cklc363aIFhpg6/LBP4X5QI2NsOWRwmLxT
         Netj9ErUJG/yyiMRywzrPT+7YBoYupGZ/UE69oS1zfbSki+eotLwHIVCW9aWR4HtFwWV
         By1NhjUsGxAjPGso+7SlngXob7cteFyQqJg6MD5mxFVKQFwXEGqLdvJ21wlJlAa5FAO1
         yMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685135459; x=1687727459;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YP3yyXP3BrPlOcLWQwfs7ftvYdUlxaat2PcZaN8PaI=;
        b=BhhTBiUVpfAHXJ43bpOkj0tOlwgEmFCSWemv4akYFEgxEAtdUI54z/RpmEPKyrtkLR
         JilLRP4oRpukVoZkZ2nZsNlRahZP+L/UZbUe1lGsURVFc+lS6ApyL4BqzkRKvQF91QXo
         c7QbEmceqW53LMznhwtWyHZ304w8REzDyGtrABP4CLzR0twhA1VBnHUKljdlZ7IoNQrj
         6oRp45YZnYU0cIx39rUfT+p75nhGgE/IoRalGHpayAnTlrUgeOaagD5fuH8x9dGpAfgd
         6ZAv3oPdu7ab+N+JN3PKlPsKBoxRXlj0WFZs8oPMr7Ij3z2QcyTaSWwDmHsGNatKkoGC
         Tgxg==
X-Gm-Message-State: AC+VfDyelEaDuObHdh2sbvBIIm0PxaGEAiw4wsUhZmKPteKdJcF7L9O0
        lvcO7wLUMfCW8UlGPWqHncQ=
X-Google-Smtp-Source: ACHHUZ7NzReL0jdgWVee4OpcX2fNJPkkO4WoT50OpJwqUHoFI3ZK2ptdQX3KSNOliKSlf4bVu/0vmw==
X-Received: by 2002:a05:6a20:72a4:b0:104:45df:42db with SMTP id o36-20020a056a2072a400b0010445df42dbmr945333pzk.9.1685135459065;
        Fri, 26 May 2023 14:10:59 -0700 (PDT)
Received: from smtpclient.apple ([66.170.99.95])
        by smtp.gmail.com with ESMTPSA id h29-20020a63531d000000b0051afa49e07asm3121733pgb.50.2023.05.26.14.10.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 May 2023 14:10:58 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH v2] x86/lib: Do not use local symbols with
 SYM_CODE_START_LOCAL()
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20230526204559.GAZHEahxxnQaHhSUul@nazgul.local>
Date:   Fri, 26 May 2023 14:10:47 -0700
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D63AB9E6-BA52-4E24-B8EF-C7B9DB1595CC@gmail.com>
References: <20230525184244.2311-1-namit@vmware.com>
 <38e24fd4-9213-229d-9919-7ae3bfb113bb@intel.com>
 <24E47178-C177-425F-A8EF-CFFAE22597D4@gmail.com>
 <20230526155336.GAZHDWAFi1FRqq83TP@nazgul.local>
 <0F07EEDB-8A3F-4224-9FF1-43A5300B1B8B@gmail.com>
 <20230526204559.GAZHEahxxnQaHhSUul@nazgul.local>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 26, 2023, at 1:45 PM, Borislav Petkov <bp@alien8.de> wrote:
>=20
> On Fri, May 26, 2023 at 10:29:29AM -0700, Nadav Amit wrote:
>> Can you give me some examples for code whose address cannot be mapped
>> back to a symbol?
>=20
> No, this is not what I'm talking about.
>=20
> I'm talking about all the local labels the compiler uses. For example:
>=20
> $ make kernel/sched/core.s
> $ grep -E "^\.L" kernel/sched/core.s | wc -l
> 2799
>=20
> All those local labels are not in the symbol table (get discarded) and
> the addresses they represent are shown as belonging to the containing
> function.

Right. But the symbols I mentioned are not contained in any other =
symbol.
If you run gdb and try to disasm this bad_get_user_clac (its address),
you=E2=80=99d currently get "No function contains specified address=E2=80=9D=
.

That what makes these 2 symbols different than the others.

>=20
>> I did not ask to make them global. Just to keep them as local after
>> linkage in the executable, like all other functions in the kernel.
>=20
> Ok, not global. But local and present in the symbol table:
>=20
> 105185: ffffffff81b89330    17 NOTYPE  LOCAL  DEFAULT    1 =
bad_get_user_clac
>=20
> And again, this helps how exactly?

Allowing debuggers, tracers, disassemblers and instrumentation tools to
work the same way they work as they work with any other piece of code in
the kernel.

I personally work on code instrumentation and this makes my life hard =
for
no good reason.

[ Perhaps the question should go the other way around: why addresses of
code in these functions should not be mapped to any symbol? ]

