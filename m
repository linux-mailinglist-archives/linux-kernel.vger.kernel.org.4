Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4E35BD384
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiISRUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiISRT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:19:56 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A8917050
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:19:54 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id w8so48056024lft.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=dRf0ty06/uotKyN1jAoSPPbSnVAvm0buWGfL71jirrE=;
        b=RC/Vi3Kc9McNRFaLh5HLy+9shoIAOcCiokeINHvd0TsUg1EChRhJCYFS3Nf3K+9Q7G
         fvg0JgltwdUiR9FsG9L97XUYl6DR6T2vKj56jFI86zKWmD3c4bw/C1KoPyJ0dLxbYWUW
         m6ST2MtAyJxyFlVpsgSOXIzQ3pV7NTOo4sSqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=dRf0ty06/uotKyN1jAoSPPbSnVAvm0buWGfL71jirrE=;
        b=UPpnzkhwoFEh1+QcnrhPGUOrHo2kAB06a3pf2SmwqRfv4FO9b/JNfXdDEOaqUBkqaW
         O1Paw/RmXbVPs0aFbquJqg4LBCedf7RxAOmw2I3T0iqjEIR02DrKVUzPro33SaIUjC00
         ABJn92M+BBNNwbz3VVCzNWiUPXwGkR9DKgAFiQqdgrDuUX/DGlQhqyYNgmNQJwSMZN+I
         f1H58Q1LVeBbIN9iB6jtCZAGCJOf6XYsFxb97wOW88/fCBvTB6/W8X0eNHrdckBNAGlQ
         PuUXAT7t0XovWXUEHGUQII1xQuyziy89OCa9TAz8SD5SnQ+pkZMit0Z1lliDCt8+PzsZ
         mljg==
X-Gm-Message-State: ACrzQf2aoVtUinKIPmzLaH552emJ5IrF2E+Le6r8TcyN4qVkhdtUUMVp
        BBRKhm8CdOLeHUo6iOrxDsR2wIezLV+bgo2/zpE=
X-Google-Smtp-Source: AMsMyM6iYSuDcprnRC38Cp/cqgUEhswQLVrc9RIXtrfv690KIt+4S5PYqZrdY00U5sneO1vnCrgPhA==
X-Received: by 2002:a05:6512:3295:b0:497:a156:795a with SMTP id p21-20020a056512329500b00497a156795amr6267060lfe.345.1663607992526;
        Mon, 19 Sep 2022 10:19:52 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id o16-20020a05651205d000b00497a1f92a72sm5269829lfo.221.2022.09.19.10.19.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 10:19:51 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id h3so26299970lja.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:19:50 -0700 (PDT)
X-Received: by 2002:a05:651c:178d:b0:261:bd23:a5f8 with SMTP id
 bn13-20020a05651c178d00b00261bd23a5f8mr5202580ljb.411.1663607990563; Mon, 19
 Sep 2022 10:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220915002235.v2.1.I7c0a79e9b3c52584f5b637fde5f1d6f807605806@changeid>
 <CAHmME9rhunb05DEnc=UfGr8k9_LBi1NW2Hi0OsRbGwcCN2NzjQ@mail.gmail.com>
 <CAM7w-FXHWzcN1Y7pwb6+1KA6A2oZRrfpOJdWFVWjRvjbp+DEOg@mail.gmail.com> <CAHmME9qmiNcs6iye=Yjnpfx7vy6QMd8t8nuVOg7omOhOdkN-Hw@mail.gmail.com>
In-Reply-To: <CAHmME9qmiNcs6iye=Yjnpfx7vy6QMd8t8nuVOg7omOhOdkN-Hw@mail.gmail.com>
From:   Sven van Ashbrook <svenva@chromium.org>
Date:   Mon, 19 Sep 2022 13:19:39 -0400
X-Gmail-Original-Message-ID: <CAM7w-FULuCCww8DMyvTuU_SLuyZWqfv3sVbvPtBorYEbhGUuUA@mail.gmail.com>
Message-ID: <CAM7w-FULuCCww8DMyvTuU_SLuyZWqfv3sVbvPtBorYEbhGUuUA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] random: move add_hwgenerator_randomness()'s wait
 outside function
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Olivia Mackall <olivia@selenic.com>,
        Alex Levin <levinale@google.com>,
        Andrey Pronin <apronin@google.com>,
        Stephen Boyd <swboyd@google.com>,
        Rajat Jain <rajatja@google.com>,
        Eric Biggers <ebiggers@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 11:06 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> By the way, there was a recent ath9k patch that kind of went to a
> similar tune. [...] Maybe that's a potential solution here, or
> something similar to it.

Jason was kind enough to point me to the patch in question:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=36cb6494429bd64b27b7ff8b4af56f8e526da2b4

This patch limits the long sleep inside the fillfn kthread, by
terminating the sleep on
hwrng_unregister().

This doesn't appear like a viable approach for the suspend/resume issue?
- there is a great multitude of tpm_msleep()/msleep() calls in the tpm's
  rng_get_data() path. They would all have to be made interruptible.
- even if interrupted successfully, now the kthread must be blocked until
  after resume. If so, what is the point of using a non-freezable kthread.
