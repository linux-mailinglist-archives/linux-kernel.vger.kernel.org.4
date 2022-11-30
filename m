Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C05363DE4B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiK3Sfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiK3Sf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:35:29 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2742793A48;
        Wed, 30 Nov 2022 10:35:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 71326CE1AD7;
        Wed, 30 Nov 2022 18:35:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D66C433D7;
        Wed, 30 Nov 2022 18:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669833324;
        bh=m9ZbOfSOhqrV9QbDkO0wnkpV571DI07sybMViITSyfA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IIzaMYtxRDjt6r5k1t1vOIEvc1oWyXA2ZqG9SdSqoF9X65WLxO/euqmX2ZRJvxWee
         IdwL0374yXGXYH7bU8Bn806VTOSG/Lm6w6FMITSa/xJZCM+EGtjDyM3OZHg7j16Ea2
         RyE+q+P7qmQ0NWp6zWrCiRz3DFfkV5MzZeaV0K+J367lrXFwW/44ZBu2UOM6RR4zx9
         KeGnVS67fVMe9b9p8GOUpKT2iZk7xhfcQHh907w5lclBeZoW+/4Q7Yk4r1rzM6k96F
         OIE/msMLmRpgSsjgiH+HjS8Ia85l+ZtRxOhlCv3AnZ6U/Kf+OMKGtH3O1aMU/m1J9I
         vC+Gm+8ahSIKA==
Date:   Wed, 30 Nov 2022 18:35:19 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Guo Ren <guoren@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: riscv: fix underscore requirement
 for addtional standard extensions
Message-ID: <Y4eiZ1AS+///9svR@spud>
References: <20221130180422.1642652-1-conor@kernel.org>
 <20221130180422.1642652-2-conor@kernel.org>
 <E52B0E0B-F27B-43C8-85DA-4C7AC0C52369@jrtc27.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E52B0E0B-F27B-43C8-85DA-4C7AC0C52369@jrtc27.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 06:29:18PM +0000, Jessica Clarke wrote:
> On 30 Nov 2022, at 18:04, Conor Dooley <conor@kernel.org> wrote:
> > 
> > From: Conor Dooley <conor.dooley@microchip.com>
> > 
> > The RISC-V ISA Manual allows for the first Additional Standard
> > Extension having no leading underscore. Only if there are multiple
> > Additional Standard Extensions is it needed to have an underscore.
> > 
> > The dt-binding does not validate that a multi-letter extension is
> > canonically ordered, as that'd need an even worse regex than is here,
> > but it should not fail validation for valid ISA strings.
> > 
> > Allow the first Z multi-letter extension to appear immediately prior
> > after the single-letter extensions.
> > 
> > Link: https://github.com/riscv/riscv-isa-manual/releases/tag/riscv-unpriv-pdf-from-asciidoc-15112022 # Chapter 29.5
> > Fixes: 299824e68bd0 ("dt-bindings: riscv: add new riscv,isa strings for emulators")
> > Acked-by: Guo Ren <guoren@kernel.org>
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> > Documentation/devicetree/bindings/riscv/cpus.yaml | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > index 90a7cabf58fe..e80c967a4fa4 100644
> > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > @@ -80,7 +80,7 @@ properties:
> >       insensitive, letters in the riscv,isa string must be all
> >       lowercase to simplify parsing.
> >     $ref: "/schemas/types.yaml#/definitions/string"
> > -    pattern: ^rv(?:64|32)imaf?d?q?c?b?v?k?h?(?:_[hsxz](?:[a-z])+)*$
> > +    pattern: ^rv(?:64|32)imaf?d?q?c?b?v?k?h?(?:z(?:[a-z])+)?(?:_[hsxz](?:[a-z])+)*$
> 
> Isn’t it any multi-letter extension, i.e, this should be [hsxz] again?
> 
> It certainly used to be at least; we use rv64gcxcheri...

<quote>
Non-standard extensions must be listed after all standard extensions.
They must be separated from other multi-letter extensions
by an underscore
<\quote>

Nope, you're right. I realised that the other day with the non-binding
series that was a response to v1. I had that itching feeling that I had
forgotten to do something when I was writing my changelog but could not
remember what...

Thanks Jess!

