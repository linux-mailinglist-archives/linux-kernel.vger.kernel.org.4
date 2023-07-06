Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BB5749472
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 05:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjGFDqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 23:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbjGFDqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 23:46:16 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8E019A9
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 20:46:15 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-4036bd4fff1so190941cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 20:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688615174; x=1691207174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+6/Ewb8CW5UwEFhxq3+XjTdI8H69MzsvTdOeTrNFoc=;
        b=mN6rfKgpcNjak7Axni12ZY6Wk8AwXxOEoZcKwn3D6Sa5SW8IY24aEKK1mVTR429Lfp
         ItRJBvIY02HblatSRe2TZJIrobFqPVZqallzFmZVUXYDCbVBmMXzYDVy/he4OXA63AVP
         U4ePOEC6p+4hlvrx9HsJ/eQZ8ET4e9P6IeqbMghhkANlznyKoIt40kKZVBSPIJvKt1/Z
         WTv+lXEGTlP8i0SwC6qof5B0tzZjjWY6+7daVwz/YG4UYp9YY2Wd6xhbkHZrggk6JNQ4
         X+tbMUbuB5btk/A6eumcLsHJLe66PwljLnwb2zsxQ4Z8fLORqFH0/6UfloZqBoTY5zVe
         cE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688615174; x=1691207174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+6/Ewb8CW5UwEFhxq3+XjTdI8H69MzsvTdOeTrNFoc=;
        b=JiqLFpNQsW3Rim6yeo6VrF7/VRgseWlr6qUmCFhsjKFKsRfAxzPL1Xpy399zIhOXe5
         il2Yjmleth2L9mVcBCx2TCTo2zww5yQ6oYyrDo3RskRG0du1zsnXZjRJ0E1qjOx8o8js
         F8R8AUBVpkq03sduuYMKNETvzJ42zwMybErfxhYSwHeh1GFjn1ABUrcSg74cQM7FJ2CK
         xSVKqxFvnO9wADzzkAffeC/ipblrKeBN+UJuA5OHZRIOtFN0tZQqJqvfpaoqGbl7vTMG
         03S+RtBaGwUu2elwyPHJ03Z/ak+3U0sMGC/4HEN/zu1KUCERZM6guCp/7YioGrB+316g
         TEzg==
X-Gm-Message-State: ABy/qLYYJzrDhGG3hU8GxoO/QFJCBECRXtPFcVF5MruVbxeUEztYuYdC
        +asBvDtSKWVvUqJaPXZ7kbaUbYKrmv9WQWpeaWud
X-Google-Smtp-Source: APBJJlHsHH6nzDsCx7a1NDkE/ars8TnxZry/kitdXKktcG8vaHSCWznkTEwnZR+TihSb631/t793e7pJUlf2ghaX/Jg=
X-Received: by 2002:a05:622a:1999:b0:3ef:3361:75d5 with SMTP id
 u25-20020a05622a199900b003ef336175d5mr35107qtc.11.1688615174355; Wed, 05 Jul
 2023 20:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230706032257.1662-1-duminjie@vivo.com>
In-Reply-To: <20230706032257.1662-1-duminjie@vivo.com>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 5 Jul 2023 20:46:03 -0700
Message-ID: <CANDhNCoJ2ZjGCY3yZ3K4XZF8-bNTExOUWNkqWtJ2FZW=bYFwzw@mail.gmail.com>
Subject: Re: [PATCH v1] tools: timers: fix freq average calculation
To:     Minjie Du <duminjie@vivo.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>,
        "open list:TIMEKEEPING, CLOCKSOURCE CORE, NTP, ALARMTIMER" 
        <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 8:23=E2=80=AFPM Minjie Du <duminjie@vivo.com> wrote:
>
> Delete a duplicate assignment from this function implementation.
> The note means ppm is average of the two actual freq samples.
> But ppm have a duplicate assignment.
>
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>  tools/testing/selftests/timers/raw_skew.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/timers/raw_skew.c b/tools/testing/se=
lftests/timers/raw_skew.c
> index 5beceeed0..6eba203f9 100644
> --- a/tools/testing/selftests/timers/raw_skew.c
> +++ b/tools/testing/selftests/timers/raw_skew.c
> @@ -129,8 +129,7 @@ int main(int argc, char **argv)
>         printf("%lld.%i(est)", eppm/1000, abs((int)(eppm%1000)));
>
>         /* Avg the two actual freq samples adjtimex gave us */
> -       ppm =3D (tx1.freq + tx2.freq) * 1000 / 2;
> -       ppm =3D (long long)tx1.freq * 1000;
> +       ppm =3D (long long)(tx1.freq + tx2.freq) * 1000 / 2;

Huh. So yeah, I looked back in my own history and this has been there
forever. I'm guessing I was intending to average the two samples and
then due to reasons I can't remember decided to just use the first in
the short-term for some debugging (with the second assignment) and
committed both.

I think it should be safe, because if the freq values are not the same
the test will return SKIP, so it's unlikely changing this would cause
new test failures.

Acked-by: John Stultz <jstultz@google.com>

Thanks for noticing this and sending this out!
-john
