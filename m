Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49253724CEF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238816AbjFFTWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238761AbjFFTWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:22:33 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB10E7E;
        Tue,  6 Jun 2023 12:22:31 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-977d6aa3758so477064566b.0;
        Tue, 06 Jun 2023 12:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1686079349; x=1688671349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GE52NOk0UypxP33bn8g4+XP8hmFg4c3opJesoY7LCg=;
        b=RFAg5LWJjkkZe0dQsr1JwstrCVaWo4VB47+fT3XZHOlWFBCkiIg1LETlrqMLYtgOsg
         5BDL43io2FCmpcFXE3l3+F4n66dXRDgEf8xfcxFAcdT+jznLUopgEfAvZ4GzL6SoX1da
         aoTg6k53fM94uXRiYbd5YxPCqOTK237dGA+saV3hjqJu4jF7dMwZEz+S3DD6kYhza7UE
         cQBOTuJiaDyPDGRJZwE+HyNAUqeEmCvkiwr16iMCYifHf/kQt3t5EckJoLJApR2EjiX0
         cut7EtiN7NbTHz4MfZe4TXtHdnX/LX65QcE520c2AaV9D22C7RCZtGc5YdpPoQ1Wpp/2
         296w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686079349; x=1688671349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GE52NOk0UypxP33bn8g4+XP8hmFg4c3opJesoY7LCg=;
        b=FDBAS9Wox610Bm0nx3VaEPAtnazk2/gg8jppyNsKAjYUkddSDDnL7rS0Ny8EfhVYPH
         VbIQJpNlUa/lp1eXYQehT4xn3j85LxumdUbkbAPqI/gKXLXOVWzU4mRYhD0MOhvAmwwb
         frYYGa0BE1kcuuCl51NfaHr6HCizDXIOgTOj9aETu0kI2nG4OHyaAppSSRjwK4zw8fS8
         sdnArOAetvV5YPamhy4qh15snqtBDxCDsVuCU/MyIlno9nRn46CsW9S16FBHlILTMNa2
         I1XlAAv4esjzkWBTGY6vN7LD9GkB9rUfU7dVjHLzEa6sKMQPoh9ggVmsa7YGK9i2VRfS
         nvZA==
X-Gm-Message-State: AC+VfDzKBYFd3neEyfIcNuTERvYsChca0r6bZ3bE2C2I6g6Bso1cWifg
        WHUCYngcvPW45erkeDeihzq0biEBgRNtNN4h2hQ=
X-Google-Smtp-Source: ACHHUZ5GUK/RF+eP4+MP5mNutQoh4cmUk9elSAwK6vWVlKbZiNz4TheLnToyRGeGcDtMLD6jZrkuCVoNOoQUQ2MDOyU=
X-Received: by 2002:a17:907:6e08:b0:978:6a95:512d with SMTP id
 sd8-20020a1709076e0800b009786a95512dmr4124880ejc.11.1686079349273; Tue, 06
 Jun 2023 12:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230606065918.460866-1-martin@geanix.com>
In-Reply-To: <20230606065918.460866-1-martin@geanix.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 6 Jun 2023 21:22:18 +0200
Message-ID: <CAFBinCB4sv4Fk_VNEPFaPz384XF9CfXGemSqaH9YJnEh7QNnPg@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson: move mmc_request_done() call to irq thread
To:     =?UTF-8?Q?Martin_Hundeb=C3=B8ll?= <martin@geanix.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        =?UTF-8?Q?Martin_Hundeb=C3=B8ll?= <mhu@rtx.dk>,
        stable@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Tue, Jun 6, 2023 at 8:59=E2=80=AFAM Martin Hundeb=C3=B8ll <martin@geanix=
.com> wrote:
[...]
> @@ -1040,6 +1034,13 @@ static irqreturn_t meson_mmc_irq_thread(int irq, v=
oid *dev_id)
>         if (WARN_ON(!cmd))
>                 return IRQ_NONE;
>
> +       if (!meson_mmc_bounce_buf_read(cmd->data) &&
> +           !meson_mmc_get_next_command(cmd)) {
> +               meson_mmc_request_done(host->mmc, cmd->mrq);
> +
> +               return IRQ_HANDLED;
> +       }
> +
I'm wondering if this is changing the behavior when cmd->error is non-zero.

Let's take the "status & IRQ_CRC_ERR" case from meson_mmc_irq() - previousl=
y:
- cmd->error is set
- regmap_update_bits(host->regmap, SD_EMMC_START, START_DESC_BUSY, 0);
- IRQ_WAKE_THREAD
- then inside meson_mmc_irq_thread():
-- meson_mmc_wait_desc_stop(host);
-- meson_mmc_request_done(host->mmc, cmd->mrq);

With this patch:
- cmd->error is set
- regmap_update_bits(host->regmap, SD_EMMC_START, START_DESC_BUSY, 0);
- IRQ_WAKE_THREAD
- then inside meson_mmc_irq_thread():
-- !meson_mmc_bounce_buf_read(cmd->data) &&
!meson_mmc_get_next_command(cmd) can be true, which means we only
call:
--- meson_mmc_request_done(host->mmc, cmd->mrq);
--- (note the missing meson_mmc_wait_desc_stop() call before
meson_mmc_request_done())

What do you think?
Maybe we just need to remove the code from meson_mmc_irq() and just
omit any modifications to meson_mmc_irq_thread() (as it seems all
checks that you're adding are already present in that function below
the cmd->error case).


Best regards,
Martin
