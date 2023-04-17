Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9706E49F3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjDQNdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjDQNdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:33:00 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155FC868F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:32:57 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id dm2so64260911ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681738375; x=1684330375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPiq0OVRi/FkSBkrx6r9kFVybHHOEdw9SmQm4viTMUc=;
        b=HmaGMEqlD0daDB1jKy5x8/I2mHUSTv5MdkMvVgod2xVcHLDQWpfmEUu5hvCJhlB+uY
         RBIBvON9ydZaIZ5A0hEF3/JnYamojfOZPaNv0Fnl4KtKLUlLAYOm41hAjOu/nHweOkU7
         ah61rYpdk630cG/aRRas7+JhiblpbDRVJQmKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681738375; x=1684330375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPiq0OVRi/FkSBkrx6r9kFVybHHOEdw9SmQm4viTMUc=;
        b=RWz8oO3gLBu0DC58lXLzgU3HuM2elsMPX6kWGn+odAP/clcKJPJxLs6lqzUyFHqjdI
         uqK45N2GY0Jm4WadClHw1IpS9jrKcPhHSlB3ZidEUA0dXDICF+13da4lUMuVldlqUre+
         RsOA9CoyFJqIvP+MFMQcQOHPqnX352o/osWfIUhUJwEp5UvqdDc8/GAPskwnGmfRXEJH
         zCLg5jOFyrSpg+a8XdEsExNBuxaeDVv5AwsfLXBTcdRLNuX/a9zp+8a5nf4qa84oYQxT
         FDBo5yoBBwcznJAakqOfP7DZ3HBLESqkewnM29p1R/HfO7F84aWX8SMB4M+LB8PGkI8L
         ydBg==
X-Gm-Message-State: AAQBX9d9SAnNbPFSfuef9yGnZqTVQMcaKWnqv5/j+5Ly5bn+mo46Y+DP
        +VuEPqrf9KrIoSTbmyrfT+A/3cI21Q4SmUcw5wFiUA==
X-Google-Smtp-Source: AKy350bNXUHOj9VPJauGlYx8AlK/HKyeX9DwsFWGwJfTY5CAo6JZQIU249+8sXMhIfeC6ffZ5sb89g==
X-Received: by 2002:a17:906:af9a:b0:94e:e6b9:fef2 with SMTP id mj26-20020a170906af9a00b0094ee6b9fef2mr7396652ejb.67.1681738374946;
        Mon, 17 Apr 2023 06:32:54 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id ji12-20020a170907980c00b0094e1272bd12sm6624933ejc.159.2023.04.17.06.32.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 06:32:53 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id q5so13776054wmo.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:32:53 -0700 (PDT)
X-Received: by 2002:a05:600c:2308:b0:3f1:6980:2d34 with SMTP id
 8-20020a05600c230800b003f169802d34mr1272021wmo.6.1681738373434; Mon, 17 Apr
 2023 06:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230417123956.926266-1-treapking@chromium.org>
In-Reply-To: <20230417123956.926266-1-treapking@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 17 Apr 2023 06:32:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VoC2gK5MtBU9qhVxJwRRUGBMLT96UH7F+QKcmGEYo_sQ@mail.gmail.com>
Message-ID: <CAD=FV=VoC2gK5MtBU9qhVxJwRRUGBMLT96UH7F+QKcmGEYo_sQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mt8173: Power on panel regulator on boot
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 17, 2023 at 5:40=E2=80=AFAM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> Add "regulator-boot-on" to "panel_fixed_3v3" to save time on powering
> the regulator during boot.  Also add "off-on-delay-us" to the node to
> make sure the regulator never violates the panel timing requirements.
>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
>
> ---
>
>  arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
