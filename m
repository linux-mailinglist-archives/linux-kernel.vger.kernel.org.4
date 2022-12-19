Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF8A6513C1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 21:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbiLSUUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 15:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbiLSUUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 15:20:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB002140FE;
        Mon, 19 Dec 2022 12:19:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E20AB80EF7;
        Mon, 19 Dec 2022 20:19:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668BDC433EF;
        Mon, 19 Dec 2022 20:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671481192;
        bh=tTePxdA+CAo0HaKkeJhMsyhOGYdEA4fxoVpt8swbBoc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sV6eZbQ7OQO4BbD66TmrU+8AHX03VTOHKMRBS/nFZ0CG64//0g4lajH+VAVk8F47K
         LMRUuiRoZCIkjRREHqI6tDcm3gAjAKjax4c9NJYJKLeUgUc32NWwEH7k1aFvk4MRRP
         C+y9PQQlAFhrvxmMOfb2wIaKTi9BTC36xN2MxYh7TGAFUumqT00dG7jR2E5HYGHFsR
         f1e6I/wzYK09eYBdA2jKY+BsGLCOBSjRhWx7m9Ot5Owo5bA/6K+A/a8qSd0JHudAFu
         08G3x0/vu9x4WEGUTkb83JWRQNWn3N6St5j5606e6hNKwOltW66A3QMrDbmP55n6tl
         3AMJJ+6ISEXAw==
Message-ID: <da0a1ee5-0f95-f10f-9d87-afd298df2e40@kernel.org>
Date:   Mon, 19 Dec 2022 22:19:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v12 3/6] remoteproc: pru: Add APIs to get and put the PRU
 cores
To:     MD Danish Anwar <danishanwar@ti.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Suman Anna <s-anna@ti.com>, "Andrew F . Davis" <afd@ti.com>,
        nm@ti.com, vigneshr@ti.com, srk@ti.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221216053313.2974826-1-danishanwar@ti.com>
 <20221216053313.2974826-4-danishanwar@ti.com>
Content-Language: en-US
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20221216053313.2974826-4-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/12/2022 07:33, MD Danish Anwar wrote:
> Add two new APIs, pru_rproc_get() and pru_rproc_put(), to the PRU
> driver to allow client drivers to acquire and release the remoteproc
> device associated with a PRU core. The PRU cores are treated as
> resources with only one client owning it at a time.
> 
> The pru_rproc_get() function returns the rproc handle corresponding
> to a PRU core identified by the device tree "ti,prus" property under
> the client node. The pru_rproc_put() is the complementary function
> to pru_rproc_get().
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>
