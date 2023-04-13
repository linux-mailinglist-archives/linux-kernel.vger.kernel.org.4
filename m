Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538266E173E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 00:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjDMWUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 18:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDMWUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 18:20:23 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F10226BE
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 15:20:21 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id q23so31597647ejz.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 15:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1681424419; x=1684016419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXzUcxPP626cgc8CdfapvJZ46tgsC0UFbGeqvzuoYnU=;
        b=L+kmTBG6Ktzt2fMXak5DKnXkUk4b/fuoUwKatOd0CGhdkI5rJMYFQkItVv+QO7WD3/
         lIEZLMXxIr8qcpf7usgaN9uXi7R5VJW2qW1ZDwt2xIv0aEClUscfrb/WbpQZC2v90EPI
         AE4UOhJb7UHfgjWEkxDP02QcthcuI/rNwgRCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681424419; x=1684016419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXzUcxPP626cgc8CdfapvJZ46tgsC0UFbGeqvzuoYnU=;
        b=l95vWg8d/x7690s2lVOyjRDobokEu+PzgTqLAfx3O9ALuhZAN5W6YJkFi2hmUu/GRP
         RSET+HcB3Fha3F6aTDtUQOSzDxoCsAhyd3vyEhPJwZOYCrYHEK+YoIJBI7bU8addD1MD
         /2XyscTc2TuJF8/MchyODQns9LOuLxL9ngOQFHmAOK8SZgga8nAIFaUCz5TIbwhIgoYg
         R+bFZD6czstKLWc3uIPGayI/mzKaBbAbSMZ3hauA8i6HCsBy+h/cMe/FDTfpPdJoogJ0
         Tq77OzXFEVWbXsOdVtFqvT9hvasXsQ3rMsxfu8KnbyN6bH2nw0ciUny++OcnHEwzuRaZ
         Phew==
X-Gm-Message-State: AAQBX9f9mU/lkgxPdr8FyfTUNPsQhiMpy/f1u1376rcU7NOMStC4seRN
        64I/bO4eCnn0eNRj+LFvLRPv0jTs7MCntxASTUd8Kg==
X-Google-Smtp-Source: AKy350auIb57JJe1ChVkJp3HeT4e+6OKovaMeOtJH8F0wJukKNbi8Se9d1Froa/c3PAywwWLCPuhCA==
X-Received: by 2002:a17:906:a142:b0:94a:98a2:d10c with SMTP id bu2-20020a170906a14200b0094a98a2d10cmr3902149ejb.65.1681424418797;
        Thu, 13 Apr 2023 15:20:18 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id l4-20020a170906a40400b00946be16f725sm1528630ejz.153.2023.04.13.15.20.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 15:20:17 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-94a35b11c08so385777066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 15:20:17 -0700 (PDT)
X-Received: by 2002:a50:9e85:0:b0:505:50a:a4d0 with SMTP id
 a5-20020a509e85000000b00505050aa4d0mr2029706edf.2.1681424417227; Thu, 13 Apr
 2023 15:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <CACRpkdZsoGihp-cVVKTMPFBPBj_7_ScaYJZFU6jZNugucyx3qg@mail.gmail.com>
In-Reply-To: <CACRpkdZsoGihp-cVVKTMPFBPBj_7_ScaYJZFU6jZNugucyx3qg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 13 Apr 2023 15:20:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wioXgXLB1XcxU_f_kmVwfDd+EoOX7KLtJh7fnPMZx4RBA@mail.gmail.com>
Message-ID: <CAHk-=wioXgXLB1XcxU_f_kmVwfDd+EoOX7KLtJh7fnPMZx4RBA@mail.gmail.com>
Subject: Re: [GIT PULL] Pin control fix for AMD laptops
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Kornel_Dul=C4=99ba?= <korneld@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 1:10=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> This is just a revert of the AMD fix, because the fix fixed
> broken some laptops. We are working on a proper solution.

ENOPARSE. "the fix fixed broken"

I tried to fix fixed broken it up.

             Linus
