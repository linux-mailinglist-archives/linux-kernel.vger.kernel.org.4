Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CEA6BD11D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjCPNlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjCPNlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:41:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A963C0826
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678974015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jLI+n0GbwBQRhOd6vq4dlsCtA7e4bDldTxIW64FjbEI=;
        b=Sn2U5CScFR7GdA4mBA+1p0K+bWjLpbGsNcL/84CJoGVlDyftI+rs6QacFYm45BqSKI0Kdu
        /ciML39O2+d6dZJxi+Oe0J/GaMzh8i4jflEgemmwKxmKdCxWxwJVWfOIN/JPL0AWHbiJNB
        WRy7ndhvDALUegmewb7YyXNxgrur91M=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-gnKmPKIPPXGMi6HhDe5-Ag-1; Thu, 16 Mar 2023 09:40:14 -0400
X-MC-Unique: gnKmPKIPPXGMi6HhDe5-Ag-1
Received: by mail-ed1-f72.google.com with SMTP id i42-20020a0564020f2a00b004fd23c238beso3171609eda.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678974013;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jLI+n0GbwBQRhOd6vq4dlsCtA7e4bDldTxIW64FjbEI=;
        b=sz5rUUKAF8jUSgYCQPf8t4IE/NZX6sZtxxDpvxALtNn+kYA+6D9LmUdlLgnBxlo07p
         xiffUvklP7U5B2Q4jmVj6LhlC4FVZyiCX1yh3bzuNcSGe7ezclKwEzO+J4bQ5d3sR+Vg
         qfPnS0NnyTgvmYV/ovxKZFUvqRtrt58pOzsU1L4AmN2HYfHQWDzKnA0mrKIXaUeIDjyL
         XUBVoGVeVUf9OadWcnaGeVJUIyvqW0cYfm0JSJx+/4x6i54eYV/rcwb3N2dy28gGnikS
         E4WqY2h54XqQsRp3w1UsS8AVtHI7JUwasFPHul22NxIwbMmu0o3g1t9RLQBsT6zCOLlG
         4eQw==
X-Gm-Message-State: AO0yUKXec9FLzuGAX6Ps/zbFWsCWWWCrgMYUs0aDVuK5YWJ+y1cHFBLj
        Sbi93rYsBZO4pPEqQHWaNiy4Oguu0iJIgLesfNZ4iH+QdWkb84jnjIwbZI/7YneoP71uwTFipmt
        rKgcuElFCDDXIvUW9813+qDqC
X-Received: by 2002:a17:906:b01:b0:8b1:3a23:8ec7 with SMTP id u1-20020a1709060b0100b008b13a238ec7mr9943332ejg.43.1678974013343;
        Thu, 16 Mar 2023 06:40:13 -0700 (PDT)
X-Google-Smtp-Source: AK7set9tymNTz9+387YqRSF0HfGwjk6gJq9Cx7CTWJFRUKlHqxlPPDd0aRk66kI/bxI8GFQaGPuBHw==
X-Received: by 2002:a17:906:b01:b0:8b1:3a23:8ec7 with SMTP id u1-20020a1709060b0100b008b13a238ec7mr9943316ejg.43.1678974013120;
        Thu, 16 Mar 2023 06:40:13 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id f10-20020a17090624ca00b009306ebc79d3sm796733ejb.59.2023.03.16.06.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 06:40:12 -0700 (PDT)
Message-ID: <5816e60c-5283-fa0c-fc95-76401904317e@redhat.com>
Date:   Thu, 16 Mar 2023 14:40:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US, nl
To:     Lee Jones <lee.jones@linaro.org>
Cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] Immutable branch between pdx86 and backlight due for the
 v6.4 merge window
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

As requested here is a pull-request for the apple-gmux / apple-backlight changes between the pdx86 and backlight subsytems.

Regards,

Hans


The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/ib-pdx86-backlight-6.4

for you to fetch changes up to 3608a2cd818a8d97bd3d4dc32f6c0afaf09b15ec:

  backlight: apple_bl: Use acpi_video_get_backlight_type() (2023-03-16 13:33:11 +0100)

----------------------------------------------------------------
Immutable branch between pdx86 and backlight due for the v6.4 merge window

----------------------------------------------------------------
Dan Carpenter (1):
      platform/x86: apple-gmux: return -EFAULT if copy fails

Hans de Goede (2):
      platform/x86: apple-gmux: Add acpi_video_get_backlight_type() check
      backlight: apple_bl: Use acpi_video_get_backlight_type()

Orlando Chamberlain (5):
      platform/x86: apple-gmux: use first bit to check switch state
      platform/x86: apple-gmux: refactor gmux types
      platform/x86: apple-gmux: support MMIO gmux on T2 Macs
      platform/x86: apple-gmux: add debugfs interface
      platform/x86: apple-gmux: Update apple_gmux_detect documentation

 drivers/platform/x86/Kconfig       |   1 -
 drivers/platform/x86/apple-gmux.c  | 404 ++++++++++++++++++++++++++++++-------
 drivers/video/backlight/Kconfig    |   1 +
 drivers/video/backlight/apple_bl.c |  31 +--
 include/linux/apple-gmux.h         |  72 +++++--
 include/linux/apple_bl.h           |  27 ---
 6 files changed, 393 insertions(+), 143 deletions(-)
 delete mode 100644 include/linux/apple_bl.h

