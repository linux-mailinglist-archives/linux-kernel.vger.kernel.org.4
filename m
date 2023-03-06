Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51B36AD130
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjCFWJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjCFWJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:09:28 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C409839CF8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 14:09:27 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id x12so9708480ybt.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 14:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678140567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5c358ipi4Vt99BrjRiy5z3SaM/LHgeps04nWxxfLfzs=;
        b=y6IlTFq9wh6AAJI0b2On9RPaIxlkMAom2XGC3qtLKngFcU+K2v1/dUd6PojmMTJka9
         LpWy+qNud0PFYrKrnd1OA3FhmUdBnOJCNxmWr2EmTVJEPw7sIQS2L0siDGqIV3esrP6G
         dAS7U14k2PTv/oEJlzzdbfFZvU+JGd/gxmmoLVc55SE6QmKhLZoi5RYpdgWOmO2z8pND
         y79Eqhdfzs5V+eJOm5j8N47lPfRnamv3m8rqToNX6Gc+AGXVM9d5dLwPe0FnFOU5Z+Gr
         Ko9Px+2oN8udbhUyRvJ6xv3RbuOsKljw9PCX7RKhDi0KxPrJRoEWWSA2xhzQOJ99+tDp
         vMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678140567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5c358ipi4Vt99BrjRiy5z3SaM/LHgeps04nWxxfLfzs=;
        b=ngdLrgJNDNIM7FCRNiyJwdUpCTGiEA02LWqdhmnapWy+lmhSjrhlnRd1QTAuWn10Mn
         ePvaPNA9rXYvczvG1HodiduGm/nxCbbhWVP1FLo6hgkRGYHjHdNlakA9OeosmNnP1EgC
         9GqSjitjBCS1UyxHiFTBPOADFFhq8mjHa4BFxLp95jGueOilwtsl/6NS7JdHkmJElFEa
         hcFKweEU5dzqHsrWLiLojsMI/5+vpH5Mc2dnGzSf/6fHmdXtrHnArKx50N5TgoKq27Rm
         l6l9Yp/pb5L/50CIeJedQWePf4XRo7oOh6f9w8aL/VXX6cHJDgF+l0ItL8RR0GUNp2CD
         1kMg==
X-Gm-Message-State: AO0yUKURUR9bvhZXlXdu4Wr6C8loTqm6HptIoQ6N9M4g8J0UazL3KdTU
        b5tMY3EId7+1o/k8A8Dqd2jgBBhN1DXfVaUUhvs/gw==
X-Google-Smtp-Source: AK7set/PdFBK9urMpw+5M7Ji1nzK6dx2LJ23tdjkUepZRyWvDmY3aEBF0cZ+iYqMw1+m4OTu85tD91S/epnMzfXpVHM=
X-Received: by 2002:a5b:b84:0:b0:ab8:1ed9:cfd2 with SMTP id
 l4-20020a5b0b84000000b00ab81ed9cfd2mr7363696ybq.5.1678140566986; Mon, 06 Mar
 2023 14:09:26 -0800 (PST)
MIME-Version: 1.0
References: <20230303002850.51858-1-arinc.unal@arinc9.com> <CACRpkdayVLTT0x6hfnwvL-Atafkj8PRw5uwe7Wic3jtn+X-axA@mail.gmail.com>
 <486ebf30-dde3-b77d-c292-ba7605313273@arinc9.com>
In-Reply-To: <486ebf30-dde3-b77d-c292-ba7605313273@arinc9.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Mar 2023 23:09:15 +0100
Message-ID: <CACRpkdagmqfrsZtJrWn9h8ZMiJUrsKF1_B4KV7+LhZdc6C7tLA@mail.gmail.com>
Subject: Re: [PATCH 00/20] pinctrl: ralink: fix ABI, improve driver, move to
 mediatek, improve dt-bindings
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 6, 2023 at 3:56=E2=80=AFPM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.una=
l@arinc9.com> wrote:

> Sure, if it's necessary. Once I get feedback, I'll rebase it to your
> linusw/linux-pinctrl.git for-next tree, see if it needs manual changes.
> I'll let you know.

Hm my for-next branch is a mixdown for linux-next so use the branch
named "devel" instead.

Thanks!

Linus Walleij
