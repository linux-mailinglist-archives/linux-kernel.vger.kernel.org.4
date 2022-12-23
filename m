Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459BD65562B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 00:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbiLWXfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 18:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbiLWXfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 18:35:06 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654AE34D0D;
        Fri, 23 Dec 2022 15:33:51 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BNNW42H011577;
        Fri, 23 Dec 2022 23:32:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=fxj+9QS8+FgVES+CkOHzD/eZuPkfiygDQZRXSYewnCA=;
 b=NOv863MLKCgh+9THC7nFiTV1JBFAJuslFzyJfz/drL122SeN6tZx4OPVzLvviNWPLWhM
 +HCr/Xj2AoN7Rpd9ehzUgSBiIOj26mGGffyUr5f2435iB912Kq2kFpuoWyFFrqjQEZD6
 OclrF6YTNW+vOp8MPvlQ/rSnvwCKch1VthRS0vKKBXxcURSKVF5dy4C91bKH4nB/LC6W
 kJdqV8XZkNcPAoX1jOC6AstZgtcpBX+4ITF+O88KkDS23RLLzB5X8hgBhqa74IKbbuFZ
 zMuDrTl3P2HdLw2rxaoO/tblz48w2lkT8Es9Lbj5/qTbO2CWuIJCZ88u9Bn1ZjcN4b0x XQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mn2pga502-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Dec 2022 23:32:44 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BNNWhi0000810
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Dec 2022 23:32:43 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 23 Dec 2022 15:32:42 -0800
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <gregkh@linuxfoundation.org>, <Thinh.Nguyen@synopsys.com>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <agross@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [RFC PATCH 00/14] Introduce QC USB SND audio offloading support
Date:   Fri, 23 Dec 2022 15:31:46 -0800
Message-ID: <20221223233200.26089-1-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YpZvkf7XIB1RcrCiLxeUXy3CoWpNkExn
X-Proofpoint-GUID: YpZvkf7XIB1RcrCiLxeUXy3CoWpNkExn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-23_08,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 impostorscore=0
 mlxlogscore=926 lowpriorityscore=0 suspectscore=0 mlxscore=0 phishscore=0
 clxscore=1011 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2212230197
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Wesley Cheng (14):
  ASoC: Add SOC USB APIs for adding an USB backend
  ASoC: qcom: qdsp6: Introduce USB AFE port to q6dsp
  ASoC: qcom: Add USB backend ASoC driver for Q6
  sound: usb: card: Introduce USB SND vendor op callbacks
  sound: usb: Export USB SND APIs for modules
  usb: core: hcd: Introduce USB HCD APIs for interrupter management
  usb: host: xhci: Add XHCI secondary interrupter support
  usb: dwc3: Add DT parameter to specify maximum number of interrupters
  sound: usb: Introduce QC USB SND offloading support
  sound: usb: card: Check for support for requested audio format
  sound: soc: soc-usb: Add PCM format check API for USB backend
  sound: soc: qcom: qusb6: Ensure PCM format is supported by USB audio
    device
  ASoC: dt-bindings: Add Q6USB backend bindings
  ASoC: dt-bindings: Update example for enabling USB offload on SM8250

 .../bindings/sound/qcom,q6usb-dais.yaml       |   55 +
 .../bindings/sound/qcom,sm8250.yaml           |   13 +
 drivers/usb/core/hcd.c                        |   86 +
 drivers/usb/dwc3/core.c                       |   12 +
 drivers/usb/dwc3/core.h                       |    2 +
 drivers/usb/dwc3/host.c                       |    5 +-
 drivers/usb/host/xhci-mem.c                   |  219 ++-
 drivers/usb/host/xhci-plat.c                  |    2 +
 drivers/usb/host/xhci.c                       |  169 +-
 drivers/usb/host/xhci.h                       |   15 +
 .../sound/qcom,q6dsp-lpass-ports.h            |    1 +
 include/linux/usb.h                           |    7 +
 include/linux/usb/hcd.h                       |   16 +-
 include/sound/q6usboffload.h                  |   20 +
 include/sound/soc-usb.h                       |   34 +
 sound/soc/Makefile                            |    2 +-
 sound/soc/qcom/Kconfig                        |    4 +
 sound/soc/qcom/qdsp6/Makefile                 |    1 +
 sound/soc/qcom/qdsp6/q6afe-dai.c              |   47 +
 sound/soc/qcom/qdsp6/q6afe.c                  |  183 ++
 sound/soc/qcom/qdsp6/q6afe.h                  |   46 +-
 sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c      |   23 +
 sound/soc/qcom/qdsp6/q6dsp-lpass-ports.h      |    1 +
 sound/soc/qcom/qdsp6/q6routing.c              |    8 +
 sound/soc/qcom/qdsp6/q6usb.c                  |  239 +++
 sound/soc/soc-usb.c                           |   79 +
 sound/usb/Kconfig                             |   14 +
 sound/usb/Makefile                            |    2 +-
 sound/usb/card.c                              |   43 +
 sound/usb/card.h                              |   10 +
 sound/usb/endpoint.c                          |    2 +
 sound/usb/helper.c                            |    1 +
 sound/usb/pcm.c                               |    9 +-
 sound/usb/pcm.h                               |   12 +
 sound/usb/qcom/Makefile                       |    2 +
 sound/usb/qcom/qc_audio_offload.c             | 1610 +++++++++++++++++
 sound/usb/qcom/usb_audio_qmi_v01.c            |  892 +++++++++
 sound/usb/qcom/usb_audio_qmi_v01.h            |  162 ++
 38 files changed, 3998 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6usb-dais.yaml
 create mode 100644 include/sound/q6usboffload.h
 create mode 100644 include/sound/soc-usb.h
 create mode 100644 sound/soc/qcom/qdsp6/q6usb.c
 create mode 100644 sound/soc/soc-usb.c
 create mode 100644 sound/usb/qcom/Makefile
 create mode 100644 sound/usb/qcom/qc_audio_offload.c
 create mode 100644 sound/usb/qcom/usb_audio_qmi_v01.c
 create mode 100644 sound/usb/qcom/usb_audio_qmi_v01.h

