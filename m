Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F382633C92
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiKVMfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbiKVMfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:35:34 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060695B5B4;
        Tue, 22 Nov 2022 04:35:31 -0800 (PST)
Received: from [192.168.1.104] (unknown [103.86.18.138])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9A9FB2D9;
        Tue, 22 Nov 2022 13:35:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669120529;
        bh=/6M+QajsyhNYA9rP2hcLG0kUVsJ1q/Gz4kqYMfPwRbU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O2eHZtjTE6LIOqkwO8wKRhMYrAoSZazKUA3c0pKFFmvok5PbRmU3nsVo+8aNuG50T
         4OLbxsgAAGzzxQ9wUDDkum4m4hewAHXikGu7ApSB7vlzdDYk4ppZvrF4mrwFuLLkWw
         zBivxMMYi31c1srKtitQfG6WHgKMKsR8IXsnSVHw=
Message-ID: <74899338-8586-b24c-ae6d-213d419376a7@ideasonboard.com>
Date:   Tue, 22 Nov 2022 18:04:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 00/14] staging: vc04_services: bcm2835-isp support
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Naushir Patuck <naush@raspberrypi.com>,
        David Plowman <david.plowman@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
References: <20221121214722.22563-1-umang.jain@ideasonboard.com>
 <Y3v4uZuhZTve2UI5@pendragon.ideasonboard.com>
 <CAPY8ntBrLvj_m_Rwt5SOjHypM5W3Foc6wRemFCcc1rpNQjMV0g@mail.gmail.com>
