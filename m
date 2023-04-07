Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FA26DA892
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 07:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjDGFjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 01:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjDGFjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 01:39:20 -0400
Received: from s.wrqvtzvf.outbound-mail.sendgrid.net (s.wrqvtzvf.outbound-mail.sendgrid.net [149.72.126.143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C849EF9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 22:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=equiv.tech;
        h=from:subject:references:mime-version:content-type:in-reply-to:to:cc:
        content-transfer-encoding:cc:content-type:from:subject:to;
        s=org; bh=G9VemBoo/oQmh90TMdsZVLhnDY3UIXhAohIfrIhUiYM=;
        b=AGEJ3Lwe2Ksdfcc9PGVVpVBQz7EJBu4gjIBH3Zuw1j/N3vSG1n5tXmCtOaEbvANNV2dK
        KkPYtWYIUQC5uxPJfPtrh+YRb5Kfutp9U/pFklctQsP4lTNQNKwVKGEbjSnuzTNaqZPlFZ
        3IfdD05O0jH9aUeuVoPGQo8A3wz+9iRIo=
Received: by filterdrecv-6c845fd887-lq6xf with SMTP id filterdrecv-6c845fd887-lq6xf-1-642FAC85-C
        2023-04-07 05:39:17.456579464 +0000 UTC m=+3823669.134456244
Received: from localhost (unknown)
        by geopod-ismtpd-1 (SG) with ESMTP
        id TokS6-f2QXuJBhfPgNZvSw
        Fri, 07 Apr 2023 05:39:16.607 +0000 (UTC)
Date:   Fri, 07 Apr 2023 05:39:17 +0000 (UTC)
From:   James Seo <james@equiv.tech>
Subject: Re: [PATCH v2] hwmon: add HP WMI Sensors driver
Message-ID: <ZC+sgnuy5bssD1DN@vb-22lts>
References: <20230406152321.42010-1-james@equiv.tech>
 <2257deba-187b-82d2-181c-f1fed08a2ff7@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2257deba-187b-82d2-181c-f1fed08a2ff7@gmx.de>
X-SG-EID: =?us-ascii?Q?1X41iaRO4wVP+tFXGLuxpQ0yxxMDhGIesR5UcsYKVengQKgidLJSXwOMZlPQwP?=
 =?us-ascii?Q?WsAj56po3NRvhdf1mTxjVMIv2D1=2FDP7Bkv5o0um?=
 =?us-ascii?Q?PWoegI9wRMHmPxJcjLNe2oweeMgjlSP+NrWwbFZ?=
 =?us-ascii?Q?OqRh=2FZ=2F839oH46L4lJO0ZuzGTcQOFnOu47xo2O6?=
 =?us-ascii?Q?Y4uye0HxqqPpLQW272X2yvvzk+zGFjK0Pn9H69L?=
 =?us-ascii?Q?iIlRiAFLaMu4KPiLWf7OSbNbWHrVXYAWiVuqFn?=
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Entity-ID: Y+qgTyM7KJvXcwsg19bS4g==
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> is it guaranteed that faulty sensors wont become operational later?
> Also filtering out such sensors would make the support for the hwmon_temp_fault and
> hwmon_fan_fault attributes meaningless.

Good point. I can't be certain, but the MOF does seem to imply that
sensors can indeed be faulty on just a temporary basis.

I'll filter out only the sensors that are "Not Connected" at probe
time. My thinking is, even if these might turn into connected sensors
later, that would mean the user is e.g. hot-plugging a fan (!), and
keeping them could result in a large number (~10 on my Z420) of
pointless extra channels. And this would also match the behavior of
HP's official utility.

Does that seem reasonable? Or did you mean that I shouldn't filter,
and leave disconnected sensors in like some other hwmon drivers do?

> The sanity check for HP_WMI_NUMERIC_SENSOR_GUID is unnecessary, the WMI driver core already makes sure that your driver
> is only matched with WMI devices containing HP_WMI_NUMERIC_SENSOR_GUID.
> As for the sanity check regarding HP_WMI_BIOS_GUID: this WMI GUID is not used inside the driver. Since WMI GUIDs are expected
> to be unique, checking for HP_WMI_BIOS_GUID (which AFAIK is used by the HP-BIOSCFG driver) without intending to use it is
> meaningless.

In that case, I'll gladly remove the checks. I was following the
example of the platform/x86/hp-wmi driver, which checks for that GUID
and another at module load.

Thanks for reviewing.

James
