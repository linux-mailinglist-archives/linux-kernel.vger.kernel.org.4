Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE43750745
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjGLL47 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Jul 2023 07:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjGLL44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:56:56 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA80210C;
        Wed, 12 Jul 2023 04:56:30 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-576a9507a9bso9710747b3.1;
        Wed, 12 Jul 2023 04:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689162662; x=1691754662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JufBKpP3mzx5naRhhsOQlKoe8C3zl7UqOCd3xLyoD+E=;
        b=UMGezFSiLJJfaUMatVx+tZuFnb4jrNBFNJFSuHeLfPZGqM43EF6DdDcwTcxHnO6bUx
         S1DsV9fCRo1Gj96HaSSVfHnU5Uy9hM2B/o1uGKq0GLul74ggJ/1GIuGz1jQ5WWYdzL3S
         pCQMpEW+9+6ESfYQBUU83AwwS/cu+IvH2t4gRjUGY+cv9AuIjKSfwy+ZPkFYuDowdGu0
         KoAPWpXWNWhOy4w9FnJhbt/9zRvTHkqceLJRtk/FUBq1Z2UgS8E6+H4Y+kNW0maXL+X1
         vCOLL9CAOXwJpgXgov7n0LmCM5EoEyhVZ1h35vgN/3yKf/90MM2nwWyr3iUiCOgSMiuY
         hbgg==
X-Gm-Message-State: ABy/qLauMW3NIUoyi8Jcnk+h6QBoPBp8FLexw41GcvVj/gxIxRZgFX76
        STGRZ20xET/sINPypwP4bPflI3OjOuV4Jg==
X-Google-Smtp-Source: APBJJlFkcdw7XT3xFXPwbiOiqxTqvl41wlyD6m9JoLnHdO3nl3ryY71dI8S5yoPKVbqvitwESytmjg==
X-Received: by 2002:a0d:d616:0:b0:573:284d:6476 with SMTP id y22-20020a0dd616000000b00573284d6476mr1986582ywd.1.1689162662033;
        Wed, 12 Jul 2023 04:51:02 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id m8-20020a819e08000000b0057042405e2csm1114217ywj.71.2023.07.12.04.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 04:51:01 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-ca9804dc6e4so334997276.0;
        Wed, 12 Jul 2023 04:51:01 -0700 (PDT)
X-Received: by 2002:a25:db44:0:b0:c5e:58bf:4271 with SMTP id
 g65-20020a25db44000000b00c5e58bf4271mr2041240ybf.20.1689162660779; Wed, 12
 Jul 2023 04:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230712113731.3306-1-wsa+renesas@sang-engineering.com> <20230712113731.3306-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230712113731.3306-2-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 Jul 2023 13:50:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUQc2bnR2YGLY5c7iAPXZgFY0WS9cSXyBmYAEwiwe=igA@mail.gmail.com>
Message-ID: <CAMuHMdUQc2bnR2YGLY5c7iAPXZgFY0WS9cSXyBmYAEwiwe=igA@mail.gmail.com>
Subject: Re: [PATCH 1/3] gnss: ubx: use new helper to remove open coded
 regulator handling
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 1:40 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> v_bckp shall always be enabled as long as the device exists. We now have
> a regulator helper for that, use it.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
