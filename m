Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7306B3875
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjCJIXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 03:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCJIXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:23:22 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99122138
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:23:17 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id t4so4472337ybg.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678436597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfRawS9GjEnhDkUJ4VLf3GZZI+jIZ6m1mwrZ67YFiW0=;
        b=aTjpacpeCw5UaD+UK8X3727Ptcv9iHt1dY1hnhU+0b62A5Z2YcmL5S3uvsicp2MNb4
         AmC/qzYrfsTiheg3ceMgcUk8JqWupE38+Xf+I1shvbwZbY1NaiNZ92aHctjT5eZAbrxk
         W8VszkBKIak5PaQ6EcRr1yPgkbGcGrwy9s4MVc5mMPUObhSALirGAEBJqzsHNUwLiSTg
         RbFJsq9/FKVvlQ4Gr85JEmG56H2ZG4D9xzpZ1f08TX4bEYZaVNltt/gGhDIE948Hhkyo
         J/OHYgSJoUcutQvrBUZxKDRSU2lJ9z+wrZMJ4MjlfS6eVZJOL+3LmiWIPfkiiTxMAXoe
         kffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678436597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfRawS9GjEnhDkUJ4VLf3GZZI+jIZ6m1mwrZ67YFiW0=;
        b=ZmRoc2tAYJvxAK4VymRet17CtQjO+bhzyzAixm/GZxagcK3IJLJ+iCqIliCbnROYUo
         l1No9C91YLAmPUuEpPNenZhNwIvgWK2RDo3Yolyu87EcPN91Tlm2yffZpurBdh40IJ9Y
         C220aAih1rPhD5qmt/5VrCoKJxVDQCLt9tItucj7BGO3IpAAOX/dQmj0sF04cIMddgWC
         rUkW2AFfZa0JeqsAO2wvDVBFafEo4M1CrYBimpqhXXljhmBwYsQekRgJpiza2odkJFHa
         M+I72BtyyPwSHr/7ksd2ZVN6JAbVRqGeRUXZf5V074nCOsjXMLAw9+wfQkF2pPYybxfq
         51MA==
X-Gm-Message-State: AO0yUKWRxpxjyZoEEyUVuaASc6uSsAfochz/nuc/becSHrik8mRvPz+G
        9FcHW98sAZTuvnrA71vOV6zVoQnhVJAJqojHo9hQxQ==
X-Google-Smtp-Source: AK7set9vP7GNqNzR4lgEZV0s021tkZw04mUI3df4h+oki/hkfCYg5S6k/8JKAii72AwWSm/n2N6HJE+jnK6hwaS8JhI=
X-Received: by 2002:a25:e90b:0:b0:9fc:e3d7:d60f with SMTP id
 n11-20020a25e90b000000b009fce3d7d60fmr11825794ybd.5.1678436597142; Fri, 10
 Mar 2023 00:23:17 -0800 (PST)
MIME-Version: 1.0
References: <20230309225041.477440-1-sre@kernel.org> <20230309225041.477440-5-sre@kernel.org>
In-Reply-To: <20230309225041.477440-5-sre@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Mar 2023 09:23:06 +0100
Message-ID: <CACRpkdaa6ZOt7U+iLwjrTGx87BdgXX6wbW2Ab_bHye_TNzi9Tg@mail.gmail.com>
Subject: Re: [PATCHv1 04/11] power: supply: generic-adc-battery: fix unit scaling
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

> power-supply properties are reported in =C2=B5V, =C2=B5A and =C2=B5W.
> The IIO API provides mV, mA, mW, so the values need to
> be multiplied by 1000.
>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Fixes: tag?
Cc: stable@vger.kernel.org

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

This code can not have seen much testing.

Yours,
Linus Walleij
