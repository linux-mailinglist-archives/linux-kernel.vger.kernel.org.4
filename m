Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE6C611B0D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 21:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiJ1To5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 15:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJ1Toy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:44:54 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D4E386A5;
        Fri, 28 Oct 2022 12:44:51 -0700 (PDT)
Received: from hatter.bewilderbeest.net (97-113-250-99.tukw.qwest.net [97.113.250.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 502B3344;
        Fri, 28 Oct 2022 12:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1666986291;
        bh=nQoRjrEsUO89yM+Es8sfAk3knuKjH07TV0H0W08nsVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=onq3SIl4LSZwOvPld42fB+1ZU/V+G9XEjPO7wOsux3spVTEGe2Dzp0YFId3UGOyzS
         yAGiDmnpbTEQCr1NnshE1us+H2TPhKvQ7geywlkNsG1Ncw5fqca6DIkBw6WheH3ejq
         6v0b3rVmuhyMtAJ/UbgAd3nRw8zUq2J2kzQGF3GQ=
Date:   Fri, 28 Oct 2022 12:44:50 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Naresh Solanki <naresh.solanki@9elements.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH 2/3] dt-bindings: regulator: Add regulator-output bindingg
Message-ID: <Y1wxMk2x25AeRwLr@hatter.bewilderbeest.net>
References: <20220925220319.12572-1-zev@bewilderbeest.net>
 <20220925220319.12572-3-zev@bewilderbeest.net>
 <20220929210714.GA2684335-robh@kernel.org>
 <YzYNt+IQRomycRLs@hatter.bewilderbeest.net>
 <Y1rRCq9Kdd2zPPkw@hatter.bewilderbeest.net>
 <ee37b5a1-5afc-71b3-f777-add295d9ce17@linaro.org>
 <Y1tWpikPogEtV0+x@hatter.bewilderbeest.net>
 <Y1v6migO2PNV4ksW@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Y1v6migO2PNV4ksW@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 08:51:54AM PDT, Mark Brown wrote:
>On Thu, Oct 27, 2022 at 09:12:22PM -0700, Zev Weiss wrote:
>
>> I can see why it might look that way, but I'd argue it's actually not.  The
>> systems this is intended to support provide power to entirely separate
>> external devices -- think of a power distribution unit that might have
>> arbitrary things plugged into it.  It seems to me like a property of the
>> hardware that those things shouldn't have their power supply turned off (or
>> on) just because a controller in the PDU rebooted.
>
>We don't turn things off on reboot?  We don't do anything in particular
>on reboot...
>

Okay, perhaps not on reboot specifically, but the userspace-consumer 
driver has a regulator_bulk_disable() in its .remove function, so it 
would be triggered at least by a module unload (which is sort of why I 
ended up with the "when software relinquishes control" wording in the 
patch).  If we're going to continue with the plan of using that driver 
for this functionality (which seems overall quite reasonable to me), we 
need a way to express that that must not happen on this hardware.


Thanks,
Zev

