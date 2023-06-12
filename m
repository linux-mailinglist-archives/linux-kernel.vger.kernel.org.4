Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA0372D067
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237695AbjFLUZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237261AbjFLUZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:25:01 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C23D19B;
        Mon, 12 Jun 2023 13:25:00 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-977c89c47bdso861230366b.2;
        Mon, 12 Jun 2023 13:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1686601498; x=1689193498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5rGJiRfcY9q4io21i6v5+UGLN2TIvQIc+ZeIBoHNMI=;
        b=rsq5aBp+h543P3f1o3uOlrJ8+ZkTet7FJQe0k6hVEjPCXqE28A45C5qoCMSyUA6G5n
         OqpttFi85EOTuvmrZ+ZfUgEtFjNl15FF1rsJknRqFK6XivcOL9BEdGsUZtp5j41IdKES
         P1g5rhE3yY3mhyU+DeojvzCdFMoKrbu0n86CfXvZj5yWxGkNH2nRgHQjErj9oNsu8T+J
         FFnA7Rlbg8DBc6b6I3qcwaWrSTwmMbG7JkxxecO9Xwe3TMs4QOEAIjTvvI72DmTqHGGS
         /edOsT5igvHJ2n+Y7nzLroR1k5ywT5n+yfUwRVda0Kbx/fJVZZQiYD58mEMRbL9Iph1u
         ZHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686601498; x=1689193498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5rGJiRfcY9q4io21i6v5+UGLN2TIvQIc+ZeIBoHNMI=;
        b=Z5v85VKCQwZMJPC1jvZz9UULMlN1iu5jlBYDhvyS0pRJg9dvYwTk/xU1/eaOCKrPsk
         7Szs0h07ATZ9eRqhKBliZDt4h0h+nNhdl32HwjuYERMb0lmdrdE7DLWXG2ocux71gj6u
         nefZJ2QercfMrUu5urErXwIqMuOH3sNVXzyTIPT2PUsSOzNQJpJPe9DQ7/NTCqh3wP/d
         ZCfYKnRqG2NmRf3CI0cbeVT/p1t5yDoVDEnqRmUeJ0in7ITuwUGtxRIE2lqtwL/x1en2
         LEREoCI5IvISqzVWk9SYCS4SGA80Xkg8787e2Ow/pbHsgPUKEEPn4aAdsx2TBO9lBi8r
         AqbA==
X-Gm-Message-State: AC+VfDw7Ef0ol74mq0a6CT71Weou7iQObAHNtiymv1QRWVfBuTRciTmP
        yh9oFIzm0XmjU5M8v/mYAnKNqSRDUyeLvoefzf4=
X-Google-Smtp-Source: ACHHUZ4E0TWnsoyvUR7I33Kr/9TqSPqf+D2KoUdwkY2FAuQN2/ySPcvpG1fooy3zg7oLEm0Lwr/W0Iinb3bBwvZut0o=
X-Received: by 2002:a17:907:60cd:b0:982:26c4:e4b0 with SMTP id
 hv13-20020a17090760cd00b0098226c4e4b0mr1806618ejc.6.1686601498264; Mon, 12
 Jun 2023 13:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <9d28466de1808ccc756b4cc25fc72c482d133d13.1686403934.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <9d28466de1808ccc756b4cc25fc72c482d133d13.1686403934.git.christophe.jaillet@wanadoo.fr>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 12 Jun 2023 22:24:47 +0200
Message-ID: <CAFBinCBC3Cg_1UaYTxqq21-1pQ+cnT6VfL7kmQn0+v+26hiv_w@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3-meson-g12a: Fix an error handling path in dwc3_meson_g12a_probe()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Felipe Balbi <balbi@kernel.org>,
        Yue Wang <yue.wang@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2023 at 3:32=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> If dwc3_meson_g12a_otg_init() fails, resources allocated by the previous
> of_platform_populate() call should be released, as already done in the
> error handling path.
>
> Fixes: 1e355f21d3fb ("usb: dwc3: Add Amlogic A1 DWC3 glue")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

We should move to devm_of_platform_populate() mid term.
That said, this fix is good for now because it's simple and can be backport=
ed.
