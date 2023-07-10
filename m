Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF11D74D574
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 14:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjGJMaJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jul 2023 08:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjGJMaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:30:05 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DD7C7;
        Mon, 10 Jul 2023 05:30:03 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-579dfae6855so55774237b3.1;
        Mon, 10 Jul 2023 05:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688992203; x=1691584203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8UwvHLGUzIhBAMSwcKUp8ui6YGrmrv4XLl1sm4Tehs=;
        b=clVRFHqnBV8mxNT11OY1D4ZQhBHEbqLiyxuNAW4PlJtyXfaVZzwJ4oxXvXFyfiUU9n
         WwqVzHLAx5ZtzqcD3ga5v2Kga7HMz1w4g0hziRePzQUr2mJ+z2xZI3UbbT9C+Ooe11Re
         qFFm/T5V0nyEsem4bjc0UZsvlhHTFhBKlrlnSdfYkRK2l7rDhKEHI6nVgN3ZPJ6kN6UU
         si/dJ2mvbHDUNtb/xBARCjwndw0fFxrPeyHi+QYtDsxu2meLym3nru59grZKlhjnW/GX
         s9TIx+CvVN1SRWwOeBKgdLVhP2PvBBJqaQJ3kJt+JQsPIC+dEd2jgzLvrln+oZlTBY3p
         K5Iw==
X-Gm-Message-State: ABy/qLZUHOYTjG91g+QjnS2x/eKCxYPw9oJ8S389kAUXhtUJc/PrVY6d
        VtBO0gWgtBvacER6yuKVy11MwoCv/wxBYg==
X-Google-Smtp-Source: APBJJlEcurLVE+MbcZtmCHFLT6vkYEZxGC7xIdXUP2K8/ZUYI6lB36ocJbqI05yP5223DB8KbXvX4w==
X-Received: by 2002:a0d:d890:0:b0:577:257d:bf0e with SMTP id a138-20020a0dd890000000b00577257dbf0emr12499890ywe.22.1688992202820;
        Mon, 10 Jul 2023 05:30:02 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id g78-20020a0ddd51000000b0056d51c39c1fsm2979154ywe.23.2023.07.10.05.30.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 05:30:02 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-c4dfe2a95fbso5184958276.3;
        Mon, 10 Jul 2023 05:30:02 -0700 (PDT)
X-Received: by 2002:a25:86c7:0:b0:c85:d8b6:c21d with SMTP id
 y7-20020a2586c7000000b00c85d8b6c21dmr2170442ybm.31.1688992202489; Mon, 10 Jul
 2023 05:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230710024550.59544-1-frank.li@vivo.com> <20230710024550.59544-7-frank.li@vivo.com>
In-Reply-To: <20230710024550.59544-7-frank.li@vivo.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jul 2023 14:29:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWE1VDFJeUBWEHy=9jAi5P7d0HG+e1OgeQ0Wa1TkKa1RA@mail.gmail.com>
Message-ID: <CAMuHMdWE1VDFJeUBWEHy=9jAi5P7d0HG+e1OgeQ0Wa1TkKa1RA@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] ata: sata_rcar: Convert to devm_platform_ioremap_resource()
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-ide@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
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

On Mon, Jul 10, 2023 at 4:47 AM Yangtao Li <frank.li@vivo.com> wrote:
> Use devm_platform_ioremap_resource() to simplify code.
>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
