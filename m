Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AAF634C4F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 02:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbiKWBKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 20:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbiKWBJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 20:09:53 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54833E0B4C;
        Tue, 22 Nov 2022 17:09:50 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso330611wme.5;
        Tue, 22 Nov 2022 17:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h2P8gf+wYzNKXOx25cSrhvpGQEoNCTuekRCx+Nw2j28=;
        b=m2ab6VCR2FqDwCD4YCiNpRcdmDoAQrBbX/dPrkdeM9t2NyndedzI2IG8mD60mUm+AS
         ib/OxSLKLMc4mSY9ihY2YqWj26Y5sZ2xMz57V5EsGXGPOdHMSHsa/BypSnXt69gOz8ZO
         ELzZxqZ0TKaQKmIyqz04osgS/sowX7MVojqY2L5wQjsWCgu9KnR3dfzhdL3CdpELZMR+
         2AsHNa7Fqldh4+Mogv6GP7IeRDjwYURfL3qQO3zyLrqTC3Lcx1GxPSCizs80xa/YhcN7
         5d7UHYIRFf96NW/SHwDj5AvcmXK0rQ1CEiDCb2n/eqg2QwdbqpZ+wEG+JwVFriroI5ZJ
         UVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h2P8gf+wYzNKXOx25cSrhvpGQEoNCTuekRCx+Nw2j28=;
        b=fI34Qa+eWMglBK+sm1tyXF4WSpdDB4oBn5pWwIYrR2T/H/uvkUj/tuXxteMHEMG5WJ
         pSSH87UiE/rIPGpr6dpzrAAzB0bYNWjUwFPxchvdetfir0j243KREOHJBxZGLkT4Sx7U
         qSmkwJlJXDyiIIptY3L3cYviFWpNWg1y6w50d++T+nRBCg8IvJHQyirD9m/3s1hQWS4x
         KcQw9zDHb/NjJTKJZqa4SvTWTV4WXe7g1UU+hmXB6JAn7CTGv58fhQmGBNRVIcLEAIAC
         qwEBGdAblkpyC4zUYjgqw2CZpfY1QBgvpR0ggPvW/+7PELq60ZktDlitJar6mcUQQHDA
         sCmg==
X-Gm-Message-State: ANoB5plm00CsrSoJR4DzApGM8XPlOXb3KIIAqdTu3jyRB8QtnwBDsW8y
        h5ccV4rKEBCnfs/Fe2+l6Do=
X-Google-Smtp-Source: AA0mqf7lmH+04AUolkaBTFwPPeNuy3oJWCslZo4NOqqslaATaVYt/0jlzNZCtH0/Cwap0/Fx9E1JPg==
X-Received: by 2002:a7b:c4d8:0:b0:3cf:9bcd:5009 with SMTP id g24-20020a7bc4d8000000b003cf9bcd5009mr9770744wmk.196.1669165788598;
        Tue, 22 Nov 2022 17:09:48 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:3178:d8a1:a393:6d85])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c315100b003cf483ee8e0sm421345wmo.24.2022.11.22.17.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 17:09:47 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v6 0/4] Add driver for CSI2 and CRU modules found on Renesas RZ/G2L SoC
Date:   Wed, 23 Nov 2022 01:09:39 +0000
Message-Id: <20221123010943.324689-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URI_HEX autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This patch series aims to add driver support to CRU module found on Renesas
RZ/G2L SoC.

The Camera Data Receiving Unit (CRU) consists of a MIPI CSI-2 block and an
Image Processing block. The Image Processing block can receive video data
received from the external Digital Parallel Interface or MIPI CSI-2 block,
and perform appropriate image processing for each.

More details:
* https://renesas.info/wiki/File:CRU.png
* https://www.renesas.com/document/mah/rzg2l-group-rzg2lc-group-users-manual-hardware-0?language=en&r=1467981

Currently the driver has been tested using yavta and Gstreamer on RZ/G2L
SMARC EVK using the ov5645 sensor on CSI2 interface only.

