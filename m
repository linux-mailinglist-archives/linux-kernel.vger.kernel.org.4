Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FDA6AED5A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 19:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjCGSDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 13:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjCGSDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:03:04 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA46EA6BF5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 09:56:12 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id g3so55890949eda.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 09:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1678211771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpbwD5A+nT3p8meze/QbtH3VFkABogGoDoeoO8g0g+8=;
        b=GYEZjQyFR0uDSo/6obGk52hmnrkvkX/aOV+lQp6jP9HYYzznFirIN/GJoNFU1AGTn3
         VtKvQ0U2EOj9bfIycG9jNIdZ1bTbcxWniVUxTlMik7QFPDzLAUBjGCox1E4/2JHALhbq
         2x/N2l9l5kF5eeWDQRle0rU1Pq7MxbBV937Yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678211771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpbwD5A+nT3p8meze/QbtH3VFkABogGoDoeoO8g0g+8=;
        b=qEHHBiPLQMW6T2Uc4sGSmLb0+1HwBQvxliPsdK3sxIfFFRKRJEov9dUJLYFR4q3VEp
         xE0rMsSXymhtgf19XbZw+gshSk66kp8EVYUTMVg08nkbq1v5WCPkP4NFWsiwd2nCH/Ex
         m48IGtVEky0xj7MNpXnM0QBqkOXnXee5olHiZvA1KzAfH2nAUR8/VC0JKWHX2t6ZARyQ
         7b6dFRtaZfShY8Ct8mZFgoUP7XKl6evp5YF0zgEQEFyG7lO9nb0vlonQPnW2qdY8x834
         AhU87eh5ex+szjvtz5uwZHEgoZndaCthm5NtAvIS0nvK8ZEqFmcj7wTLs148onw5g88s
         bCjg==
X-Gm-Message-State: AO0yUKUCFmDYIkFLUkM4PuAst8+TiCGU1mU6kT1e6uDbdRgUtWgqBF/9
        wP7G8zYDQDylokn+kUDzLRc8u9TPvYw9PRsGJZF1iuX5
X-Google-Smtp-Source: AK7set8yZq683GGVmE8yFOgwflur1XyW3nprOv1Q4CZxsRn0uKQgVWuDkK4j3f08lhXJMtONT11HtA==
X-Received: by 2002:a05:6402:8ca:b0:4ab:4289:e9f8 with SMTP id d10-20020a05640208ca00b004ab4289e9f8mr12595359edz.3.1678211771096;
        Tue, 07 Mar 2023 09:56:11 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id v18-20020a17090651d200b008bbc9115038sm6448356ejk.56.2023.03.07.09.56.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 09:56:10 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id x3so55681858edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 09:56:10 -0800 (PST)
X-Received: by 2002:a17:906:b10d:b0:878:561c:6665 with SMTP id
 u13-20020a170906b10d00b00878561c6665mr7662618ejy.0.1678211770178; Tue, 07 Mar
 2023 09:56:10 -0800 (PST)
MIME-Version: 1.0
References: <20230307125358.772287565@linutronix.de> <20230307125538.989175656@linutronix.de>
In-Reply-To: <20230307125538.989175656@linutronix.de>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Tue, 7 Mar 2023 09:55:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjO15WdfF2Y=pROf2pid0zW5xfHnfJt3bH2QWQp6oWyGw@mail.gmail.com>
Message-ID: <CAHk-=wjO15WdfF2Y=pROf2pid0zW5xfHnfJt3bH2QWQp6oWyGw@mail.gmail.com>
Subject: Re: [patch V2 4/4] net: dst: Switch to rcuref_t reference counting
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Wangyang Guo <wangyang.guo@intel.com>,
        Arjan van De Ven <arjan@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 4:57=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> -       atomic_t                __refcnt;       /* 64-bit offset 64 */
> +       rcuref_t                __refcnt;       /* 64-bit offset 64 */

> -       atomic_t                __refcnt;       /* 32-bit offset 64 */
> +       rcuref_t                __refcnt;       /* 32-bit offset 64 */

I assume any mis-use is caught by typechecking, but I'd be even
happier if you changed the name of the member when you fundamentally
change the use model for it (eg "__refcnt" -> "__rcuref" or
something).

Or was there some reason for not doing that?

          Linus
