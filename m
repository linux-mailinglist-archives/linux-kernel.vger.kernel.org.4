Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD52A6FBCF4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 04:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbjEICOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 22:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbjEICOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 22:14:11 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A7A93E6;
        Mon,  8 May 2023 19:14:10 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 8BA0784788;
        Tue,  9 May 2023 04:14:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683598448;
        bh=SIC05a1h6bRWGMz9RDdtOyxBzwCAwNUqEJPqWKbzSxc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aMeANNK+KgPlA8gSVw6iwHDK5qOPrrNoMCyGrDKeLXHJjGXMB01w2l0TPVRok5pxu
         CYFZQQzBwg6m0cLdqDuI+y1kdmedWI/SEFyf4zKZunINZ0uJPFeoGMayZtDstQGbD/
         lzfIW0ACxfKWsmCvGW4a5i/u+y+cr8Ob2dHEGtk6DI0sQGe3Eu9oJNOnF+GwqLJqkM
         ru8JpSQ8h/n4CMeLldiRcTPwPGeoFRPaUBkwAKXjRzRgb37qQQuNQjhNIQmvS9Cizu
         7bT9f8vg9cmB5qzX7KYeF6tHAmoP/63KDhHotbDjDG9jEqENNdpz69Wrh0OFS3vyyh
         s5WCFZf/otDJA==
Message-ID: <211f0b07-568e-509d-464a-2f8821d300d7@denx.de>
Date:   Tue, 9 May 2023 02:11:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 3/6] drm: lcdif: Determine bus format and flags in
 ->atomic_check()
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
References: <20230508055740.635256-1-victor.liu@nxp.com>
 <20230508055740.635256-4-victor.liu@nxp.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230508055740.635256-4-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/23 07:57, Liu Ying wrote:
> Instead of determining LCDIF output bus format and bus flags in
> ->atomic_enable(), do that in ->atomic_check().  This is a
> preparation for the upcoming patch to check consistent bus format
> and bus flags across all first downstream bridges in ->atomic_check().
> New lcdif_crtc_state structure is introduced to cache bus format
> and bus flags states in ->atomic_check() so that they can be read
> in ->atomic_enable().
> 
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Reviewed-by: Marek Vasut <marex@denx.de>
