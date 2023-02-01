Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913CB686B2F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbjBAQJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjBAQJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:09:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A6326A6;
        Wed,  1 Feb 2023 08:09:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8FFB6172E;
        Wed,  1 Feb 2023 16:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A11C433EF;
        Wed,  1 Feb 2023 16:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675267774;
        bh=OFFjipLLeQzikky+LqTRKkqTej58cv5vGpMRCQQNo04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SsrkQlAySNT9T4qTChhsbieGUNSl3Lrv5aqnwB8d2ACOwkYCE9Lj6FxsMc28mSb13
         rkwOnTuuMMwPN6vksKjY49Gs7H3hzKCldVN2gE9ZUzmZZPQqqixwkwLLT+ycRaxhZU
         4sNUcpgEE76kzKHXx0vlAujb3J6YiuFdOqHen0fx7q9teXxE47FzeQdxShky6AfkBd
         8zk/nkucfPLWshM1UI8ENSM5Pym3mq8rN2/k9SkD4QUQmaSBxAM+VuUV/gHQWMZOrs
         kfd8R5FL+VNCbfwo1eYUVO26VuJrco88CcCkznENly8sBQqKbF5qZnm8898BidQBR5
         RXqcRSaScpvmw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pNFgJ-00078p-HR; Wed, 01 Feb 2023 17:09:55 +0100
Date:   Wed, 1 Feb 2023 17:09:55 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [RFC 18/24] dt-bindings: rtc: qcom-pm8xxx: add uefi-variable
 offset
Message-ID: <Y9qO0yQ7oLux2L9n@hovoldconsulting.com>
References: <20230126142057.25715-1-johan+linaro@kernel.org>
 <20230126142057.25715-19-johan+linaro@kernel.org>
 <20230130184944.GA3096050-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130184944.GA3096050-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ +CC: Ard ]

On Mon, Jan 30, 2023 at 12:49:44PM -0600, Rob Herring wrote:
> On Thu, Jan 26, 2023 at 03:20:51PM +0100, Johan Hovold wrote:
> > On many Qualcomm platforms the PMIC RTC control and time registers are
> > read-only so that the RTC time can not be updated. Instead an offset
> > needs be stored in some machine-specific non-volatile memory, which a
> > driver can take into account.
> > 
> > Add a 'qcom,uefi-rtc-info' boolean flag which indicates that the RTC
> > offset is stored in a Qualcomm specific UEFI variable so that the RTC
> > time can be updated on such platforms.
> > 
> > The UEFI variable is
> > 
> > 	882f8c2b-9646-435f-8de5-f208ff80c1bd-RTCInfo
> > 
> > and holds a 12-byte structure where the first four bytes is a GPS time
> > offset in little-endian byte order.
> 
> Can't you just try to read the UEFI variable and use it if that 
> succeeds?

Generally, yes. The problem here is that this UEFI variable is not used
on all devices using these PMICs and I need a way to determine whether
to wait for the UEFI variables to become available or not (e.g. when
efivars support is built as module, yes, that's a thing now...).

> I don't like this in DT because what if lots of devices start storing 
> lots of things in vendor specific UEFI variables. It doesn't scale.

I hope we won't see that even if we already have some devices for x86
platforms storing MAC addresses and such in UEFI variables. They
currently access the UEFI firmware directly (i.e. not using the efivars
abstraction) and simply assume UEFI is always there.

With the Google SMI efivars implementation or the new Qualcomm SMC-based
one, we need a way to determine whether to wait for efivars to become
registered. For drivers where efivars is always needed we can just probe
defer, but in this case we should not wait unless the DT indicates that
the RTC offset is stored in UEFI on this particular machine.

Just as the nvmem-cell property indicates that the offset is stored in
some abstract nvmem, it seems reasonable to describe the offset being
stored in UEFI when that is the case (even if it is indeed generally
possible to probe for the latter).

An alternative might be to describe the efivars fw dependency in DT too
(e.g. for device links), but I believe you have already expressed some
concerns over that:

	https://lore.kernel.org/lkml/20230130210530.GA3339716-robh@kernel.org/

Johan