Content-Language: en-US
From:   Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <CAPY8ntBrLvj_m_Rwt5SOjHypM5W3Foc6wRemFCcc1rpNQjMV0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 11/22/22 5:12 PM, Dave Stevenson wrote:
> Hi Umang and Laurent
>
> On Mon, 21 Nov 2022 at 22:16, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
>> Hi Umang,
>>
>> Nice to see this series on the list !
>>
>> On Tue, Nov 22, 2022 at 03:17:08AM +0530, Umang Jain wrote:
>>> This series aims to upport bcm2835-isp from the RPi kernel [1] and is a
>>> independent subset of earlier series [2] posted to upport CSI-2/CCP2
>>> receiver IP core("Unicam) + the ISP driver found in BCM283x and compatible
>>> SoCs (namely BCM2711). Unicam is still under active development to work
>>> with multistream support to get into mainline. Hence only the ISP driver
>>> will remain the primary area of this series.
>>>
>>> Patch (01-02)/14  adds a new driver named vc-sm-cma to handle memory sharing
>>> with the VC4 VPU.
>>>
>>> Patch 03/14 adds a small extension to videobuf2 to allow exporting as a
>>> dma_buf instead of a file-descriptor.
>>>
>>> Patch (04-05)/14 adds a couple of improvements/support for
>>> bcm2835-isp(event callback and zero-copy) to vchiq-mmal.
>>>
>>> Patch (06-09)/14 adds the core bcm2835-isp driver along with headers
>>> and format defintions.
>>>
>>> Patch (10-11)/14 deals with the colorspace support.
>>> Note: This is still WIP since the implementation of colorspace is still
>>> getting ironed out (especially around setting of colorspace flags handling).
>>>
>>> Patch 12/14 allows multiple instances of the ISP.
>>>
>>> Patch 13/14 adds a admin-guide document on bcm2835-isp.
>>>
>>> Patch 14/14 wires all this up with the vchiq-mmal driver.
>>>
>>> Testing:
>>> Tested with RPi Model 4B running linux mainline v6.1-rc6. To test
>>> end-to-end, I choose to cherry-pick the Unicam patches and OV5647 DT
>>> bindings from [1]). Once done, functional testing was conducted with
>>> libcamera[3] and its utility tools.
>>>
>>> Also note: Reviews given on [2] for the relevant ISP driver patches have
>>> been incorporated in this version.
>>>
>>> Known issues:
>>> - Colorspace handling
>> This will require further discussions, I'll try to comment on this topic
>> in the review of the ISP driver patch.
>>
>>> - vc-sm-cma spamming kernel log with
>>>        - pr_err("%s: Expecting an uncached alias for dma_addr %pad\n"
>> Do you have any plan to address this ? Is the root cause known ?
> You've picked up an old version of the downstream driver.

I didn't pick version of driver rather, I picked commits that were 
leading to the rpi-5.15.y branch of the downstream kernel

> Pi0&1 share the VPU L2 cache with the ARM in the architecture, so they
> use the 0x8 cache alias.
> See https://github.com/raspberrypi/linux/commit/e22927f8ec9dc87772ac61d6aba00dc8046b4f49

And certainly I missed to notice / pick this commit out on the vc-sm-cma 
driver.
Thanks for providing the link! I'll squash it for v2.
>
>    Dave
>
>>> [1]: https://github.com/raspberrypi/linux
>>> [2]: https://lore.kernel.org/linux-media/20200504092611.9798-1-laurent.pinchart@ideasonboard.com/
>>> [3]: https://libcamera.org/getting-started.html
>>>
>>> Dave Stevenson (7):
>>>    staging: vc04_services: Add new vc-sm-cma driver
>>>    staging: vchiq_arm: Register vcsm-cma as a platform driver
>>>    media: videobuf2: Allow exporting of a struct dmabuf
>>>    staging: mmal-vchiq: Add support for event callbacks
>>>    staging: mmal-vchiq: Use vc-sm-cma to support zero copy
>>>    staging: mmal_vchiq: Add image formats to be used by bcm2835-isp
>>>    uapi: bcm2835-isp: Add bcm2835-isp uapi header file
>>>
>>> David Plowman (2):
>>>    vc04_services: bcm2835-isp: Allow formats with different colour spaces
>>>    vc04_services: bcm2835-isp: Permit all sRGB colour spaces on ISP
>>>      outputs
>>>
>>> Naushir Patuck (5):
>>>    media: uapi: v4l2-core: Add ISP statistics output V4L2 fourcc type
>>>    staging: vc04_services: bcm2835-isp: Add a more complex ISP processing
>>>      component
>>>    staging: vc04_services: bcm2835_isp: Allow multiple users
>>>    docs: admin-guide: media: bcm2835-isp: Add documentation for
>>>      bcm2835-isp
>>>    staging: vc04_services: vchiq: Load bcm2835_isp driver from vchiq
>>>
>>>   .../admin-guide/media/bcm2835-isp.rst         |  127 ++
>>>   .../userspace-api/media/drivers/index.rst     |    1 +
>>>   .../userspace-api/media/v4l/meta-formats.rst  |    1 +
>>>   .../v4l/pixfmt-meta-bcm2835-isp-stats.rst     |   41 +
>>>   MAINTAINERS                                   |    9 +
>>>   .../media/common/videobuf2/videobuf2-core.c   |   36 +-
>>>   drivers/media/v4l2-core/v4l2-ioctl.c          |    1 +
>>>   drivers/staging/vc04_services/Kconfig         |    4 +
>>>   drivers/staging/vc04_services/Makefile        |    2 +
>>>   .../staging/vc04_services/bcm2835-isp/Kconfig |   14 +
>>>   .../vc04_services/bcm2835-isp/Makefile        |    8 +
>>>   .../bcm2835-isp/bcm2835-isp-ctrls.h           |   72 +
>>>   .../bcm2835-isp/bcm2835-isp-fmts.h            |  558 +++++
>>>   .../bcm2835-isp/bcm2835-v4l2-isp.c            | 1817 +++++++++++++++++
>>>   .../interface/vchiq_arm/vchiq_arm.c           |    6 +
>>>   .../staging/vc04_services/vc-sm-cma/Kconfig   |   10 +
>>>   .../staging/vc04_services/vc-sm-cma/Makefile  |   12 +
>>>   .../staging/vc04_services/vc-sm-cma/vc_sm.c   |  801 ++++++++
>>>   .../staging/vc04_services/vc-sm-cma/vc_sm.h   |   54 +
>>>   .../vc04_services/vc-sm-cma/vc_sm_cma_vchi.c  |  507 +++++
>>>   .../vc04_services/vc-sm-cma/vc_sm_cma_vchi.h  |   63 +
>>>   .../vc04_services/vc-sm-cma/vc_sm_defs.h      |  187 ++
>>>   .../vc04_services/vc-sm-cma/vc_sm_knl.h       |   28 +
>>>   .../staging/vc04_services/vchiq-mmal/Kconfig  |    1 +
>>>   .../vc04_services/vchiq-mmal/mmal-common.h    |    5 +
>>>   .../vc04_services/vchiq-mmal/mmal-encodings.h |   66 +
>>>   .../vc04_services/vchiq-mmal/mmal-msg.h       |   35 +
>>>   .../vchiq-mmal/mmal-parameters.h              |  165 +-
>>>   .../vc04_services/vchiq-mmal/mmal-vchiq.c     |  253 ++-
>>>   .../vc04_services/vchiq-mmal/mmal-vchiq.h     |    5 +
>>>   include/media/videobuf2-core.h                |   15 +
>>>   include/uapi/linux/bcm2835-isp.h              |  347 ++++
>>>   include/uapi/linux/v4l2-controls.h            |    6 +
>>>   include/uapi/linux/videodev2.h                |    1 +
>>>   34 files changed, 5225 insertions(+), 33 deletions(-)
>>>   create mode 100644 Documentation/admin-guide/media/bcm2835-isp.rst
>>>   create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-meta-bcm2835-isp-stats.rst
>>>   create mode 100644 drivers/staging/vc04_services/bcm2835-isp/Kconfig
>>>   create mode 100644 drivers/staging/vc04_services/bcm2835-isp/Makefile
>>>   create mode 100644 drivers/staging/vc04_services/bcm2835-isp/bcm2835-isp-ctrls.h
>>>   create mode 100644 drivers/staging/vc04_services/bcm2835-isp/bcm2835-isp-fmts.h
>>>   create mode 100644 drivers/staging/vc04_services/bcm2835-isp/bcm2835-v4l2-isp.c
>>>   create mode 100644 drivers/staging/vc04_services/vc-sm-cma/Kconfig
>>>   create mode 100644 drivers/staging/vc04_services/vc-sm-cma/Makefile
>>>   create mode 100644 drivers/staging/vc04_services/vc-sm-cma/vc_sm.c
>>>   create mode 100644 drivers/staging/vc04_services/vc-sm-cma/vc_sm.h
>>>   create mode 100644 drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c
>>>   create mode 100644 drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.h
>>>   create mode 100644 drivers/staging/vc04_services/vc-sm-cma/vc_sm_defs.h
>>>   create mode 100644 drivers/staging/vc04_services/vc-sm-cma/vc_sm_knl.h
>>>   create mode 100644 include/uapi/linux/bcm2835-isp.h
>> --
>> Regards,
>>
>> Laurent Pinchart

