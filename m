Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDFB6192DB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 09:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiKDIgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 04:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiKDIgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 04:36:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B975111C;
        Fri,  4 Nov 2022 01:36:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19243620EE;
        Fri,  4 Nov 2022 08:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7C1C433D6;
        Fri,  4 Nov 2022 08:36:39 +0000 (UTC)
Message-ID: <1d770c8e-1ac5-34b5-7c09-f55b8325c9cb@xs4all.nl>
Date:   Fri, 4 Nov 2022 09:36:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v6 0/5] Support Nuvoton NPCM Video Capture/Encode Engine
To:     Marvin Lin <milkfafa@gmail.com>, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com
References: <20221104033810.1324686-1-milkfafa@gmail.com>
Content-Language: en-US
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20221104033810.1324686-1-milkfafa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marvin,

On 04/11/2022 04:38, Marvin Lin wrote:
> This patch series add DTS node, dt-bindings document and drivers for Video
> Capture/Differentiation Engine (VCD) and Encoding Compression Engine (ECE)
> present on Nuvoton NPCM SoCs.
> 
> VCD can capture/differentiate video data from digital or analog sources,
> then the ECE will compress the data into HEXTILE format.
> 
> HEXTILE compressed format is defined in Remote Framebuffer Protocol (RFC
> 6143) and is used by VNC features, so we also add a patch to support it.
> 
> Changes in v6:
>   - Support NPCM845 and add compatible "nuvoton,npcm845-video".
>   - Correct pixel format to V4L2_PIX_FMT_HEXTILE which is newly added in
>     this patch series.
> 
> Changes in v5:
>   - Simplify function prefix "nuvoton_" to "npcm_".
>   - Increase VCD_BUSY_TIMEOUT_US and ECE_POLL_TIMEOUT_US to 300ms to
>     prevent polling timeout when ECC is enabled or system is busy.
> 
> Changes in v4:
>   - Fix compile warning reported by kernel test robot.
> 
> Changes in v3:
>   - Add video driver entry in MAINTAINERS.
>   - Change config name to CONFIG_VIDEO_NPCM_VCD_ECE.
>   - Reduce the waiting time after resetting the VCD/ECE module.
>   - Correct data types of some variables.
> 
> Changes in v2:
>   - Add Hextile document and locate with vendor formats.
> 
> Marvin Lin (5):
>   arm: dts: Add node for NPCM Video Capture/Encode Engine
>   dt-bindings: media: Add dt-bindings for NPCM Video Capture/Encode
>     Engine
>   dt-bindings: arm/npcm: Add dt-bindings for Graphics Core Information

FYI: you need to CC this series to devicetree@vger.kernel.org so they can review
the bindings.

Regards,

	Hans

>   media: Add HEXTILE compressed format
>   drivers: media: platform: Add NPCM Video Capture/Encode Engine driver
> 
>  .../bindings/arm/npcm/nuvoton,gfxi.yaml       |   41 +
>  .../bindings/media/nuvoton,npcm-video.yaml    |   87 +
>  .../media/v4l/pixfmt-reserved.rst             |    7 +
>  MAINTAINERS                                   |    9 +
>  arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi |   19 +
>  drivers/media/platform/Kconfig                |    1 +
>  drivers/media/platform/Makefile               |    1 +
>  drivers/media/platform/nuvoton/Kconfig        |   12 +
>  drivers/media/platform/nuvoton/Makefile       |    2 +
>  drivers/media/platform/nuvoton/npcm-video.c   | 2093 +++++++++++++++++
>  drivers/media/v4l2-core/v4l2-ioctl.c          |    1 +
>  include/uapi/linux/videodev2.h                |    1 +
>  12 files changed, 2274 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/nuvoton,npcm-video.yaml
>  create mode 100644 drivers/media/platform/nuvoton/Kconfig
>  create mode 100644 drivers/media/platform/nuvoton/Makefile
>  create mode 100644 drivers/media/platform/nuvoton/npcm-video.c
> 

