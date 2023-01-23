Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F98677ECA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjAWPKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjAWPKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:10:49 -0500
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D96B13521;
        Mon, 23 Jan 2023 07:10:48 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-50112511ba7so116666447b3.3;
        Mon, 23 Jan 2023 07:10:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/bqJof5MO3pbg3UYX8cTuwpn5Rti6iDINf4SN3BEsI=;
        b=S6dHBNTjgSrKbwbzKP6W65/OZ46qhS5oT7a6g8lmY3rxVi+FuXO3TDXs/2SMtaoxCs
         s4U1ng/9R+a4IA4hI/+ASzollNZirnfhCIlHrIJUYMgIVsyiCf4kvYi02O43WsULwKpO
         32kyuidA7cm4HdD33Hu2lU/IBB33db6gJ92Oey/VrmMB+XgNsmOiV1BFxSOyaExrMEgu
         ZC9ynux3AygJqPPU+4P3Ql4IybHX9DA/1Q3fvx6tmNa1inDHKBBn6EDcvItkfvnSRzzK
         VetiTuqYrhEnifjrEh8ATmyvcjZYkGsr0WbMs2hVGWj9gG6a/G/Xgl6cLdJiFL+dWwTX
         acEQ==
X-Gm-Message-State: AFqh2krnlmt+oXIcEuMsSjs8pyx9luOI0wNwk+Yj7b2a7GR1yOKwrKVB
        NCLjawinTfYk9bwevU1zHK4M5GFGKsPVDQ==
X-Google-Smtp-Source: AMrXdXuByoLCN6ljNUdv0ZqdUQ6MDymJvPowrThRFf9GPZtY4cNLskM6vvV1DIAAKTXvG3G+CsQHYQ==
X-Received: by 2002:a05:7500:20ce:b0:f1:c647:cb45 with SMTP id u14-20020a05750020ce00b000f1c647cb45mr1869449gau.44.1674486647057;
        Mon, 23 Jan 2023 07:10:47 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id g16-20020a05620a40d000b006fc3fa1f589sm10371803qko.114.2023.01.23.07.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 07:10:46 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-4b718cab0e4so175660097b3.9;
        Mon, 23 Jan 2023 07:10:46 -0800 (PST)
X-Received: by 2002:a0d:e657:0:b0:4d9:3858:392 with SMTP id
 p84-20020a0de657000000b004d938580392mr2080328ywe.502.1674486646123; Mon, 23
 Jan 2023 07:10:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1669406380.git.geert@linux-m68k.org> <a9883a81-d909-09c5-708b-d598e030380e@physik.fu-berlin.de>
In-Reply-To: <a9883a81-d909-09c5-708b-d598e030380e@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 23 Jan 2023 16:10:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWHUnWBN7ddBow+fqmt8W--9wFe5x_YMeRg7GQ=BNAL2Q@mail.gmail.com>
Message-ID: <CAMuHMdWHUnWBN7ddBow+fqmt8W--9wFe5x_YMeRg7GQ=BNAL2Q@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/3] Atari DRM driver
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Adrian,

On Mon, Jan 23, 2023 at 4:09 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 11/25/22 21:31, Geert Uytterhoeven wrote:
> > This RFC patch series adds a DRM driver for the good old Atari
> > ST/TT/Falcon hardware.  It was developed and tested (only) on the ARAnyM
> > emulator.
>
> I just remembered this WIP driver. Has there been any progress?

So far no further progress.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
