Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF0D74D5FC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 14:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjGJMrn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jul 2023 08:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjGJMrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:47:41 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C705A7;
        Mon, 10 Jul 2023 05:47:41 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-579ef51428eso57428297b3.2;
        Mon, 10 Jul 2023 05:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688993260; x=1691585260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSqp8QS3Eas+YBinZHpl7xLqipq/Ys4jkKB7+on99uc=;
        b=fxM/j3YItc11qUJ7maKZuEaELNkTsnoHa4Kx1sQ9A4RZxw7eMvQ63UOdKY/jaSo2wd
         pwmaP5OnX/imw+tea+6YLCd+2fWW+ZXWMieaCufykgXd/dZKWqC3YQhx670itBsWItz7
         1iTxAgeFn5uMIIlyjBvKH204VHTynBocGntkzO/plgzYTHz6B1E3410HIyjrkYPGZWGv
         oJCywH/rUdlkDsT3udfFZrSKiHZyfxn+tkU6i0nrxkWkPlfAwn8MzolUAu8PNiNaNx78
         v4VHhxMDS+w7sOq13DQd6eG/juF6uSy4V6mZzetJLXfDY+ozuGfyACn6lTCL/yS1pzAw
         c9Xw==
X-Gm-Message-State: ABy/qLaAwpPgPFjrZKW3P0wz/oOwF840u26TmmImJ9Ji8RkoOPpTeSIl
        A4/xXlikWrj1XDLo7h/bVaJlK1Ho1/jxYg==
X-Google-Smtp-Source: APBJJlHDGRj66C6PwIDG66DppX4uHDDOki7uehMoF5Nz2C/ZkP8ilWkPSH14uymypmT/VgUcB1RiEA==
X-Received: by 2002:a0d:d9c9:0:b0:56f:eaef:9d40 with SMTP id b192-20020a0dd9c9000000b0056feaef9d40mr13320419ywe.46.1688993260092;
        Mon, 10 Jul 2023 05:47:40 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id u63-20020a816042000000b0054c0f3fd3ddsm3072618ywb.30.2023.07.10.05.47.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 05:47:39 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-579ef51428eso57427907b3.2;
        Mon, 10 Jul 2023 05:47:39 -0700 (PDT)
X-Received: by 2002:a5b:98e:0:b0:c49:95fd:6361 with SMTP id
 c14-20020a5b098e000000b00c4995fd6361mr12951040ybq.0.1688993259725; Mon, 10
 Jul 2023 05:47:39 -0700 (PDT)
MIME-Version: 1.0
References: <fed02e0325275df84e2d76f8c481e40e7023cbd9.1688760372.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <fed02e0325275df84e2d76f8c481e40e7023cbd9.1688760372.git.christophe.jaillet@wanadoo.fr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jul 2023 14:47:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXO-f6KP1WCwwyy6Jy5eZpZ4LfFEV6y14dyrVYRp5QRMg@mail.gmail.com>
Message-ID: <CAMuHMdXO-f6KP1WCwwyy6Jy5eZpZ4LfFEV6y14dyrVYRp5QRMg@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: rzg2l: Simplify .determine_rate()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org
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

On Fri, Jul 7, 2023 at 10:06 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
> rzg2l_cpg_sd_clk_mux_determine_rate() is the same as
> __clk_mux_determine_rate_closest(), so use the latter to save some LoC.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v6.6.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
