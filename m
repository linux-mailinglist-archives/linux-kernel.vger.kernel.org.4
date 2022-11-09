Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F656230E5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiKIRBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiKIRAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:00:37 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F18725EB9;
        Wed,  9 Nov 2022 08:57:31 -0800 (PST)
Received: from [IPv6:2a00:23c6:c311:3401:6f3:8395:bfcd:5774] (unknown [IPv6:2a00:23c6:c311:3401:6f3:8395:bfcd:5774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B41FC660299E;
        Wed,  9 Nov 2022 16:57:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668013049;
        bh=5XX30GDDObnVpKhO4SSJkOEt/pSECVBAEq8tUkHExgg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AAVj16CGYvlm/Jul0lCXSG7FZPTSDlPoj0Gu0wLaWpg68VwHsNuFoSbLgqtER6TXD
         i+jwfAHneOJ3IKRl3+1zQXzjJgOeKH52Z2VUNF9+FN3HKvzDlnEl6TejOqkRrgo3f5
         y3l2+8xE2K3TRklipNFYtGnL9uyhuKHS0lYgttJNsx/bHAMwHCDTSrD8O2dXwLbaF6
         EpvzxEc66vIrpfpUCHpDoqLWTloy+rh8SaKLA9BRbfxXHy0uan0ZG30RR5OUbdPb7J
         vH7GFEJfHZ0X5JaLAr1WFFIwK3KgATcgdoXjO7Hzs9wKPkuADXF69vOxYpns0yYlEz
         35KGtdtk3Sy/Q==
Message-ID: <ffad28af41ddb78b8d1a9dab7ca2d31d61fb1ba4.camel@collabora.com>
Subject: Re: [PATCH v6 00/14] CSI2RX support on J721E
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Pratyush Yadav <p.yadav@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Benoit Parrot <bparrot@ti.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Niklas =?ISO-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Date:   Wed, 09 Nov 2022 16:57:26 +0000
In-Reply-To: <20220121142904.4091481-1-p.yadav@ti.com>
References: <20220121142904.4091481-1-p.yadav@ti.com>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.0-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-01-21 at 19:58 +0530, Pratyush Yadav wrote:
> Hi,
>=20
> This series adds support for CSI2 capture on J721E. It includes some
> fixes to the Cadence CSI2RX driver, re-structures the TI platform
> drivers, and finally adds the TI CSI2RX wrapper driver.
>=20
> This series used to include the DPHY and DMA engine patches as well,
> but
> they have been split off to facilitate easier merging.
>=20
> Tested on TI's J721E with OV5640 sensor.
>=20
> The branch with all the patches needed to enable testing (dts nodes,
> OV5640 dropped patch, etc.) can be found here at
> https://github.com/prati0100/linux-next/=C2=A0branch "capture".
>=20

I've recently tried the patches from the above repo, ported forward to
kernel v6.0 on the AM625-SK with an OV5640 based camera. There were a
few things that I've had to patch up/hack to get it basically working,
the biggest probably being that (unlike the vendor driver provided for
this board) the CSI bridge gets set in 1x16 mode and the OV5640 driver
is hard coded to 2x8. I have a tree here:

https://gitlab.collabora.com/martyn/linux/-/commits/am625-sk-ov5640/

With the tree I've assembled I'm seeing capture failures a good
percentage of the time. I'm trying to capture a series of 10 still
images at the moment, the pipeline seems to get setup then no data
arrives (or at least it's not recognised). Killing it and rerunning
usually (eventually) works. I haven't dug into that yet.

Martyn

> Changes in v6:
> - Move the lock around the dereference for framefmt in
> =C2=A0 csi2rx_{get,set}_fmt() instead of when we get the pointer.
> - Do not return an error when an unsupported format is set. Instead
> =C2=A0 adjust the code to the first format in the list.
> - Drop variable bpp and use fmt->bpp directly.
> - Drop variable got_pm. Call phy_pm_runtime_put() unconditionally
> since
> =C2=A0 it will just return an error if runtime PM is not enabled.
> - Drop transcoding from the commit message.
> - Make csi2rx_media_ops const.
>=20
> Changes in v5:
> - Cleanup notifier in csi2rx_parse_dt() after the call to
> =C2=A0 v4l2_async_nf_add_fwnode_remote().
> - Use YUV 1X16 formats instead of 2X8.
> - Only error out when phy_pm_runtime_get_sync() returns a negative
> =C2=A0 value. A positive value can be returned if the phy was already
> =C2=A0 resumed.
> - Do not query the source subdev for format. Use the newly added
> =C2=A0 internal format instead.
> - Make i unsigned.
> - Change %d to %u
> - Add dependency on PHY_CADENCE_DPHY_RX instead of PHY_CADENCE_DPHY
> =C2=A0 since the Rx mode DPHY now has a separate driver.
> - Drop ti_csi2rx_validate_pipeline(). Pipeline validation should be
> done
> =C2=A0 at media_pipeline_start().
> - Do not assign flags.
> - Fix error handling in ti_csi2rx_start_streaming(). Free up vb2
> buffers
> =C2=A0 when media_pipeline_start() fails.
> - Move clock description in comments under the clocks property.
> - Make ports required.
> - Add link validation to cdns-csi2rx driver.
>=20
> Changes in v4:
> - Drop the call to set PHY submode. It is now being done via
> compatible
> =C2=A0 on the DPHY side.
> - Acquire the media device's graph_mutex before starting the graph
> walk.
> - Call media_graph_walk_init() and media_graph_walk_cleanup() when
> =C2=A0 starting and ending the graph walk respectively.
> - Reduce max frame height and width in enum_framesizes. Currently
> they
> =C2=A0 are set to UINT_MAX but they must be a multiple of step_width, so
> they
> =C2=A0 need to be rounded down. Also, these values are absurdly large
> which
> =C2=A0 causes some userspace applications like gstreamer to trip up. Whil=
e
> it
> =C2=A0 is not generally right to change the kernel for an application bug=
,
> it
> =C2=A0 is not such a big deal here. This change is replacing one set of
> =C2=A0 absurdly large arbitrary values with another set of smaller but
> still
> =C2=A0 absurdly large arbitrary values. Both limits are unlikely to be hi=
t
> in
> =C2=A0 practice.
> - Add power-domains property.
> - Drop maxItems from clock-names.
> - Drop the type for data-lanes.
> - Drop uniqueItems from data-lanes. Move it to video-interfaces.yaml
> =C2=A0 instead.
> - Drop OV5640 runtime pm patch. It seems to be a bit complicated and
> it
> =C2=A0 is not exactly necessary for this series. Any CSI-2 camera will
> work
> =C2=A0 just fine, OV5640 just happens to be the one I tested with. I don'=
t
> =C2=A0 want it to block this series. I will submit it as a separate patch
> =C2=A0 later.
>=20
> Changes in v3:
> - Use v4l2_get_link_freq() to calculate pixel clock.
> - Move DMA related fields in struct ti_csi2rx_dma.
> - Protect DMA buffer queue with a spinlock to make sure the queue
> buffer
> =C2=A0 and DMA callback don't race on it.
> - Track the current DMA state. It might go idle because of a lack of
> =C2=A0 buffers. This state can be used to restart it if needed.
> - Do not include the current buffer in the pending queue. It is
> slightly
> =C2=A0 better modelling than leaving it at the head of the pending queue.
> - Use the buffer as the callback argument, and add a reference to csi
> in it.
> - If queueing a buffer to DMA fails, the buffer gets leaked and DMA
> gets
> =C2=A0 stalled with. Instead, report the error to vb2 and queue the next
> =C2=A0 buffer in the pending queue.
> - DMA gets stalled if we run out of buffers since the callback is the
> =C2=A0 only one that fires subsequent transfers and it is no longer being
> =C2=A0 called. Check for that when queueing buffers and restart DMA if
> =C2=A0 needed.
> - Do not put of node until we are done using the fwnode.
> - Set inital format to UYVY 640x480.
> - Add compatible: contains: const: cdns,csi2rx to allow SoC specific
> =C2=A0 compatible.
> - Add more constraints for data-lanes property.
>=20
> Changes in v2:
> - Use phy_pm_runtime_get_sync() and phy_pm_runtime_put() before
> making
> =C2=A0 calls to set PHY mode, etc. to make sure it is ready.
> - Use dmaengine_get_dma_device() instead of directly accessing
> =C2=A0 dma->device->dev.
> - Do not set dst_addr_width when configuring slave DMA.
> - Move to a separate subdir and rename to j721e-csi2rx.c
> - Convert compatible to ti,j721e-csi2rx.
> - Move to use Media Controller centric APIs.
> - Improve cleanup in probe when one of the steps fails.
> - Add colorspace to formats database.
> - Set hw_revision on media_device.
> - Move video device initialization to probe time instead of register
> time.
> - Rename to ti,j721e-csi2rx.yaml
> - Add an entry in MAINTAINERS.
> - Add a description for the binding.
> - Change compatible to ti,j721e-csi2rx to make it SoC specific.
> - Remove description from dmas, reg, power-domains.
> - Remove a limit of 2 from #address-cells and #size-cells.
> - Fix add ^ to csi-bridge subnode regex.
> - Make ranges mandatory.
> - Add unit address in example.
> - Add a reference to cdns,csi2rx in csi-bridge subnode.
> - Expand the example to include the csi-bridge subnode as well.
> - Re-order subject prefixes.
> - Convert OV5640 to use runtime PM and drop Cadence CSI2RX s_power
> patch.
> - Drop subdev call wrappers from cdns-csi2rx.
> - Move VPE and CAL to a separate subdir.
> - Rename ti-csi2rx.c to j721e-csi2rx.c
>=20
> Pratyush Yadav (14):
> =C2=A0 media: cadence: csi2rx: Unregister v4l2 async notifier
> =C2=A0 media: cadence: csi2rx: Cleanup media entity properly
> =C2=A0 media: cadence: csi2rx: Add get_fmt and set_fmt pad ops
> =C2=A0 media: cadence: csi2rx: Add external DPHY support
> =C2=A0 media: cadence: csi2rx: Soft reset the streams before starting
> capture
> =C2=A0 media: cadence: csi2rx: Set the STOP bit when stopping a stream
> =C2=A0 media: cadence: csi2rx: Fix stream data configuration
> =C2=A0 media: cadence: csi2rx: Populate subdev devnode
> =C2=A0 media: cadence: csi2rx: Add link validation
> =C2=A0 media: Re-structure TI platform drivers
> =C2=A0 media: ti: Add CSI2RX support for J721E
> =C2=A0 media: dt-bindings: Make sure items in data-lanes are unique
> =C2=A0 media: dt-bindings: Add DT bindings for TI J721E CSI2RX driver
> =C2=A0 media: dt-bindings: Convert Cadence CSI2RX binding to YAML
>=20
> =C2=A0.../devicetree/bindings/media/cdns,csi2rx.txt | 100 --
> =C2=A0.../bindings/media/cdns,csi2rx.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 176 ++++
> =C2=A0.../bindings/media/ti,j721e-csi2rx.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 101 ++
> =C2=A0.../bindings/media/video-interfaces.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 1 +
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 10 +-
> =C2=A0drivers/media/platform/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 12 +
> =C2=A0drivers/media/platform/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0drivers/media/platform/cadence/cdns-csi2rx.c=C2=A0 | 274 +++++-
> =C2=A0drivers/media/platform/ti/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
> =C2=A0drivers/media/platform/ti/cal/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> =C2=A0.../{ti-vpe =3D> ti/cal}/cal-camerarx.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 0
> =C2=A0.../platform/{ti-vpe =3D> ti/cal}/cal-video.c=C2=A0=C2=A0 |=C2=A0=
=C2=A0 0
> =C2=A0.../media/platform/{ti-vpe =3D> ti/cal}/cal.c=C2=A0=C2=A0 |=C2=A0=
=C2=A0 0
> =C2=A0.../media/platform/{ti-vpe =3D> ti/cal}/cal.h=C2=A0=C2=A0 |=C2=A0=
=C2=A0 0
> =C2=A0.../platform/{ti-vpe =3D> ti/cal}/cal_regs.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 0
> =C2=A0.../media/platform/ti/j721e-csi2rx/Makefile=C2=A0=C2=A0 |=C2=A0=C2=
=A0 2 +
> =C2=A0.../platform/ti/j721e-csi2rx/j721e-csi2rx.c=C2=A0=C2=A0 | 913
> ++++++++++++++++++
> =C2=A0.../platform/{ti-vpe =3D> ti/vpe}/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 4 -
> =C2=A0.../media/platform/{ti-vpe =3D> ti/vpe}/csc.c=C2=A0=C2=A0 |=C2=A0=
=C2=A0 0
> =C2=A0.../media/platform/{ti-vpe =3D> ti/vpe}/csc.h=C2=A0=C2=A0 |=C2=A0=
=C2=A0 0
> =C2=A0.../media/platform/{ti-vpe =3D> ti/vpe}/sc.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 0
> =C2=A0.../media/platform/{ti-vpe =3D> ti/vpe}/sc.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 0
> =C2=A0.../platform/{ti-vpe =3D> ti/vpe}/sc_coeff.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 0
> =C2=A0.../media/platform/{ti-vpe =3D> ti/vpe}/vpdma.c |=C2=A0=C2=A0 0
> =C2=A0.../media/platform/{ti-vpe =3D> ti/vpe}/vpdma.h |=C2=A0=C2=A0 0
> =C2=A0.../platform/{ti-vpe =3D> ti/vpe}/vpdma_priv.h=C2=A0 |=C2=A0=C2=A0 =
0
> =C2=A0.../media/platform/{ti-vpe =3D> ti/vpe}/vpe.c=C2=A0=C2=A0 |=C2=A0=
=C2=A0 0
> =C2=A0.../platform/{ti-vpe =3D> ti/vpe}/vpe_regs.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 0
> =C2=A028 files changed, 1481 insertions(+), 121 deletions(-)
> =C2=A0delete mode 100644
> Documentation/devicetree/bindings/media/cdns,csi2rx.txt
> =C2=A0create mode 100644
> Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
> =C2=A0create mode 100644 Documentation/devicetree/bindings/media/ti,j721e=
-
> csi2rx.yaml
> =C2=A0create mode 100644 drivers/media/platform/ti/Makefile
> =C2=A0create mode 100644 drivers/media/platform/ti/cal/Makefile
> =C2=A0rename drivers/media/platform/{ti-vpe =3D> ti/cal}/cal-camerarx.c
> (100%)
> =C2=A0rename drivers/media/platform/{ti-vpe =3D> ti/cal}/cal-video.c (100=
%)
> =C2=A0rename drivers/media/platform/{ti-vpe =3D> ti/cal}/cal.c (100%)
> =C2=A0rename drivers/media/platform/{ti-vpe =3D> ti/cal}/cal.h (100%)
> =C2=A0rename drivers/media/platform/{ti-vpe =3D> ti/cal}/cal_regs.h (100%=
)
> =C2=A0create mode 100644 drivers/media/platform/ti/j721e-csi2rx/Makefile
> =C2=A0create mode 100644 drivers/media/platform/ti/j721e-csi2rx/j721e-
> csi2rx.c
> =C2=A0rename drivers/media/platform/{ti-vpe =3D> ti/vpe}/Makefile (78%)
> =C2=A0rename drivers/media/platform/{ti-vpe =3D> ti/vpe}/csc.c (100%)
> =C2=A0rename drivers/media/platform/{ti-vpe =3D> ti/vpe}/csc.h (100%)
> =C2=A0rename drivers/media/platform/{ti-vpe =3D> ti/vpe}/sc.c (100%)
> =C2=A0rename drivers/media/platform/{ti-vpe =3D> ti/vpe}/sc.h (100%)
> =C2=A0rename drivers/media/platform/{ti-vpe =3D> ti/vpe}/sc_coeff.h (100%=
)
> =C2=A0rename drivers/media/platform/{ti-vpe =3D> ti/vpe}/vpdma.c (100%)
> =C2=A0rename drivers/media/platform/{ti-vpe =3D> ti/vpe}/vpdma.h (100%)
> =C2=A0rename drivers/media/platform/{ti-vpe =3D> ti/vpe}/vpdma_priv.h (10=
0%)
> =C2=A0rename drivers/media/platform/{ti-vpe =3D> ti/vpe}/vpe.c (100%)
> =C2=A0rename drivers/media/platform/{ti-vpe =3D> ti/vpe}/vpe_regs.h (100%=
)
>=20

