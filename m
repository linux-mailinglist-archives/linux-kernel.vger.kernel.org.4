Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81769704F6D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbjEPNgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbjEPNgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:36:42 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F77B40DE
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:36:40 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-ba68ad1b342so9923763276.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684244199; x=1686836199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nb1ZkbYMsj09Qa5XlkFuffZVuQBn/mvKDNAzfUB9NTE=;
        b=A/Y7B3MUH/oEkt8hcwONXDhcNj81kf+/KzzHMlUEjffM/G9gClqUlZC9KCFfd723j1
         AimIS5dJey7rLkrC49ofOlqkh0/3YSQkEbs4OdXQPBQ9pCI5/mSsoPA9X8ulQ5arojG8
         +T3CtnmEPsiRELZzaf8gNK9BFTmWVdYOQeLs3oCLxf3m49j/O06t3dOgEJw90GkzzH6M
         1we47eu0IyzS5IQypYffN6izTZ//5LDjhjArxtQjNbyrcfsyLbFQjYPSuSakiwZi+lIl
         DxvPo4TWBI7kIPw3FiAwaJRxEPhzLyeL5+jszU+ep4vepPmvEpSPzbTcegBbpB5LNWyQ
         g/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684244199; x=1686836199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nb1ZkbYMsj09Qa5XlkFuffZVuQBn/mvKDNAzfUB9NTE=;
        b=YwiHZBCYBtSMAdWSQb20NricLZV/g5t27HI1zlBLI8etBCe9ZfmRbCIuvEh+9yI8Zf
         BwIVuruz2XnujFT3+WAV/EMMNFZPo5nonnLpv9GfigRxQEDfZBCuDhlL6einCs519TGC
         u8qgbRhOBo5Pt9MabSOAKDQIrSqXiWgFwuNBgME50Twpiq0163AMYNnEsejt5dFIK1Me
         Ql8QMuwwK9BZo72ElMo8BRTRziG+R6gJfvSr4iSdL3UBVwBbzaq++2WdlVsKCy5rmy33
         BmZKNZb7CoOelEveCZFKgnVrjuF6g90JzU1aqCEY5ODDV6IIHISzIDS5z6N0TJrtQffX
         tf+A==
X-Gm-Message-State: AC+VfDzYSoDKb5eFZYsIQX066/33Xn1JCIUDkVA+r91CAdKN+dasGv1b
        2ShAn+jk4lzG+NZRBx99UQ4E6tGWio9jpabxMpDmdQ==
X-Google-Smtp-Source: ACHHUZ5uF6f6kjAqshZWmJImuHIvs5Z+nQuCywLgPD/2kS/tVxU4y+I9nVhWii/6jKYxB4prpF7dx+QqW0fPtG+qwNs=
X-Received: by 2002:a0d:fd84:0:b0:55a:178e:eea6 with SMTP id
 n126-20020a0dfd84000000b0055a178eeea6mr33827510ywf.12.1684244199349; Tue, 16
 May 2023 06:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230515174518.494907-1-afd@ti.com>
In-Reply-To: <20230515174518.494907-1-afd@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 May 2023 15:36:28 +0200
Message-ID: <CACRpkdagzO7HMdNCwwL2f-jYYUH-W2vr30B6hhzMCMeFXWPnug@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: tps65086: Use devm_gpiochip_add_data() to
 simplify remove path
To:     Andrew Davis <afd@ti.com>
Cc:     Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, May 15, 2023 at 7:45=E2=80=AFPM Andrew Davis <afd@ti.com> wrote:

> Use devm version of gpiochip add function to handle removal for us.
>
> While here update copyright and module author.
>
> Signed-off-by: Andrew Davis <afd@ti.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
