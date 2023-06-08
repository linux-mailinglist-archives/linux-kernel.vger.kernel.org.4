Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEA1727BA0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbjFHJmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbjFHJmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:42:04 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E11213C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 02:42:03 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-56ca07b34b1so3417847b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 02:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686217322; x=1688809322;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C0rSNYJAAkGVGvXyT9xVOarM8J//G5UDa6R1/kM0Qto=;
        b=N8YLznZ9FSIfPXhZCq0gFbw8PYMpOn7N1L8jXEJ/RuUBy6880zurMNAn1KzcJEzLoW
         zf15QZpI/Y0JMuXE4YqqvqScTCLdIdI9kGmKK7GgpwFzD8qDMjeYBoUqc9eaAOVnSXIR
         7rIBNmzaVg0uHNMbH1GxHdhzOwI5MaRqFvdIJ4Vujn0shG0ChacjoNMwr0moKgZEyMhf
         API2Sql41r8lpBa2k45Dv0VjPQj9vVpKGlOGxZ5+JkNGxNeWna6xlf3b/2G1lBp9i0Uf
         JVK8Gqqnys6bksls+w5NSvv/VhQ7bfbdkIZJtWLgzxNFo+YTY9eWPGYAwQjTEq8s/PaC
         RcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686217322; x=1688809322;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C0rSNYJAAkGVGvXyT9xVOarM8J//G5UDa6R1/kM0Qto=;
        b=ItIHIhkg2AoyE0qjqjsyqJVgwkNeOnNMxC2JrTmYtLzxXJRH4Fis1tqGQpCQPjH6Gx
         SvZaFyD0wlxdvYINUfQ4YUkx+ltlT/89kNhUyfnOl1g6+56y3TEO/wG58JFCIeuMqmix
         7STzZpz0Df9ZxVSbhgXkZbGTL5xsoVGanPE8y5Ogq16VZ4yb04YHHbYBW9ybHwiZbMZs
         LVlzobS55EiMwjrEmUj1p4MBOHoIlRqWP7/subUd3P5hZPt1TVbCjK/yRSnafn46U2NW
         5yPXjpOCkEszaKcIKLiFxdBoLXYvnfjpHu+6Q5dJfz9EFnPXLecdtjVZBYnYv1IBZjz3
         C6DQ==
X-Gm-Message-State: AC+VfDx+TCH22tPZbxSdOtW2koA0V3EhRQEOiX1lY2S0z/boJw01MfpF
        0oj1YwXzITjadrmts4m3qWfeH54jpVhngB9JAx7D0lj8JS8=
X-Google-Smtp-Source: ACHHUZ4NhbCeRsTGBs+JPTsljuKPowuGYRbzjPwE/Kvj3MCJX1Y1MtRswA/WZssAqYL8CqnOHjdD4aYnwhNQMj/utAc=
X-Received: by 2002:a81:a202:0:b0:565:b76d:3af7 with SMTP id
 w2-20020a81a202000000b00565b76d3af7mr8991054ywg.3.1686217322134; Thu, 08 Jun
 2023 02:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-bSRZuLhZQ4Kpb4NRF2yY6XifYpB3ei4=6oFDAaG+OmeGebQ@mail.gmail.com>
 <ZH8YS+LxMM1ZPpsc@feng-clx> <CAP-bSRaNQj+fi1r0MZ64wB5_rfjHmEBFQ+QueiNQ9dnyJixG8A@mail.gmail.com>
 <ZH8pyG1SyfGxQKAm@feng-clx> <CAP-bSRa3_Janfh0yAnwmG=bh9niNUjWRPG2fQqc2SxcQR=OHGA@mail.gmail.com>
 <ZH86C4A4qpeAz/n4@feng-clx> <86521835-f13f-4d43-9a38-9a55abae0b89@paulmck-laptop>
In-Reply-To: <86521835-f13f-4d43-9a38-9a55abae0b89@paulmck-laptop>
From:   Chris Bainbridge <chris.bainbridge@gmail.com>
Date:   Thu, 8 Jun 2023 10:41:51 +0100
Message-ID: <CAP-bSRZa9axG59E3knkVXy4=36irR9E7SXqT-QSikW7BoQueBw@mail.gmail.com>
Subject: Re: PROBLEM: skew message does not handle negative ns skew
To:     paulmck@kernel.org
Cc:     Feng Tang <feng.tang@intel.com>, tglx@linutronix.de,
        sboyd@kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2023 at 20:04, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> That is a bit user-unfriendly.  Does the following fix address this
> issue at your end?

[    2.095149] clocksource: timekeeping watchdog on CPU3: Marking
clocksource 'tsc' as unstable because the skew is too large:
[    2.095152] clocksource:                       'hpet' wd_nsec:
515998611 wd_now: 1c29fb9 wd_last: 151e3b8 mask: ffffffff
[    2.095154] clocksource:                       'tsc' cs_nsec:
515124524 cs_now: 8af4c89f9 cs_last: 874f8e80b mask: ffffffffffffffff
[    2.095155] clocksource:                       Clocksource 'tsc'
skewed -874087 ns (0 ms) over watchdog 'hpet' interval of 515998611 ns
(515 ms)
