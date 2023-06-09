Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019FB72A07D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjFIQqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjFIQpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:45:51 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F98DF5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:45:50 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-bacf9edc87bso1887284276.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 09:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686329149; x=1688921149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZjXEvXuS9StX8at+0nJXz5jAwtpZ32DN9Ij1o6mQDo=;
        b=RzSMFnJsQBAKuquKcRuuVfqAQuY8kw0oLICOKzOQnGixgM1JKtRvs6MUOpybRwUEPx
         vpEe1c8weGnPCYRbbWf2V05c1D2DFt9WNcgPLu/2cAVo4Y9SMM1ontcuAfSIrvKJQ7/e
         mYTvpLht+6FPK/AwfVqWQ/wQQAFXpypV1LWUnhFG7cgd96EUImL15x/gFBSnBAjhEFMQ
         PuvwpG5Aa7Zu2sqXfgCDqAFOr+Nk6CXNRKzhUD18BqfPArBQk9+nX97Ti5huIrB7S/d/
         wSwAmk4Vc5sUns8EXhk5QbJ3WO4KACfkMrq+UDvf87ll7mK03x1XxQwaWZ/DWPnMm3+Z
         ICrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686329149; x=1688921149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZjXEvXuS9StX8at+0nJXz5jAwtpZ32DN9Ij1o6mQDo=;
        b=j6oi0Vcc7whxTMeR7+mw3GhL39iAnpglSqep03PEJ9ixDrOMwJoMac3gDSjn69wzJd
         0PchmujjhuZ6MSs+n4bF3qVD/5OdXGrOrmLkopCpwkweHISa7R9vkbPi+sHaUTApW9xp
         jRzpbqZpPtYVLJdF2EimveUeCGlbkNBz2GUC5PEppsBpevkt+EQOKpbbG+vii0+oyU1K
         7YhSpiixo7vwKey/FyLkAGoRWuOFnv2r79D49ko8zRs9n/4x3htrEa0T7VQfwmgG4vpE
         QwKvlYxI0RFZf4crjbThCDnewztRX8iggfmsdDSm0myMit2su9CTuFTaqS/K2eugYUt5
         5PMA==
X-Gm-Message-State: AC+VfDwlkhJ3BL2BgDfJcru4lFF6fkU66uquAHyCRj3e6KHta8zIwZlp
        2fuQF41bqa6OTYlQzZ+ydsmYtkqsXzLx6FUQNg==
X-Google-Smtp-Source: ACHHUZ4t4ZlMiujQwF6h9X6dQzVkbQhaEXjjGmPiDZS/Q6uxeas2M/uVkMkTeChxWCJnLngKn/KO18hK9lX4AJdlx1k=
X-Received: by 2002:a81:a082:0:b0:568:f405:cbfe with SMTP id
 x124-20020a81a082000000b00568f405cbfemr1667688ywg.47.1686329149556; Fri, 09
 Jun 2023 09:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230609111311.4110901-1-nik.borisov@suse.com> <20230609111311.4110901-5-nik.borisov@suse.com>
In-Reply-To: <20230609111311.4110901-5-nik.borisov@suse.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Fri, 9 Jun 2023 12:45:38 -0400
Message-ID: <CAMzpN2iUfp_DFUHz30EWOKOo-81A6AhbC1dt7im4hxg8UcAvaw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] x86: Disable laoding 32bit processes if
 ia32_disabled is true
To:     Nikolay Borisov <nik.borisov@suse.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
        jslaby@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 8:07=E2=80=AFAM Nikolay Borisov <nik.borisov@suse.co=
m> wrote:
>
> In addition to disabling 32bit syscall interface let's also disable the
> ability to load 32bit compat processes.
>
> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>

This patch needs to come beforethe patch that disables 32-bit
syscalls.  It makes no sense to be able to load a 32-bit executable
that cannot make syscalls.

Brian Gerst
