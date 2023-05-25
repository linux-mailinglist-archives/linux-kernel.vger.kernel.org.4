Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE8271096A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 12:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjEYKEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 06:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjEYKEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 06:04:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2F610B
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 03:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685008999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7CA3N1jhgCA+EK9INjfeIU30KXLxoA1XUpS7B8fqlp8=;
        b=P4ql0qMyW3N20EFHlwwdLI9i4DJ4SSbe2wfzyyWEW7QrCbofUrhQXIc3OiZjrVLmQJIn/E
        iXG1wrHZeW/Gb+Ym16theC4TIjVyQNcL9wrN5xxlzrJrARjsokEJ9vjxkRmOErBox3JUW+
        9r7l04cxIDGSvyfh8W9DAPYjaPsd1xM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-LhU9N76yM52wkFQKVur6hw-1; Thu, 25 May 2023 06:03:18 -0400
X-MC-Unique: LhU9N76yM52wkFQKVur6hw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-96f83b44939so45925666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 03:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685008997; x=1687600997;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7CA3N1jhgCA+EK9INjfeIU30KXLxoA1XUpS7B8fqlp8=;
        b=iGC44DhuvLsBfKnhvbn8k57E5sGw7Ayy8BWSMU1Pdi4i7R2xbe9nFIShZW+9Cshdkn
         B9Pi/A7G5UCd5U1ctB+yfE9vfYNZ90eUC5bBdfSqFkVsd6j0fLy5na79DZ4fnQMdClbK
         qRhUeqB8TL68A5JHuBAFO3yQiBUh/yzaDHg1+bM2xq7itKg2+6vn6VXrf9JnIu6h7Oth
         tNJuZ+sZP0Krno1aWhotd8Sip0Hbpoca5Rhmd5tx+21fqTxSK6KLWwaGHFhD+hxfV/H5
         8n9yrmzd7RnkphJV2vj4+/KE4VAJhWsJVrhE7fvuTy/URuuGJHGvlD4fYohieZWHpqKY
         Mo0g==
X-Gm-Message-State: AC+VfDxxMjx4d41DoOS9DWWutwIgDPi4GgO1jiertzcn950Tg9w5M6Tb
        iD+N11azonUwtQY/0kQgdp3ZUnZfYIcLKMkb0RPbSjz2o8b9IXTzEWl9/nmjzEfaFuF7kGhQEAG
        U61GZ1gpkvKepjEZ2IdoYmWOD
X-Received: by 2002:a17:906:9745:b0:966:5a6c:7549 with SMTP id o5-20020a170906974500b009665a6c7549mr1054356ejy.14.1685008996862;
        Thu, 25 May 2023 03:03:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Q/2L1bB5XlZ25R02jsIi9NDc7RewW3lxurnawYDHDbUeLbd0pet0VGr9CchlQrrMi8QRVUg==
X-Received: by 2002:a17:906:9745:b0:966:5a6c:7549 with SMTP id o5-20020a170906974500b009665a6c7549mr1054330ejy.14.1685008996511;
        Thu, 25 May 2023 03:03:16 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id j23-20020a170906475700b00967a18df1easm632621ejs.117.2023.05.25.03.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 03:03:16 -0700 (PDT)
Message-ID: <941d687d-ef8e-0823-fff0-3011be6c0e0a@redhat.com>
Date:   Thu, 25 May 2023 12:03:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.4-3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the second round of fixes for platform-drivers-x86 for 6.4.

Nothing special to report just a few small fixes.

Regards,

Hans


The following changes since commit 3d43f9f639542fadfb28f40b509bf147a6624d48:

  platform/mellanox: fix potential race in mlxbf-tmfifo driver (2023-05-09 11:54:35 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.4-3

for you to fetch changes up to 3279decb2c3c8d58cb0b70ed5235c480735a36ee:

  platform/x86/intel/ifs: Annotate work queue on stack so object debug does not complain (2023-05-23 12:55:16 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.4-3

A small set of assorted bug fixes for 6.4.

The following is an automated git shortlog grouped by driver:

ISST:
 -  Remove 8 socket limit

asus-wmi:
 -  Ignore WMI events with codes 0x7B, 0xC0

platform/mellanox:
 -  mlxbf-pmc: fix sscanf() error checking

platform/x86/amd/pmf:
 -  Fix CnQF and auto-mode after resume

platform/x86/intel/ifs:
 -  Annotate work queue on stack so object debug does not complain

----------------------------------------------------------------
Alexandru Sorodoc (1):
      platform/x86: asus-wmi: Ignore WMI events with codes 0x7B, 0xC0

Dan Carpenter (1):
      platform/mellanox: mlxbf-pmc: fix sscanf() error checking

David Arcari (1):
      platform/x86/intel/ifs: Annotate work queue on stack so object debug does not complain

Mario Limonciello (1):
      platform/x86/amd/pmf: Fix CnQF and auto-mode after resume

Steve Wahl (1):
      platform/x86: ISST: Remove 8 socket limit

 drivers/platform/mellanox/mlxbf-pmc.c              |  5 ++--
 drivers/platform/x86/amd/pmf/core.c                | 34 +++++++++++++++++-----
 drivers/platform/x86/asus-nb-wmi.c                 |  2 ++
 drivers/platform/x86/intel/ifs/load.c              |  2 +-
 .../x86/intel/speed_select_if/isst_if_common.c     | 12 ++++----
 5 files changed, 36 insertions(+), 19 deletions(-)

