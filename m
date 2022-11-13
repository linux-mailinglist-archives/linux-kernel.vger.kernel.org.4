Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67226271AA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 19:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbiKMSf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 13:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiKMSf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 13:35:56 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB374B7C4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 10:35:54 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id p184so6760055iof.11
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 10:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mJFd6KRt696QPqbMtfBXILk0+fJS876IuAdt2Ssa9PM=;
        b=GzKWscTdvh2hk4tzP8v31C8alOFGxi/XsK5nAe6M4cZSD5dQpOKPn2CM+bxUk5Yhe/
         E56jWnypE8tjaNq1HQ9ah0XSfrNbF3ZGZmcTDZGiivv57EWuF/DD3oENfQta5O9y4KVI
         WbL5k2tmsE61lGvv6uEmwFxRVMp1RTAETxDwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJFd6KRt696QPqbMtfBXILk0+fJS876IuAdt2Ssa9PM=;
        b=5bWTkc+7R7glMHjBW5upaIJRuHzBywV0EBFYjk2eACwdiUp7AEr2y1mIox92B1Bsie
         s1UozYiVhuSXqHxZdDp0cYYkByxSZ8yNMD4YUenZz9hUt3KIDm+AUtYY/eVRoxp1qG4r
         JccqnxaZH3A/B9xVBPAHur4xFmulFZXpkNdlF9VguWiVtHONhJJ9zpuCS7/QiGNNjJ64
         qsP3BHvBw23qRm4kq4pnv/uQx/eF/N/BnuIbIVnJF2gBAHJbYXG48RvDQC7WltieWXAD
         6p+77pezlL1snsuWQA/LNMbCwYx7GqhrS7s9HBp2r0VVx1mVTljRKFRlRyS9ahv9IHqV
         bvfQ==
X-Gm-Message-State: ANoB5pmQFAvdX64zvWCsaPypAFf8a4TEsDmhkolvgK3G3IrpX7hCupK/
        RMkprqETmOj5GebExIc8AgLdG4vEBwIL/w==
X-Google-Smtp-Source: AA0mqf5bwCFPKnIchl4l72IEGh2srHM4K7tYAPW0hc5BrLAib5b9dhaKWhr2PGbNiDZ7P0M3cpXbBQ==
X-Received: by 2002:a5d:8f91:0:b0:6af:ed54:1c81 with SMTP id l17-20020a5d8f91000000b006afed541c81mr4452051iol.106.1668364553505;
        Sun, 13 Nov 2022 10:35:53 -0800 (PST)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id cx12-20020a056638490c00b003733e2ce4e8sm2725620jab.59.2022.11.13.10.35.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 10:35:52 -0800 (PST)
Received: by mail-io1-f54.google.com with SMTP id 63so6762989iov.8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 10:35:51 -0800 (PST)
X-Received: by 2002:a05:6638:30b:b0:375:7eda:8c7e with SMTP id
 w11-20020a056638030b00b003757eda8c7emr4531530jap.27.1668364550714; Sun, 13
 Nov 2022 10:35:50 -0800 (PST)
MIME-Version: 1.0
References: <20221112011946.11127-1-aichao@kylinos.cn>
In-Reply-To: <20221112011946.11127-1-aichao@kylinos.cn>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Sun, 13 Nov 2022 19:35:39 +0100
X-Gmail-Original-Message-ID: <CANiDSCtVUph=T9kBJ3OLuKM4SNwuCHvZTkFtGSBS3vxMRnV0Ow@mail.gmail.com>
Message-ID: <CANiDSCtVUph=T9kBJ3OLuKM4SNwuCHvZTkFtGSBS3vxMRnV0Ow@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Fix bandwidth error for Alcor camera
To:     Ai Chao <aichao@kylinos.cn>
Cc:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ai

Thanks for your patch. Can you take a look to the other comments from
my previous email?

Also next time, please add v2, v3.. to your subject, to make it easier
to follow the status of the patch.

Thanks!

