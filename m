Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E9972B86E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 09:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbjFLHJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 03:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjFLHJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:09:23 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7E21988;
        Mon, 12 Jun 2023 00:04:22 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 9B0CCEBEE9;
        Sun, 11 Jun 2023 23:23:49 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qNkXHMKsc_bt; Sun, 11 Jun 2023 23:23:48 -0700 (PDT)
From:   Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1686551028; bh=5WdmsNcfnfJhZlcRD/AABB3BQ/Q/V4x0NfhKyYWvdOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pZrs4NYHksUe2cl7XbAEerstNlOYmsYefC5/fD5zoqRbR5YTSTOPQb4SSt5JWlgZn
         RKnkF8zjiqAoCCRdI9H7mcpjQ67pxAwOi8UZggmmlkohain1f6AZeqN3Zzi1ei6yJ9
         LSEN6hIbSE6w4/VPZaGwU287566rR4cluYqFehVMle/t71wBYGKOhXb39hWDOxoSou
         flLO37GBD8ue+lVNW2c8rv6ivngWKbabIKDAbg8fPYI35uIUem6giHmW1HP76k2ROh
         +sUAHrPNZ2O9Ocz9v23sV0P54buaOQ+F6z4PdynRIMZwzX7DPG8Us9EjlRmGHSZ+ZN
         YAy9yhATC+4/Q==
To:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH 2/3] thermal: qoriq_thermal: only enable supported sensors
Date:   Mon, 12 Jun 2023 08:23:34 +0200
Message-ID: <23120696.6Emhk5qWAg@pliszka>
In-Reply-To: <507b5daa-73e7-8d21-4f73-c56f88c6bf77@linaro.org>
References: <20230516083746.63436-1-peng.fan@oss.nxp.com> <1966575.usQuhbGJ8B@pliszka>
 <507b5daa-73e7-8d21-4f73-c56f88c6bf77@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On =C5=9Broda, 7 czerwca 2023 21:10:18 CEST Daniel Lezcano wrote:
> On 07/06/2023 19:42, Sebastian Krzyszkowiak wrote:
>=20
> [ ... ]
>=20
> >> Hence, the thermal_zone_device_register_with_trips() is not called, the
> >> thermal zone is not created neither updated.
> >=20
> > Again - that's not the case the check is there for. It's there for zones
> > that do exist and that do get registered, because REGS_TMR only gets set
> > *after* all the zones are already registered (the driver as it is right
> > now does not know which sites it should enable before registering the
> > zones). Because of that, the first value a zone gets after being
> > registered is always bogus, because no monitoring site has been enabled
> > yet at all.
>=20
> Ok, I misunderstood. I thought that was for failing registered thermal zo=
ne.
>=20
> Would enabling the site in ops->change_mode do the trick ?

Haven't tested, but from a quick glance at the core I believe it should!

Peng, would you like to try that approach out and update this patch?

Thanks,
Sebastian


