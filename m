Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080C863A200
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 08:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiK1Hf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 02:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiK1Hf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 02:35:27 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8770E11C39;
        Sun, 27 Nov 2022 23:35:26 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 4B31AB8B;
        Mon, 28 Nov 2022 08:35:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1669620924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ocIpEc4oly3ThjoyxNnqhXwhEE8f24PzAQ3YyFZsq0E=;
        b=GG/4fi2urRgj9huQRUua/FNJIWwhv3B1hDN4Ym4/Dg6HVd2bYkzqO/bV7gKuN3+PeT7bzD
        r3alQ09y1EwPrSx+apphusNdMyd2h+dlr9wqj0NHi9Vkb/lJKkzvPbTKB78JSPAwhVF2UM
        n/u3HAOZHS8en0x58QdmAxdrqkg0ZbB2vPyzyQ0SRucTbVB25pXWPJKTxYQliQCDpc5chQ
        jvRMqnOgC7z2QHR+BNyrie2pSqjGPLMHvuAlIyg6rp9hbvmCcD/86K3HjBlaX+5b+Ns4ym
        A6ObmnZVdq5BdB31knwrJypx8FsXg0FSeXVYgMIqNGrRoHfmN4kBYIDSohKEjQ==
MIME-Version: 1.0
Date:   Mon, 28 Nov 2022 08:35:24 +0100
From:   Michael Walle <michael@walle.cc>
To:     =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, u-boot@lists.denx.de,
        =?UTF-8?Q?Rafa?= =?UTF-8?Q?=C5=82_Mi=C5=82ecki?= 
        <rafal@milecki.pl>
Subject: Re: [PATCH V2 1/2] nvmem: core: refactor .cell_post_process() CB
 arguments
In-Reply-To: <20221128065923.1180-1-zajec5@gmail.com>
References: <20221128065923.1180-1-zajec5@gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <f2bb569404903bc937fbe3840582f3c4@walle.cc>
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

Am 2022-11-28 07:59, schrieb Rafał Miłecki:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Pass whole NVMEM cell struct and length pointer as arguments to 
> callback
> functions.
> 
> This allows:
> 
> 1. Cells content to be modified based on more info
>    Some cells (identified by their names) contain specific data that
>    needs further processing. This can be e.g. MAC address stored in an
>    ASCII format. NVMEM consumers expect MAC to be read in a binary 
> form.
>    More complex cells may be additionally described in DT. This change
>    allows also accessing relevant DT nodes and reading extra info.
> 
> 2. Adjusting data length
>    If cell processing results in reformatting it, it's required to
>    adjust length. This again applies e.g. to the MAC format change from
>    ASCII to the byte-based.
> 
> Later on we may consider more cleanups & features like:
> 1. Dropping "const char *id" and just using NVMEM cell name
> 2. Adding extra argument for cells providing multiple values
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> This solution conflicts with 1 part of Michael's work:
> [PATCH v2 00/20] nvmem: core: introduce NVMEM layouts
> https://lore.kernel.org/linux-arm-kernel/20220901221857.2600340-1-michael@walle.cc/
> 
> Instead of:
> 1. Adding NVMEM cell-level post_process callback
> 2. Adding callback (.fixup_cell_info()) for setting callbacks
> 3. Dropping NVMEM device-level post_process callback
> I decided to refactor existing callback.
> 
> Michael's work on adding #nvmem-cell-cells should be possible to easily
> rebase on top of those changes.

As yours should be easily added on top of my series. I've showed that
providing a global post process hook is bad because that way you need
to have *all* cells of your device read-only.

-michael
