Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B82631D63
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiKUJyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 04:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiKUJxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:53:34 -0500
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A102B64E0;
        Mon, 21 Nov 2022 01:53:15 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id df6so5453955qvb.0;
        Mon, 21 Nov 2022 01:53:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dxlrpHlOJrUzNiNVmnykBC6a+Ejp+1DltlLbnpgotG4=;
        b=Sch+av9+OEcZdhNhUkKff+xSVH0lIXnPSLyUsposAMOXv5Pvrc7aYtL5tpDILbDwat
         BfCammRwvEHM0E0mu8TiOHIRjJIRNwmDpv2W7Q/A/9O6MfxjFN26EsnHqmISO8bSb3B6
         0M5V/cLG0/SxDBCTm8hqF/HW/QdT/w/lvvoLWIg3RKUGXB3J+JuzgFPyues/Q4JNGgHY
         GJzWWLOcwRpdra5Bdvqvt0ZOaoM7NLNpOo4+aTMoZ4eQRF6nng1PAOobPHg8vRGOuzdd
         hMuEz2btlMSGiD7g+COwbSL5f6QQVKGCvXfRAc4hOtUexUn0/5wR+Seduaxj4KnLNlJu
         AqDw==
X-Gm-Message-State: ANoB5pl6Uou7D4lt/jtfx+9ct26ktDbEbD0HgubjxEuX6GnAj121m+vG
        uOJGoC9qJpZpcAUgKgFdQgnY4+GfhMfXrQ==
X-Google-Smtp-Source: AA0mqf6GsPe6nRV7NxA/yGXhs+1Aw69ZQhSp/JW35R56RZhILFmvNqUJtvWEmI/rsFHSPU1FWtvA9g==
X-Received: by 2002:a0c:8c41:0:b0:4c6:a037:c4e8 with SMTP id o1-20020a0c8c41000000b004c6a037c4e8mr8008979qvb.37.1669024394414;
        Mon, 21 Nov 2022 01:53:14 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id j6-20020a05620a410600b006fa2dde9db8sm7984386qko.95.2022.11.21.01.53.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 01:53:12 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id b131so12946469yba.11;
        Mon, 21 Nov 2022 01:53:12 -0800 (PST)
X-Received: by 2002:a25:ad8b:0:b0:6de:6c43:3991 with SMTP id
 z11-20020a25ad8b000000b006de6c433991mr15164599ybi.604.1669024391712; Mon, 21
 Nov 2022 01:53:11 -0800 (PST)
MIME-Version: 1.0
References: <20221118145512.509950-1-gsomlo@gmail.com> <20221118145512.509950-5-gsomlo@gmail.com>
In-Reply-To: <20221118145512.509950-5-gsomlo@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Nov 2022 10:53:00 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVAGt0V7QnGcbujL-a+W+7_Q4nRAeU+EB5yKOph2P1s9g@mail.gmail.com>
Message-ID: <CAMuHMdVAGt0V7QnGcbujL-a+W+7_Q4nRAeU+EB5yKOph2P1s9g@mail.gmail.com>
Subject: Re: [PATCH v5 04/14] serial: liteuart: don't set unused port fields
To:     Gabriel Somlo <gsomlo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        ilpo.jarvinen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 3:55 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
> Remove regshift and iobase port fields, since they are unused
> by the driver.
>
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
