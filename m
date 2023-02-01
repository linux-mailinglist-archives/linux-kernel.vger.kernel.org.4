Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A7B6861FA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 09:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjBAIss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 03:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjBAIsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 03:48:40 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7E41ADC9;
        Wed,  1 Feb 2023 00:48:30 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id CCDF1126A;
        Wed,  1 Feb 2023 09:48:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1675241308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5LVbd7jMGTqPofcbHc2TSxV+zHK32m9KszR9jNPn+f0=;
        b=IEe4l47u14uRCeFaJXl+EM8cQsUA0cu2Vny9UkvZ+jDGbBPGKzpJ5NOLJa8ellGSkAryB4
        +XF1PYzyYHMc6V19ZfNi4sMaDV9NDoIDDfKLEjgU0nf+yiqkMrF2BKQkX91jXa4B1HH0sh
        TXMwXVB/exdMbD0TEjqC6cNbzU9V1hI4w1y/jd169DsfglVKU7sZDlCY45bxm5eeC6ZteV
        QY9dZEulLjmLZlIHcF3ta/6m7etnjvSvBSusnbWJYBfIIbFrE5ZV7Vb3a9aHRWTOmxV924
        R3rtB9tUIY9RioDFMGqEs+0MKeYXGX9Qh+RE4u46lK4Cd2caU0AKkSRfORKA1Q==
From:   Michael Walle <michael@walle.cc>
To:     zajec5@gmail.com
Cc:     devicetree@vger.kernel.org, hayashi.kunihiko@socionext.com,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        mhiramat@kernel.org, rafal@milecki.pl, robh+dt@kernel.org,
        srinivas.kandagatla@linaro.org, Michael Walle <michael@walle.cc>
Subject: Re: [PATCH 3/4] nvmem: mtk-efuse: replace driver with a generic MMIO one
Date:   Wed,  1 Feb 2023 09:48:21 +0100
Message-Id: <20230201084821.1719839-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230201064717.18410-4-zajec5@gmail.com>
References: <20230201064717.18410-4-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Mediatek EFUSE uses a simple MMIO that can be handled with a generic
> driver. Replace this driver to avoid code duplication.

I don't think this is the correct approach. You'll restrict that driver
to being read-only. I admit that right now, it's read only, but it can
be extended to also support efuse writing. With this changes, it's not
possible.

> static const struct of_device_id mmio_nvmem_of_match_table[] = {
> 	{ .compatible = "mmio-nvmem", },
>+	/* Custom bindings that were introduced before the mmio one */
>+	{ .compatible = "mediatek,mt8173-efuse", },
>+	{ .compatible = "mediatek,efuse", },

Why do you assume that all mediatek efuses will be the same? This should
rather be something like (in the dts/binding):

compatible = "mediatek,mt8173-efuse", "mmio-nvmem";

So if there is no driver for the particular efuse, it will fall back to the
generic one.

-michael
