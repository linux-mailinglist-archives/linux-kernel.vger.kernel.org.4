Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F54572E3B6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242487AbjFMND7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242614AbjFMNDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:03:45 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6B919B7;
        Tue, 13 Jun 2023 06:03:41 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-62dea65edb2so5658746d6.0;
        Tue, 13 Jun 2023 06:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686661420; x=1689253420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ph8muSYdWfoSysNozHej0lspNPRmqVyqDCHut3XIIUY=;
        b=ln4YUxRpK9f8I0HhdEpd3858fLpiCbXpocosM3zRqygyHl9hyBPjUxT+VR91cFlFvm
         SrGpVOwRuy2qhZvkPlOGuQILYTukeFo9Bg3uC/QOod5fjB11XhE9Xk3T8NpJfEKtDTsI
         8W9+g4X79V6llo/DMNJTA8V+NV8wYsoIpca8C5kqStEZXfEKurpdmcjz/ZRDzVDDtd1J
         PgjHR54Hlnrb6NkJy48VfGywsN78zbALz9eiBOvMWf+TJUx91ipSjMGos8meeRi2U58C
         iEavMOG6xrHPTZCUTGXyJojaR5nPjJ+sNOnTv/WsikKRVOprOtT9ZXgEA3X8OGfyWoWB
         fJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686661420; x=1689253420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ph8muSYdWfoSysNozHej0lspNPRmqVyqDCHut3XIIUY=;
        b=PkQWidmvtEJeqqE2sejzFq6t6dAtFB4hqpMxBr/iuRsL2hcts9dZ9VLesHaC2p9kkC
         SN43wXqXUGAZfum79VfJoURSKvTDZ4aPP3zGjG1SjLWNPQYVpB+0ae+8dRM5Iq44IZI/
         YjAFHOPIvQL/rXcRAgbmY7PLFLiIQusf5RRHhi7fFkSHdqUjip7qjcKEsYqF0gPIQzWb
         YPqCKJqGPe3krrYzke7O7/QuXzXrwEoUOpcZswHnB0X9DEm4kmwvN35qDuyOo4VwezL3
         9akcBVozYRa2w68vwLdnY6viDjn2TUfH4zPFYbw8PuE4Q1xBzTeW80dtY7GDf0RWNIjw
         GFfw==
X-Gm-Message-State: AC+VfDxZ/P1DqeaW8hzycwsJcKZ4nGupr52Rz735mYAGcttEhRy5bd62
        +jhncQ/7AEI33M+2ONib5tyOBUSMTdptru6RDhI=
X-Google-Smtp-Source: ACHHUZ5nOTLhze+E2wXOckkmMBUzoKHAynMMVWwnxk/gQWe9ti2e0UBDodLfEIjcbxBl0q5mNW1fPU58CsqjOiGw3xo=
X-Received: by 2002:a05:6214:401c:b0:62d:e73b:c4ab with SMTP id
 kd28-20020a056214401c00b0062de73bc4abmr6160647qvb.1.1686661420050; Tue, 13
 Jun 2023 06:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230613075834.5219-1-zhuyinbo@loongson.cn> <20230613075834.5219-3-zhuyinbo@loongson.cn>
In-Reply-To: <20230613075834.5219-3-zhuyinbo@loongson.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 13 Jun 2023 16:03:03 +0300
Message-ID: <CAHp75VdtFjkyBF4K1+MOHAmp0S6RU5Cg3NYD8yGH+8FBBG0Zuw@mail.gmail.com>
Subject: Re: [PATCH v13 2/2] spi: loongson: add bus driver for the loongson
 spi controller
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
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

On Tue, Jun 13, 2023 at 10:58=E2=80=AFAM Yinbo Zhu <zhuyinbo@loongson.cn> w=
rote:

...

> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>

> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Just a remark for the next contribution. When you have a tag, no need
to have a Cc for the same person, Git tools automatically add all
tagged people to the Cc list of email.

--=20
With Best Regards,
Andy Shevchenko
