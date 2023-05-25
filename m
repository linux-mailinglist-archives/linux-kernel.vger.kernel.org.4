Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7E77117A2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjEYTuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 15:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbjEYTuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 15:50:03 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E35095;
        Thu, 25 May 2023 12:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=BXuAUuI6O9SQYBQZ05xd3Kxteg3sg/LRhBLPYI5uuRc=; b=s4C/WmJFFzQ1IE4A4s1NkfIrRO
        tvMFii1XJtYo/bbpGG5hq//WvomUow58EWxLQi2CvvMyw282dRq3jdiBLub03ExRgmC3EQGH8B0FZ
        qIZV3Iz+/5QaQ1TkiTVxvOs8xzoNp8aWhaG0VOtCNYC5+I/HBfDkqtI7exkmV0q3Asy8=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:54570 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q2Gy2-0003K6-Pr; Thu, 25 May 2023 15:49:47 -0400
Date:   Thu, 25 May 2023 15:49:46 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     andy.shevchenko@gmail.com
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20230525154946.98829ff5bda64d7c723ed6ff@hugovil.com>
In-Reply-To: <ZG9F8xsPqs2ZWfED@surfacebook>
References: <20230525040324.3773741-1-hugo@hugovil.com>
        <20230525040324.3773741-12-hugo@hugovil.com>
        <ZG9F8xsPqs2ZWfED@surfacebook>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH v3 11/11] serial: sc16is7xx: add dump registers function
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2023 14:26:43 +0300
andy.shevchenko@gmail.com wrote:

> Thu, May 25, 2023 at 12:03:25AM -0400, Hugo Villeneuve kirjoitti:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > With this driver, it is very hard to debug the registers using
> > the /sys/kernel/debug/regmap interface.
> > 
> > The main reason is that bits 0 and 1 of the register address
> > correspond to the channels bits, so the register address itself starts
> > at bit 2, so we must 'mentally' shift each register address by 2 bits
> > to get its offset.
> > 
> > Also, only channels 0 and 1 are supported, so combinations of bits
> > 0 and 1 being 10b and 11b are invalid, and the display of these
> > registers is useless.
> > 
> > For example:
> > 
> > cat /sys/kernel/debug/regmap/spi0.0/registers
> > 04: 10 -> Port 0, register offset 1
> > 05: 10 -> Port 1, register offset 1
> > 06: 00 -> Port 2, register offset 1 -> invalid
> > 07: 00 -> port 3, register offset 1 -> invalid
> > ...
> > 
> > Add a debug module parameter to call a custom dump function for each
> > port registers after the probe phase to help debug.
> 
> Not sure about this. Can we rather create an abstract mapping on regmap?
> (Something like gpio-pca953x.c has)

Hi,
maybe we can, but more like they do in the driver max310x.c (single, dual and quad UART versions).

I will look into it, but it will probably be a patch that affects a lot of the code, and that I would like to submit separately after this serie, and so I will probably simply drop this current patch (11/11) since it will not be needed anymore.

Hugo.
