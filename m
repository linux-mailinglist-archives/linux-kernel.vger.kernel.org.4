Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C756625E2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 13:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbjAIMwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 07:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbjAIMw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 07:52:26 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B44CB41;
        Mon,  9 Jan 2023 04:52:26 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id i20so7619361qtw.9;
        Mon, 09 Jan 2023 04:52:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k3NkQ2MoGKot6GyanlF01tIJyl/D3I3FmiwM87+ZRR0=;
        b=qt0kXDAY6EZfmz2ZMrHCYCfwwy5OLWBLtKVQ4zCBW2WTE4SXsup8uswTK04SiCzj6e
         qNmT70nhsJCeZSsbw+3c1QWbTiBF7R1t4amlhaq5L5ZxpBI1mNMuGZlJMohz0eqk9JJI
         7OnouTce9H7hfVZPql91zAjNkP2Qzs2fdGsyXNT39MDS3Jwx/juDqYPRnyY3F++58J1G
         Eqf+nVxX+Y++yXn5Mas7IB2z8I0FSUWrp8GCZgEPPFd0KPOy+jiJSv7kqh0H/fqBTvTG
         wCB7tVw54iSmKcRmx/jmRNtn0UTKRMZBl9a4DJcK2nGlFm3Kv/VqdFP+a7rnIjC/uKpH
         g7iA==
X-Gm-Message-State: AFqh2krvH3xXUmiK/pUTd48WjBaCumHyMwS2T53OpWJmNEbOX3QN2R6h
        aTIwnqoGzrJz1C4PqqhNEnfv+2DtFRMFuA==
X-Google-Smtp-Source: AMrXdXuyCnvavHh1UZDI6wcy5FdKryQlGuC+Cjj6bJoqbHcaTN5kadVo4uNlRKdNurXUYeCwTpKeVw==
X-Received: by 2002:ac8:41d5:0:b0:3ac:b93d:84b6 with SMTP id o21-20020ac841d5000000b003acb93d84b6mr6528446qtm.4.1673268745025;
        Mon, 09 Jan 2023 04:52:25 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id y4-20020ac87c84000000b0039a55f78792sm4509544qtv.89.2023.01.09.04.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 04:52:24 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-4c7d35b37e2so54760177b3.2;
        Mon, 09 Jan 2023 04:52:23 -0800 (PST)
X-Received: by 2002:a81:17d5:0:b0:480:fa10:459e with SMTP id
 204-20020a8117d5000000b00480fa10459emr3677548ywx.283.1673268743712; Mon, 09
 Jan 2023 04:52:23 -0800 (PST)
MIME-Version: 1.0
References: <20221117114907.138583-1-fabrizio.castro.jz@renesas.com> <20221117114907.138583-2-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20221117114907.138583-2-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Jan 2023 13:52:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUTjem_dYf1ycbGc6TGz28Jn7m_iSUmFJvOCWYcyCeaPg@mail.gmail.com>
Message-ID: <CAMuHMdUTjem_dYf1ycbGc6TGz28Jn7m_iSUmFJvOCWYcyCeaPg@mail.gmail.com>
Subject: Re: [PATCH 1/2] watchdog: rzg2l_wdt: Issue a reset before we put the
 PM clocks
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 12:49 PM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> On RZ/Five SoC it was observed that setting timeout (to say 1 sec) wouldn't
> reset the system.
>
> The procedure described in the HW manual (Procedure for Activating Modules)
> for activating the target module states we need to start supply of the
> clock module before applying the reset signal. This patch makes sure we
> follow the same procedure to clear the registers of the WDT module, fixing
> the issues seen on RZ/Five SoC.
>
> While at it re-used rzg2l_wdt_stop() in rzg2l_wdt_set_timeout() as it has
> the same function calls.
>
> Fixes: 4055ee81009e ("watchdog: rzg2l_wdt: Add set_timeout callback")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