Pipeline and compliance output:
------------------------------------

root@smarc-rzg2l:~# media-ctl -p
Media controller API version 6.1.0

Media device information
------------------------
driver          rzg2l_cru
model           renesas,rzg2l-cru
serial
bus info        platform:10830000.video
hw revision     0x0
driver version  6.1.0

Device topology
- entity 1: csi-10830400.csi2 (2 pads, 2 links)
            type V4L2 subdev subtype Unknown flags 0
            device node name /dev/v4l-subdev0
        pad0: Sink
                [fmt:UYVY8_1X16/1280x960 field:none colorspace:srgb]
                <- "ov5645 0-003c":0 [ENABLED,IMMUTABLE]
        pad1: Source
                [fmt:UYVY8_1X16/1280x960 field:none colorspace:srgb]
                -> "cru-ip-10830000.video":0 [ENABLED,IMMUTABLE]

- entity 4: ov5645 0-003c (1 pad, 1 link)
            type V4L2 subdev subtype Sensor flags 0
            device node name /dev/v4l-subdev1
        pad0: Source
                [fmt:UYVY8_1X16/1280x960 field:none colorspace:srgb
                 crop:(0,0)/1280x960]
                -> "csi-10830400.csi2":0 [ENABLED,IMMUTABLE]

- entity 8: cru-ip-10830000.video (2 pads, 2 links)
            type V4L2 subdev subtype Unknown flags 0
            device node name /dev/v4l-subdev2
        pad0: Sink
                [fmt:UYVY8_1X16/1280x960 field:none]
                <- "csi-10830400.csi2":1 [ENABLED,IMMUTABLE]
        pad1: Source
                [fmt:UYVY8_1X16/1280x960 field:none]
                -> "CRU output":0 [ENABLED,IMMUTABLE]

- entity 17: CRU output (1 pad, 1 link)
             type Node subtype V4L flags 0
             device node name /dev/video0
        pad0: Sink
                <- "cru-ip-10830000.video":1 [ENABLED,IMMUTABLE]

root@smarc-rzg2l:~# v4l2-compliance -s
v4l2-compliance 1.22.1-4864, 64 bits, 64-bit time_t
v4l2-compliance SHA: 47c8c377cf29 2021-10-23 15:12:35

Compliance test for rzg2l_cru device /dev/video0:

Driver Info:
        Driver name      : rzg2l_cru
        Card type        : RZG2L_CRU
        Bus info         : platform:10830000.video
        Driver version   : 6.1.0
        Capabilities     : 0xa4200001
                Video Capture
                Streaming
                Extended Pix Format
                Device Capabilities
        Device Caps      : 0x24200001
                Video Capture
                Streaming
                Extended Pix Format
Media Driver Info:
        Driver name      : rzg2l_cru
        Model            : renesas,rzg2l-cru
        Serial           :
        Bus info         : platform:10830000.video
        Media version    : 6.1.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.1.0
Interface Info:
        ID               : 0x03000013
        Type             : V4L Video
Entity Info:
        ID               : 0x00000011 (17)
        Name             : CRU output
        Function         : V4L2 I/O
        Pad 0x01000012   : 0: Sink
          Link 0x02000017: from remote pad 0x100000a of entity 'cru-ip-10830000.video' (Video Pixel Formatter): Data, Enabled, Immutable

Required ioctls:
        test MC information (see 'Media Driver Info' above): OK
        test VIDIOC_QUERYCAP: OK
        test invalid ioctls: OK

Allow for multiple opens:
        test second /dev/video0 open: OK
        test VIDIOC_QUERYCAP: OK
        test VIDIOC_G/S_PRIORITY: OK
        test for unlimited opens: OK

Debug ioctls:
        test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
        test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
        test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
        test VIDIOC_ENUMAUDIO: OK (Not Supported)
        test VIDIOC_G/S/ENUMINPUT: OK
        test VIDIOC_G/S_AUDIO: OK (Not Supported)
        Inputs: 1 Audio Inputs: 0 Tuners: 0

