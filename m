Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBFA6DC725
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 15:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjDJNKr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Apr 2023 09:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjDJNKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 09:10:44 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F1E2D49;
        Mon, 10 Apr 2023 06:10:38 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 2ADE524E20A;
        Mon, 10 Apr 2023 21:10:30 +0800 (CST)
Received: from EXMBX167.cuchost.com (172.16.6.77) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 10 Apr
 2023 21:10:30 +0800
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX167.cuchost.com
 (172.16.6.77) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 10 Apr
 2023 21:10:29 +0800
Received: from EXMBX168.cuchost.com ([fe80::3c2d:dee5:4938:3fc4]) by
 EXMBX168.cuchost.com ([fe80::3c2d:dee5:4938:3fc4%16]) with mapi id
 15.00.1497.044; Mon, 10 Apr 2023 21:10:29 +0800
From:   JiaJie Ho <jiajie.ho@starfivetech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH v4 4/4] crypto: starfive - Add hash and HMAC support
Thread-Topic: [PATCH v4 4/4] crypto: starfive - Add hash and HMAC support
Thread-Index: AQHZa3+jdYvISdTjqUmPzN0mADxyja8jpS2AgACU6YD//5HogIAAsqtQ
Date:   Mon, 10 Apr 2023 13:10:29 +0000
Message-ID: <c1925af208b540c2bd78a16bc593ecae@EXMBX168.cuchost.com>
References: <20230410073752.39506-1-jiajie.ho@starfivetech.com>
 <20230410073752.39506-5-jiajie.ho@starfivetech.com>
 <ZDO/z++4/TE6AiIz@gondor.apana.org.au>
 <6df549e9-d0f6-23ca-882f-527c4e40b553@starfivetech.com>
 <ZDPgXyGZtMZw5G4q@gondor.apana.org.au>
In-Reply-To: <ZDPgXyGZtMZw5G4q@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [161.142.156.149]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH v4 4/4] crypto: starfive - Add hash and HMAC support
> 
> On Mon, Apr 10, 2023 at 04:43:37PM +0800, Jia Jie Ho wrote:
> >
> > The hardware requires user to set a 'final' bit after data transfer completed.
> > This completion is to wait for the interrupt signal from device that
> > the final digest has been populated to the read registers.
> >
> > I'll do the finalize_request call directly in the next version.
> 
> Instead of the IRQ performing a completion, it could instead schedule a tasklet
> and do the callback directly from the tasklet.
> 
> Actually, the ordering between the IRQ and DMA callback is a bit confusing.
> Which one is supposed to occur first and how does it interact with the other
> event?
> 

The sequence of event would be:
1. Wait for DMA transfer to complete.
2. Set bit in device CSR to indicate final block has been transferred.
3. Device will send IRQ once result is ready.
4. Read out final digest value from device.

Thanks,
Jia Jie
