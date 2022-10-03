Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15755F390E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 00:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiJCWar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 18:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiJCWao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:30:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1678151A0F;
        Mon,  3 Oct 2022 15:30:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA035B81123;
        Mon,  3 Oct 2022 22:30:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D53C433C1;
        Mon,  3 Oct 2022 22:30:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jFI2mxte"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664836238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yj9avLD2rMdmmgRpsM+awTOml8jxYm5aGg0yHPIWqFI=;
        b=jFI2mxteNjMvWvfkDesXSr/5sIzr5hxfP2DNSHIYrrFy1rARsKeTsOikFKTox3KMdPpsTr
        dtSmEKtiXCqL7y9DR/CcwKw/d3hzO5Zwqppfe+vgLGkSOacwwFRfOVYn94wYcB7gQ5XbA0
        58b0XuF5lLtVxS7pzujDCPejVI99miU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a2fa84bc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 3 Oct 2022 22:30:37 +0000 (UTC)
Received: by mail-vk1-f173.google.com with SMTP id k9so6209343vke.4;
        Mon, 03 Oct 2022 15:30:37 -0700 (PDT)
X-Gm-Message-State: ACrzQf2oryo7W+bYaGHVBRFnYpEusY2e57QTep1ffm3PwfvxlhaZbz4o
        2JaPFm20TIrqE4Dfr4aKTNu7Dd4RPGct8DZ9cDA=
X-Google-Smtp-Source: AMsMyM6QKQhdoTy0cG2xPRbANbT5/smmbqlYjXBcZyYFORHbVvNfd5Y+Vd0ERhOmLocUWvlnVTUqSaXDnC84qcBUH3s=
X-Received: by 2002:a1f:1b45:0:b0:3a7:ba13:11ce with SMTP id
 b66-20020a1f1b45000000b003a7ba1311cemr10572301vkb.3.1664836236974; Mon, 03
 Oct 2022 15:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220930140138.575751-1-Jason@zx2c4.com> <CAAdtpL5BQA-y-N0Bc--KbfT9WXok0kNQ17YuF1Yyjg13DHLtgQ@mail.gmail.com>
In-Reply-To: <CAAdtpL5BQA-y-N0Bc--KbfT9WXok0kNQ17YuF1Yyjg13DHLtgQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 4 Oct 2022 00:30:25 +0200
X-Gmail-Original-Message-ID: <CAHmME9pbVUxTJrF-2XRHsz07P127TyvEWbDL38hi2YdRry+pAQ@mail.gmail.com>
Message-ID: <CAHmME9pbVUxTJrF-2XRHsz07P127TyvEWbDL38hi2YdRry+pAQ@mail.gmail.com>
Subject: Re: [PATCH] mips: allow firmware to pass RNG seed to kernel
To:     =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philippe,

On Tue, Oct 4, 2022 at 12:07 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> > +       add_bootloader_randomness(rng_seed, len);
>
> So we call char/random code with len=3D0. Is it safe?
> Maybe simply safer to check len before calling hex2bin?

add_bootloader_randomness() is safe for all input sizes, and is
written to be callable with len=3D0 and have no effect. So this function
should be good as-is; there's no need to special case an unlikely
instance that's already handled by add_bootloader_randomness().

Jason
