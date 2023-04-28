Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DA16F1DFA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 20:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346361AbjD1S1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 14:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344368AbjD1S1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 14:27:02 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888A5449D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 11:26:59 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-94f6c285d92so17119766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 11:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682706418; x=1685298418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MqD98UQcwdygRnwlRdXPaInX1Ic0ElwE1KiswWqRhQ=;
        b=hG5/I7/Lfbz9x4pcGKSatCk8xgTy5AZJfcHDWuoH/v0/fVGSJStCtjoGsPKpW923KR
         nPq4j1gP9Ifia/MDYccqWpyw0Q3UWudTw2FT0bXscIW7sNKMSt1H/1IoLh0ontxPHxZG
         ShBVktwwXo0VfLTDOYlPLEqrHCFWLTJbZtXmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682706418; x=1685298418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9MqD98UQcwdygRnwlRdXPaInX1Ic0ElwE1KiswWqRhQ=;
        b=FnSge8APA7ZaKWLSCeJOigi1wH/y3W02mRIiiW3Bhr207FIQ30UACtTvC/VG/z53hP
         XuhYJMQt5LOszAYr5t7dofC1glmm5du94bRMVjDu9WU5rC6729zE6MAZ5cuhtD4b/jA0
         Y4cnvkYLtahRnD0LZ2oj0cFXWqK98clmEzWU0d3S+5+yDzFZ12zZyLWwkMV7lmtJ1Isg
         4pkeTSZb4rdmXuAjRJD5RDVKbZeiPcDdtE/BA36any075kaZM90+tkTKu1jB7GVcqDLi
         +OcRTZzBiJnqxd/NTHXqfISz1pS1jR4SPb1kJyPgSyqMWZmUAo6408eRwlpOyXYP33W+
         4LSQ==
X-Gm-Message-State: AC+VfDxNpE8hxr/2l/fb3FjW7yP0SvHHALsCpfdLKufphaFkcrt2s6Yb
        QLEviyMP3meQpzsrDUvwoFAG1ngzbApevoHKdjcHpQ==
X-Google-Smtp-Source: ACHHUZ6AePVtDzaOQyPKo1oWstSpHfceW67+9XUdlr63TAI1vjMB7M8kgXiezMF5Fkzr6BxKBG27wQ==
X-Received: by 2002:a17:907:a08a:b0:94e:61d3:d13b with SMTP id hu10-20020a170907a08a00b0094e61d3d13bmr6486978ejc.75.1682706417618;
        Fri, 28 Apr 2023 11:26:57 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id sd22-20020a1709076e1600b009572bd99281sm10101199ejc.224.2023.04.28.11.26.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 11:26:56 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-94f109b1808so19114666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 11:26:56 -0700 (PDT)
X-Received: by 2002:a17:907:629b:b0:95e:e0fa:f724 with SMTP id
 nd27-20020a170907629b00b0095ee0faf724mr6523145ejc.39.1682706416181; Fri, 28
 Apr 2023 11:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230421-kurstadt-stempeln-3459a64aef0c@brauner>
 <CAHk-=whOE+wXrxykHK0GimbNmxyr4a07kTpG8dzoceowTz1Yxg@mail.gmail.com>
 <20230425060427.GP3390869@ZenIV> <20230425-sturheit-jungautor-97d92d7861e2@brauner>
 <CAHk-=wjpBq2D97ih_AA0D7+KJ8ihT6WW_cn1BQc43wVgUioH2w@mail.gmail.com> <eb05bc4e50464579a60b80ddfd596a6a@AcuMS.aculab.com>
In-Reply-To: <eb05bc4e50464579a60b80ddfd596a6a@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Apr 2023 11:26:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=whdwStxVMiqQAKMJdYEF+mrxgqxvj1rFgbRw-9Rptavsg@mail.gmail.com>
Message-ID: <CAHk-=whdwStxVMiqQAKMJdYEF+mrxgqxvj1rFgbRw-9Rptavsg@mail.gmail.com>
Subject: Re: [GIT PULL] pidfd updates
To:     David Laight <David.Laight@aculab.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Fri, Apr 28, 2023 at 1:40=E2=80=AFAM David Laight <David.Laight@aculab.c=
om> wrote:
>
> It is definitely architecture dependant.
> x86-64 and arm-64 will return two 64bit values in registers.
> x86-32 and arm-32 return two 32bit values on stack.

Yes, but I think the "return value in two registers" is the generic
thing. At least gcc has very special code to deal with a two-register
return value.

And yes, those registers will then obviously be different sizes on
different architectures, but a tuple like a '(ptr,fd)' thing will fit
regardless.

We very much do depend on this kind of pattern generating reasonable
code in some parts of the kernel.

               Linus
