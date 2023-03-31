Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1036D2878
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 21:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjCaTH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 15:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjCaTH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 15:07:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780CF22E80
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680289597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GfL4asY+ZnHcLZiDdqOI9tltGi48G8yGqEg4NgPtO4A=;
        b=Kw03Ty0YoTuB+3N/nVmxWP2AlsprBF+kEkh8KP/nc2PzaHbJA3IQsaBJ6MORV0ahRPTAP+
        dA3MTzFR8wGdodVFSPtO9OPfvdGjD1uPRft8JaK9pkKvgi+Jtnz+1/ERyLKW5Pem3cX5fC
        iXSf/KCcYAFmiQQ1eluSbjX/yOhftPA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-1lbIaCneOnm43s8hAvAv0w-1; Fri, 31 Mar 2023 15:06:36 -0400
X-MC-Unique: 1lbIaCneOnm43s8hAvAv0w-1
Received: by mail-ed1-f69.google.com with SMTP id h11-20020a0564020e8b00b004e59d4722a3so33004576eda.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680289594;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GfL4asY+ZnHcLZiDdqOI9tltGi48G8yGqEg4NgPtO4A=;
        b=D6nWgOn0Id2VT8NZawpSxvH9iHLx9cUs4MrNKcLuYt1AclLCzPPzCWDEeRIIGBaCLF
         aTholMRJCT4HOxWiZSKEiBSJIbIKUKpAo2wDOiWsKygcL5o8Kn2VisZbkaik5i8mBBTj
         Gw0Dkl0hIuWP0JFa6jR3dGbhEFRLf4OE/nD8ZNnl55efNnXgxBevy23TNOZN1Iwxx9hc
         Kpi5NM5K8bOv/IyLzWk2pR7jIpg1/11PdOvE7YwdiaXeRKCjH4baSaZKHI3GctW5LD8B
         traVAA4o6ArGegAhWlkSurqieNJs3Q8Zt8RDZ2svM3trA2cAVgJvblGIpEqY+5SjEtP7
         J5Yw==
X-Gm-Message-State: AAQBX9dvGYv1rIIm8OqMehn6owk1fl2C0v242ZDDOFqQOM+gX2rsnrQ3
        bmqy0J3HDRT9frJjJOTp7fmiZ2Uap97Sq7ZGhdMa4XbKjfRutr2aiS9zLkzHLRxSnnryJVbY1y1
        dbcHfjPak0c28grEyZK7mXpI3QB5h7ej9
X-Received: by 2002:aa7:d39a:0:b0:4fd:2b05:aa2 with SMTP id x26-20020aa7d39a000000b004fd2b050aa2mr27475764edq.42.1680289594403;
        Fri, 31 Mar 2023 12:06:34 -0700 (PDT)
X-Google-Smtp-Source: AKy350YA+ItNnwj/ji7Kbipg9PlB9562AAtBo6LkVXgG3d4qMLvslyY4/p0Nlhc9ppxbyjf2LJTyzg==
X-Received: by 2002:aa7:d39a:0:b0:4fd:2b05:aa2 with SMTP id x26-20020aa7d39a000000b004fd2b050aa2mr27475750edq.42.1680289594134;
        Fri, 31 Mar 2023 12:06:34 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id v14-20020a50a44e000000b004bc15a440f1sm1367864edb.78.2023.03.31.12.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 12:06:33 -0700 (PDT)
Message-ID: <531dfb17-bdc6-00a2-cbf2-7a7c096896b0@redhat.com>
Date:   Fri, 31 Mar 2023 21:06:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.3-4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Here is another round of fixes for platform-drivers-x86 for 6.3.

Highlights:
 -  Fix a regression in ideapad-laptop which caused the touchpad
    to stop working after a suspend/resume on some models
 -  1 other small fix and 3 hw-id additions

Regards,

Hans


The following changes since commit acd0acb802b90f88d19ad4337183e44fd0f77c50:

  platform/surface: aggregator: Add missing fwnode_handle_put() (2023-03-22 15:23:03 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.3-4

for you to fetch changes up to e3271a5917d1501089b1a224d702aa053e2877f4:

  platform/x86: ideapad-laptop: Stop sending KEY_TOUCHPAD_TOGGLE (2023-03-31 19:37:18 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.3-4

Highlights
 -  Fix a regression in ideapad-laptop which caused the touchpad
    to stop working after a suspend/resume on some models
 -  1 other small fix and 3 hw-id additions

The following is an automated git shortlog grouped by driver:

asus-nb-wmi:
 -  Add quirk_asus_tablet_mode to other ROG Flow X13 models

gigabyte-wmi:
 -  add support for X570S AORUS ELITE
 -  add support for B650 AORUS ELITE AX

ideapad-laptop:
 -  Stop sending KEY_TOUCHPAD_TOGGLE

platform/x86/intel/pmc:
 -  Alder Lake PCH slp_s0_residency fix

----------------------------------------------------------------
Hans de Goede (2):
      platform/x86: gigabyte-wmi: add support for X570S AORUS ELITE
      platform/x86: ideapad-laptop: Stop sending KEY_TOUCHPAD_TOGGLE

Rajvi Jingar (1):
      platform/x86/intel/pmc: Alder Lake PCH slp_s0_residency fix

Thomas Weißschuh (1):
      platform/x86: gigabyte-wmi: add support for B650 AORUS ELITE AX

weiliang1503 (1):
      platform/x86: asus-nb-wmi: Add quirk_asus_tablet_mode to other ROG Flow X13 models

 drivers/platform/x86/asus-nb-wmi.c    |  3 ++-
 drivers/platform/x86/gigabyte-wmi.c   |  2 ++
 drivers/platform/x86/ideapad-laptop.c | 23 ++++++++++-------------
 drivers/platform/x86/intel/pmc/core.c | 13 ++++++++++++-
 4 files changed, 26 insertions(+), 15 deletions(-)

