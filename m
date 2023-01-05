Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D2A65F5A8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 22:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235702AbjAEVWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 16:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235685AbjAEVWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 16:22:39 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91B663F78;
        Thu,  5 Jan 2023 13:22:38 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 158E74E;
        Thu,  5 Jan 2023 22:22:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1672953756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ox7VPyBj9rpPGH+NpgnW8hD2Q0z2tHsAencWwwhtRQI=;
        b=fJTN8EFsbxVxuPH4IewRqcLi3VDgvAY+j/X4sf1PMQIlo2+hYxqmd9HUictud5ook8iOXD
        FdDZuXwA+AK+7N3fbAE8CQJEb/QglQulJQl3gi3+zoxG0a2ysGecUE7Gg/+0Xag8S5ZHNj
        vkdo+bevhuxY0J+SY3Rq0HTOl7qjVoL0e7hfOVzOegApBvmJd8OYD5gUcNr+d1fWubyuwv
        XwveyFnTooaatYN9EAxDKuTc9F9Yeal3WJbC8OhHMkMqR/V56QDydgDj8OaKt0dnKo8SIi
        D6z+3G83s0ESgF1C45Y/mD4nZHNYBpNLX0MRj9mDvcdqDt2FSHYzTS7rTOk0Gw==
MIME-Version: 1.0
Date:   Thu, 05 Jan 2023 22:22:35 +0100
From:   Michael Walle <michael@walle.cc>
To:     =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, u-boot@lists.denx.de,
        =?UTF-8?Q?Rafa?= =?UTF-8?Q?=C5=82_Mi=C5=82ecki?= 
        <rafal@milecki.pl>
Subject: Re: [PATCH 2/3] nvmem: core: allow .read_post_process() callbacks to
 adjust data length
In-Reply-To: <20230105171038.13649-2-zajec5@gmail.com>
References: <20230105171038.13649-1-zajec5@gmail.com>
 <20230105171038.13649-2-zajec5@gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <d2fa8acafac0d10c4340128e81e1a765@walle.cc>
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

Hi,

Am 2023-01-05 18:10, schrieb Rafał Miłecki:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Sometimes reading NVMEM cell value involves some data reformatting. It
> requires passing updated size value to the caller. Support that.

Wouldn't it make more sense to convert that driver to
proper nvmem layouts, where
  (1) you get that for free,
  (2) support others storages than just mtd
  (3) don't duplicate the mtd read code

-michael
