Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272E472AB8A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 14:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjFJMwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 08:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjFJMw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 08:52:27 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2E83A9E;
        Sat, 10 Jun 2023 05:52:27 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-55afa2472d9so1778495eaf.0;
        Sat, 10 Jun 2023 05:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686401546; x=1688993546;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypunSIKUqzh75YIeQaRkHjhmNZ/hwFhCbdx6FqXAu9o=;
        b=g45/G3xC9sH2xNWZ6p7/51PCGM+7NosvtHN4VJoiDJxnTel/9M5KBWRJXTrbVFGxk8
         u5MXFHO/yBVREKnKTeZSFVBJnairzfK8l1912tF7jCrey4fPFI64Pjn5A4IXCo51t7un
         rlMZ3BK6wD3AMoJWg0v7rJaPx2kNXTrUOrvjya6R6McblHu89Sl/Hj1xbcOe6qhCHage
         2c72hl7T8Zq8yX5rzilD+b0AupIowbIqRpCuUTckO2QE+qpWcYWRo4zpPxtk52Cc/TXM
         Wdvjj+/rVzXDwDEXINf80szdTpuCkkzXTjacnVTfc3RUieDfTEpJ+RG928/jsC3D3q25
         2rAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686401546; x=1688993546;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ypunSIKUqzh75YIeQaRkHjhmNZ/hwFhCbdx6FqXAu9o=;
        b=CJswm5iSn1cQzY8ZEnyI9FesRGdKQtjqkCs32oDr9xHmFJ265bBCC0NEUebVHTmcw7
         7eQeivaoO78WrAkJ/JVayeYcjGTpu1FkL+v3vn9Mk8oSiawNUTEK0LZpNjZ1/8muhrSY
         kn8ih6CH2nY8etdczJA1XQ2CWhsjqD/ef7Ce2yhw1XqWGcvJ2wrZI3dNSqFXMnxFqEmq
         YXeRyIyhDc+euy8F6qqYX7MfdJ7yVPqFPBePOpoyaj73z9ihfXtj+lBGXiU39/ar/hWs
         WXJZ/F1YBkVs/m2pYhRoGNEmQzYXcOuvfmMMJQIgGO8TddnUB+mwjmpd5r50fUMIG6z5
         l0VQ==
X-Gm-Message-State: AC+VfDxx6bt/Qpil7W8Pd03THMLbRkMmYg+JCSEb1HyvG+QYVcHd96T0
        cLRKxYvrD64S7TnmxDAARg==
X-Google-Smtp-Source: ACHHUZ5tZl6zQi3tZ3ZIyb80b0WEZFIQ3IM8ZhCNGZxrKoZC2y3OSR1/MtXGpq4cjDjk0GM+k+2xPQ==
X-Received: by 2002:a4a:e7c1:0:b0:546:dd51:f74f with SMTP id y1-20020a4ae7c1000000b00546dd51f74fmr2296073oov.4.1686401546227;
        Sat, 10 Jun 2023 05:52:26 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id v4-20020a4aa504000000b00552acb7c89dsm1652130ook.21.2023.06.10.05.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 05:52:25 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:8f19:4a52:beef:59ed])
        by serve.minyard.net (Postfix) with ESMTPSA id 76BDB1800BA;
        Sat, 10 Jun 2023 12:52:24 +0000 (UTC)
Date:   Sat, 10 Jun 2023 07:52:23 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        openipmi-developer@lists.sourceforge.net,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: ipmi: aspeed,ast2400-kcs-bmc: drop unneeded
 quotes
Message-ID: <ZIRyB531ttuE1SUI@mail.minyard.net>
Reply-To: minyard@acm.org
References: <20230609140729.64799-1-krzysztof.kozlowski@linaro.org>
 <778e2930-1678-45bb-a01e-21bf321fb6d8@betaapp.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <778e2930-1678-45bb-a01e-21bf321fb6d8@betaapp.fastmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2023 at 08:49:27AM +0930, Andrew Jeffery wrote:
> 
> 
> On Fri, 9 Jun 2023, at 23:37, Krzysztof Kozlowski wrote:
> > Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> > checking for this can be enabled in yamllint.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Acked-by: Andrew Jeffery <andrew@aj.id.au>

This is in my next tree.  Thank you.

-corey

> 
> > ---
> >  .../devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml  | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git 
> > a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml 
> > b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
> > index 4ff6fabfcb30..129e32c4c774 100644
> > --- a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
> > +++ b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
> > @@ -41,7 +41,7 @@ properties:
> >        - description: STR register
> > 
> >    aspeed,lpc-io-reg:
> > -    $ref: '/schemas/types.yaml#/definitions/uint32-array'
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> >      minItems: 1
> >      maxItems: 2
> >      description: |
> > @@ -50,7 +50,7 @@ properties:
> >        status address may be optionally provided.
> > 
> >    aspeed,lpc-interrupts:
> > -    $ref: "/schemas/types.yaml#/definitions/uint32-array"
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> >      minItems: 2
> >      maxItems: 2
> >      description: |
> > @@ -63,12 +63,12 @@ properties:
> > 
> >    kcs_chan:
> >      deprecated: true
> > -    $ref: '/schemas/types.yaml#/definitions/uint32'
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> >      description: The LPC channel number in the controller
> > 
> >    kcs_addr:
> >      deprecated: true
> > -    $ref: '/schemas/types.yaml#/definitions/uint32'
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> >      description: The host CPU IO map address
> > 
> >  required:
> > -- 
> > 2.34.1
