Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0551B6EE767
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbjDYSLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjDYSLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:11:30 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298B016188;
        Tue, 25 Apr 2023 11:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=U2T+3q+meoJ1RyFUzTpHWdzOes64G2J8fo+n1ACnzfg=; b=YNnQpd2IZ5c1OxuBS050AUlVQx
        giWmA7A2zBpEj+iEP29GoSKMHucg0iut4a3F4hXIYG1m/F38rjOcmslgdKITcbV+6P4pOd1OBTuOr
        B+muuG3UaHemTQSZTz4j4dQUDif//LB+PYeKga6R6H5ofPOwXhd7MZcPWjq7hroCeAR6gcnIIe9lk
        ruqEZtsDnTSYr6IUo5DKACoH1EXjy+d6+NqtfrGld/AAP5iZKClK93y2zdlTCzvTguuDhEe4cs/+9
        vLq2gorD9pq7jM4xMDRA3j1TccNY44i5+DwGRxcl/u4XIlOIV97eeO8K8M/uVDetd4bUvVMepEk6n
        0XJtLXhQ==;
Received: from p200300ccff17ff001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff17:ff00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1prN8I-0005Sf-Qi; Tue, 25 Apr 2023 20:11:19 +0200
Date:   Tue, 25 Apr 2023 20:11:17 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org
Subject: Re: [BISECTED REGRESSION] OMAP1 GPIO breakage
Message-ID: <20230425201117.457f224c@aktux>
In-Reply-To: <20230425173241.GF444508@darkstar.musicnaut.iki.fi>
References: <20230425173241.GF444508@darkstar.musicnaut.iki.fi>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.24; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 25 Apr 2023 20:32:41 +0300
Aaro Koskinen <aaro.koskinen@iki.fi> wrote:

> Hi,
> 
> It seems GPIOs on OMAP1 boards are somewhat broken after:
> 
> commit 92bf78b33b0b463b00c6b0203b49aea845daecc8
> Author: Andreas Kemnade <andreas@kemnade.info>
> Date:   Fri Jan 13 21:59:22 2023 +0100
> 
>     gpio: omap: use dynamic allocation of base
> 
> E.g. on OSK1 the ethernet IRQ cannot (omap_gpio.0) no longer be requested:
> 
> [    0.277252] Error requesting gpio 0 for smc91x irq
> 
> Also the tps65010 (still using static allocation) will now conflict:
> 
> [    0.400726] gpio gpiochip5: Static allocation of GPIO base is deprecated, use dynamic allocation.
> [    0.400848] gpio gpiochip5: (tps65010): GPIO integer space overlap, cannot add chip
> [    0.400970] gpiochip_add_data_with_key: GPIOs 208..214 (tps65010) failed to register, -16
> [    0.401092] tps65010 i2c-tps65010: can't add gpiochip, err -16
> 
> I think this change should be reverted until the board files and other
> gpiochips are fixed accordingly.
> 
well, then just fix that tps65010 thing. 

that change is itself a regression fix for exactly the same kind of error.
twl4030 gpio registration conflicts with omap gpio registration.
Probably in former times, the dynamic allocation always started at 512, 
so no conflicts between static and dynamic.

So I see two options: either fix the remaining static allocation
or fix allocation so there are no overlaps between static and dynamic.

Regards,
Andreas
