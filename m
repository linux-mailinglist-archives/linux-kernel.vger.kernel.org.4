Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA1A734D31
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjFSIJm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Jun 2023 04:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjFSIJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:09:26 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183E51731;
        Mon, 19 Jun 2023 01:08:58 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5702415be17so26124857b3.2;
        Mon, 19 Jun 2023 01:08:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687162108; x=1689754108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJTqCVXdPadmDoFW6YXRm6Af8uvl9zqFd+RPVsZaxPw=;
        b=PsUwJmE9HiWO05W04Yar7wba8s0NtPkw4bCYrZoGmCfNXNgkx+3ZIx3nYV5MUH68+5
         0lAKeKJNJ/B6M6VitZBr1LFmoX29aWPFZPAR19eHO0a7AskEqXHaqD7kYdHhfwKnf95i
         S3yL6MIymJhZ/+9J41slrm33BJRQwCJyYYnNIdx2J6ewX1QPgZ0zysfShAMUhHwEZyOz
         XY6zVtieEb0QlCaS+Nw5g3k85BzbLyb0YFZhAdLZMNmI8y/1kaVYg8ZFzi8iQE3m7egW
         0y/PpTqPRLNZARLJn3OOQLPtVAsUYkwMgwJk4jRqOqemKIMLg9Kcqi/Fqc5WrhF7iXmo
         sVTw==
X-Gm-Message-State: AC+VfDw8Uzv0ws2dpvTytDoa9gJcMukh4rn7+GfiU1ZZzy40CRFgtOOj
        IVQK7/9T8ZYjyq0R1s2HdK46rMNq7vksow==
X-Google-Smtp-Source: ACHHUZ43ggvQxr0tbtXYZGsG4+XN95dGApJUvd28qPoxdnka/gqqXqxML2b9PR6Bgw1DMoABIKJgRg==
X-Received: by 2002:a0d:cc02:0:b0:56d:2c60:2f84 with SMTP id o2-20020a0dcc02000000b0056d2c602f84mr6438977ywd.46.1687162107732;
        Mon, 19 Jun 2023 01:08:27 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id w135-20020a0dd48d000000b00568a207aaedsm1232871ywd.68.2023.06.19.01.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 01:08:27 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-570282233ceso26207067b3.1;
        Mon, 19 Jun 2023 01:08:27 -0700 (PDT)
X-Received: by 2002:a25:db54:0:b0:bc7:2e80:b50f with SMTP id
 g81-20020a25db54000000b00bc72e80b50fmr3976835ybf.61.1687162107270; Mon, 19
 Jun 2023 01:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230617150302.38477-1-aford173@gmail.com> <20230617150302.38477-4-aford173@gmail.com>
In-Reply-To: <20230617150302.38477-4-aford173@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 19 Jun 2023 10:08:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVnRaXAdh7aA_-0oLigSn7xPPL61tnsDVxaF0r7-tYXkg@mail.gmail.com>
Message-ID: <CAMuHMdVnRaXAdh7aA_-0oLigSn7xPPL61tnsDVxaF0r7-tYXkg@mail.gmail.com>
Subject: Re: [PATCH 4/4] clk: renesas: r8a774e1: Add 3dge and ZG support
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Sat, Jun 17, 2023 at 5:03 PM Adam Ford <aford173@gmail.com> wrote:
> The 3dge and ZG clocks are necessary to support the 3D graphics.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v6.6, with s/e1/b1/ in the one-line summary.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
