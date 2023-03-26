Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3CA6C9777
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 20:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjCZSaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 14:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjCZSaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 14:30:23 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3432440E1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 11:30:22 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h8so27129157ede.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 11:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679855420;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=63o6e5rEgX2IrN7zKM8V/sqYJ9KqMSs/8xneBhtemz8=;
        b=a+X09xb6Xg2LN0YE6I9dwWGx8Iydb5dVfBNXUu30YMTUCxvR/5sS9a6RlTOCSfCere
         jf/6+IFmH3c6oRMoc9MNi1+skC64nVUmkEoYe6+GgXK+MmTzEmAMqzbwrTOpt/g8rgTQ
         XMbXk4Ap6uLOSZ2Rc5UxK1RWweWeM5eXov3Ffccbw9j5voaKQUaAZEhduvLudHX+TXJQ
         fxwM/6T9hXCGSkaSIDVyFNvC+m7l+jekCGhYONWeqa50zsaJrm1tvmYw9Uw+1vbFF4FT
         0lVZ3x551OxXQBTXbM5+fBeH8a46uoTSPr1dYH5bzYxYqEmjCrxzVEMU1F0/ED3Wdh99
         Hp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679855420;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=63o6e5rEgX2IrN7zKM8V/sqYJ9KqMSs/8xneBhtemz8=;
        b=Gnxs+US08JIlgpfjNjIII9HbQIQNrzg3P2rTkFzL5cj8sSdKARYott1BRpyhIuGi/5
         gUrs94H0OMgNR7Hhpi7ijjpuaFQeONhqGeNNSqjdu5XKqhOOa29lC2SCTCYmEKjI5Zao
         uWO6+nM/wDd4HaPYfeiWfRNzOWXwpTQTNO0dmMY5DYLSFrpyAs1qFbf07ZgFObycnvez
         x4BXBEKxLtL6NESukoQw1UIElpMdnd3t8RvK3d4JSOexN46zWmlrxaooCzHYOiqZg9zn
         8JCLoQit/sosCJ5GGQv1VFoUOhcIAykncC6k56voB/GgD5lBWlh725j5oJFa6tAAKTf+
         BvWw==
X-Gm-Message-State: AAQBX9dfXc22vS1byfua5ysKkNJfUPS3sy1Eu2nsZ8Nrh35c7+KbhTaU
        GxItasK7xAKutUnZAUEM9Q==
X-Google-Smtp-Source: AKy350YA8IN7Rquiu4eZ1pwnI/sPJvRbi8U+y6X0oCKABdKxueWbJ5wqn0w1uPz2D6X1hAsklJF7xw==
X-Received: by 2002:a17:906:bcd1:b0:921:5cce:6599 with SMTP id lw17-20020a170906bcd100b009215cce6599mr10718283ejb.41.1679855420414;
        Sun, 26 Mar 2023 11:30:20 -0700 (PDT)
Received: from p183 ([46.53.253.224])
        by smtp.gmail.com with ESMTPSA id kx1-20020a170907774100b0091fdd2ee44bsm13149307ejc.197.2023.03.26.11.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 11:30:20 -0700 (PDT)
Date:   Sun, 26 Mar 2023 21:30:18 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] tools/nolibc: tests: add test for -fstack-protector
Message-ID: <89a960c7-0c9b-43ab-9fc8-a68405f7ed6a@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> #if defined(__clang__)
> __attribute__((optnone))
> #elif defined(__GNUC__)
> __attribute__((optimize("O0")))
> #endif
> static int smash_stack(void)
> {
> 	char buf[100];
> 
> 	for (size_t i = 0; i < 200; i++)
> 		buf[i] = 'P';
> 
> 	return 1;
> }

If you want to corrupt the stack, corrupt the stack!

asm(
".globl f\n"
"f:\n"
"movq $0, (%rsp)\n"
"ret\n"
".type f,@function\n"
".size f,.-f"
);

No problems with optimisation levels.
