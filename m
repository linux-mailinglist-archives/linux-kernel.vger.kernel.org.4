Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722326B9255
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjCNL5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjCNL42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:56:28 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA924A029E;
        Tue, 14 Mar 2023 04:56:06 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32EBtJfd051493;
        Tue, 14 Mar 2023 06:55:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678794919;
        bh=uHm4Y10hjvWq/urDXzVMdijlz/j7xhvD4AGxkf0ml/w=;
        h=From:To:CC:Subject:Date;
        b=eowpk0pa2uctRQ1EAOZIeqKmonHwm58h7gwBC1t1a7+m/z0GNOOPyO5quJrFnTtyE
         3OgMyO6VR2Indz721hNLSxICnqq61aPrfP/TkjTkA+iS/iIyHgC1cEh7CczgRSCBdk
         aeRBUjnApNlbHlR0pZRpcTNyYGhqsNExdmHOm4V4=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32EBtJQe112447
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Mar 2023 06:55:19 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 14
 Mar 2023 06:55:18 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 14 Mar 2023 06:55:18 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32EBtH31072438;
        Tue, 14 Mar 2023 06:55:18 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <mripard@kernel.org>, <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <laurent.pinchart@ideasonboard.com>,
        <sakari.ailus@linux.intel.com>, <tomi.valkeinen@ideasonboard.com>
CC:     <linux-kernel@vger.kernel.org>, <bparrot@ti.com>,
        <niklas.soderlund+renesas@ragnatech.se>, <j-luthra@ti.com>,
        <devarsht@ti.com>, <praneeth@ti.com>, <u-kumar1@ti.com>,
        <vigneshr@ti.com>, <nm@ti.com>, <martyn.welch@collabora.com>,
        <vaishnav.a@ti.com>
Subject: [PATCH v7 00/13] CSI2RX support on J721E
Date:   Tue, 14 Mar 2023 17:25:03 +0530
Message-ID: <20230314115516.667-1-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support for CSI2 capture on J721E. It includes some
fixes to the Cadence CSI2RX driver, and adds the TI CSI2RX wrapper driver.

This is a V7 of the below V6 series,
https://lore.kernel.org/all/20220121142904.4091481-1-p.yadav@ti.com/

Since Pratyush moved out of TI, I will be working on upstreaming the
TI CSI2RX wrapper support.

Tested on TI's J721E EVM with LI OV5640 sensor module.
https://gist.github.com/vaishnavachath/f030a257d5b6569817bc9deab1c4fa77

Also, Tested on TI AM62-SK with Pcam5C OV5640 module.
https://gist.github.com/vaishnavachath/ff2605faa92f1a6ab5670426da28ccee

For all newer TI platforms that TI J721E Silicon Revision 1.0, below update
to DPHY RX driver is needed:
https://lore.kernel.org/all/20230314073137.2153-1-vaishnav.a@ti.com/

Changes in v7:
- For patch 10/13 ("Add CSI2RX support for J721E"):
- Fix incorrect value written in SHIM_PSI_CFG0_DST_TAG
- Drop support for 2X8 formats.
- Update maintainer to Vaishnav as Pratyush moved out of TI.
- Address Sakari's review comments:
- Update MAX_HEIGHT_LINES, MAX_WIDTH_BYTES to prevent overflow.
- Assign dma_slave_config during declaration, drop memset().
- dma_release_channel() on slave_config failure.
- provide entity ops for the vdev entity with link_validate().
- mutex_destroy() on ti_csi2rx_probe failure path.
- Drop busy check in remove().
- mutex_destroy() in ti_csi2rx_remove().
- Address Laurent's review comments:
- Update entries in Makefile in alphabetical order.
- include headers in alphabetical order.
- Drop redundant CSI DT defines and use from media/mipi-csi2.h.
- Rename csi_df to csi_dt.
- Drop v4l2_colorspace from ti_csi2rx_fmt and set default in
  ti_csi2rx_v4l2_init()
