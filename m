Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1337631D1F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiKUJpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 04:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiKUJpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:45:32 -0500
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBDFDEA4;
        Mon, 21 Nov 2022 01:45:31 -0800 (PST)
Received: by mail-qv1-f50.google.com with SMTP id i12so7685709qvs.2;
        Mon, 21 Nov 2022 01:45:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=35vxWs5cwO0QxNYuBdoRAR/aU6e3A2oDOcVJrHNXrgM=;
        b=g1kmj9nsL3IK0BRaYUCqdA1YOqyjLNcQWmHQxPBvzDv/KgKONxBgsHDtp4Cl+7Q3tS
         IQc7P9S7ciugFc41ptjqwAhGtnkmUn3AJCYWASWkoB2+TRLnGgT4aNFPMrZIeohn4zHN
         Nd6oFEJl+8g9HVb3tEbI33HZu0eqiowJlsBPl9q4wvCOF/MDSSyDKKkyxInxK89zRwJb
         OqjrBOZXmgCym0nu4l6zDNOGX5iRdybwPbeozOrww+j5jbH46GUiAKcUjMO40GiEtGoB
         4coTRPVAesILHJnMDTbusWDoANtO2Bt5XcunnE3I4bjGRrbKcsjrAJsbXqK0QIQdGAqJ
         CFlA==
X-Gm-Message-State: ANoB5pn1hSQ9a3Rg2y7bz94+yts4cMUUZmj7pU5t3mc4IkwlEyb4YT8D
        G1GPbS6jV1XzTgB/KHIc3IH8UQcP/mwAOg==
X-Google-Smtp-Source: AA0mqf6BYBDenKmoprjrVUhMEL5+aZ87Y18Rrrt9teXhL6lPyXv48r9zDRLnCz46aicSJaEELDqmuw==
X-Received: by 2002:ad4:430f:0:b0:4bb:64f7:dce5 with SMTP id c15-20020ad4430f000000b004bb64f7dce5mr16520851qvs.15.1669023930405;
        Mon, 21 Nov 2022 01:45:30 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id i10-20020a05620a404a00b006bb8b5b79efsm8078070qko.129.2022.11.21.01.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 01:45:29 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-3a7081e3b95so4045177b3.1;
        Mon, 21 Nov 2022 01:45:29 -0800 (PST)
X-Received: by 2002:a81:f80f:0:b0:38e:e541:d8ca with SMTP id
 z15-20020a81f80f000000b0038ee541d8camr15639818ywm.283.1669023929286; Mon, 21
 Nov 2022 01:45:29 -0800 (PST)
MIME-Version: 1.0
References: <20221118145512.509950-1-gsomlo@gmail.com> <20221118145512.509950-2-gsomlo@gmail.com>
In-Reply-To: <20221118145512.509950-2-gsomlo@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Nov 2022 10:45:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUoE7HUmAxQkwTditVzGL6cJiw8tnEa9ys6EcSOp8seBw@mail.gmail.com>
Message-ID: <CAMuHMdUoE7HUmAxQkwTditVzGL6cJiw8tnEa9ys6EcSOp8seBw@mail.gmail.com>
Subject: Re: [PATCH v5 01/14] serial: liteuart: use KBUILD_MODNAME as driver name
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

On Fri, Nov 18, 2022 at 3:56 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
> Replace hard-coded instances of "liteuart" with KBUILD_MODNAME.
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
