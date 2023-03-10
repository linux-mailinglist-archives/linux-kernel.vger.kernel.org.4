Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3727D6B387D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjCJIYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 03:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjCJIYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:24:33 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FBBFA8CC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:24:32 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-536af432ee5so84871697b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678436671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cqbe41L79xMn0U1eZswNbJM0D6J8PpjbmWluzE5/54E=;
        b=jda69MG4fHPANNwaP3ByFkGscFkBdPUdkzgqSHMwjiy8eEGByy3bdAjsj9frZJSuO1
         Y4Ajuwm58IPFDLj/d48ZBpbd1ZkmkbEK39HEnYJTbVrq02Yms5eAeqvrXR7vB5joFLni
         BZv6x7sNmOr5Vf09tx1GHZdjl+GVsnC4zoqkDDlFU9k2jbRHucDzOInxPgLCk7Og2WPw
         BIlLnQgbtijbOnvaJeEFBbAbghdv6FdEYzvckqv7JK3/KpzLLev5jiqg2w9FdcMfjF6o
         pa1aAlT0w/ug6KIIFgsUildTNCrLF996YIXf8SexWUwqjqHpeiCueZqlbFLkxy+fcfDa
         zBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678436671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cqbe41L79xMn0U1eZswNbJM0D6J8PpjbmWluzE5/54E=;
        b=v6ROvNbYefXWNM8Ws2J15d54tXGloFr6q94h5rXdly2jNk0/WldPB8oi9KSttP9IT9
         4waLhdrx4w198r+tMlBteL+/FcoRLpKu8JJiEov+3cMbdtPuA9mODUmtcWxMo7r4k8s8
         qme5RWu8lr1OkBO1lbKeAvHZ/63oE05903ReN7O9/pfMWLdeCq1OnqkkUe0IqdG4pBY1
         iKP0XL1dOgzoEAQ1t7hyR08zPCCboFZR/MXvacSLK/+GAhn0KsqPSlqipG6JkyE6YAag
         r+M8izFajBNDojBHdp2ATbaK2LT46LgUa+VCc2NbwN2siCrMGOs6Up9TAuUHHfZxCwQd
         QBPg==
X-Gm-Message-State: AO0yUKWKHOuuo12slS0Cn6acEhCHt1JrBRvvQqft+NzzDrEQyJw7QjxR
        dIrLS4OvUvBhhH/Hn1YEthb0NpG85XCa3S03t8yOM5M1pCZ2rptq
X-Google-Smtp-Source: AK7set/ULdW4mWcU5V3nV+kxHkOjhoq7vHwNBjvgEDxD6Gw9Sd6rP/OGTdvAmMe6dAaJj5vzLRuD83T86IbYfbmPziU=
X-Received: by 2002:a81:b61a:0:b0:52e:c79a:cda with SMTP id
 u26-20020a81b61a000000b0052ec79a0cdamr16227783ywh.10.1678436671460; Fri, 10
 Mar 2023 00:24:31 -0800 (PST)
MIME-Version: 1.0
References: <20230309225041.477440-1-sre@kernel.org> <20230309225041.477440-6-sre@kernel.org>
In-Reply-To: <20230309225041.477440-6-sre@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Mar 2023 09:24:20 +0100
Message-ID: <CACRpkdbO9VD9-N_CEDpuUpfpwPG8hkghyTG+OQseMOEiDtO0iQ@mail.gmail.com>
Subject: Re: [PATCHv1 05/11] power: supply: generic-adc-battery: drop jitter
 delay support
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2023 at 11:50=E2=80=AFPM Sebastian Reichel <sre@kernel.org> =
wrote:

> Drop support for configuring IRQ jitter delay by using big
> enough fixed value.
>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
