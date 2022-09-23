Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60D75E75E0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 10:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiIWIdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 04:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiIWIdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 04:33:39 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49180E173E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 01:33:37 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D9840E0008;
        Fri, 23 Sep 2022 08:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663922015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hzACXGQVUXUlqzRxfF5DU+srPu0BVRboZgK6ovyGN7g=;
        b=EtW+5zQZYseGeB0HP2gGRuLbgGbb0iIvvMjOPecmSWPCecctBpynaL/Wrhfh36fOObUBvp
        wBQkW0Flgv+8NzH+Kxdzdcjj0byfq0RScXPA8aTqoZTbnLPKtYXmc8NFu8PR751QU+jEqc
        h+EH+yT4SWFkH3O4abtRCVIUWYll3YAphOZQ4Cf1dCgGBn5M+y+DN1TTRaX8RyNZQScxmp
        J0zakU+4SofaKJfaQcjmVSk9+M4xoCP3K0IkU1O5YmHiqwrD6dC2nrkHxLdqt42oPk47sb
        06ketAPidO+yyam4f2131Vt/bfHQad8ydTletCJk81ZHeUKuYTpgo1jTzZCb3w==
Date:   Fri, 23 Sep 2022 10:33:33 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Exposing nvmem cells to userspace?
Message-ID: <20220923103333.78c7a19b@xps-13>
In-Reply-To: <d1d07787-129d-e363-12d4-17f7858ab255@linaro.org>
References: <20220922122347.1866f758@xps-13>
        <d1d07787-129d-e363-12d4-17f7858ab255@linaro.org>
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

Hi Srinivas,

srinivas.kandagatla@linaro.org wrote on Thu, 22 Sep 2022 22:33:52 +0100:

> On 22/09/2022 11:23, Miquel Raynal wrote:
> > Hello Srinivas,
> >=20
> > I am currently looking at the Open Compute Project ONIE Tlv tables in
> > modern networking hardware. Thanks to the specification being available
> > for many years and rather easy to implement, those tables are already
> > present in many switches. Manufacturers just have to provide a small
> > storage medium exposing factory-related information (manufacturer, date,
> > serial#, mac addresses, etc) in Type-Length-Value fields, as well
> > as their own extensions if they want. These tables are common, but
> > there is currently no shared decoding logic, each provider maintaining
> > its own internally.
> >=20
> > I am currently looking for upstreaming an nvmem layout driver for
> > exposing the standard nvmem cells. This way, Ethernet drivers might eg.
> > take the base MAC address from there. But I feel like there is
> > something missing, because the vendor name, the device version, the
> > serial number or any other information available in these tables might
> > also very well be used by the userspace rather than the kernel drivers
> > only. =20
>=20
> Could you explain the userspace side use-case?

Right now I don't have any TBH. But in general, having access to a
serial number, a manufacturing date, a hardware batch or whatever other
per-device factory information is always useful.

> > Thus, I was wondering if there was some ongoing work to make these
> > cells available to userspace (in /sys maybe?) or if this had already
> > been discussed somewhere. Otherwise, would you be open to such a =20
>=20
> we had this discussed this in many instances and this is some thing we wo=
uld desire to have but we never got it moving forward.

Ok.

> > contribution? I guess it would also be a useful debug tool anyway (and
> > might very well be moved somewhere else than in /sys). =20
>=20
> getting sysfs working correctly in sync with userspace might be tricky in=
 this particular case as we will be creating cells after the provider drive=
r is created.
>=20
> debugfs on the other hand is more doable.

Ok, I might try something with debugfs then. I'll keep this in mind.

Thanks,
Miqu=C3=A8l