On Sat, 12 Nov 2022 at 02:28, Ai Chao <aichao@kylinos.cn> wrote:
>
> For Alcor Corp. Slave camera(1b17:6684), it support to
> output compressed video data, and it return a wrong
>  dwMaxPayloadTransferSize fields. This is a fireware issue,
> but the manufacturer cannot provide a const return fields
> by the fireware. so we check the dwMaxPayloadTransferSize fields,
> if it large than 0x1000, reset dwMaxPayloadTransferSize to 1024.
>
> lsusb -d 1b17:6684 -v
>
> Bus 001 Device 007: ID 1b17:6684 Alcor Corp. Slave camera
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass          239 Miscellaneous Device
>   bDeviceSubClass         2
>   bDeviceProtocol         1 Interface Association
>   bMaxPacketSize0        64
>   idVendor           0x1b17
>   idProduct          0x6684
>   bcdDevice            1.01
>   iManufacturer           1 Alcor Corp.
>   iProduct                2 Slave camera
>   iSerial                 0
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength       0x0443
>     bNumInterfaces          2
>     bConfigurationValue     1
>     iConfiguration          0
>     bmAttributes         0x80
>       (Bus Powered)
>     MaxPower              200mA
>     Interface Association:
>       bLength                 8
>       bDescriptorType        11
>       bFirstInterface         0
>       bInterfaceCount         2
>       bFunctionClass         14 Video
>       bFunctionSubClass       3 Video Interface Collection
>       bFunctionProtocol       0
>       iFunction               4 Slave camera
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           1
>       bInterfaceClass        14 Video
>       bInterfaceSubClass      1 Video Control
>       bInterfaceProtocol      0
>       iInterface              4 Slave camera
>       VideoControl Interface Descriptor:
>         bLength                13
>         bDescriptorType        36
>         bDescriptorSubtype      1 (HEADER)
>         bcdUVC               1.00
>         wTotalLength       0x004f
>         dwClockFrequency       30.000000MHz
>         bInCollection           1
>         baInterfaceNr( 0)       1
>       VideoControl Interface Descriptor:
>         bLength                28
>         bDescriptorType        36
>         bDescriptorSubtype      6 (EXTENSION_UNIT)
>         bUnitID                 6
>         guidExtensionCode         {68bbd0b0-61a4-4b83-90b7-a6215f3c4f70}
>         bNumControl            24
>         bNrPins                 1
>         baSourceID( 0)          2
>         bControlSize            3
>         bmControls( 0)       0xff
>         bmControls( 1)       0xff
>         bmControls( 2)       0xff
>         iExtension              0
>       VideoControl Interface Descriptor:
>         bLength                18
>         bDescriptorType        36
>         bDescriptorSubtype      2 (INPUT_TERMINAL)
>         bTerminalID             1
>         wTerminalType      0x0201 Camera Sensor
>         bAssocTerminal          0
>         iTerminal               0
>         wObjectiveFocalLengthMin      0
>         wObjectiveFocalLengthMax      0
>         wOcularFocalLength            0
>         bControlSize                  3
>         bmControls           0x0000000e
>           Auto-Exposure Mode
>           Auto-Exposure Priority
>           Exposure Time (Absolute)
>       VideoControl Interface Descriptor:
>         bLength                11
>         bDescriptorType        36
>         bDescriptorSubtype      5 (PROCESSING_UNIT)
>       Warning: Descriptor too short
>         bUnitID                 2
>         bSourceID               1
>         wMaxMultiplier          0
>         bControlSize            2
>         bmControls     0x0000177f
>           Brightness
>           Contrast
>           Hue
>           Saturation
>           Sharpness
>           Gamma
>           White Balance Temperature
>           Backlight Compensation
>           Gain
>           Power Line Frequency
>           White Balance Temperature, Auto
>         iProcessing             0
>         bmVideoStandards     0x09
>           None
>           SECAM - 625/50
>       VideoControl Interface Descriptor:
>         bLength                 9
>         bDescriptorType        36
>         bDescriptorSubtype      3 (OUTPUT_TERMINAL)
>         bTerminalID             3
>         wTerminalType      0x0101 USB Streaming
>         bAssocTerminal          0
>         bSourceID               2
>         iTerminal               0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x81  EP 1 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0010  1x 16 bytes
>         bInterval               7
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       0
>       bNumEndpoints           0
>       bInterfaceClass        14 Video
>       bInterfaceSubClass      2 Video Streaming
>       bInterfaceProtocol      0
>       iInterface              0
>       VideoStreaming Interface Descriptor:
>         bLength                            15
>         bDescriptorType                    36
>         bDescriptorSubtype                  1 (INPUT_HEADER)
>         bNumFormats                         2
>         wTotalLength                   0x0385
>         bEndPointAddress                  130
>         bmInfo                              0
>         bTerminalLink                       3
>         bStillCaptureMethod                 2
>         bTriggerSupport                     1
>         bTriggerUsage                       0
>         bControlSize                        1
>         bmaControls( 0)                     0
>         bmaControls( 1)                     0
>       VideoStreaming Interface Descriptor:
>         bLength                            11
>         bDescriptorType                    36
>         bDescriptorSubtype                  6 (FORMAT_MJPEG)
>         bFormatIndex                        1
>         bNumFrameDescriptors                9
>         bFlags                              1
>           Fixed-size samples: Yes
>         bDefaultFrameIndex                  1
>         bAspectRatioX                       0
>         bAspectRatioY                       0
>         bmInterlaceFlags                 0x00
>           Interlaced stream or variable: No
>           Fields per frame: 1 fields
>           Field 1 first: No
>           Field pattern: Field 1 only
>         bCopyProtect                        0
>       VideoStreaming Interface Descriptor:
>         bLength                            50
>         bDescriptorType                    36
>         bDescriptorSubtype                  7 (FRAME_MJPEG)
>         bFrameIndex                         1
>         bmCapabilities                   0x00
>           Still image unsupported
>         wWidth                           1920
>         wHeight                          1080
>         dwMinBitRate                248832000
>         dwMaxBitRate                1492992000
>         dwMaxVideoFrameBufferSize     6220800
>         dwDefaultFrameInterval         333333
>         bFrameIntervalType                  6
>         dwFrameInterval( 0)            333333
>         dwFrameInterval( 1)            400000
>         dwFrameInterval( 2)            500000
>         dwFrameInterval( 3)            666666
>         dwFrameInterval( 4)           1000000
>         dwFrameInterval( 5)           2000000
>       VideoStreaming Interface Descriptor:
>         bLength                            50
>         bDescriptorType                    36
>         bDescriptorSubtype                  7 (FRAME_MJPEG)
>         bFrameIndex                         2
>         bmCapabilities                   0x00
>           Still image unsupported
>         wWidth                           2048
>         wHeight                          1536
>         dwMinBitRate                377487360
>         dwMaxBitRate                2264924160
>         dwMaxVideoFrameBufferSize     9437184
>         dwDefaultFrameInterval         333333
>         bFrameIntervalType                  6
>         dwFrameInterval( 0)            333333
>         dwFrameInterval( 1)            400000
>         dwFrameInterval( 2)            500000
>         dwFrameInterval( 3)            666666
>         dwFrameInterval( 4)           1000000
>         dwFrameInterval( 5)           2000000
>       VideoStreaming Interface Descriptor:
>         bLength                            42
>         bDescriptorType                    36
>         bDescriptorSubtype                  7 (FRAME_MJPEG)
>         bFrameIndex                         3
>         bmCapabilities                   0x00
>           Still image unsupported
>         wWidth                           1600
>         wHeight                          1200
>         dwMinBitRate                230400000
>         dwMaxBitRate                921600000
>         dwMaxVideoFrameBufferSize     5760000
>         dwDefaultFrameInterval         500000
>         bFrameIntervalType                  4
>         dwFrameInterval( 0)            500000
>         dwFrameInterval( 1)            666666
>         dwFrameInterval( 2)           1000000
>         dwFrameInterval( 3)           2000000
>       VideoStreaming Interface Descriptor:
>         bLength                            38
>         bDescriptorType                    36
>         bDescriptorSubtype                  7 (FRAME_MJPEG)
>         bFrameIndex                         4
>         bmCapabilities                   0x00
>           Still image unsupported
>         wWidth                           2592
>         wHeight                          1944
>         dwMinBitRate                604661760
>         dwMaxBitRate                1813985280
>         dwMaxVideoFrameBufferSize    15116544
>         dwDefaultFrameInterval         666666
>         bFrameIntervalType                  3
>         dwFrameInterval( 0)            666666
>         dwFrameInterval( 1)           1000000
>         dwFrameInterval( 2)           2000000
>       VideoStreaming Interface Descriptor:
>         bLength                            50
>         bDescriptorType                    36
>         bDescriptorSubtype                  7 (FRAME_MJPEG)
>         bFrameIndex                         5
>         bmCapabilities                   0x00
>           Still image unsupported
>         wWidth                           1280
>         wHeight                          1024
>         dwMinBitRate                157286400
>         dwMaxBitRate                943718400
>         dwMaxVideoFrameBufferSize     3932160
>         dwDefaultFrameInterval         333333
>         bFrameIntervalType                  6
>         dwFrameInterval( 0)            333333
>         dwFrameInterval( 1)            400000
>         dwFrameInterval( 2)            500000
>         dwFrameInterval( 3)            666666
>         dwFrameInterval( 4)           1000000
>         dwFrameInterval( 5)           2000000
>       VideoStreaming Interface Descriptor:
>         bLength                            42
>         bDescriptorType                    36
>         bDescriptorSubtype                  7 (FRAME_MJPEG)
>         bFrameIndex                         6
>         bmCapabilities                   0x00
>           Still image unsupported
>         wWidth                           1280
>         wHeight                           960
>         dwMinBitRate                147456000
>         dwMaxBitRate                589824000
>         dwMaxVideoFrameBufferSize     3686400
>         dwDefaultFrameInterval         500000
>         bFrameIntervalType                  4
>         dwFrameInterval( 0)            500000
>         dwFrameInterval( 1)            666666
>         dwFrameInterval( 2)           1000000
>         dwFrameInterval( 3)           2000000
>       VideoStreaming Interface Descriptor:
>         bLength                            50
>         bDescriptorType                    36
>         bDescriptorSubtype                  7 (FRAME_MJPEG)
>         bFrameIndex                         7
>         bmCapabilities                   0x00
>           Still image unsupported
>         wWidth                           1280
>         wHeight                           720
>         dwMinBitRate                110592000
>         dwMaxBitRate                663552000
>         dwMaxVideoFrameBufferSize     2764800
>         dwDefaultFrameInterval         333333
>         bFrameIntervalType                  6
>         dwFrameInterval( 0)            333333
>         dwFrameInterval( 1)            400000
>         dwFrameInterval( 2)            500000
>         dwFrameInterval( 3)            666666
>         dwFrameInterval( 4)           1000000
>         dwFrameInterval( 5)           2000000
>       VideoStreaming Interface Descriptor:
>         bLength                            50
>         bDescriptorType                    36
>         bDescriptorSubtype                  7 (FRAME_MJPEG)
>         bFrameIndex                         8
>         bmCapabilities                   0x00
>           Still image unsupported
>         wWidth                            800
>         wHeight                           600
>         dwMinBitRate                 57600000
>         dwMaxBitRate                345600000
>         dwMaxVideoFrameBufferSize     1440000
>         dwDefaultFrameInterval         333333
>         bFrameIntervalType                  6
>         dwFrameInterval( 0)            333333
>         dwFrameInterval( 1)            400000
>         dwFrameInterval( 2)            500000
>         dwFrameInterval( 3)            666666
>         dwFrameInterval( 4)           1000000
>         dwFrameInterval( 5)           2000000
>       VideoStreaming Interface Descriptor:
>         bLength                            50
>         bDescriptorType                    36
>         bDescriptorSubtype                  7 (FRAME_MJPEG)
>         bFrameIndex                         9
>         bmCapabilities                   0x00
>           Still image unsupported
>         wWidth                            640
>         wHeight                           480
>         dwMinBitRate                 36864000
>         dwMaxBitRate                221184000
>         dwMaxVideoFrameBufferSize      921600
>         dwDefaultFrameInterval         333333
>         bFrameIntervalType                  6
>         dwFrameInterval( 0)            333333
>         dwFrameInterval( 1)            400000
>         dwFrameInterval( 2)            500000
>         dwFrameInterval( 3)            666666
>         dwFrameInterval( 4)           1000000
>         dwFrameInterval( 5)           2000000
>       VideoStreaming Interface Descriptor:
>         bLength                            42
>         bDescriptorType                    36
>         bDescriptorSubtype                  3 (STILL_IMAGE_FRAME)
>         bEndpointAddress                    0
>         bNumImageSizePatterns               9
>         wWidth( 0)                       1920
>         wHeight( 0)                      1080
>         wWidth( 1)                       2048
>         wHeight( 1)                      1536
>         wWidth( 2)                       1600
>         wHeight( 2)                      1200
>         wWidth( 3)                       2592
>         wHeight( 3)                      1944
>         wWidth( 4)                       1280
>         wHeight( 4)                      1024
>         wWidth( 5)                       1280
>         wHeight( 5)                       960
>         wWidth( 6)                       1280
>         wHeight( 6)                       720
>         wWidth( 7)                        800
>         wHeight( 7)                       600
>         wWidth( 8)                        640
>         wHeight( 8)                       480
>         bNumCompressionPatterns             0
>       VideoStreaming Interface Descriptor:
>         bLength                             6
>         bDescriptorType                    36
>         bDescriptorSubtype                 13 (COLORFORMAT)
>         bColorPrimaries                     1 (BT.709,sRGB)
>         bTransferCharacteristics            1 (BT.709)
>         bMatrixCoefficients                 4 (SMPTE 170M (BT.601))
>       VideoStreaming Interface Descriptor:
>         bLength                            27
>         bDescriptorType                    36
>         bDescriptorSubtype                  4 (FORMAT_UNCOMPRESSED)
>         bFormatIndex                        2
>         bNumFrameDescriptors                9
>         guidFormat                            {32595559-0000-0010-8000-00aa00389b71}
>         bBitsPerPixel                      16
>         bDefaultFrameIndex                  1
>         bAspectRatioX                       0
>         bAspectRatioY                       0
>         bmInterlaceFlags                 0x00
>           Interlaced stream or variable: No
>           Fields per frame: 2 fields
>           Field 1 first: No
>           Field pattern: Field 1 only
>         bCopyProtect                        0
>       VideoStreaming Interface Descriptor:
>         bLength                            30
>         bDescriptorType                    36
>         bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
>         bFrameIndex                         1
>         bmCapabilities                   0x00
>           Still image unsupported
>         wWidth                           1920
>         wHeight                          1080
>         dwMinBitRate                165888000
>         dwMaxBitRate                165888000
>         dwMaxVideoFrameBufferSize     4147200
>         dwDefaultFrameInterval        2000000
>         bFrameIntervalType                  1
>         dwFrameInterval( 0)           2000000
>       VideoStreaming Interface Descriptor:
>         bLength                            42
>         bDescriptorType                    36
>         bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
>         bFrameIndex                         2
>         bmCapabilities                   0x00
>           Still image unsupported
>         wWidth                           2048
>         wHeight                          1536
>         dwMinBitRate                251658240
>         dwMaxBitRate                1006632960
>         dwMaxVideoFrameBufferSize     6291456
>         dwDefaultFrameInterval         500000
>         bFrameIntervalType                  4
>         dwFrameInterval( 0)            500000
>         dwFrameInterval( 1)            666666
>         dwFrameInterval( 2)           1000000
>         dwFrameInterval( 3)           2000000
>       VideoStreaming Interface Descriptor:
>         bLength                            30
>         bDescriptorType                    36
>         bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
>         bFrameIndex                         3
>         bmCapabilities                   0x00
>           Still image unsupported
>         wWidth                           1600
>         wHeight                          1200
>         dwMinBitRate                153600000
>         dwMaxBitRate                153600000
>         dwMaxVideoFrameBufferSize     3840000
>         dwDefaultFrameInterval        2000000
>         bFrameIntervalType                  1
>         dwFrameInterval( 0)           2000000
>       VideoStreaming Interface Descriptor:
>         bLength                            30
>         bDescriptorType                    36
>         bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
>         bFrameIndex                         4
>         bmCapabilities                   0x00
>           Still image unsupported
>         wWidth                           2592
>         wHeight                          1944
>         dwMinBitRate                161243136
>         dwMaxBitRate                161243136
>         dwMaxVideoFrameBufferSize    10077696
>         dwDefaultFrameInterval        5000000
>         bFrameIntervalType                  1
>         dwFrameInterval( 0)           5000000
>       VideoStreaming Interface Descriptor:
>         bLength                            34
>         bDescriptorType                    36
>         bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
>         bFrameIndex                         5
>         bmCapabilities                   0x00
>           Still image unsupported
>         wWidth                           1280
>         wHeight                          1024
>         dwMinBitRate                104857600
>         dwMaxBitRate                167772160
>         dwMaxVideoFrameBufferSize     2621440
>         dwDefaultFrameInterval        1250000
>         bFrameIntervalType                  2
>         dwFrameInterval( 0)           1250000
>         dwFrameInterval( 1)           2000000
>       VideoStreaming Interface Descriptor:
>         bLength                            30
>         bDescriptorType                    36
>         bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
>         bFrameIndex                         6
>         bmCapabilities                   0x00
>           Still image unsupported
>         wWidth                           1280
>         wHeight                           960
>         dwMinBitRate                 98304000
>         dwMaxBitRate                 98304000
>         dwMaxVideoFrameBufferSize     2457600
>         dwDefaultFrameInterval        2000000
>         bFrameIntervalType                  1
>         dwFrameInterval( 0)           2000000
>       VideoStreaming Interface Descriptor:
>         bLength                            34
>         bDescriptorType                    36
>         bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
>         bFrameIndex                         7
>         bmCapabilities                   0x00
>           Still image unsupported
>         wWidth                           1280
>         wHeight                           720
>         dwMinBitRate                 73728000
>         dwMaxBitRate                147456000
>         dwMaxVideoFrameBufferSize     1843200
>         dwDefaultFrameInterval        1000000
>         bFrameIntervalType                  2
>         dwFrameInterval( 0)           1000000
>         dwFrameInterval( 1)           2000000
>       VideoStreaming Interface Descriptor:
>         bLength                            50
>         bDescriptorType                    36
>         bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
>         bFrameIndex                         8
>         bmCapabilities                   0x00
>           Still image unsupported
>         wWidth                            800
>         wHeight                           600
>         dwMinBitRate                 38400000
>         dwMaxBitRate                230400000
>         dwMaxVideoFrameBufferSize      960000
>         dwDefaultFrameInterval         333333
>         bFrameIntervalType                  6
>         dwFrameInterval( 0)            333333
>         dwFrameInterval( 1)            400000
>         dwFrameInterval( 2)            500000
>         dwFrameInterval( 3)            666666
>         dwFrameInterval( 4)           1000000
>         dwFrameInterval( 5)           2000000
>       VideoStreaming Interface Descriptor:
>         bLength                            50
>         bDescriptorType                    36
>         bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
>         bFrameIndex                         9
>         bmCapabilities                   0x00
>           Still image unsupported
>         wWidth                            640
>         wHeight                           480
>         dwMinBitRate                 24576000
>         dwMaxBitRate                147456000
>         dwMaxVideoFrameBufferSize      614400
>         dwDefaultFrameInterval         333333
>         bFrameIntervalType                  6
>         dwFrameInterval( 0)            333333
>         dwFrameInterval( 1)            400000
>         dwFrameInterval( 2)            500000
>         dwFrameInterval( 3)            666666
>         dwFrameInterval( 4)           1000000
>         dwFrameInterval( 5)           2000000
>       VideoStreaming Interface Descriptor:
>         bLength                            42
>         bDescriptorType                    36
>         bDescriptorSubtype                  3 (STILL_IMAGE_FRAME)
>         bEndpointAddress                    0
>         bNumImageSizePatterns               9
>         wWidth( 0)                       1920
>         wHeight( 0)                      1080
>         wWidth( 1)                       2048
>         wHeight( 1)                      1536
>         wWidth( 2)                       1600
>         wHeight( 2)                      1200
>         wWidth( 3)                       2592
>         wHeight( 3)                      1944
>         wWidth( 4)                       1280
>         wHeight( 4)                      1024
>         wWidth( 5)                       1280
>         wHeight( 5)                       960
>         wWidth( 6)                       1280
>         wHeight( 6)                       720
>         wWidth( 7)                        800
>         wHeight( 7)                       600
>         wWidth( 8)                        640
>         wHeight( 8)                       480
>         bNumCompressionPatterns             0
>       VideoStreaming Interface Descriptor:
>         bLength                             6
>         bDescriptorType                    36
>         bDescriptorSubtype                 13 (COLORFORMAT)
>         bColorPrimaries                     1 (BT.709,sRGB)
>         bTransferCharacteristics            1 (BT.709)
>         bMatrixCoefficients                 4 (SMPTE 170M (BT.601))
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       1
>       bNumEndpoints           1
>       bInterfaceClass        14 Video
>       bInterfaceSubClass      2 Video Streaming
>       bInterfaceProtocol      0
>       iInterface              0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x82  EP 2 IN
>         bmAttributes            5
>           Transfer Type            Isochronous
>           Synch Type               Asynchronous
>           Usage Type               Data
>         wMaxPacketSize     0x1400  3x 1024 bytes
>         bInterval               1
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       2
>       bNumEndpoints           1
>       bInterfaceClass        14 Video
>       bInterfaceSubClass      2 Video Streaming
>       bInterfaceProtocol      0
>       iInterface              0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x82  EP 2 IN
>         bmAttributes            5
>           Transfer Type            Isochronous
>           Synch Type               Asynchronous
>           Usage Type               Data
>         wMaxPacketSize     0x1340  3x 832 bytes
>         bInterval               1
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       3
>       bNumEndpoints           1
>       bInterfaceClass        14 Video
>       bInterfaceSubClass      2 Video Streaming
>       bInterfaceProtocol      0
>       iInterface              0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x82  EP 2 IN
>         bmAttributes            5
>           Transfer Type            Isochronous
>           Synch Type               Asynchronous
>           Usage Type               Data
>         wMaxPacketSize     0x0c00  2x 1024 bytes
>         bInterval               1
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       4
>       bNumEndpoints           1
>       bInterfaceClass        14 Video
>       bInterfaceSubClass      2 Video Streaming
>       bInterfaceProtocol      0
>       iInterface              0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x82  EP 2 IN
>         bmAttributes            5
>           Transfer Type            Isochronous
>           Synch Type               Asynchronous
>           Usage Type               Data
>         wMaxPacketSize     0x0c00  2x 1024 bytes
>         bInterval               1
> Device Qualifier (for other device speed):
>   bLength                10
>   bDescriptorType         6
>   bcdUSB               2.00
>   bDeviceClass          239 Miscellaneous Device
>   bDeviceSubClass         2
>   bDeviceProtocol         1 Interface Association
>   bMaxPacketSize0        64
>   bNumConfigurations      1
> Device Status:     0x0000
>   (Bus Powered)
>
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
> ---
>  drivers/media/usb/uvc/uvc_video.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index d2eb9066e4dc..49226c3f423c 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -234,6 +234,14 @@ static void uvc_fixup_video_ctrl(struct uvc_streaming *stream,
>
>                 ctrl->dwMaxPayloadTransferSize = bandwidth;
>         }
> +
> +       /*Alcor Corp. Slave camera return wrong dwMaxPayloadTransferSize*/
> +       if ((format->flags & UVC_FMT_FLAG_COMPRESSED) &&
> +           (ctrl->dwMaxPayloadTransferSize > 0x1000) &&
> +           (le16_to_cpu(stream->dev->udev->descriptor.idVendor) == 0x1b17) &&
> +           (le16_to_cpu(stream->dev->udev->descriptor.idProduct) == 0x6684)) {
> +               ctrl->dwMaxPayloadTransferSize = 1024;
> +       }
>  }
>
>  static size_t uvc_video_ctrl_size(struct uvc_streaming *stream)
> --
> 2.25.1
>


-- 
Ricardo Ribalda
