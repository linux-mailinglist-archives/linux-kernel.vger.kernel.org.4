Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBD26B38B2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjCJIba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 03:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjCJIbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:31:18 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D60E4C78
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:31:01 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-536c2a1cc07so84345517b3.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678437060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csGLQ+HJvr4LxzgGWY6CNMVw5Or5HiSrrGSUyV9nTeY=;
        b=qqVZrbljiVaxCDq7PK4DMNod9UIjiHSEeWRPRsWMxPQdZvr+AyT0Ppd6CVYruMFA1r
         YzNlMxj2hjWNrrQC4KKqG1H0E3eXgPUU1LBCZ3ASMOkKBzxAc4cI/4O5VVrX1OIRW60T
         mymVrUmxpMTGde0v61S810KiHJcAfGrlqyZ7VE7yMfnvANX3cyIwI5SR0OElMY7mvfs4
         2ATkAKGpEITCiGh5b4o5+ZFIA+OYQBkz4OZtiA3bIN2+lVAEmrMrz5mMnnFLxN/VdOIc
         ziXnla55HBB4GW+525DbP+vSdZziZDTQWHE8PHIfqJuK67egL2z8umDmc/sPN85RBzr/
         y2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678437060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csGLQ+HJvr4LxzgGWY6CNMVw5Or5HiSrrGSUyV9nTeY=;
        b=Ts7DXVq6FShoOP2OKXyx/jC6kwr6/ntHMGXwQL2VcDHglPU+Na336juAhfMd2e8MLC
         ID6yr/vafLDV97pzLZJvM1ntw2ce8Y+HdyrnCiLCan7ZP/QTLlUhzX656CF2yT0iVsRg
         AUJrVaO3PtnMOkgQ1oh10xWEFYlTrysx7L4a66c7CeIVlE38Ygp2WKuv0/JXzFFY+W1A
         HOAtnULkZK+WhcmvmKyR9Vd0gOSXf3QmnIFyzrdesZupPqo8nUoVFraF9k6u4EcWeHjN
         8LNqSSfJ7xZgs8ymyRgelmcWRhsR07rrZVZm1P8ayeXg9tWlcgM11kz1NaO2oq9Os/Oo
         rB5Q==
X-Gm-Message-State: AO0yUKWFPqHmT52k4jrYKxKOFsZsq/cLgYzMtI8NjuOU1HT6LSIhixz5
        5DxplquiJ4AMYy76hGr7ZOOrq7/9R6ELmIroFLmzvQ==
X-Google-Smtp-Source: AK7set/prggt4Pz8CJxuZSir5+zLD32kXIut3Cm9wOY9Y9/ajINMubM9mi6k/4gvyZeaMxR3Z3lPoktZBE3cRrALz7E=
X-Received: by 2002:a81:a9c6:0:b0:52e:f77c:315d with SMTP id
 g189-20020a81a9c6000000b0052ef77c315dmr1128456ywh.3.1678437060520; Fri, 10
 Mar 2023 00:31:00 -0800 (PST)
MIME-Version: 1.0
References: <20230309225041.477440-1-sre@kernel.org> <20230309225041.477440-9-sre@kernel.org>
In-Reply-To: <20230309225041.477440-9-sre@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Mar 2023 09:30:49 +0100
Message-ID: <CACRpkdbsBzmTmEus=CnDw41WKS799kXmpekD8NY8OWkeR6HwBA@mail.gmail.com>
Subject: Re: [PATCHv1 08/11] power: supply: generic-adc-battery: use
 simple-battery API
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

> Use standard simple-battery API for constant battery
> information like min and max voltage. This simplifies
> the driver a lot and brings automatic support for DT.
>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

That's neat.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
