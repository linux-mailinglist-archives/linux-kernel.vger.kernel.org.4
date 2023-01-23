Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23212677C88
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 14:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjAWNbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 08:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjAWNbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:31:39 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E55025E28;
        Mon, 23 Jan 2023 05:31:22 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so8558249wmc.1;
        Mon, 23 Jan 2023 05:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IiQpuXpBb4cBOqCMVo/w9+06S5nTuiyPXun0t7GmDww=;
        b=NVK//NF+MovBPm0sYrlCXYaPcNA6vLY38zW+/h3NHzA6cTR+clA2pTzSaa0eB//Lfr
         g+3wN42AqhsFLlUMyBzD6JxHcLfBNgYwDbTzvwGY4YFTE3HUUsc/fk7ETR56/SirG2QL
         sKwabKDl89npx3nJYFBb2puRkwZAl3tDD/b0Ukqs/j7MbwPWJ2XxvwA6M8KK0bGqr1pY
         bC9T4VN+R1b22TegF+q1maCF1LLfsX60d92+Go7aVizwUYZASA6CNDVNiz8vlq3TeAPl
         9pK6gXWsLJA5vd/8nPQWf6OAn3EyYy5mwFjHiALVbdro2fT7SjXnMpEydhzJNtOzTr8R
         gk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IiQpuXpBb4cBOqCMVo/w9+06S5nTuiyPXun0t7GmDww=;
        b=gzedKelqGYJ2f7RwxgpRzYYfPD7g2dZTUBKyvPFtwtKBZ73tisIyRWLE574IjbJiiN
         vyJ/jKZp8Nj4drzaV32r97d6n6W9dQndmqxyA2avlh8HeFCt4hLhRK1Ti1B+9RkoLyvp
         OuGa/yshZGVLEjS4nuXWqaK4q++qIx5Sd4Z/DFbVMWVsZAIUKKvikTA6FO64hambpvjm
         VR3DlE8bM4r+37J/ZH3x2hbQtk/maCe+YbLm9H6JoHYEzFahKfuzfljhCUz0w1SJLiPp
         nwFxjBHoECuPago0ncjkbjpBS1lSWpLZ4aerf/CLVjBolpZjSycFGXhiRIrjutZmmc+q
         YGSw==
X-Gm-Message-State: AFqh2kpqic1A3SlX06IcGubif3yOcYksp8U5Mwb7GLYNrqIVwXjr+0dY
        w7HHRpZt/p4vlJRPXvCCh20=
X-Google-Smtp-Source: AMrXdXvI5gYLj1NVCeuWSquycOAxs42i3j7nSK8uG5+v84VTM6E2hQJuJhbaAb1h+jgfeeiba/O4Lw==
X-Received: by 2002:a05:600c:5d1:b0:3d0:761b:f86 with SMTP id p17-20020a05600c05d100b003d0761b0f86mr24205469wmd.28.1674480678338;
        Mon, 23 Jan 2023 05:31:18 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id d28-20020adfa41c000000b00286ad197346sm4199253wra.70.2023.01.23.05.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 05:31:17 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 0/2] media: meson: vdec: add HEVC decode codec
Date:   Mon, 23 Jan 2023 13:31:11 +0000
Message-Id: <20230123133113.3254659-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This mini-series adds support for HEVC decoding. It combines the original codec
work done by Maxime Jourdan in 2019 [0] and improvements by Benjamin Roszak in
2021 [1]. Only GXBB/GXL/GXM are enabled as decoding currently crashes on G12A
and later SoCs when trying to decode a 10-bit HEVC stream.

The goal of upstreaming the driver in its current state is to encourage greater
community contribution towards adding missing features, and fixing the bugs and
conformance issues necessary to get out of staging.

The HEVC codec presented here is generally partnered with FFMpeg sources that
are being maintained by the Raspberry Pi Foundation [2] and [3] that contain
numerous improvements to v4l2_m2m (and v4l2_request) support. There is active
work in progress to refine the changeset and send it upstream.

Christian

[0] https://github.com/Elyotna/linux/commits/4.20/v4l2-m2m-pr
[1] https://gitlab.com/benjamin545/linux-amlogic/-/commits/aml-hevc
[2] https://github.com/jc-kynesim/rpi-ffmpeg/commits/release/4.4/rpi_import_1
[3] https://github.com/jc-kynesim/rpi-ffmpeg/tree/dev/5.1.2/rpi_import_1

Benjamin Roszak (1):
  media: meson: vdec: implement 10bit bitstream handling

Maxime Jourdan (1):
  media: meson: vdec: add HEVC decode codec

 drivers/staging/media/meson/vdec/Makefile     |    2 +-
 drivers/staging/media/meson/vdec/codec_h264.c |    3 +-
 drivers/staging/media/meson/vdec/codec_hevc.c | 1463 +++++++++++++++++
 drivers/staging/media/meson/vdec/codec_hevc.h |   13 +
 .../media/meson/vdec/codec_hevc_common.c      |  161 +-
 .../media/meson/vdec/codec_hevc_common.h      |    3 +-
 drivers/staging/media/meson/vdec/codec_vp9.c  |   35 +-
 drivers/staging/media/meson/vdec/esparser.c   |    4 +-
 drivers/staging/media/meson/vdec/hevc_regs.h  |    1 +
 drivers/staging/media/meson/vdec/vdec.h       |    1 +
 .../staging/media/meson/vdec/vdec_helpers.c   |   44 +-
 .../staging/media/meson/vdec/vdec_helpers.h   |   10 +-
 .../staging/media/meson/vdec/vdec_platform.c  |   37 +
 13 files changed, 1678 insertions(+), 99 deletions(-)
 create mode 100644 drivers/staging/media/meson/vdec/codec_hevc.c
 create mode 100644 drivers/staging/media/meson/vdec/codec_hevc.h

-- 
2.34.1

