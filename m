Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A88737C23
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjFUHSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjFUHSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:18:18 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE82186
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 00:18:17 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-bfee66a5db6so411878276.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 00:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687331897; x=1689923897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAOzKmP5oeuqoPZ8mGCdEqZLbk+qvPzQr7Zb3mr9TxY=;
        b=YUNuT3Cuka98cObtbBUQDTjmWE/tBZlANmdRnPMI+WdEOUG063dg6xfMiXUdEHN3Nf
         KR4Po5I2lVgUepBl0GHneuu7qLdda2OQrptbxlbwCH1U/WTAroLqIat7tJwdjPTw3IwA
         VW+mazXpNwQa9q87geLhOesYquwiph38x45+ZL4ULD0zirFpSddBShdb7+Q7FyKJfJm2
         +GL000qgd7YXT9Q9PIa5xhlsbkg2EaPDdeaQWTKKMV/qZvUEy9q6Kayv6NOL8m6U2tVv
         HN0X88lYBJEQG6deggF9ZobqYZDQWDXp9vkaZmD4+gvbi6lWLcxESWHDlOEbIdn7pzhE
         MYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687331897; x=1689923897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAOzKmP5oeuqoPZ8mGCdEqZLbk+qvPzQr7Zb3mr9TxY=;
        b=UFf5MVZGqma3PHZqy/JPyLHSd2z2VurB01QKYDoR+/wWQ6pvFvjz/1bFcRekRPalN3
         5J1pf0rdX2W5o55HE66qgiFrTuAgdcuRaWEMNrMim0YZxh59VbvC8siOAqjof4bekNYE
         9l0KTVUglhOkYx5l2OJO0EnFeJn33hLHIf6W2pciNyNOExNxD8+EPHlWXvp7Z2BWhQEv
         RhMAx2EQg7LP8xkrVJIEVgTmAkgF9nDbS2ePT1H1Tae0PpbwMxmMNnHlF0MSYoahrg+E
         OcsWHqf6UGfWJUPeSlCJzUMQ72nh4ZklIpnDeuGg9dhF0DI1Iu8Jf174diUvGCfa0pO5
         S3zQ==
X-Gm-Message-State: AC+VfDxjWC62vRFCxnput85xxHwYAXNPxuBYs8LPODIQhd50WNAdyNFi
        pqWM+7yJvbaaNJx2nGM7ACz/RjrU+1TOYGVjGSfhxw==
X-Google-Smtp-Source: ACHHUZ7x21xxT6KjFP9038FIfz1FmoHroQoN+E6LWDijzKd21UMlCjyfB1Q3cK+4JYbIYvLYb13iRyy+y0cKToHfFt8=
X-Received: by 2002:a25:1686:0:b0:bac:f582:eefd with SMTP id
 128-20020a251686000000b00bacf582eefdmr5430321ybw.35.1687331896900; Wed, 21
 Jun 2023 00:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230620104349.834687-1-valentin.caron@foss.st.com>
In-Reply-To: <20230620104349.834687-1-valentin.caron@foss.st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 21 Jun 2023 09:18:05 +0200
Message-ID: <CACRpkdZO+_UsPUKVTG-7v=zMposGh_j-2Nf-C_BUPUUqxypxXQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: stm32: set default gpio line names using pin names
To:     Valentin Caron <valentin.caron@foss.st.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-gpio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 12:43=E2=80=AFPM Valentin Caron
<valentin.caron@foss.st.com> wrote:

> Add stm32_pctrl_get_desc_pin_from_gpio function to find a stm32 pin
> descriptor which is matching with a gpio.
> Most of the time pin number is equal to pin index in array. So the first
> part of the function is useful to speed up.
>
> And during gpio bank register, we set default gpio names with pin names.
>
> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>

If I get some ACK from the STM32 pinctrl maintainers I can merge
this, seems useful! Maybe you already reviewed it internally at ST?
I personally don't mind if you bring over internal reviewed-by tags.

Yours,
Linus Walleij
