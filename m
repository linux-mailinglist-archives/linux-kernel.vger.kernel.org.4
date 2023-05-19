Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013147095D7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 13:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjESLEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 07:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjESLD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 07:03:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE631BE3;
        Fri, 19 May 2023 04:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684494210; x=1716030210;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=070GsWUlchrSnGGLy4XXwdGMLjuXVQ6M8kOzuNip+lg=;
  b=Bx9tZLNuSQhho6zCwYJkbCz8T9t0o6NZaxeB+sM4lckDgnhmP6HBnJMC
   JIghJ6VkJ9NS7tTOyHZMpbTvMZF/Lg4aSisuyBmbEEW3k6gWgzfNSy615
   XSN8Fq2qrKJZushN2jqBxbwb5W1+YBTv5XQqT58OYh5GRZxmn9HRlki+V
   lRoaKqFKLng2Yq+OkhIaCSm1+l5lioWBUfut3jaGHcklOFvsVzbXlJ0+j
   cxl2j/k54uEp3CNSrPsDyP9AfHEOwy8+qtfkV1E17FaeeHvhdq96XZm3C
   fPJD64vQGQr6L/exAtvI9bMaqj7GKYWOFTHiiDwl5aQ3+SFI+DpuHBAT9
   g==;
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="asc'?scan'208";a="212109504"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 May 2023 04:03:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 19 May 2023 04:03:10 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 19 May 2023 04:03:09 -0700
Date:   Fri, 19 May 2023 12:02:47 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <conor@kernel.org>, <daire.mcnamara@microchip.com>
Subject: Potential issue with (or misunderstanding of) of_irq_get()
Message-ID: <20230519-unkempt-cartel-48efb4d8f0b4@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="00T+oOMGxgbKK3n9"
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00T+oOMGxgbKK3n9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey!

I've run into an issue with of_irq_get() while writing an irqchip driver
and I was hoping that by posting about it I might get some guidance as
to whether I just doing something fundamentally wrong in my code, or
if the specific case was just an oversight.

I've been trying to solve the issue that I pointed out here:
https://lore.kernel.org/linux-gpio/23a69be6-96d3-1c28-f1aa-555e38ff991e@mic=
rochip.com/

To spare reading that, the TL;DR is that the SoC has 3 GPIO controllers,
with 14, 24 and 32 GPIOs each. All 68 can be used for interrupts.
The PLIC only has 41 interrupts for GPIOs, so there's a bit of extra RTL
sitting between the GPIO controllers and the PLIC, that is runtime
configurable, deciding whether an GPIO gets a PLIC interrupt of its
own or shares an interrupt with other GPIOs from the same GPIO controller.

Since the interrupt router/mux is not part of the GPIO controller blocks,
I have written a driver for the it & changed the representation in the DT
to the below. For each of the 41 interrupts "consumed" by the driver
bound to the irqmux node, I have created a domain.

	irqmux: interrupt-controller@20002054 {
		interrupt-parent =3D <&plic>;
		interrupts =3D <13>, <14>, <15>, <16>,
			     <17>, <18>, <19>, <20>,
			     <21>, <22>, <23>, <24>,
			     <25>, <26>, <27>, <28>,
			     <29>, <30>, <31>, <32>,
			     <33>, <34>, <35>, <36>,
			     <37>, <38>, <39>, <40>,
			     <41>, <42>, <43>, <44>,
			     <45>, <46>, <47>, <48>,
			     <49>, <50>, <51>, <52>,
			     <53>;
	};

	gpio0: gpio@20120000 {
		interrupt-parent =3D <&irqmux>;
		npios =3D <14>;
		interrupts =3D <0>, <1>, <2>, <3>,
			     <4>, <5>, <6>, <7>,
			     <8>, <9>, <10>, <11>,
			     <12>, <13>;
	};

	gpio1: gpio@20121000 {
		interrupt-parent =3D <&irqmux>;
		npios =3D <24>;
		interrupts =3D <32>, <33>, <34>, <35>,
			     <36>, <37>, <38>, <39>,
			     <40>, <41>, <42>, <43>,
			     <44>, <45>, <46>, <47>,
			     <48>, <49>, <50>, <51>,
			     <52>, <53>, <54>, <55>;
	};

	gpio2: gpio@20122000 {
		interrupt-parent =3D <&irqmux>;
		npios =3D <32>;
		interrupts =3D <64>, <65>, <66>, <67>,
			     <68>, <69>, <70>, <71>,
			     <72>, <73>, <74>, <75>,
			     <76>, <77>, <78>, <79>,
			     <80>, <81>, <82>, <83>,
			     <84>, <85>, <86>, <87>,
			     <88>, <89>, <90>, <91>,
			     <92>, <93>, <94>, <95>;
	};

