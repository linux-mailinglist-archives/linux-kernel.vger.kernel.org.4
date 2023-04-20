Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E9A6E8621
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 02:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjDTABf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 20:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjDTABc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 20:01:32 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F5F4ED0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 17:01:31 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-172-149.tukw.qwest.net [174.21.172.149])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 45069401;
        Wed, 19 Apr 2023 17:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1681948890;
        bh=pvBFZe6aNKnnGQpibVcXWzLk+OxdYqXD2UbQjrEDfp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TYoRseOyAvyZhFb31OMcQvY8dwZedJ8jh72GMdcktGH9E2hTE4/HArAa2eFhpl/C5
         1OQZcgcAu3YZOtj2jrkSV8ppwpSLRr+bXOYLCIEjuCTBrdrNcciZ3/B62dMADuhgjj
         uLMuorT0E/RvEp7gEOYMIzdRw9r8pRDxb6kPqpEc=
Date:   Wed, 19 Apr 2023 17:01:28 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: regulator: Add dt property
Message-ID: <0da2b301-8780-48c0-a5dc-326474011e8d@hatter.bewilderbeest.net>
References: <20230418145051.4192963-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230418145051.4192963-1-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 07:50:50AM PDT, Naresh Solanki wrote:
>Add DT property regulator-supplies.
>This enables us to couple one or more regulator output to gether. This
>is use in case of Single connector having 2 or more supplies.
>
>Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>---
> .../bindings/regulator/regulator-output.yaml         | 12 +++++++++---
> 1 file changed, 9 insertions(+), 3 deletions(-)
>
>diff --git a/Documentation/devicetree/bindings/regulator/regulator-output.yaml b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
>index 078b37a1a71a..17f683d3c1f3 100644
>--- a/Documentation/devicetree/bindings/regulator/regulator-output.yaml
>+++ b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
>@@ -21,13 +21,19 @@ properties:
>   compatible:
>     const: regulator-output
>
>-  vout-supply:
>+  regulator-supplies:
>     description:
>-      Phandle of the regulator supplying the output.
>+      Specifies the name of the output supply provided by the regulator.
>+      Defaults to "vout".
>+    default: "vout"
>+

Was this meant to be specified as a string-array to allow providing 
multiple names?

>+patternProperties:
>+  ".*-supply":
>+    description:
>+      Specified the phandle for various supplies
>
> required:
>   - compatible
>-  - vout-supply
>
> additionalProperties: false
>
>

I think it would be nice to also update the examples to show what a 
multi-supply instance would look like.

A slightly more descriptive subject line would also be good -- "Add dt 
property" is a bit vague.

>base-commit: c55470f8b0616b0adb758077dbae9b19c5aac005
>-- 
>2.39.1
>
