Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524086D59E5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbjDDHoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjDDHow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:44:52 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A727E57;
        Tue,  4 Apr 2023 00:44:50 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 79E5640002;
        Tue,  4 Apr 2023 07:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680594288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BYz2JgYiereU0Wk7c9RqlcSNQDMCeypHl3FQ4vU0Rfg=;
        b=hnatSd6ZQXMYxpRjRnCkBRfXnuPuselbfg287WSvQIvIOGA8lvVNsZC2ff2jpyOzs/EYwc
        L8qqitijje8at2kRpt0+7c8GQbBKTvKlLeJqUE/WCnwfft4JOiUsbTOes6wr6VLOmfLbyz
        WoJm8L89WP0NPCHtUSK73VavI09TnIcehI5IjQdKS9rNzoVDpyfjLUtPxMGrMD6cRHWnH8
        XSaKt4yzFRZtHyPnui/h7pR8zJQ2kM5rdCJqnoN/TLn7C+O/mm2CvL0WKoxcljbAjTVxSb
        Dsl4ro7UNt/OyrG/QEuw0E/W+FEZWXgSJFy/b6MivaXJGMxiAtUGLS0ekU6AXg==
Date:   Tue, 4 Apr 2023 09:44:46 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>, a.zummo@towertech.it,
        jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org,
        Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
Subject: Re: [PATCH v5 2/2] dt-bindings: rtc: add max313xx RTCs
Message-ID: <2023040407444619bf5596@mail.local>
References: <20230403154342.3108-1-Ibrahim.Tilki@analog.com>
 <20230403154342.3108-3-Ibrahim.Tilki@analog.com>
 <dd6f0842-519f-1bc9-f7f5-459863dc3dcd@linaro.org>
 <202304040710049c9cc01a@mail.local>
 <996b49ab-5e2e-76bc-efb1-38c6384871f6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <996b49ab-5e2e-76bc-efb1-38c6384871f6@linaro.org>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2023 09:21:56+0200, Krzysztof Kozlowski wrote:
> On 04/04/2023 09:10, Alexandre Belloni wrote:
> >>
> >>> +      RTC can be used as a clock source through its clock output pin when
> >>> +      supplied.
> >>> +    const: 0
> >>> +
> >>> +  clocks:
> >>> +    description: |
> >>
> >> Do not need '|'.
> >>
> >>> +      RTC uses this clock for clock input when supplied. Clock has to provide
> >>> +      one of these four frequencies: 1Hz, 50Hz, 60Hz or 32.768kHz.
> >>> +    maxItems: 1
> >>> +
> >>> +  aux-voltage-chargeable:
> >>> +    enum: [0, 1, 2]
> >>> +    description: |
> >>> +      Enables trickle charger.
> >>> +      0: Charger is disabled (default)
> >>> +      1: Charger is enabled
> >>> +      2: Charger is enabled with a diode
> >>
> >> 2 is not an allowed value. I asked to drop this property. It is coming
> >> from rtc.yaml. I also do not understand "with a diode". So otherwise it
> >> is charging with, I don't know, FET?
> > 
> > No, what is not explained here (and maybe not unsterstood by the
> > submitter) is that the RTC has an extra diode so, 
> 
> Value of 2 is still not allowed and if the patch was tested, it would be
> clearly visible. Unfortunately patch was not tested...
> 
> > charging will always
> > enable a diode, select a resistor and then have or not an extra diode.
> > Figure2 of the MAX31329 datasheet is great.
> 
> So the diode is in the max313xx? Then why enabling it is a property of
> DT? Either this should be inferred from compatible or is even a policy,
> not a DT property. Just because device has a register for something, is
> not an argument that "something" should be in DT.

Well, it depends on the battery that is installed on the board so it
makes sense to have it in DT.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
