Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4417689E58
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 16:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjBCPd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 10:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjBCPd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 10:33:57 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D076C101;
        Fri,  3 Feb 2023 07:33:53 -0800 (PST)
Received: from [192.168.1.15] (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5B0DC890;
        Fri,  3 Feb 2023 16:33:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1675438432;
        bh=fJkl9CAORGIkT6BIuLDLkQQjolu5v1t/zilLrJLaP30=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HqtQazw4SA8pN0X8rhRqgkmYms1LGmxOCFvxtSrqNLsng7CuCXgspzf0cxDpfZT2x
         6KU1QEjZlBqGjkI9XxR/0FpkBNoIrPd4DLBw/JeDxaOrPQQdnnpGnZUSpkjma3X/TI
         6H/IEXKWyXima/RvUUMy8MKZEALHgzMTZzREkD0A=
Message-ID: <ab6f52bb-a3f5-afda-c037-f009153a0bb6@ideasonboard.com>
Date:   Fri, 3 Feb 2023 17:33:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 3/6] drm/tidss: Add support for AM625 DSS
Content-Language: en-US
To:     Aradhya Bhatia <a-bhatia1@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
References: <20230125113529.13952-1-a-bhatia1@ti.com>
 <20230125113529.13952-4-a-bhatia1@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20230125113529.13952-4-a-bhatia1@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2023 13:35, Aradhya Bhatia wrote:
> Add support for the DSS controller on TI's new AM625 SoC in the tidss
> driver.
> 
> The first video port (VP0) in am625-dss can output OLDI signals through
> 2 OLDI TXes. A 3rd output port has been added with "DISPC_PORT_OLDI" bus
> type.

Not a big thing here as you add support for a new SoC, but the ordering 
of the patches is not optimal. Here you add the AM625 DSS support, but 
then you continue actually adding the DSS support (well, mainly OLDI) in 
the following patches.

I think patch 6 could be before this patch. Parts of patch 4 could also 
be before this patch. The AM65X renames from patch 5 could be before 
this patch.

I'm mainly thinking of a case where someone uses AM625 and is bisecting 
a problem. What happens if his board uses OLDI, and he happens to hit 
one of these patches during bisect? If the display just stays black, but 
otherwise everything works fine, then no problem. But if it crashes or 
starts spamming sync losts or such or gives errors, it's not so nice.

  Tomi

