Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD09D6FE26D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbjEJQYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjEJQYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:24:16 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A2E7295;
        Wed, 10 May 2023 09:24:14 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 957D6847D4;
        Wed, 10 May 2023 18:24:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683735852;
        bh=YfK3NDPm4uKljhmxMm5kl6PuadMMC7H4LxZSFWINyaI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tncnbaAvVd8OKACynXOSURQ1gI4KvC9aQGZeUURjbmKK0gQVluw+uL7sF6E7Anfde
         2TXh/K0M0EXWViSi9XrF2k1bNwYUa2p0M27T5RD5JMRgsAwPi1F5bvgHdF+mXdlazO
         pATsr40sS3uNF6VafaqniXmjgUramxTD4Lf85UqJDvMx0yyTHCMqPqkpkC/7bnPmYa
         lcQj+0hDr8PtFl2Gx7WBCyHMeFfo55Smu1+0tJT5BeQOe4O3jeZPzNIl0HaHKe5i4s
         dRNIy8HQKNdBuPqQ7lkmXAZs1g3ZEGecKO4hWpK9odAVFKcswaYG0WOTLOy8NR9AGD
         Pr70KskTkkj2w==
Message-ID: <b3b77a65-5109-0e29-99c5-6cefaba0492c@denx.de>
Date:   Wed, 10 May 2023 18:24:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 5/6] drm: lcdif: Add multiple encoders and first
 bridges support
Content-Language: en-US
To:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     stefan@agner.ch, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        krzysztof.kozlowski@linaro.org, LW@karo-electronics.de,
        alexander.stein@ew.tq-group.com
References: <20230510092450.4024730-1-victor.liu@nxp.com>
 <20230510092450.4024730-6-victor.liu@nxp.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230510092450.4024730-6-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/23 11:24, Liu Ying wrote:
> The single LCDIF embedded in i.MX93 SoC may drive multiple displays
> simultaneously.  Look at LCDIF output port's remote port parents to
> find all enabled first bridges.  Add an encoder for each found bridge
> and attach the bridge to the encoder.  This is a preparation for
> adding i.MX93 LCDIF support.
> 
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v5->v6:
> * Drop MAX_DISPLAYS macro. (Marek)
> * Drop the encoder member in struct lcdif_drm_private.
> * Drop endpoint id check.

It might be nice to check (based on driver data for each IP variant) the 
encoder count, but that can be a separate patch.

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks !

btw if this doesn't get picked by someone in like a week or two, let me 
know and I'll apply this via drm-misc .
