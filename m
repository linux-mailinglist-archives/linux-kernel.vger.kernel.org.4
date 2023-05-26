Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70013712BF3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242685AbjEZRlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236811AbjEZRlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:41:09 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92146E6A
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:40:58 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-96f8d485ef3so159879766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685122857; x=1687714857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSaK6G2VVNNpdqq+Y56+DOhWYZRR11ay4bAj5o0qKr0=;
        b=czdUTFvhPB0C6gRIDGLrtXntLLjn8RAMUDHXPG5nwslO2jPFmWYNzO+F0MNWObI7tc
         IdwG9omkM1l+EucKUrK4tisIoPYa/TVw8r+Ho1fMGy0DrxUz2LYhusjUAl/dG6r2MfJq
         dChQOAoZqKl4SeoRM/4MPmdihEA4hptwF3e/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685122857; x=1687714857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSaK6G2VVNNpdqq+Y56+DOhWYZRR11ay4bAj5o0qKr0=;
        b=YFsRRmEQvLkC/aFKuccUuEQX6J22NfpGDAnPbyifC7mvWEVhp7t8QLI49mM7IEkCb3
         z1ziiz3oI6mm7dpeNkOz8tw9+ZZunngJi3mYfNGLnW6TeoMiNY2DwdCzbcuaVjx3/zdT
         TrW5iCkLhZsgv1OMDBDredit6APMhg5uE+vdPys3u1mt2o5X44F2bJz5zYCpDLxtVB3c
         rCrv65yKVDPlRkUDsvTQoiPhc35pkP2EKzhesmQz1DIXACj9FOv2lLgfwLrQebcWJCMY
         6oXC1/fw02t5qhmyloBFYPjly2I6Ghsewe5o4PPq1wQCbGDt6OZ+WzoEz2auDa7MEN1E
         yZJQ==
X-Gm-Message-State: AC+VfDwMSUvRCYZlpZAfd+QH2oADyx4/wPQnw9EVj1ywpK6eV8qh8kT4
        KKJlZofZDVj5Az5Wo4HdHUfuadCJbCJAgzHGVN7biVGM
X-Google-Smtp-Source: ACHHUZ4B7zlcO4gHyrkovLJQqCFiuneuPVv5VVy5HkswZawSdLwuUB1FC7bnKEqqYEZhrAbiF+AbEA==
X-Received: by 2002:a17:907:84b:b0:96f:a0ee:114b with SMTP id ww11-20020a170907084b00b0096fa0ee114bmr2606337ejb.21.1685122856809;
        Fri, 26 May 2023 10:40:56 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id d5-20020a170906640500b0094ef923a6ccsm2417929ejm.219.2023.05.26.10.40.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 10:40:56 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-96f7bf29550so157375866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:40:56 -0700 (PDT)
X-Received: by 2002:a17:907:786:b0:965:ff38:2fb3 with SMTP id
 xd6-20020a170907078600b00965ff382fb3mr2607275ejb.74.1685122856105; Fri, 26
 May 2023 10:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <CANn89iKUbyrJ=r2+_kK+sb2ZSSHifFZ7QkPLDpAtkJ8v4WUumA@mail.gmail.com>
 <CAHk-=whqNMUPbjCyMjyxfH_5-Xass=DrMkPT5ZTJbFrtU=qDEQ@mail.gmail.com>
 <CANn89i+bExb_P6A9ROmwqNgGdO5o8wawVZ5r3MHnz0qfhxvTtA@mail.gmail.com>
 <CAHk-=wig6VizZHtRznz7uAWa-hHWjrCNANZ9B+1G=aTWPiVH4g@mail.gmail.com>
 <CAHk-=whkci5ck5Him8Lx5ECKHEtj=bipYmOCGe8DWrrp8uDq5g@mail.gmail.com>
 <CAHk-=whtDupvWtj_ow11wU4_u=KvifTqno=5mW1VofyehjdVRA@mail.gmail.com> <CANn89i+u8jvfSQAQ=_JY0be56deJNhKgDWbqpDAvfm-i34qX9A@mail.gmail.com>
In-Reply-To: <CANn89i+u8jvfSQAQ=_JY0be56deJNhKgDWbqpDAvfm-i34qX9A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 May 2023 10:40:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh16fVwO2yZ4Fx0kyRHsNDhGddzNxfQQz2+x08=CPvk_Q@mail.gmail.com>
Message-ID: <CAHk-=wh16fVwO2yZ4Fx0kyRHsNDhGddzNxfQQz2+x08=CPvk_Q@mail.gmail.com>
Subject: Re: x86 copy performance regression
To:     Eric Dumazet <edumazet@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 10:25=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> arch/x86/lib/copy_user_64.S:34:2: error: invalid instruction mnemonic
> 'alternative'

Ok, that's just odd. For me, assembler mnemonics - very much including
macros - are case-insensitive.

It's actually documented that way, with the example given is for a
macro that is declared as "sum" and then used as "SUM":

   https://sourceware.org/binutils/docs/as/Macro.html

And if you want to use macros as pseudo-instructions, that's what you
want, since typically assembler instructions are not case sensitive.

But yeah, your build environment is clearly different, and yes, we
declare the macro with all caps, and other places use it that way too.

Clang?

              Linus
