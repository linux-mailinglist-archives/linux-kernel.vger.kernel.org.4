Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65E66D5145
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 21:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjDCTYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 15:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjDCTYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 15:24:49 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178A5E7C;
        Mon,  3 Apr 2023 12:24:47 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkzcv-3yyyyyyyyyyyyyt-3.rev.dnainternet.fi [IPv6:2001:14ba:4505:1fdc::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Pr16v6hS3z49Q0d;
        Mon,  3 Apr 2023 22:24:39 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1680549885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tp5qcqPaxivMIuFMRKaAe5HT8V/qPK5f6UKZnTDqXZs=;
        b=wj8iMdaB6O5svgBz97QcbFfxl9pOUa1PNhWR6/nMI8DJ/TlBNBIzxaoXQ4xFtAVcllZBGn
        1h11XWEmzs+t+7S8wZmoH14Ni8IZIiAbMuwhBvBpaZQSxGqHI3PBS4/eRQdeOwpNSUUZ4Q
        9oD4KR5OR/7ixTFuQJjiBae6kKroRXjgsr1oQ1YHFdRtSRUWdkyXT6ydrbBKs2fI2Nf6at
        KgPm5BT3ib2zzo+p3tbEYZMZCdzbPUGlXdxIKRq6Wl3LoBqS5w7Tcdh9ze+jq4BX8ZDee1
        E31/c03A+3U1KSnRAQJPWWdm9O+j4FuxlElRkzejBkCFdfXldIoFoa2cL7+rAQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1680549885; a=rsa-sha256;
        cv=none;
        b=pTLkgQTxUMn8kAT5W3Z+ogFont60P6E8KePKCXivg0tBgmGITjjXMVNgPLPZmGVszTwkb9
        8xmV8K+JZuzm7F5CFJy//1r6ial5+VTAqVELsLbmuuAMfOY1FbI3yDkl8ZCGK0ToM5mF6F
        iXE23DARwHLsLEzlUBnPniLP4sabKK6I8VHkzWvPos67ec7cBwbNsoN6VKbLTay13Lx0Te
        srYyEk9eLJ72MlypaetY0e3iRJp+oyVh9XtQdLwdV+Gk7bvcCtArTcbo8tYuuL7peYlIWK
        3MAa6H4E+TVhwLzsPEbZwvIuhCayXj1Up3OmaEuUmeKIlKMxGrnJHjS1tylKqw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1680549885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tp5qcqPaxivMIuFMRKaAe5HT8V/qPK5f6UKZnTDqXZs=;
        b=nDY5LUXsU7qY8CejlN+YlEuCBrJE/yaOwuV73ThTDfxvd8Q/gVoeJnKw2jhXh4fy8A7SPX
        04/1VA27KvucaNF6obkcJs2PPrdTE0lqb28f0pJOkLQXoIeseCKj3IvDUyXnBCVMbpl03s
        yasLIby0zyRIhZg4rK6kfJ04rUVkkEFvNGm5TZYXULNkyhoQREHpmP/LL8JdsOm0Nmc2LH
        0bmnev2mHgSMrVvTzXkiub2kKx9ZZcsn7/QC6F+28qWZ7KKjWBErPDIXmgXOy47iBBRRO6
        0ZiawUTptzsFdcFQ0UPZ510Z4RUtHySIcAMki/r3tFx2/Ka+zwbnh9UJRyw49Q==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 4C2E2634C91;
        Mon,  3 Apr 2023 22:22:09 +0300 (EEST)
Date:   Mon, 3 Apr 2023 22:22:08 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Joe Tessler <jrt@google.com>,
        Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Benoit Parrot <bparrot@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] media: dt-bindings: Drop unneeded quotes
Message-ID: <ZCsnYGMkV2Zrw3fJ@valkosipuli.retiisi.eu>
References: <20230320233944.2920964-1-robh@kernel.org>
 <ZCaoVwRuxVOTZdI4@valkosipuli.retiisi.eu>
 <36febd82-85b2-aa4d-c7e0-6343b119e0cc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36febd82-85b2-aa4d-c7e0-6343b119e0cc@gmail.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stan,

How are you doing?

On Mon, Apr 03, 2023 at 08:26:28PM +0300, Stanimir Varbanov wrote:
> Hei Sakari,
> 
> On 31.03.23 г. 12:31 ч., Sakari Ailus wrote:
> > Hi Rob,
> > 
> > On Mon, Mar 20, 2023 at 06:39:42PM -0500, Rob Herring wrote:
> > > Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> > > checking for this can be enabled in yamllint.
> > > 
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > 
> > This patch contains changes to Qualcomm bindings that have been already
> > made by other patches by Krzysztof. I think these took some time to get
> > merged to the media tree.
> > 
> > I've dropped those, the result is here:
> > 
> > <URL:https://git.linuxtv.org/sailus/media_tree.git/commit/?id=d75cae0884e80bba486f85e82b33a1dae3c9c976>
> > 
> 
> Do you think it will fix this pull request failure?
> 
> https://lore.kernel.org/all/20230329214310.2503484-1-jenkins@linuxtv.org/

Ah, it seems to be the same issue here.

The patch has been merged via my tree, whereas the rest of the patchset was
apparently merged by Hans earlier on.

<URL:https://patchwork.linuxtv.org/project/linux-media/list/?series=9531&submitter=&state=*&q=&archive=&delegate=>

-- 
Kind regards,

Sakari Ailus
