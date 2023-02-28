Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC616A5E56
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 18:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjB1Rjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 12:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB1Rjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 12:39:45 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A64EB48;
        Tue, 28 Feb 2023 09:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=1kOgwoHUpeZnKGhyoamiE8rEFrDmo1RwpX9g7ay49uU=;
        t=1677605984; x=1678815584; b=rFRfyDlifnbAyOf4a0fTb8IBFaUyN/wm3835wfSaUb38eCM
        PneAneNy0FbbUfiu/+U3Ngbglgjc8b0t5syJMqRm6tiS/hCItJPOKlYf3kntxWZRQnt6bkxeixJrH
        qy5K+/F2EZM6cJaZcgImkvgGhq/wCh7oD7khjDhMzsalaUnUtIrDRmbrMs/dHpW5u5nin+nM1Be56
        /ml2A3ANRg0CSyS+Fsyyi8UTINCNwavro2yAAeRQnLC2OZeCjGBS6yFMiQy4AuElDZYJjZijuCZrU
        u2PNXF86zuAtOSqRXZF4w5o9/xoX/VF+iHXrm5N2ExOhhL0eqLaZ4j13mPMMKiUw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pX3wt-00845w-0N;
        Tue, 28 Feb 2023 18:39:35 +0100
Message-ID: <699d35cd36f3d77c112a6aa8705b043efaa63711.camel@sipsolutions.net>
Subject: Re: [PATCH] virt-pci: add platform bus support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        "robh@kernel.org" <robh@kernel.org>, devicetree@vger.kernel.org,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>
Date:   Tue, 28 Feb 2023 18:39:34 +0100
In-Reply-To: <Y+t6qXBxLqf/+eQM@axis.com>
References: <20230127-uml-pci-platform-v1-1-ec6b45d2829f@axis.com>
         <d3f6d627290bb1a6a1fcfdfd5fad915578453e02.camel@sipsolutions.net>
         <Y+t6qXBxLqf/+eQM@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-02-14 at 13:12 +0100, Vincent Whitchurch wrote:
>=20
> Yes, Greg was initially totally opposed to the idea of putting platform
> devices under PCI devices, but in his latest email he seemed to
> allow it in some cases.  It's still unclear if he'd be OK with a
> "virtual PCI-to-platform bridge" though.  And yes, adding platform
> devices support like in this patch removes one layer and also eliminates
> the disadvantage of having to wait for user space to specify a PCI ID
> for the bridge device.

Right.

> > > +	if (!dev->irq)
> > > +		return;
> > >=20
> >=20
> > Does that mean platform devices don't have interrupts, or does that mea=
n
> > not all of them must have interrupts?
>=20
> They don't have interrupts via this driver.  There isn't any standard
> way for platform devices to handle interrupts since it it all depends on
> what interrupt-parent is specified in the devicetree and how that is
> implemented.

Ah, OK.

> > I'll note that this also would allow the device to send an MSI which
> > feels a bit wrong? But I guess it doesn't really matter.
>=20
> We could avoid setting up the IRQ/MSI virtqueue when we know we're
> dealing with platform devices.

Not sure it matters then?

> > So let me ask this: Conceptually, wouldn't the "right" way to handle
> > this be a new virtio device and protocol and everything, with a new
> > driver to handle it? I realise that would likely lead to quite a bit of
> > code duplication, for now I just want to understand the concept here a
> > bit better.
>=20
> Yes, that could be a way to do it.  Or there could perhaps be some
> feature bits indicating that only MMIO read/write/memset are allowed.

Right.

> > How much code would we actually duplicate? Most of virt-pci is dedicate=
d
> > to the mess of PCI MSI domains, bridges, etc.
>=20
> Probably not a huge amount, I can try to cook up a patch if you'd like.
> But, besides the code duplication, I'm not sure if adding another new
> virtio driver without a specification would be OK?

Yeah ... let's not worry. Was mostly trying to understand it better.

I'm not really bothered by it :)

> > The limitation to a single device feels odd, and the fact that you have
>=20
> The limitation to a single device here is not a problem since one can
> use simple-bus to instantiate any number of platform devices via the
> devicetree.  The devicetree at the end of this email shows how that
> looks like.

OK cool.

> With a devicetree like the one below, using it shouldn't be all that
> different from using the normal virt-pci except that the register ranges
> and IRQ information are in the devicetree rather than coming via the
> config space implementation in the virtio device.

Makes sense.

Thanks for all the answers & examples! Let's just leave it as is then :)

johannes
