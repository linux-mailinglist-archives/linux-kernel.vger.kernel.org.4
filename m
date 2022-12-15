Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED15364DAFC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiLOMRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiLOMRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:17:09 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1253023178;
        Thu, 15 Dec 2022 04:17:08 -0800 (PST)
Received: from desky.lan (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9ADE3327;
        Thu, 15 Dec 2022 13:17:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671106626;
        bh=vHL6GZOxYhpH36KMFMPNVqQC7bma+TwthR0lKzTlePI=;
        h=From:To:Cc:Subject:Date:From;
        b=f3diQ6mmvwrmIgKtwo574H9q3BED+ARNjlSNhYMHGV/7EwMTzRfqXNyYunGjksrxk
         Lk6eCMxa0I4EJclzqQfVehmcbHX33fUwJm8K4h7mWFI/oENPBCxqjVt3HES+d6gYln
         3O16jKi2CEYpihoicgZF2y/9kW8FOb4mnnb1kZZA=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        sakari.ailus@linux.intel.com,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        niklas.soderlund+renesas@ragnatech.se,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        satish.nagireddy@getcruise.com, Tomasz Figa <tfiga@chromium.org>
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v16 00/20] v4l: routing and streams support
Date:   Thu, 15 Dec 2022 14:16:14 +0200
Message-Id: <20221215121634.287100-1-tomi.valkeinen@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v16 of the streams series. The v15 can be found from:

https://lore.kernel.org/all/20221003121852.616745-1-tomi.valkeinen@ideasonboard.com/

My work branch with additional drivers can be found from:

git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git streams/work-v16

And there's also the v4l-utils series v2 to add support to v4l2-ctl and
media-ctl:

https://lore.kernel.org/all/20220714132116.132498-1-tomi.valkeinen@ideasonboard.com/

(Note: the v4l-utils above has not been changed to accommodate the drop
of V4L2_SUBDEV_ROUTE_FL_SOURCE yet)

Changes in v16:
- v4l2_subdev_link_validate_get_format: Drop use of for_each_set_bit(),
  as the sink_streams_mask is not unsigned long.
- v4l2_subdev_set_routing: Cast parameters given to check_mul_overflow()
  to size_t to avoid compiler warnings.
- Drop V4L2_SUBDEV_ROUTE_FL_SOURCE
- Require a code change and kernel compilation to enable Streams API.

A bit more details for the last two changes:

V4L2_SUBDEV_ROUTE_FL_SOURCE felt somewhat hacky, and the whole question
of how sensors' streams in various cases should be handled was unclear.
Thus it was decided (me, Laurent, Sakari) that we should only support
the current single-stream sensors and work on multi-streams sensors on
top of this series. This should not hinder any use case that was
supportable in the v15, as most likely the second stream from a sensor
would be an embedded data stream, and embedded data is not (really)
supported upstream.

The routing and stream support has been worked on for years by multiple
persons, and has proven to be very complicated feature, or a set of
features. While this series has been used on multiple different
platforms for various use cases, we would still like to be on the safe
side, especially regarding the userspace APIs. Thus, we decided that it
would be good to get this series merged while still making it clear that
the uAPI is not quite stable yet, and to achieve that, there's a static
variable in v4l2-subdev.c that the user needs to set to enable the API.

 Tomi

Jacopo Mondi (2):
  media: Documentation: Add GS_ROUTING documentation
  media: subdev: Add for_each_active_route() macro

Laurent Pinchart (5):
  media: subdev: Add [GS]_ROUTING subdev ioctls and operations
  media: subdev: add v4l2_subdev_routing_validate() helper
  media: v4l2-subdev: Add v4l2_subdev_state_xlate_streams() helper
  media: v4l2-subdev: Add subdev .(enable|disable)_streams() operations
  media: v4l2-subdev: Add v4l2_subdev_s_stream_helper() function

Sakari Ailus (1):
  media: Add stream to frame descriptor

Tomi Valkeinen (12):
  media: v4l2-subdev: Sort includes
  media: add V4L2_SUBDEV_FL_STREAMS
  media: add V4L2_SUBDEV_CAP_STREAMS
  media: subdev: Require code change to enable [GS]_ROUTING
  media: subdev: add v4l2_subdev_has_pad_interdep()
  media: subdev: add v4l2_subdev_set_routing helper()
  media: Documentation: add multiplexed streams documentation
  media: subdev: add stream based configuration
  media: subdev: use streams in v4l2_subdev_link_validate()
  media: subdev: add "opposite" stream helper funcs
  media: subdev: add streams to v4l2_subdev_get_fmt() helper function
  media: subdev: add v4l2_subdev_set_routing_with_fmt() helper

 .clang-format                                 |    1 +
 .../driver-api/media/v4l2-subdev.rst          |    8 +
 .../userspace-api/media/v4l/dev-subdev.rst    |  140 +++
 .../userspace-api/media/v4l/user-func.rst     |    1 +
 .../v4l/vidioc-subdev-enum-frame-interval.rst |    5 +-
 .../v4l/vidioc-subdev-enum-frame-size.rst     |    5 +-
 .../v4l/vidioc-subdev-enum-mbus-code.rst      |    5 +-
 .../media/v4l/vidioc-subdev-g-crop.rst        |    5 +-
 .../media/v4l/vidioc-subdev-g-fmt.rst         |    5 +-
 .../v4l/vidioc-subdev-g-frame-interval.rst    |    5 +-
 .../media/v4l/vidioc-subdev-g-routing.rst     |  147 +++
 .../media/v4l/vidioc-subdev-g-selection.rst   |    5 +-
 drivers/media/v4l2-core/v4l2-ioctl.c          |   25 +-
 drivers/media/v4l2-core/v4l2-subdev.c         | 1000 ++++++++++++++++-
 include/media/v4l2-subdev.h                   |  377 +++++++
 include/uapi/linux/v4l2-subdev.h              |   74 +-
 16 files changed, 1758 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-subdev-g-routing.rst

-- 
2.34.1

