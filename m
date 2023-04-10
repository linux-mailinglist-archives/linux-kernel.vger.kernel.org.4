Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8556DC74A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 15:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjDJN34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 09:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDJN3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 09:29:55 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099B34C09;
        Mon, 10 Apr 2023 06:29:50 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1plra8-00EJyK-RY; Mon, 10 Apr 2023 21:29:17 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 10 Apr 2023 21:29:16 +0800
Date:   Mon, 10 Apr 2023 21:29:16 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     JiaJie Ho <jiajie.ho@starfivetech.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4 4/4] crypto: starfive - Add hash and HMAC support
Message-ID: <ZDQPLGG+DorFwZ+1@gondor.apana.org.au>
References: <20230410073752.39506-1-jiajie.ho@starfivetech.com>
 <20230410073752.39506-5-jiajie.ho@starfivetech.com>
 <ZDO/z++4/TE6AiIz@gondor.apana.org.au>
 <6df549e9-d0f6-23ca-882f-527c4e40b553@starfivetech.com>
 <ZDPgXyGZtMZw5G4q@gondor.apana.org.au>
 <c1925af208b540c2bd78a16bc593ecae@EXMBX168.cuchost.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1925af208b540c2bd78a16bc593ecae@EXMBX168.cuchost.com>
X-Spam-Status: No, score=4.3 required=5.0 tests=HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 01:10:29PM +0000, JiaJie Ho wrote:
>
> The sequence of event would be:
> 1. Wait for DMA transfer to complete.
> 2. Set bit in device CSR to indicate final block has been transferred.

OK, 2 should be done in the DMA callback function.

> 3. Device will send IRQ once result is ready.
> 4. Read out final digest value from device.

4 should be done from a tasklet scheduled from the IRQ handler.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