This approach in DT allows the GPIO controller driver to not care about
the router/mux configuration, which makes sense to me as it is not part
of those IP blocks.

My irqchip driver was adding domains like so:

	for (; i < MPFS_MUX_NUM_IRQS; i++) {
		priv->irqchip_data[i].output_hwirq =3D i;

		priv->irqchip_data[i].irq =3D irq_of_parse_and_map(node, i);

		domain =3D irq_domain_add_linear(node, MPFS_MAX_IRQS_PER_GPIO,
					       &mpfs_irq_mux_nondirect_domain_ops,
					       &priv->irqchip_data[i]);

		irq_set_chained_handler_and_data(priv->irqchip_data[i].irq,
						 mpfs_irq_mux_nondirect_handler,
						 &priv->irqchip_data[i]);
	}

In my irqchip's select callback I check the struct irq_fwspec's param[0]
to determine which domain is actually responsible for it.

That's all working nicely & I was doing some cleanup before submitting,
when I noticed that debugfs complained about the fact that I had several
domains hanging off the same of device_node:
debugfs: File ':soc:interrupt-controller@20002054' in directory 'domains' a=
lready present!
debugfs: File ':soc:interrupt-controller@20002054' in directory 'domains' a=
lready present!

To get around that, I tried to switch to creating fwnodes instead,
one for each domain:

	for (; i < MPFS_MUX_NUM_IRQS; i++) {
		priv->irqchip_data[i].output_hwirq =3D i;

		priv->irqchip_data[i].irq =3D irq_of_parse_and_map(node, i);

		fwnode =3D irq_domain_alloc_named_id_fwnode("mpfs-irq-mux", i);

		domain =3D irq_domain_create_linear(fwnode, MPFS_MAX_IRQS_PER_GPIO,
						  &mpfs_irq_mux_nondirect_domain_ops,
						  &priv->irqchip_data[i]);

		irq_set_chained_handler_and_data(priv->irqchip_data[i].irq,
						 mpfs_irq_mux_nondirect_handler,
						 &priv->irqchip_data[i]);
	}

That's grand for debugfs, but I then ran into a problem that made me feel
I had designed myself into an incorrect corner.

The GPIO driver requests interrupts using:

	nirqs =3D of_irq_count(node);
	for (i =3D 0; i < nirqs; i++)
		ret =3D platform_get_irq(pdev, i);

producing the following call trace:

	mpfs_gpio_probe()
	 platform_get_irq()
	  platform_get_irq_optional()
	   of_irq_get()
	    irq_find_host()
	     irq_find_matching_host()
	      irq_find_matching_fwnode()
	       irq_find_matching_fwspec()

of_irq_find_host() is problematic for me, because it calls into
irq_find_matching_fwspec() having created a struct irq_fwspec where it
only populated the fwnode.

In irq_find_matching_fwspec(), the check for fwspec->param_count will
always be false & my select callback is never invoked.

Since irq_find_matching_fwspec() falls back to the match callback if
param_count is zero, I have added a match callback:

	static int mpfs_irq_mux_nondirect_match(struct irq_domain *d, struct devic=
e_node *node,
						enum irq_domain_bus_token bus_token)
	{
		if(!of_device_is_compatible(node, "microchip,mpfs-gpio-irq-mux"))
			return false;
=09
		return true;
	}

But this is a hack, since I have 41 domains using the same match callback,
and will return true as long as just one of them has been created.
It is sufficient though to get me as far along irq_create_of_mapping()
which is called using a struct of_phandle_args, containing the params
array that I rely on.

I appear to have run into a fundamental assumption in of_irq_get(), which
makes me think that I have gone pretty badly wrong here somewhere.
Is this a bug/oversight/omission, or am I just doing something broken in
my code?
Given how long that code seems to be there, I am leading towards the fault
being mine (it usually is!).

The code for this (likely aberration of an) irqchip driver is here [1]
but hopefully the snippets/description is sufficient.

Thanks,
Conor.

1 - https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/commit/=
?h=3Dgpio-irq&id=3Dd1d654bd3de925a6dc48d6e2222adb3d310b8f9d

--00T+oOMGxgbKK3n9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGdXVwAKCRB4tDGHoIJi
0j1+AP9lBiTAZoMtzNZ+dwUOytHAI9hfyaJL8c82T6W/dOfsNwD/Zv4y4zpQXnH7
rIUz5OkIRe602KTdQkO5IPHy0tkF9As=
=AWth
-----END PGP SIGNATURE-----

--00T+oOMGxgbKK3n9--
