Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBD9690B46
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjBIOEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjBIOEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:04:40 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECAC2ED6E;
        Thu,  9 Feb 2023 06:04:36 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id c26so1850701ejz.10;
        Thu, 09 Feb 2023 06:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uzW3nHnj5fnCOtN0H8my2p/N7+ndBtsZe+8QmFNNzxc=;
        b=FjgF9QzbI9ls1j3RjwuZ3Eu7DLlUdjb0a1Ja5oiN2IZu3YRwoyPepCiWVDPUZ4mpkC
         z1bdOCYN4zXLJkkR+yG/x/l6rrhec4TV0zHqZaAqC1uHYtPy9pXmLpyzUFkA9D05gmgU
         HtGEiF7Ynp9iNThtr67gyBJlCOJ0aNeNHZicIvmUZZDvhMMbyzIPx1faQb+vfbeYXupV
         e/7yQxEQq/nqSXtb6F0Pu8FeRTTKYmgRIt8hiRxZUx6vl93gwkIEDCIXqwOm7yLCxmZs
         rNXVyjyyYjHAMZ4CmGy95Q+WBmNo+nFyL6iBEooD4dx0WWUNGsQ+8+x3aVcDgLX6YBXU
         e/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uzW3nHnj5fnCOtN0H8my2p/N7+ndBtsZe+8QmFNNzxc=;
        b=u/sEGTANBSyB6kQ5LZE6JU35uPsUuhElkEBnlRS6ckaJ1OvzXa8WE/hd2TCMpval3b
         0OY5R6yXqUMzYVfHypJpIxFzNuSeZcwcNQgqpBniJu/yJMypJeHChWAMxvnbZXPbprIE
         lSAWuT4RXtuWX6FgWrASpIWSLmUIQVBvbK8h1NYaTXMTNssmcp2JwJe5eCFPflNWPxCh
         D81cC1rMsKTcd7QxYFWGQvmTwNNOARQtsXuMkBAHSIR1Sh0vuV1idp1tsZMoX4aRErfV
         5/gCv4jgEy5GVyLxK20X+Kp14r2ta2RRVC6Wh3RAtu117a2BrQq0xIKgw3bkG0EOYXaX
         tKkg==
X-Gm-Message-State: AO0yUKW8MS054ojQTJd6enJZLjDGpw4OF6Lsn4HzR1ndOSNpF0grSmNC
        zWYsN2yXxH2F74w229QNcOdmmeZpLebPzT62mMo=
X-Google-Smtp-Source: AK7set/PSdiSfBCDekP8ENL67NJDJ1IrBpGhWtaVGMJMrBob/HECbFNRvkTu4UlbkRUzt+8+CArqPrFy/+UGI25NkOc=
X-Received: by 2002:a17:906:17d2:b0:889:dc4d:e637 with SMTP id
 u18-20020a17090617d200b00889dc4de637mr538111eje.6.1675951474566; Thu, 09 Feb
 2023 06:04:34 -0800 (PST)
MIME-Version: 1.0
References: <20230209063816.2782206-1-peng.fan@oss.nxp.com>
In-Reply-To: <20230209063816.2782206-1-peng.fan@oss.nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 9 Feb 2023 16:04:22 +0200
Message-ID: <CAEnQRZBZ_GYK4_ZuEy2o++-hoaF4i=CjtRs8kEfhwuYGMCrr4Q@mail.gmail.com>
Subject: Re: [PATCH V3 0/6] remoteproc: imx_rproc: support firmware in DDR
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     andersson@kernel.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        arnaud.pouliquen@foss.st.com, daniel.baluta@nxp.com,
        iuliana.prodan@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
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

Looks good to me.

On Thu, Feb 9, 2023 at 9:09 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>

> Peng Fan (6):
>   remoteproc: imx_rproc: correct i.MX8MQ DDR Code alias mapping
>   remoteproc: elf_loader: introduce rproc_elf_find_shdr
>   remoteproc: imx_rproc: add devtype
>   remoteproc: imx_rproc: force pointer type
>   remoteproc: imx_rproc: set Cortex-M stack/pc to TCML
>   remoteproc: imx_rproc: set address of .interrupts section as bootaddr

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
