Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CE16D7F1F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238562AbjDEOTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238509AbjDEOSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:18:34 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3067A59D6;
        Wed,  5 Apr 2023 07:18:02 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l27so36391948wrb.2;
        Wed, 05 Apr 2023 07:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680704276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qTSurywyiFi8YJ1Mq+URH6Inry7VQ8qeInnb5aX3H8=;
        b=kwq8npzjgNar3wa8bPxkoQH5Tcoj3rquzHsEXc9qX7MNE712UR8GVYpCZCuBdmN/7O
         Tesu2Wdqs9NaZp5dfj9orjc0PrDdhZMwZPgE5YhA1LfQIEhxkgHi4Pjbd7F/VzAaUJ82
         iciLCG8NeJlHNgd6tCxLXGwWVqlMxsTFBRedizxxZUv6QFOpa5nayh53DP9mC/evpusP
         sIOQq/l/WuSOFPhW80jS3nNJdE+sYOaQYXTG/YWfOZpfmnABbAnXriGSCNapv+apTOZ9
         0RcMQScZo6bFhg5O4D50o66Fn2DFG1ErpqGPwnOHpIfCytwu3mksWimXwXC40+jZ8LN7
         6MUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680704276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qTSurywyiFi8YJ1Mq+URH6Inry7VQ8qeInnb5aX3H8=;
        b=IBjzINx7dldIJ8rp7vleiIHvL8ql8HVqPw3dtxxUSMyd+Aj+cc8slNVy0GWpAQzkfC
         vy1T5M5UjaSMbK+AT7Et68XPGL2LjVE3qcg9B2dGG68iS0XBg3exkdEJCQ9PjcWkEBJI
         n4iOYMaoXL9AgMozHx2Ltlh4E5Cca+tBlvCXlZ/TtmbxHnIq4IAQf6z6ek8w6yduYKv0
         HQEBzMKuDMjmsUOXl+WfGO3AnFzicPKHTaVRJF6rGgyFxCQJv91K5acsvxY6gF/R/B9p
         1ReMhD5VG1QWjI97RilMP+sNQrJStUp+bdWSvzmGZI4MwDu3a80W3QBMdiC8XrmNRf1f
         D1nw==
X-Gm-Message-State: AAQBX9cDDXy1mlJElPxXABidjIpTR2J11Fas+Tf4oph+HTcUO444gl0G
        vrwLRajKza2L5JOtZQr/FQ0=
X-Google-Smtp-Source: AKy350bHGfe0sUG0mZh0J5q2qp9rZhMeNPEJUOccPaQhxv4yWAHEJgMYZuCJTo9mORajhnN8znp3OQ==
X-Received: by 2002:adf:f492:0:b0:2ce:a7df:c115 with SMTP id l18-20020adff492000000b002cea7dfc115mr4167077wro.41.1680704275852;
        Wed, 05 Apr 2023 07:17:55 -0700 (PDT)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id k4-20020a5d4284000000b002cefcac0c62sm15300877wrq.9.2023.04.05.07.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 07:17:55 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: iio: dac: add mcp4822
Date:   Wed, 05 Apr 2023 16:17:54 +0200
Message-ID: <4357039.nDxAD4yF8u@archbook>
In-Reply-To: <748c4391-1c8c-8fc2-cef9-6091512c77ef@linaro.org>
References: <20230405140114.99011-1-frattaroli.nicolas@gmail.com>
 <20230405140114.99011-4-frattaroli.nicolas@gmail.com>
 <748c4391-1c8c-8fc2-cef9-6091512c77ef@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mittwoch, 5. April 2023 16:10:10 CEST Krzysztof Kozlowski wrote:
> On 05/04/2023 16:01, Nicolas Frattaroli wrote:
> > The MCP4801, MCP4802, MCP4811, MCP4812, MCP4821, and MCP4822 are
> > SPI digital-to-analog converters by Microchip, which have an
> > internal voltage reference, in contrast to the MCP49xx series
> > of DACs which use an external voltage reference.
> > 
> > Thus, these need a separate binding, as to not overcomplicate
> > the mcp4922 binding.
> 
> The difference is just one property which is very easy to handle - one
> allOf:if:then: with
>     vref-supply: false
> 
> Are there any other differences?
> 
> Best regards,
> Krzysztof
> 
> 

In place of the external vref input, the MCP48XX series chips also
have a "SHDN" input, which is an active-low pin to disable the whole
chip and put it in a low power state. Future users of the bindings
may want to model this as being tied to some GPIO, though I haven't
done it here since I don't care about this feature.

Kind regards,
Nicolas Frattaroli


