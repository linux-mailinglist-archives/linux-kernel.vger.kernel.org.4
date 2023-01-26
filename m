Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0360367C312
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 04:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbjAZDOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 22:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjAZDOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 22:14:41 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7050464D8A;
        Wed, 25 Jan 2023 19:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1674702879; x=1706238879;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=vv6c+7Kfc39u2VKp89EVQLomNqZ9kSbPEs1muxjJ7tk=;
  b=rNHsZiyy91m8hXlIvo/5goHMQ7uDdXMvpihbLcyqhApfGl14WlzfT9vv
   al1IjaOl3CWJhKRQSylBpVdPIJGvHJ4jBpdVM6GetoXM1AYtiCjM6R95G
   c0/plnzY3Eh+Egs+W/VKnxqJtpib1DZd6LG+WdVM2Zi75qvstTDvirwO9
   E=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 25 Jan 2023 19:14:39 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.45.79.139])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 19:14:38 -0800
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 25 Jan 2023 19:14:37 -0800
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <agross@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [RFC PATCH v2 00/22] Introduce QC USB SND audio offloading support
Date:   Wed, 25 Jan 2023 19:14:02 -0800
Message-ID: <20230126031424.14582-1-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:

XHCI:
- Replaced XHCI and HCD changes with Mathias' XHCI interrupter changes
in his tree:
https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=feature_interrupters

Adjustments made to Mathias' changes:
  - Created xhci-intr.h to export/expose interrupter APIs versus exposing xhci.h.
    Moved dependent structures to this file as well. (so clients can parse out
    information from "struct xhci_interrupter")
  - Added some basic locking when requesting interrupters.
  - Fixed up some sanity checks.
  - Removed clearing of the ERSTBA during freeing of the interrupter. (pending
    issue where SMMU fault occurs if DMA addr returned is 64b - TODO)

- Clean up pending events in the XHCI secondary interrupter.  While testing USB
bus suspend, it was seen that on bus resume, the xHCI HC would run into a command
timeout.
- Added offloading APIs to xHCI to fetch transfer and event ring information.

ASoC:
- Modified soc-usb to allow for multiple USB port additions.  For this to work,
the USB offload driver has to have a reference to the USB backend by adding
a "usb-soc-be" DT entry to the device saved into XHCI sysdev.
- Created separate dt-bindings for defining USB_RX port.
- Increased APR timeout to accommodate the situation where the AFE port start
command could be delayed due to having to issue a USB bus resume while
handling the QMI stream start command.

USB SND:
- Added a platform ops during usb_audio_suspend().  This allows for the USB
offload driver to halt the audio stream when system enters PM suspend.  This
ensures the audio DSP is not issuing transfers on the USB bus.
- Do not override platform ops if they are already populated.
- Introduce a shared status variable between the USB offload and USB SND layers,
to ensure that only one path is active at a time.  If the USB bus is occupied,
then userspace is notified that the path is busy.

Several Qualcomm based chipsets can support USB audio offloading to a
dedicated audio DSP, which can take over issuing transfers to the USB
host controller.  The intention is to reduce the load on the main
processors in the SoC, and allow them to be placed into lower power modes.
There are several parts to this design:
  1. Adding ASoC binding layer
  2. Create a USB backend for Q6DSP
  3. Introduce XHCI interrupter support
  4. Create vendor ops for the USB SND driver

Adding ASoC binding layer:
soc-usb: Intention is to treat a USB port similar to a headphone jack.
The port is always present on the device, but cable/pin status can be
enabled/disabled.  Expose mechanisms for USB backend ASoC drivers to
communicate with USB SND.

Create a USB backend for Q6DSP:
q6usb: Basic backend driver that will be responsible for maintaining the
resources needed to initiate a playback stream using the Q6DSP.  Will
be the entity that checks to make sure the connected USB audio device
supports the requested PCM format.  If it does not, the PCM open call will
fail, and userpsace ALSA can take action accordingly.

Introduce XHCI interrupter support:
XHCI HCD supports multiple interrupters, which allows for events to be routed
to different event rings.  This is determined by "Interrupter Target" field
specified in Section "6.4.1.1 Normal TRB" of the XHCI specification.

Events in the offloading case will be routed to an event ring that is assigned
to the audio DSP.

Create vendor ops for the USB SND driver:
qc_audio_offload: This particular driver has several components associated
with it:
- QMI stream request handler
- XHCI interrupter and resource management
- audio DSP memory management

When the audio DSP wants to enable a playback stream, the request is first
received by the ASoC platform sound card.  Depending on the selected route,
ASoC will bring up the individual DAIs in the path.  The Q6USB backend DAI
will send an AFE port start command (with enabling the USB playback path), and
the audio DSP will handle the request accordingly.

Part of the AFE USB port start handling will have an exchange of control
messages using the QMI protocol.  The qc_audio_offload driver will populate the
buffer information:
- Event ring base address
- EP transfer ring base address

and pass it along to the audio DSP.  All endpoint management will now be handed
over to the DSP, and the main processor is not involved in transfers.

Overall, implementing this feature will still expose separate sound card and PCM
devices for both the platorm card and USB audio device:
 0 [SM8250MTPWCD938]: sm8250 - SM8250-MTP-WCD9380-WSA8810-VA-D
                      SM8250-MTP-WCD9380-WSA8810-VA-DMIC
 1 [Audio          ]: USB-Audio - USB Audio
                      Generic USB Audio at usb-xhci-hcd.1.auto-1.4, high speed

