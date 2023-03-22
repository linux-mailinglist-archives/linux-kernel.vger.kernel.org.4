Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9D36C4A28
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 13:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjCVMRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 08:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjCVMRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:17:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C6B1C587;
        Wed, 22 Mar 2023 05:17:36 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1276C66030E8;
        Wed, 22 Mar 2023 12:17:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679487455;
        bh=VAG6FUY3zGW8SQCCkjFoofi11QfIA9Yc4jJfJjx5wh8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Jt2g7cBA/bAYa4/FkjN0yppVj7IbIST2E4YPEJFxOpsdtJh5M9O8W/BwpQ2FxdoHE
         wmI1ANsM5TIaMnsMEwMXYRD5vSiPiMTegKM14+ILFFUfJ3isbDMbnXNkS2IquZujmu
         7aIHqakWjBJ2uoF0yXPBGaaZ+uMnEF2U8POENSKg52R8KRQ4Fxcqk5gbis3KWypwb+
         UMHZrEj0AzHod6kfIL03+F07oGbSxXdSuR3UM7FsO9Veneq3rNpfbYu7TWpU887o9H
         Tnzsmt+b8xClwxiS+aHuydAqyXuiA0kBwJaEamDsaz4zVcECRlZmqlKjfdfDC7JBQg
         nL1p6Tc3n+YwA==
Message-ID: <cb956c2a-1a56-6201-b809-1634cf6f4c36@collabora.com>
Date:   Wed, 22 Mar 2023 13:17:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v14 05/10] drm/bridge: anx7625: Check for Type-C during
 panel registration
Content-Language: en-US
To:     Pin-yen Lin <treapking@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Xin Ji <xji@analogixsemi.com>, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-acpi@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Lyude Paul <lyude@redhat.com>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>, Allen Chen <allen.chen@ite.com.tw>,
        dri-devel@lists.freedesktop.org, Marek Vasut <marex@denx.de>,
        Stephen Boyd <swboyd@chromium.org>,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org
References: <20230322104639.221402-1-treapking@chromium.org>
 <20230322104639.221402-6-treapking@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230322104639.221402-6-treapking@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 22/03/23 11:46, Pin-yen Lin ha scritto:
> The output port endpoints can be connected to USB-C connectors.
> Running drm_of_find_panel_or_bridge() with such endpoints leads to
> a continuous return value of -EPROBE_DEFER, even though there is
> no panel present.
> 
> To avoid this, check for the existence of a "mode-switch" property in
> the port endpoint, and skip panel registration completely if so.
> 
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


