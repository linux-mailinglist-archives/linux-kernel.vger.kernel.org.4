Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326A16E9038
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbjDTK3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbjDTK3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:29:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799D75581;
        Thu, 20 Apr 2023 03:27:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 103C66131A;
        Thu, 20 Apr 2023 10:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87138C433EF;
        Thu, 20 Apr 2023 10:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681986428;
        bh=QDYCFRnWH/Js9cZOwtaV9JCmqosAqmE5uYC3yyCCcc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UxRUuUxn+AbkEVvPQ8poUQ/HGoTo4+OTMh/WJNPZtI8kJofNIZCU8QSVxVMRMRVxx
         vKgcA0fa+zy7ffzRRFBUwXE9z7RIZpJns5cEVdModUjZXxbFqR+rR/mF60YaNZBEVs
         UOCrj1h4G/GQeWjqKAVzkmMfwlvuvt/gu5tEFCmsFNqXfPLk29pKvGPlrcr1484K77
         jiHWCUZwpgZGm2qQQjl87v8QvvBlkypm+V4B4lgpVvBsrP+91gcgQYJsJB1cLiYbk6
         DNymI0nLa4W+N+P/phNIHwcT5EwDaJVqFeMbwOug1VA6jJKUCC/gwixZyFI8BTbJ3W
         IMb14VRpbmnYw==
Date:   Thu, 20 Apr 2023 11:27:03 +0100
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Maarten Zanders <maarten.zanders@mind.be>,
        Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v7 1/2] dt-bindings: leds-lp55xx: add ti,charge-pump-mode
Message-ID: <20230420102703.GH9904@google.com>
References: <20230407102324.42604-1-maarten.zanders@mind.be>
 <20230407102324.42604-2-maarten.zanders@mind.be>
 <20230411132204.GA2918042-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230411132204.GA2918042-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023, Rob Herring wrote:

> On Fri, Apr 07, 2023 at 12:23:23PM +0200, Maarten Zanders wrote:
> > Add a binding to configure the internal charge pump for lp55xx.
> > 
> > Signed-off-by: Maarten Zanders <maarten.zanders@mind.be>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> > 
> > Notes:
> >     v1: implement as bool to disable charge pump
> >     v2: rewrite to use string configuration, supporting all modes
> >     v3: simplification by replacing string option by u8 constant,
> >         removing previous Reviewed-by tags as it's a complete
> >         rewrite of the patch.
> >     v4: added notes
> >     v5: dual license, change property type to u32
> >     v6: change license type for leds-lp-55xx.h to preferred tag
> > 
> >  .../devicetree/bindings/leds/leds-lp55xx.yaml          |  8 ++++++++
> >  include/dt-bindings/leds/leds-lp55xx.h                 | 10 ++++++++++
> >  2 files changed, 18 insertions(+)
> >  create mode 100644 include/dt-bindings/leds/leds-lp55xx.h
> > 
> > diff --git a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
> > index ae607911f1db..ede9cb9ca175 100644
> > --- a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
> > +++ b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
> > @@ -66,6 +66,12 @@ properties:
> >    '#size-cells':
> >      const: 0
> >  
> > +  ti,charge-pump-mode:
> > +    description:
> > +      Set the operating mode of the internal charge pump as defined in
> > +      <dt-bindings/leds/leds-lp55xx.h>. Defaults to auto.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> Needs constraints:
> 
> default: 3  # Auto
> maximum: 3

Once this has been fixed, I'll apply both.

-- 
Lee Jones [李琼斯]