This is to ensure that userspace ALSA entities can decide which route to take
when executing the audio playback.  In the above, if card#1 is selected, then
USB audio data will take the legacy path over the USB PCM drivers, etc...

This feature was validated using:
- tinymix: set/enable the multimedia path to route to USB backend
- tinyplay: issue playback on platform card

Mathias Nyman (4):
  xhci: fix event ring segment table related masks and variables in
    header
  xhci: remove xhci_test_trb_in_td_math early development check
  xhci: Refactor interrupter code for initial multi interrupter support.
  xhci: Add support to allocate several interrupters

Wesley Cheng (18):
  usb: xhci: Add XHCI APIs to support USB offloading
  usb: host: xhci-mem: Cleanup pending secondary event ring events
  ASoC: Add SOC USB APIs for adding an USB backend
  ASoC: dt-bindings: Add USB_RX port
  ASoC: qcom: qdsp6: Introduce USB AFE port to q6dsp
  ASoC: qdsp6: q6afe: Increase APR timeout
  ASoC: qcom: Add USB backend ASoC driver for Q6
  sound: usb: card: Introduce USB SND platform op callbacks
  sound: usb: Export USB SND APIs for modules
  dt-bindings: usb: dwc3: Add snps,num-hc-interrupters definition
  usb: dwc3: Add DT parameter to specify maximum number of interrupters
  sound: usb: Introduce QC USB SND offloading support
  sound: usb: card: Check for support for requested audio format
  sound: soc: soc-usb: Add PCM format check API for USB backend
  sound: soc: qcom: qusb6: Ensure PCM format is supported by USB audio
    device
  sound: usb: Prevent starting of audio stream if in use
  ASoC: dt-bindings: Add Q6USB backend bindings
  ASoC: dt-bindings: Update example for enabling USB offload on SM8250

 .../bindings/sound/qcom,q6usb-dais.yaml       |   55 +
 .../bindings/sound/qcom,sm8250.yaml           |   13 +
 .../devicetree/bindings/usb/snps,dwc3.yaml    |   12 +
 drivers/usb/dwc3/core.c                       |   12 +
 drivers/usb/dwc3/core.h                       |    2 +
 drivers/usb/dwc3/host.c                       |    5 +-
 drivers/usb/host/xhci-debugfs.c               |    2 +-
 drivers/usb/host/xhci-mem.c                   |  471 +++--
 drivers/usb/host/xhci-ring.c                  |   68 +-
 drivers/usb/host/xhci.c                       |  199 +-
 drivers/usb/host/xhci.h                       |   81 +-
 .../sound/qcom,q6dsp-lpass-ports.h            |    1 +
 include/linux/usb/xhci-intr.h                 |   94 +
 include/sound/pcm_params.h                    |    4 +
 include/sound/q6usboffload.h                  |   20 +
 include/sound/soc-usb.h                       |   36 +
 sound/core/oss/pcm_oss.c                      |   58 -
 sound/core/pcm_lib.c                          |   65 +
 sound/soc/Makefile                            |    2 +-
 sound/soc/qcom/Kconfig                        |    4 +
 sound/soc/qcom/qdsp6/Makefile                 |    1 +
 sound/soc/qcom/qdsp6/q6afe-dai.c              |   48 +
 sound/soc/qcom/qdsp6/q6afe.c                  |  185 +-
 sound/soc/qcom/qdsp6/q6afe.h                  |   46 +-
 sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c      |   23 +
 sound/soc/qcom/qdsp6/q6dsp-lpass-ports.h      |    1 +
 sound/soc/qcom/qdsp6/q6routing.c              |    8 +
 sound/soc/qcom/qdsp6/q6usb.c                  |  234 +++
 sound/soc/soc-usb.c                           |  215 ++
 sound/usb/Kconfig                             |   14 +
 sound/usb/Makefile                            |    2 +-
 sound/usb/card.c                              |   58 +
 sound/usb/card.h                              |   29 +
 sound/usb/endpoint.c                          |    2 +
 sound/usb/helper.c                            |    1 +
 sound/usb/pcm.c                               |   28 +-
 sound/usb/pcm.h                               |   12 +
 sound/usb/qcom/Makefile                       |    2 +
 sound/usb/qcom/qc_audio_offload.c             | 1789 +++++++++++++++++
 sound/usb/qcom/usb_audio_qmi_v01.c            |  892 ++++++++
 sound/usb/qcom/usb_audio_qmi_v01.h            |  162 ++
 41 files changed, 4546 insertions(+), 410 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6usb-dais.yaml
 create mode 100644 include/linux/usb/xhci-intr.h
 create mode 100644 include/sound/q6usboffload.h
 create mode 100644 include/sound/soc-usb.h
 create mode 100644 sound/soc/qcom/qdsp6/q6usb.c
 create mode 100644 sound/soc/soc-usb.c
 create mode 100644 sound/usb/qcom/Makefile
 create mode 100644 sound/usb/qcom/qc_audio_offload.c
 create mode 100644 sound/usb/qcom/usb_audio_qmi_v01.c
 create mode 100644 sound/usb/qcom/usb_audio_qmi_v01.h

