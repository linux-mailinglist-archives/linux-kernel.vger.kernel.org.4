Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC996D937F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 12:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjDFKBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 06:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236891AbjDFKBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 06:01:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6D483D0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 03:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680775201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1Yxg8/NohpMkUI9kgckbkMqSggfHgNmj7IZRmk35CHc=;
        b=KeV6FYFVUkgi8Ao9tf1sy1+Sw6jEjyq5EBy+NMujraTmjHsxKAT0noyX9fATs/oE8blOZw
        6j6Zeb/uzMg4dImzW4rNjUCCA3ATAnADEv5N2tkIL2skNViosgq7q4Msie2jrzyiG/mcLY
        ofQCFhKLJVxPLDJapu1FoDZNrguxwaE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-SNzftv_-OBK7TZyLyymprg-1; Thu, 06 Apr 2023 05:48:59 -0400
X-MC-Unique: SNzftv_-OBK7TZyLyymprg-1
Received: by mail-ed1-f72.google.com with SMTP id c1-20020a0564021f8100b004acbe232c03so51673580edc.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 02:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680774539; x=1683366539;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1Yxg8/NohpMkUI9kgckbkMqSggfHgNmj7IZRmk35CHc=;
        b=6X72ksFs3hjtpfW15bvj6+VpyCQTItdthO7IWdhF4uDtMWwAfrUj46MpK1Zj1pTF0s
         1jKkmGFnl5f/7N8GDNVfASCcKBdwmsoUBvFkpNY0gmnJyVthrnwVHgYKs5YkKHjykyZ7
         EgdyrcljR14yr6l9WOqYH9FKbPd/TIgb3QBo4tP9fMs1a717lorYGVZqlbEAhPevkGxr
         emqcqwgpBxZtrsYiggRQo5zy+lvIqUTGLJTP85aD7X62BNILUGdzPWPAcPcByXkNwqgw
         vdKL98pQI3Lz9O9PZQ4hy5u/SYcMJTd0ROTA165PSwMSkLkCQ7E6Uv1vRWgxzMeGUUKP
         srhw==
X-Gm-Message-State: AAQBX9ffaCC3Fy9a2dbEMZS9PvskI/rKGY5XKu7UsG+Q39Fhq0Q77D+E
        qRUbBd4Tm9ylCDWUiBUypMA/qjqI06NIKSUF+d3+inBmxQycetQILylcXX1o/LbKPjz0XaOiNHv
        pMhXwPE9s1EgJ7txvzClRt9Vu
X-Received: by 2002:a17:906:7315:b0:930:e53e:759b with SMTP id di21-20020a170906731500b00930e53e759bmr7672274ejc.11.1680774538934;
        Thu, 06 Apr 2023 02:48:58 -0700 (PDT)
X-Google-Smtp-Source: AKy350YIhpliq4YDYu7kfmb0VoXG1T09gat7l/4xuEDCgKrspb5WJObFo4ihh3LOrtRvsKP48pXPFw==
X-Received: by 2002:a17:906:7315:b0:930:e53e:759b with SMTP id di21-20020a170906731500b00930e53e759bmr7672256ejc.11.1680774538675;
        Thu, 06 Apr 2023 02:48:58 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id t19-20020a50d713000000b005021d17d896sm521157edi.21.2023.04.06.02.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 02:48:58 -0700 (PDT)
Message-ID: <93693a29-ea2a-3e6a-6581-f336abcffc80@redhat.com>
Date:   Thu, 6 Apr 2023 11:48:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.3-5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is another (small) round of fixes for platform-drivers-x86 for 6.3.

Highlights:
 -  more think-lmi fixes
 -  1 DMI quirk addition

Regards,

Hans


The following changes since commit e3271a5917d1501089b1a224d702aa053e2877f4:

  platform/x86: ideapad-laptop: Stop sending KEY_TOUCHPAD_TOGGLE (2023-03-31 19:37:18 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.3-5

for you to fetch changes up to 9a469c6dfab38326f99f105386db84230be09ee3:

  platform/x86: thinkpad_acpi: Add missing T14s Gen1 type to s2idle quirk list (2023-04-03 11:57:27 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.3-5

Highlights:
 -  more think-lmi fixes
 -  1 DMI quirk addition

The following is an automated git shortlog grouped by driver:

think-lmi:
 -  Clean up display of current_value on Thinkstation
 -  Fix memory leaks when parsing ThinkStation WMI strings
 -  Fix memory leak when showing current settings

thinkpad_acpi:
 -  Add missing T14s Gen1 type to s2idle quirk list

----------------------------------------------------------------
Armin Wolf (1):
      platform/x86: think-lmi: Fix memory leak when showing current settings

Benjamin Asbach (1):
      platform/x86: thinkpad_acpi: Add missing T14s Gen1 type to s2idle quirk list

Mark Pearson (2):
      platform/x86: think-lmi: Fix memory leaks when parsing ThinkStation WMI strings
      platform/x86: think-lmi: Clean up display of current_value on Thinkstation

 drivers/platform/x86/think-lmi.c     | 20 +++++++++++++-------
 drivers/platform/x86/thinkpad_acpi.c |  8 ++++++++
 2 files changed, 21 insertions(+), 7 deletions(-)

