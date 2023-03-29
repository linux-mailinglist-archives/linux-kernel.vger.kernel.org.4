Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B256CD539
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjC2Iv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjC2IvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:51:09 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80852685
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:50:46 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-53d277c1834so280548557b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680079845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/cLIW46SmIRvY4RiouMRQ/RQJOiGzxyqmPyutTg+zA=;
        b=QhOBzkThcCEEP2ZCg5zliykwCig0tej4mEtO5cAaTlCJE7r/I4bMQ4iBSSpjrhnae0
         L2LF5rs7cU1RatgupQufqFqIBeFvIlZv+NuT+sHNQjGGOFQ+1hgE49sNPzLCJxCdOSUP
         3GiHOBNJ4kNxbuv07uuvTShV166HoyO9x4tjK8dsgQhMHDuFGpYKNYzU6v85fOH0nA8N
         BTRDzTAcMumMh174PCFF3cgm5M/IFBYKvPVZzaqtHkv13p8pYzObR23/QK9kSAbFoS1V
         agkIoyxZgi5fPU94wcu6PdvvGt682AWB+XwG0s6houGBOcUHyk/TLJjCvaFXua8JDf+Q
         vvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680079845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/cLIW46SmIRvY4RiouMRQ/RQJOiGzxyqmPyutTg+zA=;
        b=09Q/r2NHn5xkS6AzvIeLbFqR/gPstUi7vE74B3fXeZOvMtH31Td0els2+ZOquRwhLe
         zAPsGyl2zr1iEntS6f7EIJv/SJahGmilXYBkS8Ut4EsQig8xmk43L9pUxv5fBHnc9WxL
         je1LaheKVpYDKQOz0BfXHuzAi4CyWvGE95BM384aANYjkA/jfYrxOq6hng3BaONmRcqf
         HkIrmSYYQiyD1bXevGCtPAeC5L1r/8WPNL83MisT+fKIukKhiYJibx3QDes7jEj6dfQ7
         UkY0pfCM06mkdcr2XJ8em16LQtVbIwWGHkKBZNqJCb+2v4/AsA2wfMaw8iSEYOAr/Cdg
         TGjQ==
X-Gm-Message-State: AAQBX9cGwDrINkW2c7pl6LfWopS1pxh6tBd4W9GV/8rQpV0e2eUaytLm
        Wlmf8sMNkxoZK2DwEaEPYkuqThMkSwG8NsOQsTZhlw==
X-Google-Smtp-Source: AKy350YTOjcMWaqS3odZ4BorOYs3mIxmhScLtgIMGEm9pyUKhYrReflkix3snorSrRrckz5gmqV7SwVJyJWO3XKBcJ8=
X-Received: by 2002:a81:a709:0:b0:545:4133:fc40 with SMTP id
 e9-20020a81a709000000b005454133fc40mr8817132ywh.9.1680079845742; Wed, 29 Mar
 2023 01:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230323173019.3706069-1-dianders@chromium.org>
 <CACRpkdaGpaiOVjEN6Ftq5=-yuAyD0xb7OcvtEsoqbTzias-xxw@mail.gmail.com> <CAD=FV=W6QKfQxGcSrQdgp4VHYxfk7aYZOkYx4ve7QSpoZ-LM=A@mail.gmail.com>
In-Reply-To: <CAD=FV=W6QKfQxGcSrQdgp4VHYxfk7aYZOkYx4ve7QSpoZ-LM=A@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Mar 2023 10:50:34 +0200
Message-ID: <CACRpkdaUZbyEfkcHsNuQ=KhyuiKpunZJgvrnq90kQK8Z2V4jtg@mail.gmail.com>
Subject: Re: [PATCH 00/14] Control Quad SPI pinctrl better on Qualcomm Chromebooks
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-gpio@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Rajesh Patil <rajpat@codeaurora.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 11:51=E2=80=AFPM Doug Anderson <dianders@chromium.o=
rg> wrote:

> 1. Mark could land the SPI patch at any time, assuming he's OK with
> it. It can land totally independently.

OK this happened.

> Option A:
>
> 3. You land the pinctrl and binding patches in an immutable branch and
> merge into pinctrl.
>
> 4. Bjorn merges the immutable branch into the Qulacomm tree and places
> the last 3 dts patches atop.

Looks most appetizing.

I have applied patches 6,7,8 to this immutable branch:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/lo=
g/?h=3Dib-qcom-quad-spi

and I merged that into my "devel" branch for v6.4.

Bjorn can grab the branch if he wants it.

Yours,
Linus Walleij