- Adjust field and not return EINVAL in ti_csi2rx_try_fmt_vid_cap().
- inline ti_csi2rx_video_register().
- start DMA before starting source subdev.
- move buffer cleanup to separate function ti_csi2rx_cleanup_buffers()
  to be used in ti_csi2rx_stop_streaming() and ti_csi2rx_start_streaming()
  failure path.
- Drop VB2_USERPTR, VB2_READ and V4L2_CAP_READWRITE.
- For patch 4/13 ("media: cadence: csi2rx: Add external DPHY support"):
- Fix multiplier and divider in v4l2_get_link_freq() which caused
  failures during streaming.

Changes in v6:
- Move the lock around the dereference for framefmt in
  csi2rx_{get,set}_fmt() instead of when we get the pointer.
- Do not return an error when an unsupported format is set. Instead
  adjust the code to the first format in the list.
- Drop variable bpp and use fmt->bpp directly.
- Drop variable got_pm. Call phy_pm_runtime_put() unconditionally since
  it will just return an error if runtime PM is not enabled.
- Drop transcoding from the commit message.
- Make csi2rx_media_ops const.

Changes in v5:
- Cleanup notifier in csi2rx_parse_dt() after the call to
  v4l2_async_nf_add_fwnode_remote().
- Use YUV 1X16 formats instead of 2X8.
- Only error out when phy_pm_runtime_get_sync() returns a negative
  value. A positive value can be returned if the phy was already
  resumed.
- Do not query the source subdev for format. Use the newly added
  internal format instead.
- Make i unsigned.
- Change %d to %u
- Add dependency on PHY_CADENCE_DPHY_RX instead of PHY_CADENCE_DPHY
  since the Rx mode DPHY now has a separate driver.
- Drop ti_csi2rx_validate_pipeline(). Pipeline validation should be done
  at media_pipeline_start().
- Do not assign flags.
- Fix error handling in ti_csi2rx_start_streaming(). Free up vb2 buffers
  when media_pipeline_start() fails.
- Move clock description in comments under the clocks property.
- Make ports required.
- Add link validation to cdns-csi2rx driver.

Changes in v4:
- Drop the call to set PHY submode. It is now being done via compatible
  on the DPHY side.
- Acquire the media device's graph_mutex before starting the graph walk.
- Call media_graph_walk_init() and media_graph_walk_cleanup() when
  starting and ending the graph walk respectively.
- Reduce max frame height and width in enum_framesizes. Currently they
  are set to UINT_MAX but they must be a multiple of step_width, so they
  need to be rounded down. Also, these values are absurdly large which
  causes some userspace applications like gstreamer to trip up. While it
  is not generally right to change the kernel for an application bug, it
  is not such a big deal here. This change is replacing one set of
  absurdly large arbitrary values with another set of smaller but still
  absurdly large arbitrary values. Both limits are unlikely to be hit in
  practice.
- Add power-domains property.
- Drop maxItems from clock-names.
- Drop the type for data-lanes.
- Drop uniqueItems from data-lanes. Move it to video-interfaces.yaml
  instead.
- Drop OV5640 runtime pm patch. It seems to be a bit complicated and it
  is not exactly necessary for this series. Any CSI-2 camera will work
  just fine, OV5640 just happens to be the one I tested with. I don't
  want it to block this series. I will submit it as a separate patch
  later.

Changes in v3:
- Use v4l2_get_link_freq() to calculate pixel clock.
- Move DMA related fields in struct ti_csi2rx_dma.
- Protect DMA buffer queue with a spinlock to make sure the queue buffer
  and DMA callback don't race on it.
- Track the current DMA state. It might go idle because of a lack of
  buffers. This state can be used to restart it if needed.
- Do not include the current buffer in the pending queue. It is slightly
  better modelling than leaving it at the head of the pending queue.
- Use the buffer as the callback argument, and add a reference to csi in it.
- If queueing a buffer to DMA fails, the buffer gets leaked and DMA gets
  stalled with. Instead, report the error to vb2 and queue the next
  buffer in the pending queue.
