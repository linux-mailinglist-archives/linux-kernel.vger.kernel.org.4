Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0C56E92AC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjDTL37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbjDTL3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:29:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625CF10CB;
        Thu, 20 Apr 2023 04:29:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8113761DF9;
        Thu, 20 Apr 2023 11:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4083C433D2;
        Thu, 20 Apr 2023 11:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681990108;
        bh=eWhB8HSrvOlHeakDXxHfQTUBLdrNhqVzjEsUT9awTjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rvu+c1qCqp2647lvh4zyhPkQLkAKeL4B1B/Xe73jUYQr/xOkzPjo3iPcKCgrhBU6A
         TQWAIWQzx3gQp7wOIjncNMJlgzyM4sKvcZxK6th/r41TM6fgSBZaaDG3s4sABI6SSS
         MBtas7SQ7OOgm13RPDFD9d05EXmzvNbVHK6dVSzoy85VrWVQOhvglDmaVmDofCNZGN
         pztSIpeUUM9ZavbACQqs4nOZPyM3mJR/angk24lT2iheBNYC8kaTlipqUfRidyl+CC
         Ur+lWr/7f1oTmyMYLuILyv0N1f2FTmYncQm9Wnz1RJvXhsHKR9EW4QLoZZptBZlu3d
         jEbT1RfF2kS1g==
Date:   Thu, 20 Apr 2023 12:28:23 +0100
From:   Lee Jones <lee@kernel.org>
To:     Wadim Egorov <w.egorov@phytec.de>
Cc:     upstream@lists.phytec.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
        riku.voipio@iki.fi, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, pavel@ucw.cz
Subject: Re: [PATCH v3] dt-bindings: leds: Convert PCA9532 to dtschema
Message-ID: <20230420112823.GB970483@google.com>
References: <20230412140552.451527-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230412140552.451527-1-w.egorov@phytec.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023, Wadim Egorov wrote:

> Convert the PCA9532 LED Dimmer to dtschema.
> While at it, update the example to match recommended node names and
> the link to the product datasheet. Also add GPIO properties since
> the driver allows to use unused pins as GPIOs.
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
> v3:
>   - Add gpio-controller & gpio-cells property, fixes
>     arch/arm/boot/dts/lpc3250-ea3250.dtb: pca9532@60: '#gpio-cells', 'gpio-controller'
>     do not match any of the regexes: '^led-[0-9a-z]+$', 'pinctrl-[0-9]+'
> 
> v2:
>   - Rename yaml file to match compatibles, nxp,pca953x.yaml
>   - Remove Jacek Anaszewski from maintainers list
>   - Remove color labels in example
>   - Restore labels/default-states from original example
>   - Drop reg description
>   - Add unevaluatedProperties to patternProperties scope
>   - Update description of type property & set default to 0
>   - Fix indentation in example
> ---
>  .../devicetree/bindings/leds/leds-pca9532.txt | 49 ----------
>  .../devicetree/bindings/leds/nxp,pca953x.yaml | 90 +++++++++++++++++++
>  2 files changed, 90 insertions(+), 49 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/leds/leds-pca9532.txt
>  create mode 100644 Documentation/devicetree/bindings/leds/nxp,pca953x.yaml

Applied, thanks

-- 
Lee Jones [李琼斯]
