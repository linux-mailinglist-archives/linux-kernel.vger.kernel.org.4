Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3212710C36
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240787AbjEYMkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjEYMkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:40:15 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3FE9B;
        Thu, 25 May 2023 05:40:14 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkzdf0gkyyyyyyyyyyyyt-3.rev.dnainternet.fi [IPv6:2001:14ba:4506:4f15::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4QRnh50mylz49Q1p;
        Thu, 25 May 2023 15:40:04 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1685018410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ofi9rDKaOj5yyLfZwTQCQwt32Q4sEcICZNEgWEPwvYo=;
        b=DKPXrx/FbnfaMLqgt/vzuwj7wLQ8AXTIVFKzL4YpEKJWfA0kJUKCttjkxWzzwsNd+9klEm
        l/6ItAVlA2uD72MDBos9PRgOUMsxom8qH5LE5/U6YBrnqupwx7ZV8vnd+MiG//eeMrehbp
        csZNtNYSH0/Loy/4M4YM0JIQhX1dz4Q2S5Y/xZQcHnYn1aothuv/tMstqLButi5FQq4AOl
        oeV6l9/Ly1Ip9h42qJP5+BquyPkZZ7iuE0RyVRCKWCC3AXVCsyWxSUrEC0WKx0rLqlDejx
        zbyGccAw9MLbvsS2RmzUansBRfUzc9AoOJ4t45Pf87+4+8zfQg3L68IRhGyJ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1685018410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ofi9rDKaOj5yyLfZwTQCQwt32Q4sEcICZNEgWEPwvYo=;
        b=pgVmOaEtw4vdoOZ8eaPmA7QgR+wrMMywJgDD60w0UAC7RxyzllFL534IMqFDtenK3XAljS
        m+vzDBMPa4uN11gUQVxXlmFoSIuc5cNzpwdIeRkcDwxfkOBmatYPGzOqQfC47v3uEYhwye
        mriwF2jEfs62hAYYdpqyuh/cZvO07x9niovAMH7lbln2DZRqvbca+ouVSryZHvumuyKzJ1
        b73+02DxuCtEpcT4KN53ZdZoYb4eF4s1N68JDvWQwCkEhSoH4O61Ix2pIgCw5baNCMnyqV
        N+uZ2bNbmJY65VddBTUKx7/mGXqYu4tzyC3fY8AbER5oRBa4YCbIVxAwqTYWLQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1685018410; a=rsa-sha256;
        cv=none;
        b=EQXr1FrsCQ8foHNMEHA9eY6b/C+Vv6N83O8oWbK948jenc4D+4e7/9RX4f3Dg9YE7JzWBe
        q9WEwFd9OheyWJNGkeIcGlZopb92MLZ2LRM09ycO/d64iCAR916Jst1hA9e6jUZeAcoMjj
        cgobMxqIZ02lc1wO08QVCfrUFb3irmbtvOCTuz/6fH1sWQff0nqktBLnBwp5nLkLmXhaDh
        E5FVqu/1dV//U4IGAsf17xs01k1YUL0VONCZoG2If4cFciNnNUEj0SEVkA6uv02jsGh4x1
        7uLYzOJ5xGWxPQBmzG6nwiCHtmInsVvEIb4y+GNv+D0RsC892mwiMfJ/Yhg30A==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 6AAE6634C91;
        Thu, 25 May 2023 15:40:04 +0300 (EEST)
Date:   Thu, 25 May 2023 15:40:04 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Joe Tessler <jrt@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Wenyou Yang <wenyou.yang@microchip.com>,
        Bin Liu <bin.liu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 01/28] media: cec: ch7322: drop of_match_ptr for ID table
Message-ID: <ZG9XJCD98VWjGjTN@valkosipuli.retiisi.eu>
References: <20230312131318.351173-1-krzysztof.kozlowski@linaro.org>
 <98a77653-ec58-56c4-9893-3b424f67c87e@linaro.org>
 <5afcec8b-b8f6-35b0-278a-5de185e4a7a2@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5afcec8b-b8f6-35b0-278a-5de185e4a7a2@xs4all.nl>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Sat, May 13, 2023 at 11:57:33AM +0200, Hans Verkuil wrote:
> On 12/05/2023 18:35, Krzysztof Kozlowski wrote:
> > On 12/03/2023 14:12, Krzysztof Kozlowski wrote:
> >> The driver can match only via the DT table so the table should be always
> >> used and the of_match_ptr does not have any sense (this also allows ACPI
> >> matching via PRP0001, even though it might not be relevant here).
> >>
> >>   drivers/media/cec/i2c/ch7322.c:583:34: error: ‘ch7322_of_match’ defined but not used [-Werror=unused-const-variable=]
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> > 
> > Hans, Sakari,
> > 
> > Can you pick up the patchset? There was positive feedback:
> > https://patchwork.linuxtv.org/project/linux-media/patch/20230312131318.351173-1-krzysztof.kozlowski@linaro.org/
> > 
> > but it seems it was not applied.
> 
> I see it is delegated to Sakari in patchwork and marked Under Review, but I don't
> see a corresponding pull request for this series.
> 
> Sakari, did something go wrong?

I spotted this as Hans notified me in IRC, I wasn't cc'd. Apologies for
this --- I intended to take these but I think I must have missed something
important in the process. I'll take them now.

Thanks.

-- 
Kind regards,

Sakari Ailus
