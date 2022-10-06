Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F855F62CF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiJFIfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbiJFIe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:34:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D219C2EF1A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665045295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+EbXEPu5L4Ej8mQcwyMLbTrW2/HaKxB97lXOo/ryFwg=;
        b=f9nexeNeZYM60wiKiFaQ+vHAyPGQQwXc+KbB71t/hUAQtbwnTMPf1OzdKdBuVGTldS+Mp2
        Y2bCmMYCuLUeNSXbKmepbuU34doOiQ3fT9MTPOxCFHbnJJxsYh5ie94BsdCfr+uLFM91jq
        Y1+g46O2gOEK6Dzorgm1bXN8BfDLACM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-526-_A38h202M3ei5Za71dIIMQ-1; Thu, 06 Oct 2022 04:34:54 -0400
X-MC-Unique: _A38h202M3ei5Za71dIIMQ-1
Received: by mail-wm1-f69.google.com with SMTP id v191-20020a1cacc8000000b003bdf7b78dccso694061wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 01:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=+EbXEPu5L4Ej8mQcwyMLbTrW2/HaKxB97lXOo/ryFwg=;
        b=lNKpPDEObZlVWdQ99BvKj5S7tcshlzs68DNk1gl/ajRXLFS4scRjgz3qW28r/DX9sU
         xLnkFfdSywhRQjewo0AkTnmLsNLEiC5SERm2H6yhspCET785I6K1DVPLCAaLSsi6Lsc8
         +hi1XGP423Yv3Ws4HNXJboc/lvOX0mXrA95dR7Ofn822dpUKdtHvSW+zJvnrN9yyPu+b
         jedYg4nOqFCwblCQ1jF2KmprJMjsEHnq0EwSul5F7adyIpXsK+m2Rh+L5ttf9/SMgD1K
         N0rL9TE6uZ0M4l3B53xV9FJVPIUsoRWpGY0rhq6+f0YhF3/+0qlpwIM+qZJ6TyTls0eF
         F5Yg==
X-Gm-Message-State: ACrzQf2yAi4I82DN2tuq+7v0DUUEa0LditYgmOKsr79rksonAtXeWldY
        TjD9lb5h7hoQQs+ftXXzNHluz9atHK1hsE0TyNb//Xa4xUEgWFMqShey4jcJDwRCf8412z97u2P
        4wxeJpI/pAMR8zKS70Xi8UkHR
X-Received: by 2002:a05:6000:2c1:b0:22e:7507:a182 with SMTP id o1-20020a05600002c100b0022e7507a182mr524502wry.550.1665045293448;
        Thu, 06 Oct 2022 01:34:53 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM76FEwiTpUhpylaQdvp0snlHeHrtGLIyzgFkTrTt917hJeWkxc8eVXHiBerN6PXZ+o8P0wAKg==
X-Received: by 2002:a05:6000:2c1:b0:22e:7507:a182 with SMTP id o1-20020a05600002c100b0022e7507a182mr524482wry.550.1665045293189;
        Thu, 06 Oct 2022 01:34:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:2bc:381::432? ([2a01:e0a:2bc:381::432])
        by smtp.gmail.com with ESMTPSA id l2-20020a05600c4f0200b003a682354f63sm4561516wmq.11.2022.10.06.01.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 01:34:52 -0700 (PDT)
Message-ID: <d21ce246-d3cb-e067-d482-92b12861846d@redhat.com>
Date:   Thu, 6 Oct 2022 10:34:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID for 6.1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

   git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2022100501

to receive HID subsystem queue for 6.1.

Highlights:

=====
- handling of all Bluetooth HID++ devices in the Logitech HID++ drivers (Bastien Nocera)
- fix broken atomic checks in hid-multitouch by adding memory barriers (Andri Yngvason)
- better handling of devices with AMD SFH1.1 (Basavaraj Natikar)
- better support of Nintendo clone controllers (Icenowy Zheng and Johnothan King)
- Support for various RC controllers (Marcus Folkesson)
- Add UGEEv2 support in hid-uclogic (XP-PEN Deco Pro S and Parblo A610 PRO) (José Expósito)
- some conversions to use dev_groups (Greg Kroah-Hartman)
- HID-BPF preparatory patches, mostly to convert blank defines as enums (Benjamin Tissoires)
=====

----------------------------------------------------------------
Andri Yngvason (1):
       HID: multitouch: Add memory barriers

Basavaraj Natikar (2):
       HID: amd_sfh: Change dev_err to dev_dbg for additional debug info
       HID: amd_sfh: Handle condition of "no sensors" for SFH1.1

Bastien Nocera (6):
       HID: core: Export hid_match_id()
       HID: logitech-hidpp: Enable HID++ for all the Logitech Bluetooth devices
       HID: logitech-hidpp: Remove special-casing of Bluetooth devices
       HID: logitech-hidpp: Fix "Sw. Id." for HID++ 2.0 commands
       HID: logitech-hidpp: Remove hard-coded "Sw. Id." for HID++ 2.0 commands
       HID: logitech-hidpp: Detect hi-res scrolling support

