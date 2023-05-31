Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758DF71876B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 18:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjEaQdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 12:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjEaQdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 12:33:05 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1394098;
        Wed, 31 May 2023 09:33:03 -0700 (PDT)
X-GND-Sasl: luca.ceresoli@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685550782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CuEjCfYrSXwpkGNWiwpt9RfeE5fAvVGA+wyh8qN+kyk=;
        b=CIkzXrTBevFhycdDTUYWl1lxs9WC4SxZMisyMnxKJOwtwChgHNHdQnW6OiLV0DlxtzCQlc
        8nvkEAEzHHpJxKnyXPEQTmiyfbjIXa04F2RoWRQKb3yWdIOk0bJ5k8ND73opRq0+eSRIDb
        AG/sQs1M7a/M+UWbjUHedVWNJCXF8u5VrsGHjv+micSoLQTQ4F3wuOwnIQ1eNQrr/XSpgf
        HEsjdmqaC/eaYqToLd/2J8gVOdL6ZnXM3m0wsW7iqmbgElHMyG+aDWikV46ewa4yA5M9wI
        V4lxNGNWuFN4WS5FXUWJQpjXQhUgrlqb0d8P0IHLFcdEaGHiP2LpHrLk7GYDSg==
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C81B220009;
        Wed, 31 May 2023 16:32:57 +0000 (UTC)
Date:   Wed, 31 May 2023 18:32:56 +0200
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     <mturquette@baylibre.com>, <sboyd@kernel.org>, <nm@ti.com>,
        <kristo@kernel.org>, <ssantosh@kernel.org>,
        <michal.simek@xilinx.com>, <aford173@gmail.com>,
        <mike.looijmans@topic.nl>, <robert.hancock@calian.com>,
        <shawn.guo@linaro.org>, <fabio.estevam@freescale.com>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>
Subject: Re: [PATCH 1/8] clk: vc5: check memory returned by kasprintf()
Message-ID: <20230531183256.48e1b893@booty>
In-Reply-To: <20230530093913.1656095-2-claudiu.beznea@microchip.com>
References: <20230530093913.1656095-1-claudiu.beznea@microchip.com>
        <20230530093913.1656095-2-claudiu.beznea@microchip.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

On Tue, 30 May 2023 12:39:06 +0300
Claudiu Beznea <claudiu.beznea@microchip.com> wrote:

> kasprintf() returns a pointer to dynamically allocated memory.
> Pointer could be NULL in case allocation fails. Check pointer validity.
> Identified with coccinelle (kmerr.cocci script).
> 
> Fixes: f491276a5168 ("clk: vc5: Allow Versaclock driver to support multiple instances")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

I think this driver would benefit a bit of refactoring, moving all
those similar sections to a single function.

But for the time being your change is fine:

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
