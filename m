Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F398691AB8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 10:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjBJJFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 04:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjBJJEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 04:04:49 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FA95FF4;
        Fri, 10 Feb 2023 01:04:08 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 95261C001B;
        Fri, 10 Feb 2023 09:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1676019847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AqdLlt/yCxFcNnbtgPacPBPi521WDlbKJ6hpLfV74Q4=;
        b=OpIPOGRwvaiqSl3xNLvY16H7qTrFnIKwryAreVLhA94xhK8eb3tlxNsnnr+3cMQZ38uTIl
        ntFAXnfcyJMqP6bJmRhHQxO6Cn0vK0pN5E9yJqLAWzs3wvxxN4p3Ly0F9wRRcrWYntG7t8
        fBiD6CHWXluansXjj6jSJCOeSum5NsxDU8XFoXoYocjokmXCbRtQmRtiYAfTOZObI8WBkL
        wklOU2eQd3pm9KRvIysmu4+Ji00xf1cUL5jL8V8eK6HkrEzNOmcUSan3MITAPctjq7ZHhK
        thvNRIacs6UNJLoY3ZD1hbU98tz0vIxTEc24HFaL04hQjz7TLQKv45B3Ah1aCw==
Date:   Fri, 10 Feb 2023 10:04:03 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 00/22] rtc: pm8xxx: add support for setting
 time using nvmem
Message-ID: <Y+YIg9Yp3Sy7n4Pb@mail.local>
References: <20230202155448.6715-1-johan+linaro@kernel.org>
 <167598144775.1655758.2122287458672785227.b4-ty@bootlin.com>
 <Y+X4EBACJ/AYvtOw@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+X4EBACJ/AYvtOw@hovoldconsulting.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2023 08:53:52+0100, Johan Hovold wrote:
> On Thu, Feb 09, 2023 at 11:25:34PM +0100, Alexandre Belloni wrote:
> > 
> > On Thu, 02 Feb 2023 16:54:26 +0100, Johan Hovold wrote:
> > > This series adds support for setting the RTC time on Qualcomm platforms
> > > where the PMIC RTC time registers are read-only by instead storing an
> > > offset in some other non-volatile memory. This is used to enable the RTC
> > > in the SC8280XP Compute Reference Design (CRD) and Lenovo Thinkpad X13s
> > > laptop.
> > > 
> > > The RTCs in many Qualcomm devices are effectively broken due to the time
> > > registers being read-only. Instead some other non-volatile memory can be
> > > used to store and offset which a driver can take into account. On
> > > machines like the X13s, the UEFI firmware (and Windows) use a UEFI
> > > variable for storing such an offset, but not all Qualcomm systems use
> > > UEFI.
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [01/22] rtc: pm8xxx: fix set-alarm race
> >         commit: c88db0eff9722fc2b6c4d172a50471d20e08ecc6
> 
> ...
> 
> > [15/22] rtc: pm8xxx: drop error messages
> >         commit: c94fb939e65155bc889e62396f83ef4317d643ac
> 
> I noticed that you did not apply patches 16 and 17 that add support for
> the nvmem offset. Was that on purpose or a mistake?

This was on purpose, I'll handle them tonight.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
