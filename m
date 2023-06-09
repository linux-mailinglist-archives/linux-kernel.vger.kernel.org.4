Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012C9729167
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238973AbjFIHlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238967AbjFIHl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:41:27 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDEE193
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 00:41:26 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-565a022ef06so13291227b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 00:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686296485; x=1688888485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agSzQAlA3vB7TiE+c7567YHsHwKsKQDGu0KW+ilGleg=;
        b=Xg+vzYG/nkVPeYJJh1Ji+jemWww54yCeuSV8daiHhILzKn0a26GLpcqXlZ0OUYlx07
         Ib6E6a/S+AU2+G0kFEvLaylkH8ddEDIZHdbty1OIw9dkLu18DobpppSvWmvVjGN4yF2o
         BDSBWRNkbhN/PcVAWo0BHKv0DoDyUPJ6LN5YtRDpdlQK+iXGh9ovlpEqe2Um47Y78TGI
         NHLnCP1oPfP2oAg3Q28jjQVNMQViOcm4jJ9aHShMsfYz9/Cjb8jgTuQdcdshRN4quaaM
         v36ZdfN+YIwISL9osY2y0L8t48LhO5R3P19p9wO2+hSk86ZPBf5YKzukK3oKprQCuoqB
         DvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686296485; x=1688888485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agSzQAlA3vB7TiE+c7567YHsHwKsKQDGu0KW+ilGleg=;
        b=CB8j+wzbcBYmOPcwxS8P30QCCyq38EmPWRlqUdHoTAQJeQOi5jBnVqRaGNEsCnmbzP
         hV3r4wnNTT2w+pSLtReFOOEjPiEL+TUc6RkFQykZXLcKj2sF46BB9olYJGiycNmUAngt
         jh6GA0kMr1JnBIBRkfra4n/r8iC4cciC1R6EQFZRWhD4FhevmlOCxDA2zK/Liq/2Dbsc
         Ro1fVAiQlDf8Kgicnxp55gpiBlnQeolHlFpqTz441lx/azaAmh+dK4y63aM3wf7cFlah
         YEDaTDHF4z0HpPt+H6sE6pzqFUOTcqGAs/uiDRFf5/GpP27hZaVCSzWiqXy/39abvUxC
         zKdA==
X-Gm-Message-State: AC+VfDx46GHSK2xEuAFvGhx9dys+YvTgUtzMOhyxm26xFe6Z+dZSnrdh
        lZAqqv2JM4TWpJIQZu9lW5pT46VNj2TQOe0i3/fvGg==
X-Google-Smtp-Source: ACHHUZ5jlXZ5aYo7orLGKS89d2hbatJ50uG2EaQL3Q/iP+Sg9hANlFQ5bMNtha+O/K485bvlneepJoRkjzr5dl6RBec=
X-Received: by 2002:a25:a221:0:b0:ba7:dd71:36c7 with SMTP id
 b30-20020a25a221000000b00ba7dd7136c7mr295651ybi.63.1686296485284; Fri, 09 Jun
 2023 00:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230602115201.415718-1-matthias.schiffer@ew.tq-group.com>
 <628b7411-7d12-4915-80c8-cabb74ac6590@sirena.org.uk> <CACRpkdYhFmG-Cb-5+dt1Huktnm+tkOjSGO5ZFPjGeOXRott6Dw@mail.gmail.com>
 <a1a1bf95-6333-40a8-9f08-4c952cd070df@sirena.org.uk> <6a0abd6bba2f8f940e695dfa9fd0c5f8ee19064f.camel@ew.tq-group.com>
In-Reply-To: <6a0abd6bba2f8f940e695dfa9fd0c5f8ee19064f.camel@ew.tq-group.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Jun 2023 09:41:14 +0200
Message-ID: <CACRpkdb=2fogk3bEa4fkPVYQivnvLh1F1TnBj7og43ak+F8gPw@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: dt-bindings: introduce linux,use-rt-queue flag
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 2:55=E2=80=AFPM Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:

> It is not clear to me what alternative options we currently have if we
> want a setting to be effective from the very beginning, before
> userspace is running. Of course adding a cmdline option would work, but
> that seems worse than having it in the DT in every possible way.

A agree with Mark that a command line option isn't that bad. It's something
that pertains to just the Linux kernel after all? And you can put that comm=
and
line option in the default device tree, in chosen, if you want. No-one
is going to
complain about that.

Yours,
Linus Walleij
