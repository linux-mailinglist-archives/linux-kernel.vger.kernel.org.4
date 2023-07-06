Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81486749BAE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjGFM2g convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Jul 2023 08:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjGFM2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:28:34 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C425171A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 05:28:32 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-c17534f4c63so657138276.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 05:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688646511; x=1691238511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aF033wdSvhE6en0dVjojudzrpib3grbe9zdW84Y321c=;
        b=KuP34YnlXfduurVj8nUrGxX0o4aPYJ5RSOReXoVn3qfwViEbvyqelQqB3srs7bJzL+
         rvuV47+vnMcCbZXDHi+jNMv5OmwiNAU22PbpB6it3Bk7sgs3xcwkoxqq/hOG/GYFCNoq
         Cw+CxDAcEBFYuFuMlKjfqse3fzmavVmYpYiVdAtqqAbYHsjHIqnS1nXlIH3JWjyeMRoI
         rhKMzCpARTz8FOB9Otm0fixmDm2DWEQL/1tNh/I0CNOULtYXQ8mYmzpkQ1882RQczVEJ
         R6+mXD52rr9HyKuD+aqzO4qKXnpIW5yjHcBdVu8pz21GicppLVphmDn8vh/twyOxqGZo
         AF5Q==
X-Gm-Message-State: ABy/qLaAJcfyt1mdP/hRPsATbJ0KApCU5pN4hUSWkph+9QeQd0iep9wP
        kbhdCWF9ktJFWPWwU/UbrHBn0Gn7sFd8NQ==
X-Google-Smtp-Source: APBJJlGF5rKR5WmNaDg5UNQIh14I1/c7oV6oWdKN2OCOgSt/c8/dKwZmjBhA+5Qo23Bq8DrpLJMgHw==
X-Received: by 2002:a25:a564:0:b0:c5d:cce7:bc9b with SMTP id h91-20020a25a564000000b00c5dcce7bc9bmr1665289ybi.34.1688646511087;
        Thu, 06 Jul 2023 05:28:31 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id w17-20020a05690202d100b00bf44703efd3sm288597ybh.6.2023.07.06.05.28.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 05:28:30 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-c17534f4c63so657125276.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 05:28:30 -0700 (PDT)
X-Received: by 2002:a25:a564:0:b0:c5d:cce7:bc9b with SMTP id
 h91-20020a25a564000000b00c5dcce7bc9bmr1665282ybi.34.1688646510743; Thu, 06
 Jul 2023 05:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688643442.git.geert@linux-m68k.org> <7519324a34015e1c046227269409fef688889f4f.1688643442.git.geert@linux-m68k.org>
 <18425cc3-9a4c-4269-aec0-3f821697bfd6@sirena.org.uk>
In-Reply-To: <18425cc3-9a4c-4269-aec0-3f821697bfd6@sirena.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 6 Jul 2023 14:28:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUo-3C7AQKAstEyYsnqULQVqRsjsZye_f1aB7aLLkjciA@mail.gmail.com>
Message-ID: <CAMuHMdUo-3C7AQKAstEyYsnqULQVqRsjsZye_f1aB7aLLkjciA@mail.gmail.com>
Subject: Re: [PATCH 2/3] regmap: REGMAP_SLIMBUS should select REGMAP
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Gray <bgray@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Thu, Jul 6, 2023 at 2:18 PM Mark Brown <broonie@kernel.org> wrote:
> On Thu, Jul 06, 2023 at 01:42:03PM +0200, Geert Uytterhoeven wrote:
>
> > Fix this by making REGMAP_SLIMBUS select REGMAP.
>
> Why is this being done as a separate patch?

Because this is a new select, which was not handled through the
"default y" before.  [PATCH 1/3] converted only the existing ones.

> > Drop the selection of REGMAP by MFD_WCD934X, as this is not needed
> > (now both REGMAP_SLIMBUS and REGMAP_IRQ select REGMAP).
>
> This has always been redudnant, why is it mixed into this patch?

Because it is related to REGMAP_SLIMBUS selecting REGMAP.
I agree it was redundant before, as REGMAP_IRQ already selected REGMAP.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
