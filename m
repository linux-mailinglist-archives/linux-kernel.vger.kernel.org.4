Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4682668D542
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjBGLQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjBGLQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:16:21 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A4C7DA0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 03:16:20 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 203so10507667pfx.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 03:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=etY0/5Cy5OAM96hnKpBnFOOWxF+pCw++PRPyw5AllxU=;
        b=PptnMabzoGyydtjb/qQdLmF1Kp9KPvsq5XIRWEj1BgRHyGW71E5i1f+YeK49ClxIQG
         dVJPErOt2EaCRuHgWo9NAAF5c6VCB+5jyPy54HDt40TQ/xPS7vex4nGg8tmfcYVjDeza
         DxifxNvWQDKgbMfLwGXMjC8fn9ky/70wBKhaSuowZxlyeMUNRcskf+WVcJS1dZ9XJ8MT
         //c7kOCo/Id/shwKaVKFEPFFKPlFMCLNcpkYjhkZ0eHKmVfsLCnRdHFeMIfntDoZJnsq
         KhRV8DakSG7psbEk7ryu7eTU+7pjhRvnhBazjSMjeL/bc2uO1ieHGPgfgiR2utqFGnBv
         R0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=etY0/5Cy5OAM96hnKpBnFOOWxF+pCw++PRPyw5AllxU=;
        b=J1PnrpGs96CyxmYUDAKtZkadWocn3oksjM3KzLt7/VXsrqVWDEO04UWwX4AXvA0M/J
         NM//8yVzUPk3P4IiYwFH1iLBnycgzuyD3L7xdLyJ94Zxy7pvKhEm1A6qoUYumX99P52W
         u6bfROprPHOJZExqx/T/C1/zzsjSost0XpSpKMVSCEY+CiSVmzGy0/HkdC4YTINOrjQH
         2HJonBYgYh2RG4UxNEcBGy6vj5oL+EyELUV3Hi2pxLk4ere6x0j6Vfzoserr6AYFNLJm
         Xn3XCSD8zDxZ5XqEnfTqrhFe+mhH4jAqp6V/l51Ve6KRF+aPPYN9CBPKk70HYHxY+3HJ
         QOvg==
X-Gm-Message-State: AO0yUKXWpHYzG+ouJMEDVPSjVbyhgD4nyG+7Uak2yvDnLZWVT3oC3oAk
        q3tqLn8SfW2d59sYlsn6fmilzXxJt5Hu0VKy48o=
X-Google-Smtp-Source: AK7set8cE9lJ0YZsm+aEvy6PWbH+nD9yXsYoy4tI4gSz6pbRzABiojgVlboPR+QUs0q9HrZ3Z2pjlcfMBVkWiBodsBc=
X-Received: by 2002:aa7:9496:0:b0:5a7:22e3:7bb with SMTP id
 z22-20020aa79496000000b005a722e307bbmr572013pfk.24.1675768579645; Tue, 07 Feb
 2023 03:16:19 -0800 (PST)
MIME-Version: 1.0
References: <1675760664-25193-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1675760664-25193-1-git-send-email-shengjiu.wang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 7 Feb 2023 08:16:08 -0300
Message-ID: <CAOMZO5Cs_ON6wJHGo4Gskc9sNThKW4bXC_jfMwxkkLkN5syo_A@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: fix getting version from VERID
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 7, 2023 at 6:30 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> The version information is at the bit31 ~ bit16 in the VERID
> register, so need to right shift 16bit to get it, otherwise
> the result of comparison "sai->verid.version >= 0x0301" is
> wrong.
>
> Fixes: 99c1e74f25d4 ("ASoC: fsl_sai: store full version instead of major/minor")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
