Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF9B74E76C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 08:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjGKGgU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Jul 2023 02:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjGKGgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 02:36:18 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD489B0;
        Mon, 10 Jul 2023 23:36:16 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5774335bb2aso59908177b3.0;
        Mon, 10 Jul 2023 23:36:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689057376; x=1691649376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWAhQvEef30a0QgnXpAXi7OUbX7QN63sgiP02lTQRGI=;
        b=FEk+FfMmOaw8z6xa0DMtibF9/i/8bYvjl5hG+szljtLJTkB2ACeJarkI9azg+t+1Pj
         7TAbgLIMvuUX+6h3SeQIZbnEIphCwpvg/OFLVOehZY5IZkZiXoBmFX5pWdatYMeARUVP
         84tHaAxdcfDvbvCtkWYbUV6AY/yAUeZDlwjgl8nuQDRr6hS4W892hDcsjlm+dq7hAquD
         mczVBly23nH5hge8uM+iQ1rBGJeFDNUwd6QGVPP01CK3jDdgt/QNzkUV6mf+9ETOPCbR
         6sRWW3lNXxtlFI2jteD1kjXXBKg4QOiZXKKek54gkEAdYbPk7kwl0k42KMfo1DGHwwwW
         ZQ9A==
X-Gm-Message-State: ABy/qLZLsB//OQOolVUE3atAn2PlK7rQ1jccqg7iWFxUCWLfwRiOONy1
        lsNhXJ3AKcfoUhoLtdH9gyuFSedeN4u5ug==
X-Google-Smtp-Source: APBJJlEUAtkdatWDr/8F2FKf0CODOP2oyZpG979yt0UsSvKZW7BXePOoynxexzaAn741t2BoMiVxmQ==
X-Received: by 2002:a0d:dd8c:0:b0:568:8e96:7008 with SMTP id g134-20020a0ddd8c000000b005688e967008mr12170146ywe.0.1689057375800;
        Mon, 10 Jul 2023 23:36:15 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id u10-20020a0deb0a000000b005772154dddbsm408268ywe.24.2023.07.10.23.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 23:36:15 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-bff89873d34so4822523276.2;
        Mon, 10 Jul 2023 23:36:15 -0700 (PDT)
X-Received: by 2002:a25:9e92:0:b0:c18:fa74:8721 with SMTP id
 p18-20020a259e92000000b00c18fa748721mr11893164ybq.12.1689057375251; Mon, 10
 Jul 2023 23:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230710233132.69734-1-contact@artur-rojek.eu>
In-Reply-To: <20230710233132.69734-1-contact@artur-rojek.eu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Jul 2023 08:36:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUS6AK+k8v2vZLakFQqknUP=k95-KGic0uRE9PncZ6CWQ@mail.gmail.com>
Message-ID: <CAMuHMdUS6AK+k8v2vZLakFQqknUP=k95-KGic0uRE9PncZ6CWQ@mail.gmail.com>
Subject: Re: [PATCH v2] sh: hd64461: fix virq offsets
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 1:31 AM Artur Rojek <contact@artur-rojek.eu> wrote:
> A recent change to start counting SuperH IRQ #s from 16 breaks support
> for the Hitachi HD64461 companion chip.
>
> Move the offchip IRQ base and HD64461 IRQ # by 16 in order to
> accommodate for the new virq numbering rules.
>
> Fixes: a8ac2961148e ("sh: Avoid using IRQ0 on SH3 and SH4")
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>
> v2: Make the IRQ base offset an explicit (64 + 16), as per review.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
