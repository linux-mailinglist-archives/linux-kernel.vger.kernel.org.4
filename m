Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FE371485B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 13:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjE2LMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 07:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjE2LMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 07:12:33 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2503CCF
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:12:32 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B211B836;
        Mon, 29 May 2023 13:12:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1685358729;
        bh=ADkBV2LVS+YgVqFYYD4O2XlRfoS6+tQg/VZ+VEf6b1Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hohLMmFWvioA5RJ9d0FwjFsyEu/C+X32za6b6Q8VbtETTJPfBcpsbBO2UTP6fWEpX
         0Tu4bHMD5+YLxhDhQdTyuFl8hBfvh1VzjQxLBAlp4pPUNhp1FPdtJridqyTs+sp0G1
         NarhUBv1yVAKKVnq4jzH1bgbKVVHsyCiXAz0itis=
Message-ID: <5d207be0-c8f0-7c68-91b2-d5ef873ca6cc@ideasonboard.com>
Date:   Mon, 29 May 2023 14:12:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 3/8] drm/bridge: mhdp8546: Add minimal format
 negotiation
Content-Language: en-US
To:     Aradhya Bhatia <a-bhatia1@ti.com>, neil.armstrong@linaro.org,
        Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Francesco Dolcini <francesco@dolcini.it>
Cc:     DRI Development List <dri-devel@lists.freedesktop.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
References: <20230509093036.3303-1-a-bhatia1@ti.com>
 <20230509093036.3303-4-a-bhatia1@ti.com>
 <db9b4117-b030-49a7-3732-2fc39d089ee2@ideasonboard.com>
 <d2777edc-151d-7f06-30c4-4634fdb6a63d@ti.com>
 <305382fd-2312-59d9-e2d3-25a17e0a2158@linaro.org>
 <363d3089-48d4-5663-68e8-ecf0eb4e3e0e@ti.com>
 <9f98fb99-eaf4-657c-fd2e-b2e81d9cb109@ideasonboard.com>
 <c8712ef7-c0bc-e6e7-7319-68238d011dd9@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <c8712ef7-c0bc-e6e7-7319-68238d011dd9@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/2023 08:37, Aradhya Bhatia wrote:
>> Btw, we seem to be missing get-output-fmt from the mdhp driver.
> Yes, we are.
> 
> With the drm_bridge_attach call added, the display-connector bridge will
> assign MEDIA_BUS_FMT_FIXED as the default output format. And most
> bridges support only their primary output bus format in their
> get-output-fmt hooks. I suppose it would be RGB121212_1X36 in mhdp8546's
> case.
> 
> Do we require this when there is no comprehensive way to determine if
> another bus format may be more suitable (depending on the hardware
> configurations)?

If I recall right, mhdp supports other formats than RGB121212_1X36 on 
the input side (different bit depths and also yuv). On the output side, 
even if the input is 12 bits per component, when connected to a normal 
monitor, the output bpc would be 8.

I'm not sure if any of that matters, as nobody (?) will use the output 
format of mhdp, as it just goes "outside" to the monitor, and it is the 
mhdp driver that negotiates a suitable output format with the monitor.

  Tomi

