Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092AD643563
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 21:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbiLEUNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 15:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbiLEUNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 15:13:40 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC052240A2;
        Mon,  5 Dec 2022 12:13:39 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s5so17338695edc.12;
        Mon, 05 Dec 2022 12:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cWtDONIsCwTgfk8sAybr8IvLiR4HP8gBPcVUNlysGg=;
        b=iglSNUijG2rKTe2lz9E2sf3v7dbj8huBMfl2nT9sDlAq8ieIr/fqh60MuPioWhktMC
         TUfHhi9/K9nz7eSIbOQ9+cDZEA01LwpOA5pYeUkY0I9XfodYJowNmAFM0QzOG3JfA9zj
         ZlmeDbpfVgwkF2bDoruKE5tdNxfUlPYJ9Szpr1csQzB2VOOHxBUHlJNIU6mnKBwxhogu
         cc+NRNjvBz9bdEAxc+IJTyXPxTSGJA3ri5jxAqLHPtEP4O64Nc84OF2yTLglhvFeKvJz
         d4Vi6WRGbK2uCyTVbJesGIndB3AIWuOnXq6d+G7Q7cy2baE6m5+DMuMMjjtSvvwsreOo
         PMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cWtDONIsCwTgfk8sAybr8IvLiR4HP8gBPcVUNlysGg=;
        b=Au/obgoKtYWFutQukqM3F6knM09ZKVYhYVk2cHPvuBySdpPONhd1orosICh33ex2YQ
         C0Z+n2P/Bx3XqGhs5+rXfghDxNeOo7SLiEHCm0ffVwQr5Kf1NPFL7dkPuD8TDjHC6XsP
         xrilE0uT1mmBZr2WEeL9IR3D2GB/zKOHgPXEdGYeWVxli0v2Q4RA7txStGpFsGnJIYq+
         Y2O0VmLb3t9BalcbF+yi8EKV6CIMVTWxZr/orRWCOa701phOTeyo5ljhCfQpKvPB48f/
         ThHgIPW3swUrnC+b0PSKYSdF+eFnW5sVCSBoqIGvpSVM/8jYnOyT4KD5tOH6iKrVqrd/
         G8nw==
X-Gm-Message-State: ANoB5plNHHpyrr+FN646es7+CleIVlSypY0iNFeR+yTCh8wiwh4AFPvM
        ieBSDN8p0SOnlkhq5vdkeVI=
X-Google-Smtp-Source: AA0mqf6foAvuv64vb+zdQVhIad9BChvylagP1dX5NL09miVDfVqvJUjgy1j4HCpuD07CEIIMwp8vDg==
X-Received: by 2002:aa7:c754:0:b0:46b:6096:a884 with SMTP id c20-20020aa7c754000000b0046b6096a884mr28674921eds.152.1670271218282;
        Mon, 05 Dec 2022 12:13:38 -0800 (PST)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906200a00b007ae243c3f05sm6448466ejo.189.2022.12.05.12.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 12:13:37 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        =?utf-8?B?QW5kcsOhcyBTemVtesWR?= <szemzo.andras@gmail.com>
Subject: Re: [PATCH 4/5] clk: sunxi-ng: d1: Mark cpux clock as critical
Date:   Mon, 05 Dec 2022 21:13:36 +0100
Message-ID: <4787189.31r3eYUQgx@kista>
In-Reply-To: <20221126191319.6404-5-samuel@sholland.org>
References: <20221126191319.6404-1-samuel@sholland.org> <20221126191319.6404-5-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 26. november 2022 ob 20:13:18 CET je Samuel Holland napisal(a):
> From: Andr=C3=A1s Szemz=C5=91 <szemzo.andras@gmail.com>
>=20
> Some SoCs in the D1 family feature ARM CPUs instead of a RISC-V CPU.
> In that case, the CPUs are driven from the 'cpux' clock, so it needs
> to be marked as critical.
>=20
> Signed-off-by: Andr=C3=A1s Szemz=C5=91 <szemzo.andras@gmail.com>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


