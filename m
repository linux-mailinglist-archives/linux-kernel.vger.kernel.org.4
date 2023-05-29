Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2408C7151D7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 00:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjE2W2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 18:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjE2W2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 18:28:09 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACC9AB;
        Mon, 29 May 2023 15:28:08 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-75ca95cd9b1so218168985a.0;
        Mon, 29 May 2023 15:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685399287; x=1687991287;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgPfcW2qzSYYzj32tI9lcSdz/QlSOeix4/HDyUyUMRA=;
        b=WXyQx8aQBWSDxpOeNxCAXDmwEIdCd7q8nRQZ04cW2H+3B7mG/a4vl9iOgIZjcg6ytz
         0hGnsX9zpf0xYfzgwsRNKTMtUCgjg9qFi3UYLgOqHNpDWYsXWZ8FOo7XpeIlUNKJS61V
         E0G5QQSOfDMzMZYtH303E5ojY0oszovAaip3rfuEalmerSlPaOpsbYnp/FHGQrL8S4cM
         3IARp0bHAJkUWUol+AFm9AGgXAB7vrJJdz7BUA8mrfNl+5cawpqwAYqbn8IHSSHpspuP
         F22k8+iJ02kLM5Jk9SBBbrqZPDtpPumwR8fYYk6DQDV/t6YfSX6jtxIpm8EtGXUtvrzi
         21nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685399287; x=1687991287;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fgPfcW2qzSYYzj32tI9lcSdz/QlSOeix4/HDyUyUMRA=;
        b=DlgsR/EQt6erUp2GfDT12AFa4GWJSLJmZGUXPpRfy3saY3dFHEDlruoNeyGPO+FKiM
         cEAPE4fEeEnDIkjMVY7QSiXaR7ESKeYFva3h3ZHsA6gEgZeu/5oFG5abP392ChyTlHtJ
         SJbKu8d2xv9zi+mjrYnaBqqOYeR7KXwyhVV0MjDEPJdIuMR+Lc+b/Y0GyV/DtvupzQB4
         /+0uQE/61FdiM6hWKF1vBxBGvOAYS2GVH0rEnW/QjHyuoI0RYzSOmkrNuFcb4IKSxJeZ
         4CJlo0fMgyFbYD0LGp6+orJKyAU4CBRz1/NCG74SgA2MbKPO7tY/t0MZVnvFxSqpP8yG
         75+g==
X-Gm-Message-State: AC+VfDxjfVP20Bdcv7K/mcakcfzCO1rTTDsEtm8+T3Mgmsja3dC2P5nB
        YEs1A8tYMH3gXhahvPQZhVM=
X-Google-Smtp-Source: ACHHUZ6NZ/Bb2tKmL5ScmGagfAqrAKXSkCJ3jZfX24VBwNQu8zOzFD3nvvqEpeSZAnWUUXAccWEJ8Q==
X-Received: by 2002:a05:6214:1c09:b0:626:24aa:87ef with SMTP id u9-20020a0562141c0900b0062624aa87efmr47324qvc.62.1685399287544;
        Mon, 29 May 2023 15:28:07 -0700 (PDT)
Received: from localhost ([2600:4040:2007:9800:1794:1f51:786e:6197])
        by smtp.gmail.com with ESMTPSA id t20-20020a0cea34000000b0062623d8ab7esm1215121qvp.111.2023.05.29.15.28.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 15:28:07 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 29 May 2023 18:28:05 -0400
Message-Id: <CSZ46N3I9GM7.NON5KMJ66OK5@Latitude-E6420>
Cc:     "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Vinod Koul" <vkoul@kernel.org>,
        "Kishon Vijay Abraham I" <kishon@kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>, "Olof Johansson" <olof@lixom.net>,
        <soc@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: arm: qcom: Add Samsung Galaxy
 Express
From:   "Rudraksha Gupta" <guptarud@gmail.com>
To:     "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Conor Dooley" <conor@kernel.org>
X-Mailer: aerc 0.8.2
References: <20230527040905.stmnoshkdqgiaex6@ripper>
 <20230528001010.47868-2-guptarud@gmail.com>
 <20230528-decode-creasing-f5b3996163e5@spud>
 <ad7a6ee3-cabb-6f92-a595-8791801cfe97@gmail.com>
 <a8d3d68d-d202-ddba-3289-65b347807538@linaro.org>
In-Reply-To: <a8d3d68d-d202-ddba-3289-65b347807538@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon May 29, 2023 at 3:41 AM EDT, Konrad Dybcio wrote:
>
>
> On 28.05.2023 15:36, Rudraksha Gupta wrote:
> >> Where did the "att" come from in the compatible. Is this some carrier =
specific model of the phone?
> >=20
> > This is the code name for the device. Since there are usually multiple =
variants of a device, using the code name differentiates between those vari=
ants. For example, if I left this as "samsung,express", it would be unclear=
 if I am referring to the GT-I8730 (code name: expresslte) or the SGH-I437 =
model. This is typically done in postmarketOS: https://wiki.postmarketos.or=
g/wiki/Devices and XDA developers. I believe it is a carrier specific model=
 of the Samsung Galaxy Express.
> >=20
>
> Please fix your email client:
>
> - wrap each line at about 80 characters
> - don't trim messages unless they're very long or
>   there's some other good reason
> - Don't send v(n+1) as a reply to v(n), send it in a
>   separate thread.
>
Gotcha, I will do that next time. Should I still send v2 in a separate
thread? Not sure if I should as I don't want to spam anyone.

>
>
> Konrad

