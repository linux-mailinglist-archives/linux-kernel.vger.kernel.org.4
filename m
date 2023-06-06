Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98A4723C0E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbjFFImQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbjFFImO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:42:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962AAEA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 01:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686040893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6tQ35W6HLuuEXQ1QV6ZcMIzGfWPz5E/TpOyat14Si5U=;
        b=K2VAOpmn0TwX0glJI7Kvp/j5X44kR5hyYO/ZiiY3+x7t8AkcBjfiNkSiaWtlfroQQB3qZi
        s+qMpHpG3sDSlOYkWlVIwcc4h1iKLFZkTyIXDzbhwQPg/FNA+T8Me/+PMFcI6FL/X6bc+N
        CIzQGESeiQGUUh9/e+2lwcIqYb0kUE4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-WQ_1amZcO9-p_gVoOv0Kmg-1; Tue, 06 Jun 2023 04:41:32 -0400
X-MC-Unique: WQ_1amZcO9-p_gVoOv0Kmg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-97455ea1c14so361201966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 01:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686040891; x=1688632891;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6tQ35W6HLuuEXQ1QV6ZcMIzGfWPz5E/TpOyat14Si5U=;
        b=YD4ZWf34A0E3XqLNjsq07mkU8fKB5ceS0WHUV0jVjm1W2f4w10uwQvtK4gO6J4WJ5+
         LqkIWd8Ch+ksOMVyoG0/aQrDpcd/pLbWtaSOoD2J0X3QBOd/MUiixXGSM1eM3AuGxEfM
         zwOoLnSrUZnEiZYcNtsHyceavAekkIkabWRnV+789ZYB3nvrG5Aha91xxuxN2V+RFNZh
         /cfnBUSnjl97DrERC6woyjp+X26GKDUC1GsIWv58ZB68ruEo8zPVL8+9hrilOVPhqknv
         HJ9gv1id4c13Mb4AQ/kJrfsEIEy5eXTN+pnmipAAtk2EtGp34K8M5QQMG8VvIJxTcRfY
         Ueqw==
X-Gm-Message-State: AC+VfDysQtVZ6dQpeKVYrDp/UZk2EoSwLk0iHOMY0PIz+0rNFY8Fvkry
        mZnzyrrZdeACBIbdO7Ty/J4rjOTILRMw/ToEXK/c1UyQVlvWgmDtBOuLLVnOHjhd2/GaIOnMExC
        T1OEhYDiKkPE3D/2UrTIPvpcEPk3onitw
X-Received: by 2002:a17:907:1606:b0:973:91f7:508a with SMTP id hb6-20020a170907160600b0097391f7508amr1637457ejc.4.1686040891273;
        Tue, 06 Jun 2023 01:41:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7eCTct8SXbWejRailHG0JSybcAu8U+jNTSaBUfomCUtGKIuBuzxz87cs44KUPwS3wT5KC4vg==
X-Received: by 2002:a17:907:1606:b0:973:91f7:508a with SMTP id hb6-20020a170907160600b0097391f7508amr1637447ejc.4.1686040890960;
        Tue, 06 Jun 2023 01:41:30 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id qc16-20020a170906d8b000b00965d294e633sm5278626ejb.58.2023.06.06.01.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 01:41:30 -0700 (PDT)
Message-ID: <0614c271-1786-c032-a888-26c9f9ae5a70@redhat.com>
Date:   Tue, 6 Jun 2023 10:41:29 +0200
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

Here is the third round of fixes for platform-drivers-x86 for 6.4.

Nothing special to report just a few small fixes:

 -  Various Microsoft Surface support fixes
 -  1 fix for the INT3472 driver

Regards,

Hans


The following changes since commit 3279decb2c3c8d58cb0b70ed5235c480735a36ee:

  platform/x86/intel/ifs: Annotate work queue on stack so object debug does not complain (2023-05-23 12:55:16 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.4-4

for you to fetch changes up to fb109fba728407fa4a84d659b5cb87cd8399d7b3:

  platform/x86: int3472: Avoid crash in unregistering regulator gpio (2023-05-30 12:10:22 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.4-4

Highlights:
 -  Various Microsoft Surface support fixes
 -  1 fix for the INT3472 driver

The following is an automated git shortlog grouped by driver:

int3472:
 -  Avoid crash in unregistering regulator gpio

platform/surface:
 -  aggregator_tabletsw: Add support for book mode in POS subsystem
 -  aggregator_tabletsw: Add support for book mode in KIP subsystem
 -  aggregator: Allow completion work-items to be executed in parallel
 -  aggregator: Make to_ssam_device_driver() respect constness

----------------------------------------------------------------
Hao Yao (1):
      platform/x86: int3472: Avoid crash in unregistering regulator gpio

Maximilian Luz (4):
      platform/surface: aggregator: Make to_ssam_device_driver() respect constness
      platform/surface: aggregator: Allow completion work-items to be executed in parallel
      platform/surface: aggregator_tabletsw: Add support for book mode in KIP subsystem
      platform/surface: aggregator_tabletsw: Add support for book mode in POS subsystem

 drivers/platform/surface/aggregator/controller.c       |  2 +-
 drivers/platform/surface/surface_aggregator_tabletsw.c | 10 ++++++++++
 drivers/platform/x86/intel/int3472/clk_and_regulator.c | 13 ++++++++-----
 include/linux/surface_aggregator/device.h              |  6 +-----
 4 files changed, 20 insertions(+), 11 deletions(-)

