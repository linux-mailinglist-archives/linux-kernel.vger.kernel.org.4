Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B009653004
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 11:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiLUK5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 05:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbiLUK5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 05:57:18 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E3621E3E;
        Wed, 21 Dec 2022 02:57:16 -0800 (PST)
Received: from [192.168.1.15] (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3F15DFB;
        Wed, 21 Dec 2022 11:57:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671620234;
        bh=NEpOfS56/yLzB83ZMRxsHhwGoWpFbzaQagcinoT0hU4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BFPQumQjvP87bN20iHSFPGT01gZlr+AULllteYWgMbz0eUrGgI9tZGum4CvIdyQ6f
         hTNFGjtcEkul0rqNiDRxu89rNNCLwBF/iSVjKSM8jcTvnyPAFBckxbnndVRrlefz4T
         n9d3WJLWXPdCF7rWce/sU5WPGFKp5HoVwREzTPuc=
Message-ID: <1d5bbb7f-19f1-1582-85df-35134da918a0@ideasonboard.com>
Date:   Wed, 21 Dec 2022 12:57:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v9 5/5] drm/bridge: cdns-dsi: Add support for J721E
 wrapper
Content-Language: en-US
To:     Rahul T R <r-ravikumar@ti.com>, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, jonas@kwiboo.se, jernej.skrabec@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch, p.zabel@pengutronix.de,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        jpawar@cadence.com, sjakhade@cadence.com, mparab@cadence.com,
        a-bhatia1@ti.com, devicetree@vger.kernel.org, vigneshr@ti.com,
        lee.jones@linaro.org
References: <20221031121924.29974-1-r-ravikumar@ti.com>
 <20221031121924.29974-6-r-ravikumar@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20221031121924.29974-6-r-ravikumar@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2022 14:19, Rahul T R wrote:
> Add support for wrapper settings for DSI bridge on
> j721e. Also enable DPI0
> 
> ---------------      -----------------------
> |      -------|      |-------              |
> | DSS  | DPI2 |----->| DPI0 |  DSI Wrapper |
> |      -------|      |-------              |
> ---------------      -----------------------
> 
> As shown above DPI2 output of DSS is connected
> to DPI0 input of DSI Wrapper, DSI wrapper
> gives control wheather to enable/disable DPI0
> input. In j721e above is the only configuration
> supported
> 
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> ---
>   drivers/gpu/drm/bridge/cadence/Kconfig        | 10 ++++
>   drivers/gpu/drm/bridge/cadence/Makefile       |  1 +
>   .../gpu/drm/bridge/cadence/cdns-dsi-core.c    | 35 ++++++++++++-
>   .../gpu/drm/bridge/cadence/cdns-dsi-core.h    | 13 +++++
>   .../gpu/drm/bridge/cadence/cdns-dsi-j721e.c   | 51 +++++++++++++++++++
>   .../gpu/drm/bridge/cadence/cdns-dsi-j721e.h   | 16 ++++++
>   6 files changed, 125 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-dsi-j721e.c
>   create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-dsi-j721e.h

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