Output ioctls:
        test VIDIOC_G/S_MODULATOR: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_ENUMAUDOUT: OK (Not Supported)
        test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDOUT: OK (Not Supported)
        Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
        test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
        test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
        test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
        test VIDIOC_G/S_EDID: OK (Not Supported)

Control ioctls (Input 0):
        test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK (Not Supported)
        test VIDIOC_QUERYCTRL: OK (Not Supported)
        test VIDIOC_G/S_CTRL: OK (Not Supported)
        test VIDIOC_G/S/TRY_EXT_CTRLS: OK (Not Supported)
        test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK (Not Supported)
        test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
        Standard Controls: 0 Private Controls: 0

Format ioctls (Input 0):
        test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
        test VIDIOC_G/S_PARM: OK (Not Supported)
        test VIDIOC_G_FBUF: OK (Not Supported)
        test VIDIOC_G_FMT: OK
        test VIDIOC_TRY_FMT: OK
        test VIDIOC_S_FMT: OK
        test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
        test Cropping: OK (Not Supported)
        test Composing: OK (Not Supported)
        test Scaling: OK

Codec ioctls (Input 0):
        test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
        test VIDIOC_G_ENC_INDEX: OK (Not Supported)
        test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls (Input 0):
        test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
        test VIDIOC_EXPBUF: OK
        test Requests: OK (Not Supported)

Test input 0:

Streaming ioctls:
        test read/write: OK (Not Supported)
        test blocking wait: OK
        test MMAP (no poll): OK
        test MMAP (select): OK
        test MMAP (epoll): OK
        test USERPTR (no poll): OK (Not Supported)
        test USERPTR (select): OK (Not Supported)
        test DMABUF: Cannot test, specify --expbuf-device

Total for rzg2l_cru device /dev/video0: 53, Succeeded: 53, Failed: 0, Warnings: 0
root@smarc-rzg2l:~# v4l2-compliance  -u /dev/v4l-subdev0
v4l2-compliance 1.22.1-4864, 64 bits, 64-bit time_t
v4l2-compliance SHA: 47c8c377cf29 2021-10-23 15:12:35

Compliance test for device /dev/v4l-subdev0:

Driver Info:
        Driver vers[ 2623.091211] csi-10830400.csi2: =================  START STATUS  =================
ion   : 6.1.0
        [ 2623.100129] csi-10830400.csi2: ==================  END STATUS  ==================
Capabilities     : 0x00000000

Required ioctls:
        test VIDIOC_SUDBEV_QUERYCAP: OK
        test invalid ioctls: OK

Allow for multiple opens:
        test second /dev/v4l-subdev0 open: OK
        test VIDIOC_SUBDEV_QUERYCAP: OK
        test for unlimited opens: OK

Debug ioctls:
        test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
        test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
        test VIDIOC_ENUMAUDIO: OK (Not Supported)
        test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDIO: OK (Not Supported)
        Inputs: 0 Audio Inputs: 0 Tuners: 0

Output ioctls:
        test VIDIOC_G/S_MODULATOR: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_ENUMAUDOUT: OK (Not Supported)
        test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDOUT: OK (Not Supported)
        Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
        test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
        test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
        test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
        test VIDIOC_G/S_EDID: OK (Not Supported)

Control ioctls:
        test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK (Not Supported)
        test VIDIOC_QUERYCTRL: OK (Not Supported)
        test VIDIOC_G/S_CTRL: OK (Not Supported)
        test VIDIOC_G/S/TRY_EXT_CTRLS: OK (Not Supported)
        test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK (Not Supported)
        test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
        Standard Controls: 0 Private Controls: 0

Format ioctls:
        test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK (Not Supported)
        test VIDIOC_G/S_PARM: OK (Not Supported)
        test VIDIOC_G_FBUF: OK (Not Supported)
        test VIDIOC_G_FMT: OK (Not Supported)
        test VIDIOC_TRY_FMT: OK (Not Supported)
        test VIDIOC_S_FMT: OK (Not Supported)
        test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
        test Cropping: OK (Not Supported)
        test Composing: OK (Not Supported)
        test Scaling: OK (Not Supported)

