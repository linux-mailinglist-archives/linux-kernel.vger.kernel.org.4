Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EAA739502
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 03:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjFVB4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 21:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjFVB4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 21:56:17 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAF6198B;
        Wed, 21 Jun 2023 18:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=jud17jsE6/Ga7sy3GJjdnGlQV0t2HqzZZz3k4YHmE2g=; b=ayqSlR67thHwZ0kw7SsHI3F6g7
        EcxdtI+VOuNJ0gTuuJdzuu+TpJgXdYK7F5emB9hEEHX6C/vRoAAYwx+HCRSpRyCSg0XNczaXUsqvw
        599/kdU8oZtE9n1qgXxmG8P60EugjCXR48EDDHODdOzcl3S5HhJkjJnwq13+lR9n2S08=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qC9Xh-00HDK4-HB; Thu, 22 Jun 2023 03:55:25 +0200
Date:   Thu, 22 Jun 2023 03:55:25 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Evan Quan <evan.quan@amd.com>, rafael@kernel.org,
        lenb@kernel.org, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mdaenzer@redhat.com,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        hdegoede@redhat.com, jingyuwang_vip@163.com, lijo.lazar@amd.com,
        jim.cromie@gmail.com, bellosilicio@gmail.com,
        andrealmeid@igalia.com, trix@redhat.com, jsg@jsg.id.au,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH V4 1/8] drivers/acpi: Add support for Wifi band RF
 mitigations
Message-ID: <ef7dc1ab-c6d0-4761-8d0a-8949bfd3da80@lunn.ch>
References: <216f3c5aa1299100a0009ddf4e95b019855a32be.camel@sipsolutions.net>
 <b1abec47-04df-4481-d680-43c5ff3cbb48@amd.com>
 <36902dda-9e51-41b3-b5fc-c641edf6f1fb@lunn.ch>
 <33d80292-e639-91d0-4d0f-3ed973f89e14@amd.com>
 <9159c3a5-390f-4403-854d-9b5e87b58d8c@lunn.ch>
 <a80c215a-c1d9-4c76-d4a8-9b5fd320a2b1@amd.com>
 <8d3340de-34f6-47ad-8024-f6f5ecd9c4bb@lunn.ch>
 <07ad6860-8ffb-cc6c-a8e5-e8dc4db4e87a@amd.com>
 <08dd8d17-6825-4e53-8441-85c709326f48@lunn.ch>
 <3e337dc0482e16e2aaa4090b613dc8dea7803fa8.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e337dc0482e16e2aaa4090b613dc8dea7803fa8.camel@sipsolutions.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Honestly I'm not sure though we need this complexity right now? I mean,
> it'd be really easy to replace the calls in mac80211 with some other
> more generalised calls in the future?
> 
> You need some really deep platform/hardware level knowledge and
> involvement to do this, so I don't think it's something that someone
> will come up with very easily for a DT-based platform...

What is this API about?

It is a struct device says, i'm badly designed and make a mess of the
following frequency bands. Optionally, if you ask me nicely, i might
be able to tweak what i'm doing to avoid interfering with you.

And it is about a struct device say, i'm using this particular
frequency. If you can reduce the noise you make, i would be thankful.

The one generating the noise could be anything. The PWM driving my
laptop display back light?, What is being interfered with?  The 3.5mm
audio jack?

How much deep system knowledge is needed to call pwm_set_state() to
move the base frequency up above 20Khz so only my dog will hear it?
But at the cost of a loss of efficiency and my battery going flatter
faster?

Is the DDR memory really the only badly designed component, when you
think of the range of systems Linux is used on from PHC to tiny
embedded systems?

Ideally we want any sort of receiver with a low noise amplifier to
just unconditionally use this API to let rest of the system know about
it. And ideally we want anything which is a source of noise to declare
itself. What happens after that should be up to the struct device
causing the interference.

Mario did say:

  The way that WBRF has been architected, it's intended to be able to
  scale to any type of device pair that has harmonic issues.

Andrew
