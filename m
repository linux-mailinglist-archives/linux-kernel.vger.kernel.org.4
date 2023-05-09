Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C02D6FCDA0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 20:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbjEISVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 14:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjEISVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 14:21:05 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FED10D4;
        Tue,  9 May 2023 11:21:03 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-965d2749e2eso853066766b.1;
        Tue, 09 May 2023 11:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683656462; x=1686248462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAU/TKhzNSlOY/Os7CAfOCmst5luRw79pGJePyYkmjI=;
        b=Q8iWOLG5uyCKkbR+lm2anl3kCm8BNUVgJ+ifPXKKV8jNNhtFglfYnbqyQguZRWbpho
         Siy9U83QD4C1BYdtwNRxa0i92Ut29ckJAn7oWa5OopTy63BszzXrEb+Evhar8i6w60AT
         IArC0db4KqzpBSvBNLrv9qzDEvWAX0ji5jc5qIU05O+nOiGP+nfBuvF8DzzhLCLDT41J
         BE6pkpp9AM8c7lhSKv9OoOlCHjeSEGRJHNlDKn270ma8/bmJxGKrRlJPI4VY+0ujToEh
         P7vvlgnejBaNWfHtar3tFXRjdtnNIZpQM0psYne8nrr2EPzRXq8SZCgBzuHpGai3AG0x
         6NVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683656462; x=1686248462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAU/TKhzNSlOY/Os7CAfOCmst5luRw79pGJePyYkmjI=;
        b=CD2ZbhqXase0JwUm93CxRSx/OZN1uSGdm0pNLXpbxPcvzOuwzi8yC3akL8+r/toErz
         E2aTRZVivvHPtne9fL6JxDY6SdaN91sEsZtqKruPSIKBE7cVX2it156y6nhAhzeM08w8
         b1ThDhwQIM2hFzrcGjUIdDwh6usoYz5UxMUlUmbvozq9LbTnqtoVKDDjSq0CSP4VkrAi
         eKjmZtN4lONdzSoQeOA0Rb2gK20LGvd1uUUpqZa/nQVe4GpDek/rEpC3R6wmH+F9vozJ
         sWebRTJPgSe27dQa4W5e3bmLoL9g2m3Hf+v1pFQD0bLg/YZXRO68YIuNOis6TQKAtpEZ
         brTg==
X-Gm-Message-State: AC+VfDyeOGDhICJjwCQuk4QnLimLMTCSrK2cVrR55i8Iw0Y5n4ZakvlM
        +NkDrtQxNI7bvkrVIImuQi2v17et3Ik+DdOW4RGpguUQgpY=
X-Google-Smtp-Source: ACHHUZ6OjM7PCpD8/z2IYotZln1D2/7FpG9nyZ1pFrknkuSvitkhoy9/WsrSb21c+NIg37IKCXXJQTyeNhQBNAekXSQ=
X-Received: by 2002:a17:907:5ca:b0:965:6cb9:b768 with SMTP id
 wg10-20020a17090705ca00b009656cb9b768mr10866237ejb.31.1683656462080; Tue, 09
 May 2023 11:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230509084007.24373-1-lukas.bulwahn@gmail.com> <7cbe80f0-dcc3-bfc3-3bd8-c9f96704618d@intel.com>
In-Reply-To: <7cbe80f0-dcc3-bfc3-3bd8-c9f96704618d@intel.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 9 May 2023 20:20:50 +0200
Message-ID: <CAKXUXMxO4b-8wT-88fJ=++woH-p79_4R-vUr=aELNFYinGcEuw@mail.gmail.com>
Subject: Re: [PATCH] x86: make config X86_FEATURE_NAMES visible with EXPERT
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, May 9, 2023 at 4:07=E2=80=AFPM Dave Hansen <dave.hansen@intel.com> =
wrote:
>
> On 5/9/23 01:40, Lukas Bulwahn wrote:
> > Commit 6a108a14fa35 ("kconfig: rename CONFIG_EMBEDDED to CONFIG_EXPERT"=
)
> > introduces CONFIG_EXPERT to carry the previous intent of CONFIG_EMBEDDE=
D
> > and just gives that intent a much better name.
>
> That was quite the changelog, and I'm still not quite sure:
>
> What is the problem with the existing code?
>
> What is the end user visible impact of this problem and of this proposed
> change?
>

Thanks, Dave, for your feedback.

The commit message is so lengthy, as I copied it from the original
cover letter into each commit, but I agree with your feedback.

So maybe this commit message fits better:

To simplify build configurations, the CONFIG_EMBEDDED is to be
removed. All configs that are only visible with CONFIG_EMBEDDED=3Dy
shall be now visible with CONFIG_EXPERT=3Dy.

In the x86 architecture, the config X86_FEATURE_NAMES is visible when
CONFIG_EMBEDDED is enabled. Now, make the config X86_FEATURE_NAMES
visible when CONFIG_EXPERT is enabled.


Dave, what do you think? If that is good enough for you, I will send
an updated patch with that commit message.

Lukas