Codec ioctls:
        test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
        test VIDIOC_G_ENC_INDEX: OK (Not Supported)
        test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls:
        test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK (Not Supported)
        test VIDIOC_EXPBUF: OK (Not Supported)
        test Requests: OK (Not Supported)

Total for device /dev/v4l-subdev0: 43, Succeeded: 43, Failed: 0, Warnings: 0
root@smarc-rzg2l:~# v4l2-compliance  -u /dev/v4l-subdev2
v4l2-compliance 1.22.1-4864, 64 bits, 64-bit time_t
v4l2-compliance SHA: 47c8c377cf29 2021-10-23 15:12:35

Compliance test for rzg2l_cru device /dev/v4l-subdev2:

Driver I[ 2629.048613] cru-ip-10830000.video: =================  START STATUS  =================
nfo:
        Driver ve[ 2629.057842] cru-ip-10830000.video: ==================  END STATUS  ==================
rsion   : 6.1.0
        Capabilities     : 0x00000000
Media Driver Info:
        Driver name      : rzg2l_cru
        Model            : renesas,rzg2l-cru
        Serial           :
        Bus info         : platform:10830000.video
        Media version    : 6.1.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.1.0
Interface Info:
        ID               : 0x0300000f
        Type             : V4L Sub-Device
Entity Info:
        ID               : 0x00000008 (8)
        Name             : cru-ip-10830000.video
        Function         : Video Pixel Formatter
        Pad 0x01000009   : 0: Sink
          Link 0x02000015: from remote pad 0x1000003 of entity 'csi-10830400.csi2' (Video Interface Bridge): Data, Enabled, Immutable
        Pad 0x0100000a   : 1: Source
          Link 0x02000017: to remote pad 0x1000012 of entity 'CRU output' (V4L2 I/O): Data, Enabled, Immutable

Required ioctls:
        test MC information (see 'Media Driver Info' above): OK
        test VIDIOC_SUDBEV_QUERYCAP: OK
        test invalid ioctls: OK

Allow for multiple opens:
        test second /dev/v4l-subdev2 open: OK
        test VIDIOC_SUBDEV_QUERYCAP: OK
        test for unlimited opens: OK

Debug ioctls:
        test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
        test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
        test VIDIOC_ENUMAUDIO: OK (Not Supported)
        test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDIO: OK (Not Supported)
        Inputs: 0 Audio Inputs: 0 Tuners: 0

Output ioctls:
        test VIDIOC_G/S_MODULATOR: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_ENUMAUDOUT: OK (Not Supported)
        test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDOUT: OK (Not Supported)
        Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
        test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
        test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
        test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
        test VIDIOC_G/S_EDID: OK (Not Supported)

Sub-Device ioctls (Sink Pad 0):
        test Try VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
        test Try VIDIOC_SUBDEV_G/S_FMT: OK
        test Try VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
        test Active VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
        test Active VIDIOC_SUBDEV_G/S_FMT: OK
        test Active VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
        test VIDIOC_SUBDEV_G/S_FRAME_INTERVAL: OK (Not Supported)

Sub-Device ioctls (Source Pad 1):
        test Try VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
        test Try VIDIOC_SUBDEV_G/S_FMT: OK
        test Try VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
        test Active VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
        test Active VIDIOC_SUBDEV_G/S_FMT: OK
        test Active VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
        test VIDIOC_SUBDEV_G/S_FRAME_INTERVAL: OK (Not Supported)

Control ioctls:
        test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK (Not Supported)
        test VIDIOC_QUERYCTRL: OK (Not Supported)
        test VIDIOC_G/S_CTRL: OK (Not Supported)
        test VIDIOC_G/S/TRY_EXT_CTRLS: OK (Not Supported)
        test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK (Not Supported)
        test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
        Standard Controls: 0 Private Controls: 0

