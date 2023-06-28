Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AA67419EB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjF1Uwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjF1Uwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:52:45 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FC51BCE;
        Wed, 28 Jun 2023 13:52:43 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51cb40f13f6so34903a12.2;
        Wed, 28 Jun 2023 13:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1687985562; x=1690577562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uwwnkhmaH+XqdTCHqXY7NXYfBiKXd9zzUR8VdsVxl4=;
        b=CBIk9WYo357aJEjuBNcKbzs9NSNFY9HCkN0OeyYBwfG+CkqEPc+0Aglm5vBtUXi1ob
         Y/ig0iJVlGBG8+qg3JuoafZbmSxktJvP+o4Eg9++Tsz1jvRIYrEui1wMG3roJRdz9fDB
         +EKYLq7nExU7APi7TNRyz/s07WdAYFfQcUKaNebuxq3Dm4zjTiy2Lno5Uh9YGwv7Bv9W
         YgwdKwzkkNGayWVHCQnrXwiP5GZpID+LWqvRE74oCnZMJnNw2lNtNn/bHEs/LXqf8sg3
         uN4Ly1ePIJDPoPARVUEj9oC9vH+cDHpobb7NpdA+8scsM3HmrlaNaH4f/EBUgYAhTXZI
         L0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687985562; x=1690577562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uwwnkhmaH+XqdTCHqXY7NXYfBiKXd9zzUR8VdsVxl4=;
        b=Iwcb9IlFKARfP4miR4afEkKVP85kGKkZVbykt8tqOGw+ZEHwkLNnntgefnamPZKRnl
         J0guCfLQWjJvfscrjPLGB5OqSBApnPCDUJ/PMuFmk9JvS9jEp8ydBHWUvFwsIEss4sNF
         moeticow5HVWMB3GUl+cfzYeypHUjHnTOPgWE43c6mZwJPytiTjms8odUvCP1WoTkki1
         Hf8pc5a4ndYm0z9lN4Jm1bjxYkukv5zTfM7zHlNSh1tDVdpRy/Oz9byBoy/8sRJzOLV/
         AjWBxUBEgV8ELFD362dU5RqLHT5bHEdpg5ckqdJgs9W7slLaf6KPnTKz37JkDbO9j5pJ
         5YNQ==
X-Gm-Message-State: AC+VfDxx47PV51fK3HpiN5dE+wYodiyj7pjcbiTEY9aglTFvONQe+h2n
        tCa5X+D1YNkv9+RETfbzPgyc2n+ha4qoXKYIXMg=
X-Google-Smtp-Source: ACHHUZ7qTw0U1B9WN7xmGr8oF15G8G5ZLinlix8F2DaIMKvMiOefSphIefvgleYhrWVBUqiipgmUub5L7tKP85Qx4H4=
X-Received: by 2002:a17:907:a06:b0:974:1e0e:9bd4 with SMTP id
 bb6-20020a1709070a0600b009741e0e9bd4mr31832898ejc.16.1687985561917; Wed, 28
 Jun 2023 13:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230628091533.3884385-1-huqiang.qin@amlogic.com> <20230628091533.3884385-3-huqiang.qin@amlogic.com>
In-Reply-To: <20230628091533.3884385-3-huqiang.qin@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 28 Jun 2023 22:52:30 +0200
Message-ID: <CAFBinCBYrJGHX-yqCVMm46hdVyaiHrK72Qn8Fj-F623g_Q1SMQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] irqchip: Add support for Amlogic-C3 SoCs
To:     Huqiang Qin <huqiang.qin@amlogic.com>
Cc:     tglx@linutronix.de, maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, hkallweit1@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 11:16=E2=80=AFAM Huqiang Qin <huqiang.qin@amlogic.c=
om> wrote:
>
> The Amlogic-C3 SoCs support 12 GPIO IRQ lines compared with previous
> serial chips and have something different, details are as below.
>
> IRQ Number:
> - 54     1 pins on bank TESTN
> - 53:40 14 pins on bank X
> - 39:33  7 pins on bank D
> - 32:27  6 pins on bank A
> - 26:22  5 pins on bank E
> - 21:15  7 pins on bank C
> - 14:0  15 pins on bank B
>
> Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
