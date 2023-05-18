Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C76708A29
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 23:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjERVJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 17:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjERVJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 17:09:17 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A661B6;
        Thu, 18 May 2023 14:09:16 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-965ab8ed1c0so398099666b.2;
        Thu, 18 May 2023 14:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684444155; x=1687036155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnh3tyDUDMlsulIV/kPw728cW2/MDK+ktFBwUG82RqY=;
        b=TGR7argf0z8ZhgJu/21nGdGThgR8Or+D63dA/zj8mS+KOyyn7MsXbnBiMvZb49P/T1
         wm+CJVG6i34RnLFbsCF/9bRb28Rm7vAKvuCsp655+5SEk/vnYKFGa89Bc7u+sYDrcIA4
         NIaTtdCYE9dLtXDiXfSBAMjzyAT4uABaxrQmoVhtu5Y/5tD7vb3miktce4n77e3e8kS+
         M3j85AcXJiz4DpL3xl1CQRIPo7SS6EXobIWFgnl/K+u5yAp5/FOmgAEnv9nREzflNKH/
         dfZggDiU22pFucHgdBrBg0PVzKOebkuzNRGHMI3UKr0KLVjShk7WZ4jlN483uwy+KRw4
         V+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684444155; x=1687036155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnh3tyDUDMlsulIV/kPw728cW2/MDK+ktFBwUG82RqY=;
        b=kTGksx300J5JlIEfzS93n4/LUGaWoYyxrXY7frQhn/zoCZRxuDQOMWGzifq7iNV1D9
         Evu8w3mERt9yxdInXxhJwcTnLSwjiN5vFfVhwbz3NhcBltgslsE0oKgHyxZF27RZWH1h
         Hqmcmrsatb74m7erReINj4t3PNdRCVnNrXRfpYey44YzRLJw5aUjSpEN5b6YSCk6we9f
         J3B6X5psEvkQxZ1Bz3aboJjYCBCC8YAccNO35A4H75SplTF6G8b1GXIn1V1xcF2I+6A5
         f9fyf44Pqy6eBHZLA4DgB9HNfhvTpvfbts+vOAC9ttBuv0yLapfXHZih+4+Gc+DwVKyd
         Bbbw==
X-Gm-Message-State: AC+VfDx7qqXSuF3zHs33PX7opR/YbFKrNDxZIL8Qx2qsCVo0VVL8OKfm
        jhttPTXdM0dm/qsJnZ3SPQc=
X-Google-Smtp-Source: ACHHUZ4xYGeWgw813K5HPP+JDjaf07MOHp6X1MaKB4myGbAL1dXQo69yO/4QoJnkEsY0D9X3ii5Y1w==
X-Received: by 2002:a17:907:3f0d:b0:966:2984:3da0 with SMTP id hq13-20020a1709073f0d00b0096629843da0mr475421ejc.63.1684444155082;
        Thu, 18 May 2023 14:09:15 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id b20-20020a056402139400b00508804f3b1dsm950498edv.57.2023.05.18.14.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 14:09:14 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Roman Beranek <me@crly.cz>
Cc:     Frank Oltmanns <frank@oltmanns.dev>,
        Icenowy Zheng <icenowy@aosc.io>, Ondrej Jirman <megi@xff.cz>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] ARM: dts: sunxi: rename tcon's clock output
Date:   Thu, 18 May 2023 23:09:13 +0200
Message-ID: <2281226.ElGaqSPkdT@jernej-laptop>
In-Reply-To: <20230505052110.67514-3-me@crly.cz>
References: <20230505052110.67514-1-me@crly.cz> <20230505052110.67514-3-me@crly.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 05. maj 2023 ob 07:21:08 CEST je Roman Beranek napisal(a):
> While the rate of TCON0's DCLK matches dotclock for parallel and LVDS
> outputs, this doesn't hold for DSI. According manuals from Allwinner,
> DCLK is an abbreviation of Data Clock, not dotclock, so go with that
> instead.
> 
> Signed-off-by: Roman Beranek <me@crly.cz>

Applied, thanks!

Best regards,
Jernej


