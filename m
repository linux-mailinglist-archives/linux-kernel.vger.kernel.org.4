Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994796F312F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 14:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjEAMuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 08:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjEAMt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 08:49:57 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF4E1B5;
        Mon,  1 May 2023 05:49:55 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9536df4b907so521211866b.0;
        Mon, 01 May 2023 05:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682945393; x=1685537393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWw1hTARmw+jKU6qPnbINzsea7Kkb3XA4GzRY4Vsapo=;
        b=lnSFi3HO3I7Cjd9eGoIl929JDiL/FMATuuWV4zVIETYzfB2SnwJob1osiu713IFDpc
         HVrPoP+1/gifg6H+Za43d6XMRU4zkL1hSgb9TDald3pA7XHiyr3PW3PlfeKWybenZUts
         OpupoIem6trMp2RlJmCK8CPcB/yO+ckzyvy6/2FW8WAzEuViJo698b49g0JQbf+6x4Eq
         bLKw0ZrcMRAxGh2cxNKK9U9cngh99GGksfbB0iDQi+CavYzzcow7KEPe8CYE7ddZ7b09
         77dlysqi828fEF3v3KRqKCCkd3CNx6FClRE/0xI/KuapVgblQ/hmsvWviEbmAOea4emJ
         hNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682945393; x=1685537393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWw1hTARmw+jKU6qPnbINzsea7Kkb3XA4GzRY4Vsapo=;
        b=Bx2gX+BDTUMnq84wO9DcpXM0+oMeEi9NPZ5oP9/VLC/15wGxfOy8XMEXMVnL0m2Pst
         O6AM6huYAvXkEQR4kJ4avssblH2OpSfNS0XoiHrjTLQSDR4dnj9PsLugNVmSwu9QnRGJ
         Jew301amx9Ua6ycu84jhj4FtzJhs/9Fogrryi6HMsrBABmRSJH0hYhw9gm3gnLq0VkOe
         C9iUD/c4/iFexEAnFULnBk9Y2T1RJiyVzaxm38S5qhjbB4BoEGzKiFok2lR2DU7UmkK3
         EZwdfmB6BwUZe1TqxPvQRP1J1IDK0rusmA/qt3V1+bASfei8FlvrF2zYC8PsAenBBUf9
         +qbQ==
X-Gm-Message-State: AC+VfDyK7vOjLcQGlhpwujMOAmX1a54ZqeY5kzHgGVcKR8DaceDrZp2I
        Bq8o29anaGGpJWfvLsrJHWHAkD6/pQD8qV1zuOk=
X-Google-Smtp-Source: ACHHUZ7XHHWAxWxgus3mXZZUFeWxirj8s9hcNpD+hHK7EQmccGNvepW2l2c5bOsbsB19SYSwVrJvXeMQs3jsnE8886o=
X-Received: by 2002:a17:907:c2a:b0:961:b0:3dfd with SMTP id
 ga42-20020a1709070c2a00b0096100b03dfdmr9809713ejc.7.1682945393457; Mon, 01
 May 2023 05:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230426102922.19705-1-ddrokosov@sberdevices.ru> <20230426102922.19705-2-ddrokosov@sberdevices.ru>
In-Reply-To: <20230426102922.19705-2-ddrokosov@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 1 May 2023 14:49:42 +0200
Message-ID: <CAFBinCA+-RXGOzF=Z7kdY3Ct5uME5qcKJ1BJoXJwdjs8_qiByA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] phy: amlogic: enable/disable clkin during Amlogic
 USB PHY init/exit
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        mturquette@baylibre.com, vkoul@kernel.org, kishon@kernel.org,
        hminas@synopsys.com, Thinh.Nguyen@synopsys.com,
        yue.wang@amlogic.com, hanjie.lin@amlogic.com,
        kernel@sberdevices.ru, rockosov@gmail.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-phy@lists.infradead.org
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

On Wed, Apr 26, 2023 at 12:29=E2=80=AFPM Dmitry Rokosov
<ddrokosov@sberdevices.ru> wrote:
>
> Previously, all Amlogic boards used the XTAL clock as the default board
> clock for the USB PHY input, so there was no need to enable it.
> However, with the introduction of new Amlogic SoCs like the A1 family,
> the USB PHY now uses a gated clock. Hence, it is necessary to enable
> this gated clock during the PHY initialization sequence, or disable it
> during the PHY exit, as appropriate.
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
