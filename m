Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2785EE68C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 22:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbiI1UT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 16:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbiI1UTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 16:19:47 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA5F2AE8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 13:19:35 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id g2so8625474qkk.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 13:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Q7UihWS8ORDR1BxKnz81VzSp5IRI1MlAxyRbPq+5h9k=;
        b=jDfWZqdNXNst4wyv1ZtPvnOSEjvuH+SyUxzkTFRHkiTZSDhtnjUmY7CJmecXQlJD6v
         f1yFJK5jan8JBKC0j8sNeIrHzHyqbZB7zAixx9lL0t6Zwa7J/UNtF/YcYkQOS03I8gKF
         RJnkXtybzz7Wz0unkyAfGFPdB0yPZyMm4mGw2onASpx6M1x4b6S+fIPwJ4KfNYmSMHEN
         i6at9D6Nw03D9+FPWngbo/i48pGfb80p9dtSvH27uhbLUNLRoTeHG5Wkubpx8Ymme/EE
         ejOeDqbXR3G02MZWvpl+jcOjWqd356sBt2bJASaTh/hHBOGM6cRYuFPUJACmihU5O1aZ
         +Tqg==
X-Gm-Message-State: ACrzQf1bgaI1u1ruSMCXJP/juYsHjgMeE6grXSMZYuELFSjvw7BT2gDn
        kO73F0ogSrq0jjbD/vNzxW+JJXxNOho1yg==
X-Google-Smtp-Source: AMsMyM6CwS3+I4ZWcRsJrnyCO2433C+8pPdtVpv3qcLtgXTtwFZC+ryy7C4RLD6Ef6gmA6x77txCcQ==
X-Received: by 2002:a37:ad12:0:b0:6cf:8235:a2a2 with SMTP id f18-20020a37ad12000000b006cf8235a2a2mr17551041qkm.189.1664396374622;
        Wed, 28 Sep 2022 13:19:34 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id z25-20020ac81019000000b0035d432f5ba3sm3604590qti.17.2022.09.28.13.19.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 13:19:34 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 135so17295319ybl.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 13:19:34 -0700 (PDT)
X-Received: by 2002:a5b:506:0:b0:6af:ffac:4459 with SMTP id
 o6-20020a5b0506000000b006afffac4459mr30086528ybp.365.1664396373995; Wed, 28
 Sep 2022 13:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220927130835.1629806-1-Jason@zx2c4.com>
In-Reply-To: <20220927130835.1629806-1-Jason@zx2c4.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 28 Sep 2022 22:19:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUeE-2+aAoNSMtySt6YSbbJB=OpdKD_LmuL9bDAYZgBew@mail.gmail.com>
Message-ID: <CAMuHMdUeE-2+aAoNSMtySt6YSbbJB=OpdKD_LmuL9bDAYZgBew@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] m68k: process bootinfo records before saving them
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 3:09 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> The RNG seed boot record is memzeroed after processing, in order to
> preserve forward secrecy. By saving the bootinfo for procfs prior to
> that, forward secrecy is violated, since it becomes possible to recover
> past states. So, save the bootinfo block only after first processing
> them.
>
> Fixes: a1ee38ab1a75 ("m68k: virt: Use RNG seed from bootinfo block")
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v6.1 branch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
