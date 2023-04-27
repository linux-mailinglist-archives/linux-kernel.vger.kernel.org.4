Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AF26F0CC9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344077AbjD0UA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjD0UAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:00:54 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5462700;
        Thu, 27 Apr 2023 13:00:53 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-52888681eebso408404a12.0;
        Thu, 27 Apr 2023 13:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682625653; x=1685217653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMGOSMbBiTL4p2ytvniek47LnE+wyJc8GRIvYZB1ljI=;
        b=ja13binHIOT3kAhPAQSy2s/6+KiuD3BG5T6lEpLgTujhKr9G29Zf7PtNSSNR0/gECs
         f9+4fV162BTRgESsAgF/9Zx8/okfAUFjF1IgETW27L2bV6WnmlbTnrPtTVSZzkMn+N2k
         6WeeRqPvnMIhRsSI/9cSa1+1bmRLUjLhCFU1vUP3WVIEZjoQ6EVP4SzmLgQT6Hdy31LP
         Gf1XFWS5pA8WBkumpE2cWANPWkjTptpNbYZR9iUobLvN2BSopDYjiF45+D/y04R4Xu0Z
         ztcrzTR7Kwkh6AygnqfiJ3j9sGLvdHBMwkE1o+DRCtqsdHpv/phYM6byYb9ulHwnvHs0
         tS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682625653; x=1685217653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMGOSMbBiTL4p2ytvniek47LnE+wyJc8GRIvYZB1ljI=;
        b=BsHXQKT4zkoJFogecOYn87mzH4QVCS1N1QafRtCldcIzj4XeTlyxb0lo0OxXKd+kmx
         IDUssFCylNO1Ux9ofuXOhhF5ap1s6mWvDkkLlQcH1M/CNO+6yRL51KwLT4hd/CXO36Gu
         /aGwfFQUTrOJkgRZXT8Xw2dCSDkj+MNbxsCvs1IQjcFUdY6IvVScicRweq41Z3fw2GSu
         txCxexfAXbjJRGeZgRwvhKVFiYfi4JoUqzD/krr7Si7tHO3N5S7mgrXo41DQDvM6KqJl
         MTLEcnaS+vidGuXxeM52C3kRdvX8dH25W9C600zh7HJxYywQlDjfSCYthxQ3zcNvhoz/
         z3vA==
X-Gm-Message-State: AC+VfDzBW7E6USvlaVsOzZdsntw4Y3yhl6RcPrzwYxjNXQnvgDuOuPBY
        TXyRt4RFDl+cOrUDtOMrfs7e4GXHWn73t8AQxvs=
X-Google-Smtp-Source: ACHHUZ7UHONs8b+7y92YTw/hogvHnEfzybpaDkWQhlY3+JEmyGU1KAaeT6SBMmF6MdhCuTZ8qMVzf9/PnZf1+5EeHUE=
X-Received: by 2002:a17:90a:51:b0:247:446f:7d05 with SMTP id
 17-20020a17090a005100b00247446f7d05mr2710116pjb.0.1682625652931; Thu, 27 Apr
 2023 13:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230427195538.2718661-1-hugo@hugovil.com>
In-Reply-To: <20230427195538.2718661-1-hugo@hugovil.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 27 Apr 2023 17:00:41 -0300
Message-ID: <CAOMZO5CQeeme6uhb8NCzR2QADjkBM-mRC9-GUnmhLWSGo5MMoQ@mail.gmail.com>
Subject: Re: [PATCH] imx8mn-var-som: dts: fix PHY detection bug by adding
 deassert delay
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

Hi Hugo,

On Thu, Apr 27, 2023 at 4:56=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> =
wrote:
>
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> While testing the ethernet interface on a symphony carrier
> board using an imx8mn SOM with an onboard PHY (EC hardware
> configuration), the ethernet PHY is not detected.
>
> The device tree in Variscite custom linux git repository uses the
> following property:
>
>     phy-reset-post-delay =3D <20>;
>
> Add a new property 'reset-deassert-us' of 20ms to have the same delay
> inside the ethphy handle.

Which Ethernet PHY does this board use?

What does its datasheet recommend?
