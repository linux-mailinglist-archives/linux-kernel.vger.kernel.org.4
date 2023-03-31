Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433176D1E10
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjCaKaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjCaK32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:29:28 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E541B9;
        Fri, 31 Mar 2023 03:29:27 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id z18so13088562pgj.13;
        Fri, 31 Mar 2023 03:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680258567; x=1682850567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6pGalmuH91x8qNJD26JlG8JTdBY77rcSYzW9Te/nEc=;
        b=P38k89OQ9hawqAwX0z7PTVmHWlTSsPJdKbA9TXx1+lyHzN6Q41H7DkKjmU+mSAnu/9
         JiX/BgGC0zBeT4Ga3/G+13MrX/sd8yfQr5RcLSmzB7GnTbr8iU+OEu7l0tupRnZaugkC
         kaCPzr9OK7dOuJg7U207rZ9PqZlRqoj2NAd41cnNe0Vt0vaP2IvrzKTjC5sn2DovXoI9
         g1ksVKvQ/SFJHAEnyaI3TQM0qZD/ac9B4+WQJ4OTIBRiydWK92tMv/5AexWwDDY+UP5g
         L0bRalQ3Dvh99F0dpt4/oG2tTlALM7YzG1Ccgy2vgfao2LCe3xVU7/PA+YLgSf9pNkFE
         UrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680258567; x=1682850567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6pGalmuH91x8qNJD26JlG8JTdBY77rcSYzW9Te/nEc=;
        b=X62HoKfjP0fkHeknQqOPaLpfw/FLO90DSY37uAYYqhrns++e51wJsbpmnU3rOlg1WU
         vXa8S5EwGKRSyB6gSvsewaWFf3UAn+a1M5azrGrBUYZLeEOmmq+406A4bJIcZovwE2sg
         DO8hncsxDB3wUUtJP4yUnYT5PNgVBfU0da/paZsO9RrTh2g6a5JA/mFDlOCmE7mBo3fC
         88r64qPR2rVYAdTR1PI6s9GPTMoHZ5S5at9C5WekCIBmPy28fGtX432549lGc9XRU7E3
         uulicdp8lWhQ5kfA4sZQGgDjM4jo+zlC/HEO/N1gxackPWS9Rg4zmD4hKR03YhAnKLGO
         87vQ==
X-Gm-Message-State: AAQBX9ch3jomv5xkSTL+3w+WCLfArD2o4qLwso36oqGAScyyK272kEzV
        UvBDuEWIA218291mrIxDzchX7Akhm0a9UMKyJw4=
X-Google-Smtp-Source: AKy350Y4FPAmGnEvGQNuoFr18cjoItZm2RsOM/Q35PXOW9R7n9qQeSap6aL7Y0Lu0z8GClGpQlZr3QTF2zhKBXJkJsk=
X-Received: by 2002:a63:f149:0:b0:503:72c5:dd77 with SMTP id
 o9-20020a63f149000000b0050372c5dd77mr7634305pgk.6.1680258566591; Fri, 31 Mar
 2023 03:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230331072058.2483975-1-peng.fan@oss.nxp.com>
In-Reply-To: <20230331072058.2483975-1-peng.fan@oss.nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 31 Mar 2023 07:29:14 -0300
Message-ID: <CAOMZO5A3shnqV9A18f1JOx-dmn9MzFznv9gHr-g5fJw75LByOg@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: imx6sx: spdif clock rate is too high for asrc
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 4:15=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
>
> spdif clock is one of the asrc clock source, which is used
> for ideal ratio mode. when set to 98.304MHz, it cause the
> divider of asrc input clock and output clock exceed the
> maximum value, and asrc driver saturate the value to maximum
> value, which will cause the ASRC's performance very bad.
> So we need to set spdif clock to a proper rate. which make asrc
> divider not exceed maximum value, at least one of divider not
> exceed maximum value.
> The target is spdif clock rate / output(or input) sample rate
> less than 1024(which is maximum divider).

Please add a Fixes tag.
