Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF76631EFA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiKULDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiKULC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:02:58 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09568C0F;
        Mon, 21 Nov 2022 03:02:54 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 793BB230D;
        Mon, 21 Nov 2022 12:02:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1669028572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hYQCfElNVQ+lJjNKVWhRYCzN7ZoFtPC5hBsy0r/wg3k=;
        b=KsB2e5VCFsJFnCOxgaRSw//7fihm9d64czDVlYPuBtEsPEyl/PDqwx2h6NThLC3/8PsWLW
        GcxMoG303NMwqiNHnRL7tUcp1odc2wuAr7RVQRXF7JuJMAtGD7XSS4iOSLyJMaQxKYC9+C
        UYmr8r7Y3l/t9uK7HAeWDixO8tTAHaBGe70qweuLVIE7+WaTaoGoJn3Ei9uqX3TDOecZzd
        i8xb4XYEdJlCoNREbB/SMi0J4wXfmwO2v2B7ysF5qSezdnvIE1WKdlyYpIYW8mJ6/rixEL
        Bnk2kVx5dCNfFMtfFpJVraAVG1y6dVpfCZtdQChQqinnYYhWIF2v2WOzm6Y2Bg==
MIME-Version: 1.0
Date:   Mon, 21 Nov 2022 12:02:52 +0100
From:   Michael Walle <michael@walle.cc>
To:     =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: Re: [PATCH dt-schema.git] schemas: add NVMEM cell with
 #nvmem-cell-cells
In-Reply-To: <20221121105830.7411-1-zajec5@gmail.com>
References: <20221121105830.7411-1-zajec5@gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <0a207dda53cd04b40c80fc5950a7d067@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-11-21 11:58, schrieb Rafał Miłecki:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Some NVMEM cells may provide more than 1 value. An example can be base
> MAC address that is used for calculating multiple MACs (for few
> different devices). For specifying value to read phandle needs to be
> used with an argument.
> 
> Cc: Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>
> Cc: Michael Walle <michael@walle.cc>
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> This bit is required for moving forward with the
> [PATCH v2 00/20] nvmem: core: introduce NVMEM layouts
> https://lore.kernel.org/linux-arm-kernel/20220901221857.2600340-1-michael@walle.cc/
> 
> As pointed out by Rob #nvmem-cell-cells should be added to the 
> dt-schema
> and not a Linux binding:
> Re: [PATCH v2 15/20] dt-bindings: nvmem: add YAML schema for the sl28 
> vpd layout
> https://lore.kernel.org/linux-arm-kernel/20220912192038.GA1661550-robh@kernel.org/
> 
> sl28 is one example that needs #nvmem-cell-cells
> u-boot,env is another one
> 
> Please let me know if I got this binding right at all.

There is also a pull request:
https://github.com/devicetree-org/dt-schema/pull/89

I'm not sure about the correct way to submit patches to dtschema.

-michael

