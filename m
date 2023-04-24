Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578F86ED2AE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 18:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjDXQkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 12:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjDXQkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 12:40:07 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4890D10DC;
        Mon, 24 Apr 2023 09:40:04 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 990551C0006;
        Mon, 24 Apr 2023 16:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1682354402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/r3V8RmeImnn9TTfMoyTcjasYYbylRv5Cz5piTNtYoU=;
        b=IpEu5BJcHvI8rhjTXabnQVVlOZvbdMlpeG+t1l5rAcz1fAp5/PkJqiCUEPkyCtoAwFFsoL
        bIM+GYg35xPtltbH+2RXermV2FbDZ9OsYwQQxnJbrVbBFzh5b5CYMxOtE1faSvVXu7iN+a
        gJw848Dh5K0Rn4I0Eu2OK/6WmDXtC0hU64uJAcpcnFD6ZxPi1OOhecF/0/5qgsteuUgIc+
        3itSuX+FQxOLRuddmC0TUleCvC4kY1QzLBRtyXwUtxzSUg40f/veEM5uFfe2+EFIQxW15r
        b3eLu/HNxqcDArv0gx3QEZIfsmMKilmIbhghBsilP7IgOBIfpBPy/CSJLFbjug==
Date:   Mon, 24 Apr 2023 18:40:00 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 28/43] dt-bindings: rtc: Add DT binding m48t86 rtc
Message-ID: <2023042416400019687ab8@mail.local>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230424123522.18302-29-nikita.shubin@maquefel.me>
 <20230424162548.GI2701399-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424162548.GI2701399-robh@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2023 11:25:48-0500, Rob Herring wrote:
> On Mon, Apr 24, 2023 at 03:34:44PM +0300, Nikita Shubin wrote:
> > Add YAML bindings for ST M48T86 / Dallas DS12887 RTC.
> > 
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > ---
> >  .../bindings/rtc/dallas,rtc-m48t86.yaml       | 33 +++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/rtc/dallas,rtc-m48t86.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/dallas,rtc-m48t86.yaml b/Documentation/devicetree/bindings/rtc/dallas,rtc-m48t86.yaml
> > new file mode 100644
> > index 000000000000..51f98bdbc385
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/dallas,rtc-m48t86.yaml
> > @@ -0,0 +1,33 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/rtc/dallas,rtc-m48t86.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ST M48T86 / Dallas DS12887 RTC bindings
> > +
> > +maintainers:
> > +  - Alessandro Zummo <a.zummo@towertech.it>
> > +
> > +properties:
> > +  compatible:
> > +    const: dallas,rtc-m48t86
> 
> 'rtc-' is redundant. And haven't you mixed up the vendor and part 
> number? It should be dallas,ds12887 and/or st,m48t86?
> 
> This can probably go in the trivial rtc binding.
> 

I was wonderign, is this trivial, even with two regs?

> > +
> > +  reg:
> > +    maxItems: 2
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    rtc1: rtc@10800000 {
> 
> Drop unused labels.
> 
> > +        compatible = "dallas,rtc-m48t86";
> > +        reg = <0x10800000 0x1>, <0x11700000 0x1>;
> > +    };
> > +
> > +...
> > +
> > -- 
> > 2.39.2
> > 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
