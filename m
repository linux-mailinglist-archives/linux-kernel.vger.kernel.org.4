Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8822712BB6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjEZRZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237116AbjEZRZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:25:40 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138601B0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:25:37 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f600a6a890so4105e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685121935; x=1687713935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8g5Xna8j25EFmespE1bvOARSHuLS2nJdLVHo25mjSE=;
        b=f23M39+X+33xnPxCbKYMOJ14/bCAA9KXeklSOwa8N+tHHQEeVXO9PG06uqnHlgbpvJ
         yZcoi+2V0Rnvo3xNSbHS90ZINBSY8pxHi1Xm96Pc1OjyRBIMYwQg2pzWUKm9EvEGoqIg
         mRQCwruUR1IwLekhmrhr2T58qvSw2Qkt3CloEtcqrhHH6VZq5NTF+ZeRAfTCprFOJPL7
         s4ZPJ02tHgnaBv2DpSE42RD6H0VRLlp6RyMZXB3hJs1tYXQm0tIoHRpXpiEHXKluB88B
         6iMsG8tJ8UdDub6koAvqI+jJOj4p/m1joTQtKjUwx/iR1zcf7M4i1WxdB9+hz7d0nCFk
         KzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685121935; x=1687713935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8g5Xna8j25EFmespE1bvOARSHuLS2nJdLVHo25mjSE=;
        b=I2NbXET3F2qgSUDpo0gGUYtrSD/3ucgFy3p10+wu3iyAoR6UAV/kf5WLENXtedUfiY
         hkz47KNe7ZIfinF08Ss51GWAr3eg8s9boBPp8t+Ouz5z0N8uhuYL4KC1gsi8/436LjlK
         dlZj9cMPOMC2iy3NRzDa/WwP9gC155bnlqLjpci6Aw6H4Fe8qMhh7Dd9cF4//11+TdyV
         6MVjXB1Hl3QLhnBjLNii8WMKwYJmPnfFIIeNHzLcy2rSUDHBnaOb9VlqpqA9SO4qmc08
         Jo4ugnqBt+8Z8/3WscOE9MKI7JEbinu862erphpa69PQ+/G6ZctrkzZKfX5hP/okg2lN
         847g==
X-Gm-Message-State: AC+VfDz/QGtv0yHtpRFpCUN3itJODAy4rkM9vZYw43LJgC8JuFSDlE3I
        tQpA7qDoUlc4xvR9pAjWQLCpyuKhVbIflXk2M/ZJLsQy2y/TDq7mJzU5eg==
X-Google-Smtp-Source: ACHHUZ4Br5pF7X3UghPjBulDtJS9kb5PDC2rSf69Im3yVJUMPcC8EHvOTVaj+JsGIKn1he9aPepATioYeEtg/pDKIjs=
X-Received: by 2002:a05:600c:458b:b0:3f1:758c:dd23 with SMTP id
 r11-20020a05600c458b00b003f1758cdd23mr123345wmo.7.1685121935222; Fri, 26 May
 2023 10:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <CANn89iKUbyrJ=r2+_kK+sb2ZSSHifFZ7QkPLDpAtkJ8v4WUumA@mail.gmail.com>
 <CAHk-=whqNMUPbjCyMjyxfH_5-Xass=DrMkPT5ZTJbFrtU=qDEQ@mail.gmail.com>
 <CANn89i+bExb_P6A9ROmwqNgGdO5o8wawVZ5r3MHnz0qfhxvTtA@mail.gmail.com>
 <CAHk-=wig6VizZHtRznz7uAWa-hHWjrCNANZ9B+1G=aTWPiVH4g@mail.gmail.com>
 <CAHk-=whkci5ck5Him8Lx5ECKHEtj=bipYmOCGe8DWrrp8uDq5g@mail.gmail.com> <CAHk-=whtDupvWtj_ow11wU4_u=KvifTqno=5mW1VofyehjdVRA@mail.gmail.com>
In-Reply-To: <CAHk-=whtDupvWtj_ow11wU4_u=KvifTqno=5mW1VofyehjdVRA@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 26 May 2023 19:25:23 +0200
Message-ID: <CANn89i+u8jvfSQAQ=_JY0be56deJNhKgDWbqpDAvfm-i34qX9A@mail.gmail.com>
Subject: Re: x86 copy performance regression
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 7:17=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, May 26, 2023 at 10:00=E2=80=AFAM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Let me go look at it some more. I *really* didn't want to make the
> > code worse for ERMS
>
> Oh well. I'll think about it some more in the hope that I can come up
> with something clever that doesn't make objtool hate me, but in the
> meantime let me just give you the "not clever" patch.
>
> It generates an annoying six-byte jump when the small 2-byte one would
> work just fine, but I guess only my pride is wounded.

arch/x86/lib/copy_user_64.S:34:2: error: invalid instruction mnemonic
'alternative'
 alternative "jae .Lunrolled", "jae .Llarge", ( 9*32+ 9)
 ^~~~~~~~~~~

I changed alternative to ALTERNATIVE to let it build.

 SYM_FUNC_START(rep_movs_alternative)
        cmpq $64,%rcx
-       jae .Lunrolled
+       ALTERNATIVE "jae .Lunrolled", "jae .Llarge", X86_FEATURE_ERMS

I will report test result soon, thanks !
