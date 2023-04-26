Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230796EFA1A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 20:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbjDZSdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 14:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbjDZSdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 14:33:16 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE0D4ECA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:33:13 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-94f7a7a3351so1424491666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682533991; x=1685125991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahaEO2iuc0jfMflwh1dK2W0/bDfUgJU7zzEfGmg6HUg=;
        b=GhXwi5ZBNA5UX2BiiXvqLuEx2rqO8Hv9j+fDwGNpELycFjGAjG+lctys83mJ0LyOra
         EQkbHJA4Epy3lB8UyffvOdw/OrT9Heg/lojRX4WRblo31U/Ivx5U+5CyWFoBfQaeKf+D
         H0vDD+Q9oGqqMhZz8wwA3Ubwo3e38tdO2lgZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682533991; x=1685125991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahaEO2iuc0jfMflwh1dK2W0/bDfUgJU7zzEfGmg6HUg=;
        b=bW0W6aUF7QvD0aFx4cj06qGj3wm0Dtya/nNqRqndnus6xxJb9Y4+YD2nZdguj67MCH
         Xorx1eVbKCEiUQQcueA0CQyLTyWFHa4E6dvhqU84dBtX6qbQOIWYAuPVfzcNoXVijpQm
         mSFlr9nDwsxl2fnQjfBNNdbwe/wCEVWeEYGPaswthadQVuxSzRazuM1bLHH35eIjCufE
         gcfeqSp1cPe8fbNqk625OC6wC1+J8YF5Y0zRxircaUC8MdjceX4atAE5/lhRT5XC60vr
         4keiwR4Aylyri9y87cRyS4mTuhtd3HY1vvA5iG3infl9N7FJfqNWQodtVunUF7yZv1uc
         VVsw==
X-Gm-Message-State: AAQBX9fYqCHiQm+KfZEZGwIWwJmNdPR53zCgXVjbqZLKgjtOG9vJZUt4
        wNqrAIrUB3a3qwiKRI0oE+KbfF4in/LfFDqSr0uAUg==
X-Google-Smtp-Source: AKy350ZUKAoM1M9moSw+IOFh5BZFR1mNBLLazZikQLPD95PnffzJJ82haIzRHzkebSgHuIyBM0w0qA==
X-Received: by 2002:a17:906:853:b0:93e:8791:7d8e with SMTP id f19-20020a170906085300b0093e87917d8emr16765843ejd.2.1682533991201;
        Wed, 26 Apr 2023 11:33:11 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id g11-20020a170906394b00b0094f4f2db7e0sm8679597eje.143.2023.04.26.11.33.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 11:33:10 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-506b8c6bc07so12571097a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:33:10 -0700 (PDT)
X-Received: by 2002:aa7:d309:0:b0:506:7f78:c4cc with SMTP id
 p9-20020aa7d309000000b005067f78c4ccmr18858879edq.27.1682533990350; Wed, 26
 Apr 2023 11:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230425041838.GA150312@mit.edu> <CAHk-=wiP0983VQYvhgJQgvk-VOwSfwNQUiy5RLr_ipz8tbaK4Q@mail.gmail.com>
 <CAKwvOdmXgThxzBaaL_Lt+gpc7yT1T-e7YgM8vU=c7sUita6aaw@mail.gmail.com>
 <CAHk-=wjXDzU1j-cCB28Pxt-=NV5VTbnLimY3HG4uF0HPP7us_Q@mail.gmail.com> <CAKwvOdm3gkAufWcWBqDMQNRXVqJjooFQ4Bi5YPHndWFCPScG+g@mail.gmail.com>
In-Reply-To: <CAKwvOdm3gkAufWcWBqDMQNRXVqJjooFQ4Bi5YPHndWFCPScG+g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 26 Apr 2023 11:32:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wib1T7HzHOhZBATast=nKPT+hkRRqgaFT9osahB08zNRg@mail.gmail.com>
Message-ID: <CAHk-=wib1T7HzHOhZBATast=nKPT+hkRRqgaFT9osahB08zNRg@mail.gmail.com>
Subject: Re: [GIT PULL] ext4 changes for the 6.4 merge window
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
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

On Wed, Apr 26, 2023 at 11:22=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Ah, it does do something in the callee, not the caller:

Ack, it does seem to have _some_ meaning for the return case, just not
the one we'd be looking for as a way to find mistakes in the
error-pointer case.

          Linus
