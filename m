Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FD85E5FCE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiIVKX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiIVKXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:23:51 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80746D8244
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 03:23:50 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A95E1E0003;
        Thu, 22 Sep 2022 10:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663842229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=InFQ8JobN+jZxAMn4KRH46pdNp7Ua6Sz712kAiGUGC8=;
        b=HktSsHAOPoihX/YcXqHRaPDhjFZcD/AI918vIgxruFYEtWpFB5C8nRxU5isZWLkoktc0gj
        K8jyLDHxgjO9+ctQ26Ea+z1Ex+bGFQtrXQg70yllsYWt+iCCeSX0tiUFTL1IX51lmEHQ/U
        2PlxeOM68TEhwXRStkCZg9oQJuBKPqpZ/aO44LNL6eMqMBhX9HKbI8bwmyiTDfwrnmxekb
        FjDxlR9SpQ7oE9xVoVarrMqAq+xYft0/x3BjwNcN8BUwo/ZTDirbjHFPyUJF8XrbYJggXs
        g3mjcwF2ybe3Ejsvsc5z2nVNrtqDxK9wK7R/cfCQNgUoSybifiXJsq3SyTHXiQ==
Date:   Thu, 22 Sep 2022 12:23:47 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Exposing nvmem cells to userspace?
Message-ID: <20220922122347.1866f758@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Srinivas,

I am currently looking at the Open Compute Project ONIE Tlv tables in
modern networking hardware. Thanks to the specification being available
for many years and rather easy to implement, those tables are already
present in many switches. Manufacturers just have to provide a small
storage medium exposing factory-related information (manufacturer, date,
serial#, mac addresses, etc) in Type-Length-Value fields, as well
as their own extensions if they want. These tables are common, but
there is currently no shared decoding logic, each provider maintaining
its own internally.

I am currently looking for upstreaming an nvmem layout driver for
exposing the standard nvmem cells. This way, Ethernet drivers might eg.
take the base MAC address from there. But I feel like there is
something missing, because the vendor name, the device version, the
serial number or any other information available in these tables might
also very well be used by the userspace rather than the kernel drivers
only.

Thus, I was wondering if there was some ongoing work to make these
cells available to userspace (in /sys maybe?) or if this had already
been discussed somewhere. Otherwise, would you be open to such a
contribution? I guess it would also be a useful debug tool anyway (and
might very well be moved somewhere else than in /sys).

Thanks for your time,
Miqu=C3=A8l
