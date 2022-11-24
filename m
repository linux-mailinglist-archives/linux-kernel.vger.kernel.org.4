Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA5F637C2C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiKXO5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiKXO4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:56:49 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC002C11A;
        Thu, 24 Nov 2022 06:56:44 -0800 (PST)
Received: from booty (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4B58820004;
        Thu, 24 Nov 2022 14:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1669301802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DHCQJ7ZAuuzC6UG49hSRfKeMxjBT7Ylpk7GBcGZRErE=;
        b=CVo66w0Atcxwn8aG3nTnKq12p3m+IrxlyisSdyRW1FupbUNbjU0oG74obbqTQhTSaY9oFS
        iusK80KUYBZbwkvG3b5V4NSZv5Z5qjNZL9KgPbPzL9ugR6BcqtooqsvBolXaTAoMIW9Ef8
        PJrRd+Vymz7xOEXFd/lNJf83UfaQCe/bVy6et+JqxjuQbJws4xdSlLetXfiNps6PKdEW9b
        PHOGdohwZGk43SIc+ERg4RIbHYp9cvbJLZCaqOzUyIRnqY22ZT7TpHGZiQLxaQ13PJxb4Q
        D9X5YL3d6O82VAVCsAIT6fyLe1ZDm76d0E0y9SCTFy8xjvRmbCdhJc4AQYg/hw==
Date:   Thu, 24 Nov 2022 15:56:34 +0100
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [PATCH 00/23] Add Tegra20 parallel video input capture
Message-ID: <20221124155634.5bc2a423@booty>
In-Reply-To: <3ecd7c3d-b013-18b8-ea12-ca3c673de22c@xs4all.nl>
References: <20221109141852.729246-1-luca.ceresoli@bootlin.com>
        <3ecd7c3d-b013-18b8-ea12-ca3c673de22c@xs4all.nl>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Hans,

On Thu, 24 Nov 2022 09:36:14 +0100
Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:

> Hi Luca,
> 
> On 09/11/2022 15:18, luca.ceresoli@bootlin.com wrote:
> > From: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > 
> > Tegra20 and other Tegra SoCs have a video input (VI) peripheral that can
> > receive from either MIPI CSI-2 or parallel video (called respectively "CSI"
> > and "VIP" in the documentation). The kernel currently has a staging driver
> > for Tegra210 CSI capture. This patch set adds support for Tegra20 VIP
> > capture.
> > 
> > Unfortunately I had no real documentation available to base this work on,
> > and I started from a working downstream 3.1 kernel, that I have heavily
> > reworked to fit into the existing tegra-video driver. The existing code
> > appears written with the intent of being modular and allow adding new input
> > mechanisms and new SoCs while keeping a unique VI core module. However its
> > modularity and extensibility was not enough to add Tegra20 VIP support, so
> > I added some hooks to turn hard-coded behaviour into per-SoC or per-bus
> > customizable code. There are also some fixes, some generic cleanups and DT
> > bindings.  
> 
> I plan on testing this series (esp. making sure it keeps working on non-tegra210
> hardware), but I have to find time for that. This is on my TODO list, so I will
> get to it, but it might time.

Thanks for letting me know!

Indeed, with respect to what you wrote, even testing on tegra210
hardware would be useful in case you have any, as all the hardware I
can access is tegra20.

Kind regards.
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
