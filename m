Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA2D6F0AA4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244338AbjD0RRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244326AbjD0RRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:17:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF1A59F1;
        Thu, 27 Apr 2023 10:17:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E92263DCE;
        Thu, 27 Apr 2023 17:17:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6F5C433EF;
        Thu, 27 Apr 2023 17:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682615847;
        bh=0xWA8A0zUyKpHuYdXUaZ5SCZXM9LKzezszDIXzsri/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EFLNI5Y8xqGLUGpTKLeRHASq6Vz8HG18a76B1ZAevLGlYgFL45sxMgHqW65HWt7Kf
         V2oGRRSayE9yxw3fDhhT5oy8/BX9egr9j3YWsai/fNpdjnJ10QottK2SQn9CZawxTC
         vC1O5BXmzfbpSsyeDZamy51tCyvCjyXJiPNhFWDBM1JJap3SxNkV3jBN2DcUUFPk2M
         drjRHy+Wtk/lUpBPEQ415pY6wkMEbi36h7MysKSBznJgSEdCPcN+bRqUmpFAmKtAzp
         fFLPuKsM+epJDb1xmW4oN67Cj9HtuNKw7OlHO7IwrDL59b+I9FONeoxC3gltaSc9DV
         mogPQQ78asJTQ==
Date:   Thu, 27 Apr 2023 18:17:22 +0100
From:   Lee Jones <lee@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH] dt-bindings: leds: Drop redundant cpus enum match
Message-ID: <20230427171722.GG620451@google.com>
References: <20230424151437.256073-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230424151437.256073-1-nm@ti.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2023, Nishanth Menon wrote:

> Commit e91a4d5deb96 ("dt-bindings: leds: Document commonly used
> LED triggers") introduced a enum match for cpu, while a pattern
> '^cpu[0-9]*$' already exists.
> 
> This causes linux,default-trigger = "cpu" to have more than one match
> and generates the following dtbs_check warning:
> 
> arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dtb: leds: led-2:linux,default-trigger: More than one condition true in oneOf schema:
> 	{'$ref': '/schemas/types.yaml#/definitions/string',
> 	 'oneOf': [{'items': [{'enum': ['backlight',
> 	                                'default-on',
> 	                                'heartbeat',
> 	                                'disk-activity',
> 	                                'disk-read',
> 	                                'disk-write',
> 	                                'timer',
> 	                                'pattern',
> 	                                'audio-micmute',
> 	                                'audio-mute',
> 	                                'bluetooth-power',
> 	                                'cpu',
> 	                                'flash',
> 	                                'kbd-capslock',
> 	                                'mtd',
> 	                                'nand-disk',
> 	                                'none',
> 	                                'torch',
> 	                                'usb-gadget',
> 	                                'usb-host',
> 	                                'usbport']}],
> 	            'maxItems': 1,
> 	            'minItems': 1,
> 	            'type': 'array'},
> 	           {'items': [{'pattern': '^cpu[0-9]*$'}],
> 	            'maxItems': 1,
> 	            'minItems': 1,
> 	            'type': 'array'},
> 	           {'items': [{'pattern': '^hci[0-9]+-power$'}],
> 	            'maxItems': 1,
> 	            'minItems': 1,
> 	            'type': 'array'},
> 	           {'items': [{'pattern': '^mmc[0-9]+$'}],
> 	            'maxItems': 1,
> 	            'minItems': 1,
> 	            'type': 'array'},
> 	           {'items': [{'pattern': '^phy[0-9]+tx$'}],
> 	            'maxItems': 1,
> 	            'minItems': 1,
> 	            'type': 'array'}]}
> 
> Drop the explicit match against cpu since the pattern match already
> covers the same.
> 
> Fixes: e91a4d5deb96 ("dt-bindings: leds: Document commonly used LED triggers")
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  Documentation/devicetree/bindings/leds/common.yaml | 2 --
>  1 file changed, 2 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