- DMA gets stalled if we run out of buffers since the callback is the
  only one that fires subsequent transfers and it is no longer being
  called. Check for that when queueing buffers and restart DMA if
  needed.
- Do not put of node until we are done using the fwnode.
- Set inital format to UYVY 640x480.
- Add compatible: contains: const: cdns,csi2rx to allow SoC specific
  compatible.
- Add more constraints for data-lanes property.

Changes in v2:
- Use phy_pm_runtime_get_sync() and phy_pm_runtime_put() before making
  calls to set PHY mode, etc. to make sure it is ready.
- Use dmaengine_get_dma_device() instead of directly accessing
  dma->device->dev.
- Do not set dst_addr_width when configuring slave DMA.
- Move to a separate subdir and rename to j721e-csi2rx.c
- Convert compatible to ti,j721e-csi2rx.
- Move to use Media Controller centric APIs.
- Improve cleanup in probe when one of the steps fails.
- Add colorspace to formats database.
- Set hw_revision on media_device.
- Move video device initialization to probe time instead of register time.
- Rename to ti,j721e-csi2rx.yaml
- Add an entry in MAINTAINERS.
- Add a description for the binding.
- Change compatible to ti,j721e-csi2rx to make it SoC specific.
- Remove description from dmas, reg, power-domains.
- Remove a limit of 2 from #address-cells and #size-cells.
- Fix add ^ to csi-bridge subnode regex.
- Make ranges mandatory.
- Add unit address in example.
- Add a reference to cdns,csi2rx in csi-bridge subnode.
- Expand the example to include the csi-bridge subnode as well.
- Re-order subject prefixes.
- Convert OV5640 to use runtime PM and drop Cadence CSI2RX s_power patch.
- Drop subdev call wrappers from cdns-csi2rx.
- Move VPE and CAL to a separate subdir.
- Rename ti-csi2rx.c to j721e-csi2rx.c

Pratyush Yadav (13):
  media: cadence: csi2rx: Unregister v4l2 async notifier
  media: cadence: csi2rx: Cleanup media entity properly
  media: cadence: csi2rx: Add get_fmt and set_fmt pad ops
  media: cadence: csi2rx: Add external DPHY support
  media: cadence: csi2rx: Soft reset the streams before starting capture
  media: cadence: csi2rx: Set the STOP bit when stopping a stream
  media: cadence: csi2rx: Fix stream data configuration
  media: cadence: csi2rx: Populate subdev devnode
  media: cadence: csi2rx: Add link validation
  media: ti: Add CSI2RX support for J721E
  media: dt-bindings: Make sure items in data-lanes are unique
  media: dt-bindings: Add DT bindings for TI J721E CSI2RX driver
  media: dt-bindings: Convert Cadence CSI2RX binding to YAML

 .../devicetree/bindings/media/cdns,csi2rx.txt |  100 --
 .../bindings/media/cdns,csi2rx.yaml           |  176 +++
 .../bindings/media/ti,j721e-csi2rx.yaml       |  101 ++
 .../bindings/media/video-interfaces.yaml      |    1 +
 MAINTAINERS                                   |    7 +
 drivers/media/platform/cadence/cdns-csi2rx.c  |  273 ++++-
 drivers/media/platform/ti/Kconfig             |   12 +
 drivers/media/platform/ti/Makefile            |    1 +
 .../media/platform/ti/j721e-csi2rx/Makefile   |    2 +
 .../platform/ti/j721e-csi2rx/j721e-csi2rx.c   | 1022 +++++++++++++++++
 10 files changed, 1580 insertions(+), 115 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/cdns,csi2rx.txt
 create mode 100644 Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
 create mode 100644 Documentation/devicetree/bindings/media/ti,j721e-csi2rx.yaml
 create mode 100644 drivers/media/platform/ti/j721e-csi2rx/Makefile
 create mode 100644 drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c

-- 
2.17.1

