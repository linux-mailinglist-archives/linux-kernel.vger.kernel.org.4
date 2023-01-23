Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDC06780A3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbjAWP5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjAWP5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:57:31 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FFA2D6F;
        Mon, 23 Jan 2023 07:57:29 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 79DBA82F69;
        Mon, 23 Jan 2023 16:57:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1674489447;
        bh=SLvgU234z0Ib/utCI2P4W9G7P3rxOL12bQuTeAqy2xA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GWytINUuM1EgKe60xxlQeAYWkEweDE263zdfENbvRlrjuAKeHSWGOcWc1EOhtce7L
         6nQxr4vRC3hG5xvJxoKVXLbvrEZchnTmKclVmd7Dqh9JbuMdF26F2Yfvh8WSlFfr/k
         QFprH1IV+HJIrAZ13QbZOYUtU3Mt6Pa7VMXof9o1oafvI6J0clSlqriyfKXD2ixv21
         yOoikQP8df8+4M4uIlE2vDHXaSz2i9qbTu7dh/w+5+r+vhqqSAVyGEX4X/TMslf0JT
         dKUCUR070WXpt5Udr8qqMmXI4kjY7hc7grw381kpWN7d1Kl1vnoBRuHxPDNAf0Wt84
         qmvJ/nftu4fNg==
Message-ID: <ace76615-533a-9295-8271-95262859d287@denx.de>
Date:   Mon, 23 Jan 2023 16:57:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] drm: lcdif: Add i.MX93 LCDIF support
Content-Language: en-US
To:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     stefan@agner.ch, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
References: <20230123072358.1060670-1-victor.liu@nxp.com>
 <20230123072358.1060670-3-victor.liu@nxp.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230123072358.1060670-3-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/23 08:23, Liu Ying wrote:
> The LCDIF embedded in i.MX93 SoC is essentially the same to those
> in i.MX8mp SoC.  However, i.MX93 LCDIF may connect with MIPI DSI
> controller through LCDIF cross line pattern(controlled by mediamix
> blk-ctrl) or connect with LVDS display bridge(LDB) directly or a
> parallel display(also through mediamix blk-ctrl), so add multiple
> encoders(with DRM_MODE_ENCODER_NONE encoder type) support in the
> LCDIF DRM driver and find a bridge to attach the relevant encoder's
> chain when needed.  While at it, derive lcdif_crtc_state structure
> from drm_crtc_state structure to introduce bus_format and bus_flags
> states so that the next downstream bridges may use consistent bus
> format and bus flags.

Would it be possible to split this patch into preparatory clean up and 
i.MX93 addition ? It seems like the patch is doing two things according 
to the commit message.
