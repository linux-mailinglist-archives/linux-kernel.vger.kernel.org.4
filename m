Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257526E3C94
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 00:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjDPWMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 18:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDPWMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 18:12:33 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD67211C;
        Sun, 16 Apr 2023 15:12:32 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id D5CF085C9B;
        Mon, 17 Apr 2023 00:12:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1681683151;
        bh=njiQMSpa55Md/h+IwVavrbsHo/BMerUnaJPe8xEMR9Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gha/hyJvKgc5H7SCdoyie6kvnyfwTn1IGp0hMnPAXUskY1UWWBC1+e7EHHVgtP4yY
         IhCvcUykT2iJbzXXE251hDynxzuHJEJAS+82oYX+xhanXjQnbkzvI6opz/4HjnEaAr
         qfYuQ4ysdPfBgp6iAOQeL2iA7QvG0aeehH7ApmfnhAoxiF3DFzechHrHmuFQdC9h+l
         fPDFloU0N1PvKGnj2PlNPfaLPiGPh/Bkfkr/RxLQll2SF+l3lAKFfSWdQgg/qPhae4
         YidyO8lns6MYKCZKEeZfD/QJ/ZjJrmUQRQZcbyGwBB5GOtwpHF3qkl2zk05heoUMFr
         tVeMbhUHiyCCg==
Message-ID: <5b6d4cfd-dedb-3123-9db4-28e202da11b2@denx.de>
Date:   Mon, 17 Apr 2023 00:12:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 4/6] drm: bridge: samsung-dsim: Dynamically configure DPHY
 timing
Content-Language: en-US
To:     Adam Ford <aford173@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     m.szyprowski@samsung.com, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230415104104.5537-1-aford173@gmail.com>
 <20230415104104.5537-4-aford173@gmail.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230415104104.5537-4-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/23 12:41, Adam Ford wrote:
> NXP uses a lookup table to determine the various values for
> the PHY Timing based on the clock rate in their downstream
> kernel.  Since the input clock can be variable, the phy
> settings need to be variable too.  Add an additional variable
> to the driver data to enable this feature to prevent breaking
> boards that don't support it.

Isn't there already a generic LP2HS transition time calculation in the 
kernel ?

This looks like a generic calculation which should be done by all the 
DSI hosts, so why not introduce a generic helper to do such a 
calculation (and not a table please) ?
