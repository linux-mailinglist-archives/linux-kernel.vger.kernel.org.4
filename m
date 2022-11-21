Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510F1631D81
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiKUJ4T convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Nov 2022 04:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiKUJ4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:56:01 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8182603;
        Mon, 21 Nov 2022 01:55:47 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id c15so6920953qtw.8;
        Mon, 21 Nov 2022 01:55:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=St3MUbTUVs2+aDUKogjOGRd4edHciV6Y1IPm+TilpGk=;
        b=WVCYj7V8Sm8tHa5JE8FyDSXXJn5OrKCDllQZNAqobDzOW5WIBnXHUIM/N/M+bpykG3
         T6BI/e9ajMCJX+rE+eptAiSmrvXIdt/fYAnDcSU0XEERPuYukFaA6ZVDqZeFisf8MQmc
         Ni0y4INL2XXPzCHoyhU3BAzVa9Ve8cK4uhLrovI4izOYlcSfOAwjFXR16ZVMPMIzlPhs
         lumhVfYORnTv19jMarox4KTnt0QYu2gPw5kAEc0HFao8oImlKUqvQoIwuzf7sufEGc5v
         /r0RRt9P3NXhiIiI3MTcS3rWSYDk1mZWgzv7CVRv0vWG1Vwl0ehR4VhvWNPkhGJ5nnjD
         B0Xg==
X-Gm-Message-State: ANoB5plh/TUV5xHUJrP/aSEQEm1o66q4rwbstwL0XQRXKA+pgkvXW7Sp
        mlpImc8E/38DD8StFhzKCjNhoT2FcpODeg==
X-Google-Smtp-Source: AA0mqf5Eyff0pcOh0zmyQVqGnTKHkvtL7yDxqBuSGAixLILmd9Sk+gvuhRSRRHxH/JAoWCMdNnzv+A==
X-Received: by 2002:a05:622a:2283:b0:3a5:8ba0:f81f with SMTP id ay3-20020a05622a228300b003a58ba0f81fmr16904064qtb.395.1669024546017;
        Mon, 21 Nov 2022 01:55:46 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id e9-20020ac81309000000b003a56796a764sm6412592qtj.25.2022.11.21.01.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 01:55:44 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-39e61d2087dso32938447b3.5;
        Mon, 21 Nov 2022 01:55:44 -0800 (PST)
X-Received: by 2002:a81:f80f:0:b0:38e:e541:d8ca with SMTP id
 z15-20020a81f80f000000b0038ee541d8camr15664270ywm.283.1669024544135; Mon, 21
 Nov 2022 01:55:44 -0800 (PST)
MIME-Version: 1.0
References: <20221118145512.509950-1-gsomlo@gmail.com> <20221118145512.509950-7-gsomlo@gmail.com>
In-Reply-To: <20221118145512.509950-7-gsomlo@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Nov 2022 10:55:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXuHM2QdmNUuJ7Zb9XOAaKR8fegb7KiTL+5_mPkdO307A@mail.gmail.com>
Message-ID: <CAMuHMdXuHM2QdmNUuJ7Zb9XOAaKR8fegb7KiTL+5_mPkdO307A@mail.gmail.com>
Subject: Re: [PATCH v5 06/14] serial: liteuart: move tty_flip_buffer_push()
 out of rx loop
To:     Gabriel Somlo <gsomlo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        ilpo.jarvinen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 3:56 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
> Calling tty_flip_buffer_push() for each individual received character
> is overkill. Move it out of the rx loop, and only call it once per
> set of characters received together.
>
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
