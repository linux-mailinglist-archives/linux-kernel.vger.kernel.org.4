Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABE273E3C2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjFZPoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjFZPoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:44:22 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82230E73
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:44:21 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-991ef0b464cso94049066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1687794260; x=1690386260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YnGKBUnRl+54y+0sQxUUlidbsYRaM5LpOGTqtDz4nVQ=;
        b=M9Tsn1Tzu+mNEA7nnAsQvg1Z5/LByzdzlMl+RHI7ziSvtJYcASi+ZIUPA7nvKXKkGH
         FIjN2xZvgNpkBU+0ZO8LO7y8pkIx3Yw8fGBt5WsNZUdHaA8HcLZb5n5z75C6LpwLfFjE
         B2vM7feLwgFywkB8bkAdJ0gkOmTj2340k4jZbwzaECx4KVPOK+ZgAJpCcc7BHFVlgLk6
         WsZjFwFrLAN5YkAFYOwn/1A65rRXLkfNBubWeBrO/zqtbkd8tYAbwpqs7Ix4VOE9kyg+
         wjWzCNfopV0iZKN2ERVAp/aAr7pyDUr210MlLfHTPqtIylLYimoOOVyMjNDrXe1rLwY6
         KHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687794260; x=1690386260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnGKBUnRl+54y+0sQxUUlidbsYRaM5LpOGTqtDz4nVQ=;
        b=cDGUvranpw/s5A2bN7C3Dh1MPMKN23hD/iV3w/zKe9gDOsYmEN3rwvNcNWKfiZpzg/
         iMKoBbH6XHKN0MZAXkm2kNnqQFn+8bqY/VYgpQJfbXg+nPyBruNyAjgVOL0QKZkGBlvh
         7In8/YwfSi31uEm9oyso99tY/+wrRRuYOcRkzE55fPN3ZgI3EDLNEiB6+mUkS2dj4Y+f
         WJw9Rr3xvATRvC6Z/KtRzoB3Hq+3HeLE7UKBV1Wak53grQw0ziiRJRrFBxJSduc4WYWc
         9/T7XXVS+Ae51qSk8qi0ZTzb1/1xgGEoFXezYTFHq3gpIdQBiwcUmLmk49L0vZbSz97m
         N0Xg==
X-Gm-Message-State: AC+VfDzbQUOCETjhOe0BmM6lM93aBzNFi+1aEf3ntS9UWt1i+ihcIEGa
        cSLED0tuI0tHu0ho+ZMK8gWIyA==
X-Google-Smtp-Source: ACHHUZ7m80psrFn/+MZPNhekKTjOon7CjlWS/Mw7tUoEfScBbDLcEaFAESaC9Xf5szD4tRWaGLfGjw==
X-Received: by 2002:a17:906:ee8c:b0:988:8efc:54fa with SMTP id wt12-20020a170906ee8c00b009888efc54famr17250712ejb.37.1687794260001;
        Mon, 26 Jun 2023 08:44:20 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id pj4-20020a170906d78400b009885a03467csm3388573ejb.31.2023.06.26.08.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 08:44:19 -0700 (PDT)
Date:   Mon, 26 Jun 2023 17:44:18 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     palmer@dabbelt.com, conor@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Evan Green <evan@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/9] RISC-V: shunt isa_ext_arr to cpufeature.c
Message-ID: <20230626-2b8f42ace039368c8e917393@orel>
References: <20230626-provable-angrily-81760e8c3cc6@wendy>
 <20230626-endowment-crave-d72f9423c5b3@wendy>
 <20230626-79b06f642aa2996098c9353d@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626-79b06f642aa2996098c9353d@orel>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 05:29:04PM +0200, Andrew Jones wrote:
> On Mon, Jun 26, 2023 at 12:19:41PM +0100, Conor Dooley wrote:
...
> > +const struct riscv_isa_ext_data riscv_isa_ext[] = {
> > +	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
> > +	__RISCV_ISA_EXT_DATA(zicboz, RISCV_ISA_EXT_ZICBOZ),
> > +	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
> > +	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
> > +	__RISCV_ISA_EXT_DATA(zifencei, RISCV_ISA_EXT_ZIFENCEI),
> > +	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
> > +	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
> > +	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
> > +	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
> > +	__RISCV_ISA_EXT_DATA(zbs, RISCV_ISA_EXT_ZBS),
> > +	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
> > +	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
> > +	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> > +	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
> > +	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
> > +	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
> > +	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> > +	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
> 
> I think we can either drop this null entry or drop the count variable
> below. My preference would be to drop the count variable, and always
> loop to the null.

Eh, never mind, the entry isn't null, it's "". Why do we have that entry
though? I guess it can be dropped?

Thanks,
drew