Benjamin Tissoires (3):
       HID: core: store the unique system identifier in hid_device
       HID: export hid_report_type to uapi
       HID: convert defines of HID class requests into a proper enum

Christophe JAILLET (1):
       HID: wacom: Simplify comments

Greg Kroah-Hartman (2):
       HID: playstation: convert to use dev_groups
       HID: vivaldi: convert to use dev_groups

Hangyu Hua (1):
       hid: hid-logitech-hidpp: avoid unnecessary assignments in hidpp_connect_event

Harry Stern (1):
       hid: topre: Add driver fixing report descriptor

Hyunwoo Kim (1):
       HID: roccat: Fix use-after-free in roccat_read()

Icenowy Zheng (1):
       HID: nintendo: deregister home LED when it fails

Jiangshan Yi (1):
       HID: rmi: replace ternary operator with min()

Johnothan King (1):
       HID: nintendo: check analog user calibration for plausibility

José Expósito (10):
       HID: uclogic: Add missing suffix for digitalizers
       HID: uclogic: Fix warning in uclogic_rdesc_template_apply
       HID: uclogic: KUnit best practices and naming conventions
       HID: uclogic: Refactor UGEE v2 string descriptor parsing
       HID: uclogic: Refactor UGEE v2 frame initialization
       HID: uclogic: Parse the UGEE v2 frame type
       HID: uclogic: Add support for UGEE v2 dial frames
       HID: uclogic: Add support for UGEE v2 mouse frames
       HID: uclogic: Add support for XP-PEN Deco Pro S
       HID: uclogic: Add support for Parblo A610 PRO

Marcus Folkesson (2):
       HID: Add driver for VRC-2 Car Controller
       HID: Add driver for PhoenixRC Flight Controller

Ping Cheng (2):
       HID: wacom: Add new Intuos Pro Small (PTH-460) device IDs
       HID: wacom: add three styli to wacom_intuos_get_tool_type

Randy Dunlap (1):
       HID: Kconfig: remove redundant "depends on HID" lines

Shaomin Deng (1):
       HID: sony: Fix double word in comments

Wolfram Sang (1):
       HID: move from strlcpy with unused retval to strscpy

  MAINTAINERS                                   |  12 +++++++
  drivers/hid/Kconfig                           | 100 ++++++++++++++++-----------------------------------------
  drivers/hid/Makefile                          |   7 +++-
  drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c |   8 +++--
  drivers/hid/hid-core.c                        |  22 +++++++------
  drivers/hid/hid-google-hammer.c               |   4 ++-
  drivers/hid/hid-ids.h                         |   6 ++++
  drivers/hid/hid-logitech-hidpp.c              | 164 ++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------
  drivers/hid/hid-multitouch.c                  |   8 ++---
  drivers/hid/hid-nintendo.c                    |  60 ++++++++++++++++++----------------
  drivers/hid/hid-playstation.c                 |  16 +++------
  drivers/hid/hid-pxrc.c                        | 112 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/hid/hid-rmi.c                         |   6 ++--
  drivers/hid/hid-roccat.c                      |   4 +++
  drivers/hid/hid-sony.c                        |   2 +-
  drivers/hid/hid-steam.c                       |   8 ++---
  drivers/hid/hid-topre.c                       |  49 ++++++++++++++++++++++++++++
  drivers/hid/hid-uclogic-core.c                |   5 +++
  drivers/hid/hid-uclogic-params-test.c         | 192 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/hid/hid-uclogic-params.c              | 230 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------
  drivers/hid/hid-uclogic-params.h              |  10 ++++++
  drivers/hid/hid-uclogic-rdesc-test.c          |  22 ++++++-------
  drivers/hid/hid-uclogic-rdesc.c               |  76 ++++++++++++++++++++++++++++++++++++++++++-
  drivers/hid/hid-uclogic-rdesc.h               |   8 +++++
  drivers/hid/hid-vivaldi-common.c              |  29 +++++++++--------
  drivers/hid/hid-vivaldi-common.h              |   4 +--
  drivers/hid/hid-vivaldi.c                     |   4 ++-
  drivers/hid/hid-vrc2.c                        |  91 ++++++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/hid/i2c-hid/i2c-hid-core.c            |   2 +-
  drivers/hid/usbhid/hid-core.c                 |   2 +-
  drivers/hid/usbhid/usbkbd.c                   |   2 +-
  drivers/hid/usbhid/usbmouse.c                 |   2 +-
  drivers/hid/wacom.h                           |   5 +--
  drivers/hid/wacom_sys.c                       |  11 ++-----
  drivers/hid/wacom_wac.c                       |  13 +++++---
  drivers/hid/wacom_wac.h                       |   4 +--
  include/linux/hid.h                           |  33 ++++++++-----------
  include/uapi/linux/hid.h                      |  26 +++++++++++----
  38 files changed, 1034 insertions(+), 325 deletions(-)
  create mode 100644 drivers/hid/hid-pxrc.c
  create mode 100644 drivers/hid/hid-topre.c
  create mode 100644 drivers/hid/hid-uclogic-params-test.c
  create mode 100644 drivers/hid/hid-vrc2.c

-- 

Cheers,
Benjamin

