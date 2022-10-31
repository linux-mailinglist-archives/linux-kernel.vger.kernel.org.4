Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DDF613DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiJaSut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJaSuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:50:46 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D57AD2E5;
        Mon, 31 Oct 2022 11:50:46 -0700 (PDT)
Received: from hatter.bewilderbeest.net (97-113-250-99.tukw.qwest.net [97.113.250.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 6BE4B1A6;
        Mon, 31 Oct 2022 11:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1667242245;
        bh=yI4VxHDcRGzkmJzt6Mtn+pBg7sqPLddFXxyeqLB99ZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gLWG6j8XI9P3wq9uVxSiD+zKUj/071FKMi6IBkvvr8Av3dFpgp4Av5G4GD/vuEFmJ
         TrlXBhscA3fP3xDH9qvvU3W/YPzTR7Tjt6PENNQ3waFCParDKvnWnNEm38g6DSkZcb
         +iHqKDcjUEWKGkxTa6nY73G0m7zLjQuk4uxvNLdk=
Date:   Mon, 31 Oct 2022 11:50:38 -0700
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
Message-ID: <Y2AY/tQLQ6m+SXI7@hatter.bewilderbeest.net>
References: <20220925220319.12572-1-zev@bewilderbeest.net>
 <20220925220319.12572-3-zev@bewilderbeest.net>
 <20220929210714.GA2684335-robh@kernel.org>
 <YzYNt+IQRomycRLs@hatter.bewilderbeest.net>
 <Y1rRCq9Kdd2zPPkw@hatter.bewilderbeest.net>
 <ee37b5a1-5afc-71b3-f777-add295d9ce17@linaro.org>
 <Y1tWpikPogEtV0+x@hatter.bewilderbeest.net>
 <Y1v6migO2PNV4ksW@sirena.org.uk>
 <Y1wxMk2x25AeRwLr@hatter.bewilderbeest.net>
 <Y1/tnic0qc/Ll/5u@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Y1/tnic0qc/Ll/5u@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 08:45:34AM PDT, Mark Brown wrote:
>On Fri, Oct 28, 2022 at 12:44:50PM -0700, Zev Weiss wrote:
>> On Fri, Oct 28, 2022 at 08:51:54AM PDT, Mark Brown wrote:
>
>> > We don't turn things off on reboot?  We don't do anything in particular
>> > on reboot...
>
>> Okay, perhaps not on reboot specifically, but the userspace-consumer driver
>> has a regulator_bulk_disable() in its .remove function, so it would be
>> triggered at least by a module unload (which is sort of why I ended up with
>> the "when software relinquishes control" wording in the patch).  If we're
>> going to continue with the plan of using that driver for this functionality
>> (which seems overall quite reasonable to me), we need a way to express that
>> that must not happen on this hardware.
>
>Ah, that would be the test driver not intended to be used in production
>then...  That shouldn't be a blocker for the DT binding, and if there's
>a different compatible string for this application then we can either
>make the userspace consumer do something different based on that
>compatible string or have a new driver which does something more
>sensible and perhaps has a better userspace ABI.  Either way so long as
>we can tell the thing being described is a BMC output from the DT
>binding I think we can leave it up to the OS to do something constructive
>with that rather than trying to control the specific behaviour in the
>binding.

Ah, alright -- that seems like a nice (obvious in retrospect, of course) 
solution that should work well I think.  I'll post a v2 with that 
approach soon.


Thanks,
Zev