Format ioctls:
        test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK (Not Supported)
        test VIDIOC_G/S_PARM: OK (Not Supported)
        test VIDIOC_G_FBUF: OK (Not Supported)
        test VIDIOC_G_FMT: OK (Not Supported)
        test VIDIOC_TRY_FMT: OK (Not Supported)
        test VIDIOC_S_FMT: OK (Not Supported)
        test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
        test Cropping: OK (Not Supported)
        test Composing: OK (Not Supported)
        test Scaling: OK (Not Supported)

Codec ioctls:
        test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
        test VIDIOC_G_ENC_INDEX: OK (Not Supported)
        test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls:
        test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK (Not Supported)
        test VIDIOC_EXPBUF: OK (Not Supported)
        test Requests: OK (Not Supported)

Total for rzg2l_cru device /dev/v4l-subdev2: 58, Succeeded: 58, Failed: 0, Warnings: 0
root@smarc-rzg2l:~#

v5 -> v6
* DT binding patches un-changed
* Dropped array indexing in rzg2l_csi2_global_timings.
* Implemented PM runtime
* Dropped Checking pad in rzg2l_csi2_set_format()
* Dropped printing error message in case of s_stream failure
* Dropped updating source pad format in set_fmt 
* Made pad links ENABLED | IMMUTABLE for CRU IP <-> CSI and CRU IP <-> output
* Enable PM runtime before rzg2l_cru_dma_register() call
* Moved media_device_register()/media_device_unregister() in
  rzg2l_cru_video_register()/rzg2l_cru_video_unregister() functions
* Dropped including v4l2-ctrls.h
* Dropped missing filed doc for structure
* Made input_is_yuv and output_is_yuv as local variables
* Got rid of is_csi for now as we are currently support CSI only.
* Got rid of compose member from struct rzg2l_cru_dev
* Got rid of mbus_code member from struct rzg2l_cru_dev
* Propagate sink fmt to src format
* Now validating fse code in enum_frame_size
* Dropped log_status callback
* Dropped including v4l2-event.h
* Dropped setting bus_info in rzg2l_cru_querycap()
* Dropped vidioc_log_status, vidioc_subscribe_event and vidioc_unsubscribe_event
* Now calling pm_runtime_resume_and_get() and enabling vclk in s_stream

v4 -> v5
* Fixed review comments pointed by Sakari

v3 -> v4
* Included RB tag from Rob for binding patch
* Implemented post_streamoff callback in CSI driver
* Undo the configuration if s_stream(1) fails
* Made sure we call post_streamoff in the error path if s_stream(1) failed

v2 -> v3:
* Updated clock names in DT binding doc
* Included presetn reset signal and added reset-names in CSI binding
* Renamed csi20 -> csi in DT binding doc
* Included RB tag from Krzysztof for patch#1
* Switched to runtime PM for both CSI and CRU drivers
* Implemented pre_streamon callback in CSI driver
* Got rid of rzg2l_csi2_cmn_rstb_deassert()/
  rzg2l_csi2_dphy_setting/rzg2l_csi2_mipi_link_setting() from CSI driver
* Switched to for-loop instead of if block for getting CSI timings
* Fixed rzg2l_csi2_set_format() as pointed by Laurent
* Copied all colorspace-related fields received from userspace (colorspace,
  xfer_func, ycbcr_enc and quantization) in rzg2l_csi2_set_format.
