Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600BA6EE32F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbjDYNfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbjDYNf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:35:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70EE14444;
        Tue, 25 Apr 2023 06:35:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37DAB62E7B;
        Tue, 25 Apr 2023 13:35:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC30C433EF;
        Tue, 25 Apr 2023 13:35:00 +0000 (UTC)
Date:   Tue, 25 Apr 2023 19:04:57 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] dt-bindings: leds: Drop redundant cpus enum match
Message-ID: <20230425133457.GA5640@thinkpad>
References: <20230424151437.256073-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230424151437.256073-1-nm@ti.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 10:14:37AM -0500, Nishanth Menon wrote:
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

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  Documentation/devicetree/bindings/leds/common.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Documentation/devicetree/bindings/leds/common.yaml
> index 11aedf1650a1..58b492d00246 100644
> --- a/Documentation/devicetree/bindings/leds/common.yaml
> +++ b/Documentation/devicetree/bindings/leds/common.yaml
> @@ -105,8 +105,6 @@ properties:
>            - audio-mute
>              # LED indicates bluetooth power state
>            - bluetooth-power
> -            # LED indicates activity of all CPUs
> -          - cpu
>              # LED indicates camera flash state
>            - flash
>              # LED indicated keyboard capslock
> -- 
> 2.40.0
> 

-- 
மணிவண்ணன் சதாசிவம்
