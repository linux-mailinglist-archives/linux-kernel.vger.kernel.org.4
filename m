Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACDD6EE823
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 21:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbjDYTWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 15:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbjDYTWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 15:22:01 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F5414F5F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 12:21:59 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-94f6c285d92so1164920966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 12:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682450517; x=1685042517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRik1ba8P7vVGVJFKz6rQn6VBICPL/tBFMdSaau0t/M=;
        b=WYym1n7S1kqgCyMUiIvmULs8Zsq+o45e+rMpU6g/adFa2YzJ83aVVT2fSuHa9qYoq9
         ooZsDYgX46UiziHq9gJ10ksFRe2T2s3fjtNy+PwyPdRUURDxx1bioETmPqmdtR+dRwqu
         awv5T91Rp6RZeabW4bdXk35LKTjQLBWq9kl90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682450517; x=1685042517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRik1ba8P7vVGVJFKz6rQn6VBICPL/tBFMdSaau0t/M=;
        b=ZoXFwXCZkHHri7zqdmSqZcTS85YgYJE1EtdkOWObwsYyqk+lRU+UOiEyWIwE2EtMd7
         EJuhE7JHBHqKqY5O1/UNjtmdn+M4ActrqwzxSQdyP6ZD1txMiAWCJOVVYDwt78SWhn6p
         qAzqrGThlni57fr2q88KNII4KdMe405iIdezSpbC1q89FBjU+C0Tdvnq4uS0/VTYiWas
         9KUz3xC/VY+jnPZx9uiHg1iCBPzxmF8BYAdidDce/mcQ/zCqE+7NajsG51qVrUGA84rA
         cI4ZbEvYd6X+X8Hh27UoiOzFEIo6AacjSD8pVbR1j/6KZyizF1PF7mz7v2wKm8tE8Gkr
         LfNg==
X-Gm-Message-State: AAQBX9ewikBPGz6eH8pO1E2ps324DjpINoPWiBX1l6K3ZrO6zr0HsUTD
        y2Vh5fICIRvdphIKr8HRMVRqPP1bSRrFJEXLjsnbQQ==
X-Google-Smtp-Source: AKy350Yqcmp1+vWeNrU+t+Guv+W3VxL8C4BbcPZFpOO/ir8EYRWGb5e4NI/dKUIG/TZ2NpxLHPKwrA==
X-Received: by 2002:a17:906:cb94:b0:94a:4ce3:8043 with SMTP id mf20-20020a170906cb9400b0094a4ce38043mr13324838ejb.52.1682450517547;
        Tue, 25 Apr 2023 12:21:57 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id aa21-20020a170907355500b00957dad777c1sm4810315ejc.107.2023.04.25.12.21.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 12:21:56 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-506b20efd4cso10454911a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 12:21:56 -0700 (PDT)
X-Received: by 2002:aa7:dace:0:b0:4fb:78a0:eabe with SMTP id
 x14-20020aa7dace000000b004fb78a0eabemr15219963eds.14.1682450516259; Tue, 25
 Apr 2023 12:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <bbd25997-173e-4c3b-930c-65c6232908e3@app.fastmail.com> <3579080b-db88-493c-a260-7313a81e2aa3@app.fastmail.com>
In-Reply-To: <3579080b-db88-493c-a260-7313a81e2aa3@app.fastmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Apr 2023 12:21:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgMmTo=SL1URex5kQbhwGhfBy541tbNbLXrYniAnTxvew@mail.gmail.com>
Message-ID: <CAHk-=wgMmTo=SL1URex5kQbhwGhfBy541tbNbLXrYniAnTxvew@mail.gmail.com>
Subject: Re: [GIT PULL 4/4] ARM: SoC devicetree changes for 6.4
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

On Mon, Apr 24, 2023 at 2:06=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> ARM: SoC devicetree changes for 6.4

Hmm. This also has commit e49eabe3e13f ("pinctrl: qcom: Support
OUTPUT_ENABLE; deprecate INPUT_ENABLE") that doesn't seem to be
obviously about devicetree changes.

Whatever. I took the pull, but that change looked oddly out of place..

            Linus
