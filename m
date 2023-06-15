Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF500731D73
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjFOQJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjFOQJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:09:29 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60D210D8;
        Thu, 15 Jun 2023 09:09:28 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-62df2192d13so26256876d6.1;
        Thu, 15 Jun 2023 09:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686845368; x=1689437368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKVz/RTAXXjd8RP818E57r6LSIPS1q/cVSZkW9HhAGg=;
        b=hH3juqC0OXxTzxcQ4IAU7ms8+4pF03Lo2Vz+zya+7KNRfs+qiTe9FIPMM1f5HbEb5e
         fJdI8GViioXHYDJOxOcZ6EO+oIJVTM/78JbN8kO6MXOHFoJnGkNAHVUzkXPGeaab1H/U
         nrCPvRi76Z37/ru8CtN/X4cn7014B5k9SjM1OSK6iHEtJ2fmqzReB4L9lGQjWn006dlB
         leXpIKyIgVGpjZlnke1ecaf2deciNuisCWHzPkxkiPCLiWjIJOSR6wAwFb48ZzLMFk5u
         gUPumIwEmnK9S8alVP7ArfsqEH5u0vcs8FGQjyFM0HNw3R3sgHLv7scc76dU04abcB/I
         BALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686845368; x=1689437368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKVz/RTAXXjd8RP818E57r6LSIPS1q/cVSZkW9HhAGg=;
        b=ECh2aBbiDfl3Xs7dRjfriHmvAaYqwkvag+yvTV+eBR+hwdTjljhBE8kIJNBqo2WdwR
         OqvYFek/pdQXM+b8pm9+NkdeFrH1n+zqNGBfijSxuKgCE3GlyG3exehiQcNNfmiLoTOL
         1mmknxzkK3SDoBAExdM+zC1H7JHitiPxqKDJOdIOwaTpC2KDeui4BGbnLPt8rSdXZ2fU
         HIyr+7VaTAku8pg2OoTJIBT/Z67YhRz/znXo714s71mrv8RIhMqbfKA1r6psC/sIP3Ch
         Lxs2+9noLqFbIFdPgefHUfG5amfse+7s+M1uQzXD+MM/rUO2OxMjm564pRw57LeZLpob
         dsxw==
X-Gm-Message-State: AC+VfDzl+4LfO+zE0AqJqoIyg5To+MfDJNng30bbkoJkZL9oaW2TcNk6
        VbQH4Pb8yOSja/Zqy/PyHOkxqn4DAwqPlmVWsgk=
X-Google-Smtp-Source: ACHHUZ7ZwrxrtxBJReWHgNq5/laIrn64aqOWh6CzxudfDcovU5BZSNv/5cXUmDQyFYokHSDYfaa5eh1zV7d0oCC0ON0=
X-Received: by 2002:a05:6214:e4b:b0:629:78ae:80ef with SMTP id
 o11-20020a0562140e4b00b0062978ae80efmr20904575qvc.32.1686845367888; Thu, 15
 Jun 2023 09:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230615152631.224529-1-herve.codina@bootlin.com> <20230615152631.224529-8-herve.codina@bootlin.com>
In-Reply-To: <20230615152631.224529-8-herve.codina@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 15 Jun 2023 19:08:51 +0300
Message-ID: <CAHp75VfQNtanhNvUeivHO_rpH0F+csPm6QPyheOV-W8hYkbbMQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/13] minmax: Introduce {min,max}_array()
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
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

On Thu, Jun 15, 2023 at 6:26=E2=80=AFPM Herve Codina <herve.codina@bootlin.=
com> wrote:
>
> Introduce min_array() (resp max_array()) in order to get the
> minimal (resp maximum) of values present in an array.

Only in the case if you need to send a new version (otherwise a follow
up will be okay)...

...

> + * The first typeof(&(array)[0]) is needed in order to support arrays of=
 both
> + * 'int *buff' and 'int buf[N]' types.

int buff[N] ?

> + * The array can be an array of const items.
> + * typeof() keeps the const qualifier. Use __unconst_typeof() in order t=
o

+ _integer

> + * discard the const qualifier for the __element variable.

--=20
With Best Regards,
Andy Shevchenko
