Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3D2675347
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 12:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjATLPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 06:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjATLP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 06:15:27 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4D83584;
        Fri, 20 Jan 2023 03:15:26 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CD80A660230B;
        Fri, 20 Jan 2023 11:15:21 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674213324;
        bh=CASdzRtoHYplP6yd6/mt/6hm04+ftfOht/MoW2dAnK8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YaLvVsczluXVfnE14rTAqsOFML8ibEN1/3WdsV84rBmyv56rm0yhbjdLUhD+eXUI3
         yKn2Ye+ICWEX+swXtC8nTyojSyi5j8aVZuPYvhCHx1sWbnW1CWR4J/WG6G5TcHOWq+
         13fRRh3EqjgwoQo7KnaqPqj0ur/D2OH2xexc1gB7gf/Hlbt7rT5ZQgwX6J3xN0YQdo
         SrTxkQ28Dw8AuQNXaTwK75BGopNLRf82Lq2KW9Jw2yZz9otY2jWkfw+0AnSgNmiMk3
         /A+CAQqcuPdlo4xosz+MWz7duPvfGPQgBCRsPxfwYxeslWq4G5I77YLn6dGajAqHo7
         NKDsK9qZMT2Aw==
Message-ID: <1e924d3b-1283-b9f9-d2a0-0e42db656d4e@collabora.com>
Date:   Fri, 20 Jan 2023 12:15:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 3/3] drm: Convert users of drm_of_component_match_add
 to component_match_add_of
Content-Language: en-US
To:     Sean Anderson <sean.anderson@seco.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Jyri Sarha <jyri.sarha@iki.fi>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        John Stultz <jstultz@google.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Mali DP Maintainers <malidp@foss.arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Samuel Holland <samuel@sholland.org>,
        Sean Paul <sean@poorly.run>, Tian Tao <tiantao6@hisilicon.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        etnaviv@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-sunxi@lists.linux.dev
References: <20230119191040.1637739-1-sean.anderson@seco.com>
 <20230119191040.1637739-4-sean.anderson@seco.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230119191040.1637739-4-sean.anderson@seco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/01/23 20:10, Sean Anderson ha scritto:
> Every user of this function either uses component_compare_of or
> something equivalent. Most of them immediately put the device node as
> well. Convert these users to component_match_add_of and remove
> drm_of_component_match_add.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> Acked-by: Jyri Sarha <jyri.sarhaı@iki.fi>
> Tested-by: Jyri Sarha <jyri.sarha@iki.fi>

For MediaTek mtk_drm_drv:

Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