* Initialised pad in rzg2l_csi2_init_config() 
* Introduced RZG2L_CSI2_DEFAULT_WIDTH/HEIGHT/FMT macros
* Dropped RZG2L_CSI2_SOURCE_VC0-RZG2L_CSI2_SOURCE_VC3 macros
* Modeled CRU IP block as a subdev
* Dropped explicitly selecting VIDEO_RZG2L_CSI2 for VIDEO_RZG2L_CRU config
* Replaced v4l2_dev_to_cru macro with inline function notifier_to_cru()
* Dropped id parameter from rvin_mc_parse_of()
* Renamed rzg2l_cru_csi2_init() -> rzg2l_cru_media_init()
* Used dev_err_probe() in rzg2l_cru_probe()
* Replaced devm_reset_control_get() -> devm_reset_control_get_exclusive()
* Prefixed HW_BUFFER_MAX and HW_BUFFER_DEFAULT macros with RZG2L_CRU_
* Moved asserting presetn signal from rzg2l_cru_dma_register() to rzg2l_cru_start_streaming_vq()
* Dropped VB2_READ from VB2 io_modes
* Used dev_dbg() in rzg2l_cru_video_register() and rzg2l_cru_video_unregister()
* Got rid of rzg2l_cru_notify()
* Dropped V4L2_CAP_READWRITE from device caps
* Introduced rzg2l_cru_v4l2_init() for initialization.
* Got rid v4l2_pipeline_pm_get() and used PM in ov5645 sensor driver. Patch posted 
  https://patchwork.linuxtv.org/project/linux-media/patch/20220927201634.750141-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

v1 -> v2:
* Dropped media prefix from subject
* Renamed node name csi20 -> csi
* Used 4 spaces for indentation in example node
* Dropped reset-names and interrupt-names properties
* Dropped oneOf from compatible
* Included RB tags from Laurent
* Marked port0/1 as required for cru node
* Sorted Kconfig select
* Prefixed generic names for struct/variables with rzg2_csi2
* Dropped unnecessary checks for remote source
* Dropped exporting functions
* Moved lane validation to probe
* Split up rzg2l_csi2_dphy_setting() and rzg2l_csi2_mipi_link_setting()
* Used rzg2l_csi2_write() wherever possible
* Dropped stream_count/lock members from csi2 struct
* Used active subdev state instead of manually storing format in driver
* Implemented init_cfg/enum_frame_size/enum_mbus_code callbacks
* Dropped check for bus_type of remote source
* Switched to manually turning ON/OFF the clocks instead of pm_runtime so that
  the mipi/dhpy initialization happens as per the HW manual
* Hardcoded VC0 usage for now as streams API is under development

v1:
- https://patchwork.kernel.org/project/linux-renesas-soc/cover/20220801214718.16943-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

RFC v2:
- https://patchwork.kernel.org/project/linux-renesas-soc/cover/20220121010543.31385-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

RFC v1:
- https://patchwork.kernel.org/project/linux-renesas-soc/cover/20211207012351.15754-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar
Lad Prabhakar (4):
  media: dt-bindings: Document Renesas RZ/G2L CSI-2 block
  media: dt-bindings: Document Renesas RZ/G2L CRU block
  media: platform: Add Renesas RZ/G2L MIPI CSI-2 receiver driver
  media: platform: Add Renesas RZ/G2L CRU driver

 .../bindings/media/renesas,rzg2l-cru.yaml     |  157 +++
 .../bindings/media/renesas,rzg2l-csi2.yaml    |  149 +++
 drivers/media/platform/renesas/Kconfig        |    1 +
 drivers/media/platform/renesas/Makefile       |    1 +
 .../media/platform/renesas/rzg2l-cru/Kconfig  |   33 +
 .../media/platform/renesas/rzg2l-cru/Makefile |    6 +
 .../platform/renesas/rzg2l-cru/rzg2l-core.c   |  338 ++++++
 .../platform/renesas/rzg2l-cru/rzg2l-cru.h    |  152 +++
 .../platform/renesas/rzg2l-cru/rzg2l-csi2.c   |  877 ++++++++++++++
 .../platform/renesas/rzg2l-cru/rzg2l-ip.c     |  255 ++++
 .../platform/renesas/rzg2l-cru/rzg2l-video.c  | 1057 +++++++++++++++++
 11 files changed, 3026 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
 create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/Kconfig
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/Makefile
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c

-- 
2.25.1

