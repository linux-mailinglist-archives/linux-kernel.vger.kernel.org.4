Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8826C5D22
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 04:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCWDTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 23:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCWDTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 23:19:19 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0876549F9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 20:19:19 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id bc5so5227823ilb.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 20:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679541558;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=IRXO7QJ0B/Cc2kNEah61SJ0fpcm/qbW5lEVf0t91C3I=;
        b=A+2jk63pKCmaVFBGmX4EfxWkmuXhwdUjKhxvuPbEA0CiRsr+eo+Y5XMd0zw6sTuHJE
         pHlessgLKQHZ/E9rxsHZQMcHkwkdj4qtcVO1GJyQQnr54fWXBxksG/fB/BW6+h95/Rms
         EyhaVcp/fspugeQQ7TibZWzkwEl9V+fB6FqopVbml6IU61qxnYYiJkmaIzDIBDZ9Ak1T
         jt9yrACiNrnGiSoLGDVZvxiEuuw29gt6rAmRBQKhG19lv0+whKQTkgP9a2HpM4/RoXXg
         ofTDZDzsiDkYFN/2+x3MOMBl+0tQSQmG0WDdrygk6n1iI/jDTQ1gB5+6OrB4IHIwvR5Y
         jQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679541558;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRXO7QJ0B/Cc2kNEah61SJ0fpcm/qbW5lEVf0t91C3I=;
        b=J71+fUdJ2EXk85myG0EWIkzln8tZnKPU5p/M4A9dHcUJJn6Rvb2TV/VNoqeCqx69CO
         dbtvmh/pdbpwpAXnhzDwdpMae2/Mh4aR0sj3q9d4gJVNSGWtItO4qUOA0IizfwKP7vmp
         ZDJwdd4lUIuUnwcYP7zbIsOZXPDKqeNpkcQLDR03DlufiKPvUGcB94c5sya3pNoKpE/u
         Hkf5BECP3kXgnWC/57g1ZMDv2a7ewXWUUPvE6NIgGiaNcWPF6W0BZKVMYx9LXjgbUkRX
         /aB0Wrr6MMqgujqr4+upjGs2yHkAUEKeGmDL45ney7IzleoAjAwQv1fbOEcaUIYpzjb3
         8pAQ==
X-Gm-Message-State: AO0yUKXrlUJf0k3mNb7DHquX/rWL/1zhgECor1jJRLmY/kIRaBLOWioz
        Q53KUjtA04AYKOnmz33/U7o=
X-Google-Smtp-Source: AK7set/DPMVjpqfZ3zThax9Ch72WB2Te4FGYyKbkbxdyOXk9MT6kGFG5Wufn0uBwiJGt4DJhXzQ29g==
X-Received: by 2002:a92:c80c:0:b0:315:365d:534f with SMTP id v12-20020a92c80c000000b00315365d534fmr5965797iln.19.1679541558321;
        Wed, 22 Mar 2023 20:19:18 -0700 (PDT)
Received: from MBP (ec2-18-117-95-84.us-east-2.compute.amazonaws.com. [18.117.95.84])
        by smtp.gmail.com with ESMTPSA id g2-20020a92c7c2000000b003159b6d97d6sm4772218ilk.52.2023.03.22.20.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 20:19:18 -0700 (PDT)
References: <20230303161906.831686-1-schspa@gmail.com>
 <20230303161906.831686-2-schspa@gmail.com>
User-agent: mu4e 1.8.10; emacs 29.0.60
From:   Schspa Shi <schspa@gmail.com>
To:     tglx@linutronix.de, longman@redhat.com, swboyd@chromium.org,
        linux@roeck-us.net, wuchi.zero@gmail.com
Cc:     linux-kernel@vger.kernel.org, Schspa Shi <schspa@gmail.com>
Subject: Re: [PATCH 2/2] debugobject: add unit test for static debug object
Date:   Thu, 23 Mar 2023 11:16:48 +0800
In-reply-to: <20230303161906.831686-2-schspa@gmail.com>
Message-ID: <m2sfdwnoi8.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Schspa Shi <schspa@gmail.com> writes:

> Add test case to enusre that static debug object correctness.
>
> Tested on little-endian arm64 qemu, result:
>
> [    2.385735] KTAP version 1
> [    2.385860] 1..1
> [    2.386406]     KTAP version 1
> [    2.386658]     # Subtest: static debugobject init
> [    2.386726]     1..1
> [    2.401777]     ok 1 static_debugobject_test
> [    2.402455] ok 1 static debugobject init
>
> Signed-off-by: Schspa Shi <schspa@gmail.com>
> ---
>  MAINTAINERS                    |   5 ++
>  lib/Kconfig.debug              |  14 ++++
>  lib/Makefile                   |   2 +
>  lib/test_static_debug_object.c | 125 +++++++++++++++++++++++++++++++++
>  4 files changed, 146 insertions(+)
>  create mode 100644 lib/test_static_debug_object.c

Hi tglx:

What do you think about this test case? Should we need it ? There are
some platform compatibility issues here that need a little optimization.

-- 
BRs
Schspa Shi
