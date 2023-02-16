Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32FE69943C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjBPMZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBPMZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:25:11 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C897D359A;
        Thu, 16 Feb 2023 04:25:10 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id r18so1130604pgr.12;
        Thu, 16 Feb 2023 04:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ECpjNj5Mz+6PXn6eBEkZo59C5waHc69Z45QaiskDXb4=;
        b=GNcVmTgw8rTlypkN60A0Mt+DgwA49XDN7jFjf6uh5t7v8r/+FaoUwEfDZhlGF1X+QU
         CrzmS0p5365PJJAA4ZOGuoATx0z5r68iDoqZZ64i9PahFlSRzira/lRXd135lzJuNyA/
         btsDU0TlcQO3H4IkXLh+ifo1IQQfSQjelu7T+J6MUzkuoMCpbfnECd6uLIzVcS3AVuM+
         nhVtgMsEfOmQUJ39raUEkrZYfsEz9p3riFLoWBL+KhxOoBTz5n35X/qMq5bQ7g4WVw9z
         PkFhyB7QxNQ7ARfRqQ4jHZUv29VarP64QRE9Xbda4wYuuuE84NZtoBlYDmGDBfOnNet5
         taOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECpjNj5Mz+6PXn6eBEkZo59C5waHc69Z45QaiskDXb4=;
        b=LZtvmGqonITPBkBDtS3Fmss/OM9cORwKnb9+sW/tmvbVpF3YLjbRoDYibUtHWt3nBe
         krl/CGcfjH6k7zR0DNMx5GAsCkuQNl6BP2WrEep9OCm7OolCD4jWTwr0lNE180P3XUrW
         fb/NTviN4aXzuYgPAsb+iBNCbWEbkVoeEFYMcDRC7AypLHd30ftp8ugDHdrDIQwPRqxy
         0yjYGhOQhyMXfnUskZg+AkLpwrPES+L8O8f/hh76FWk0Ie7nY+h74CmXZ8nDJ1HEajaa
         SHiFxs/RRgz7PlSgb/c/mQ+LKYhLUoz/8ea54cViE7w+dDHv6mFyrpFtzWneE/ghP0am
         3OWQ==
X-Gm-Message-State: AO0yUKUt71mh02qwQz9DAu82fUihgRKWidZrwSr16J9BJRkUERrvmzTh
        QM1esbBS4RSSxKyNxkKrQbw=
X-Google-Smtp-Source: AK7set9oQOt8AWYq+a1Ezre9JhWMv9VwOE49mbt3rCn2R4/ZOV0Qz6pehLqGUfCeSloDq/XQKArt9w==
X-Received: by 2002:aa7:8424:0:b0:5a8:380d:7822 with SMTP id q4-20020aa78424000000b005a8380d7822mr5125338pfn.23.1676550310293;
        Thu, 16 Feb 2023 04:25:10 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id c10-20020aa781ca000000b005a909290425sm1224055pfn.172.2023.02.16.04.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 04:25:09 -0800 (PST)
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Seth Forshee <sforshee@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: [PATCH v2 0/5] apple-gmux: support MMIO gmux type on T2 Macs
Date:   Thu, 16 Feb 2023 23:23:38 +1100
Message-Id: <20230216122342.5918-1-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch series adds support for the MMIO based gmux present on these
Dual GPU Apple T2 Macs: MacBookPro15,1, MacBookPro15,3, MacBookPro16,1,
MacBookPro16,4 (although amdgpu isn't working on MacBookPro16,4 [1]).

Changes from v1/RFC[2]:

- Drop commits "use cpu_to_be32 instead of manual reorder" and
  "consolidate version reading" as the former was broken and they
  could introduce regressions.
- Only use the GMSP acpi method on MMIO gmux's.
- Use a debugfs interface instead of a sysfs interface.
- Document some of the chips used with MMIO gmux's.
- Move changes to amdgpu and snd_hda_intel out of this patchset.

# 1:

has a slight change in how the switch state is read: instead of checking
for x == 2, check !(x & 1)

# 2:

implements a system to support more than 2 gmux types

# 3:

start using the gmux's GMSP acpi method when handling interrupts on MMIO
gmux's. This is needed for the MMIO gmux's to clear interrupts.

# 4:

Adds support for the MMIO based gmux on T2 macs.

# 5:

Add a debugfs interface to apple-gmux so data from ports can be read
and written to from userspace.

This can be used for more easily researching what unknown ports do,
and switching gpus when vga_switcheroo isn't ready (e.g. when one gpu
is bound to vfio-pci and in use by a Windows VM, I can use this to
switch my internal display between Linux and Windows easily).

# Issues:

1. Switching gpus at runtime has the same issue as indexed gmux's: the
inactive gpu can't probe the DDC lines for eDP [3]

2. Powering on the amdgpu with vga_switcheroo doesn't work well. I'm
told on the MacBookPro15,1 it works sometimes, and adding delays helps,
but on my MacBookPro16,1 I haven't been able to get it to work at all:

amdgpu: switched off
amdgpu: switched on
amdgpu 0000:03:00.0:
    Unable to change power state from D3hot to D0, device inaccessible
amdgpu 0000:03:00.0:
    Unable to change power state from D3cold to D0, device inaccessible
[drm] PCIE GART of 512M enabled (table at 0x00000080FEE00000).
[drm] PSP is resuming...
[drm:psp_hw_start [amdgpu]] *ERROR* PSP create ring failed!
[drm:psp_resume [amdgpu]] *ERROR* PSP resume failed
[drm:amdgpu_device_fw_loading [amdgpu]]
    *ERROR* resume of IP block <psp> failed -62
amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_resume failed (-62).
snd_hda_intel 0000:03:00.1: Enabling via vga_switcheroo
snd_hda_intel 0000:03:00.1:
    Unable to change power state from D3cold to D0, device inaccessible
snd_hda_intel 0000:03:00.1: CORB reset timeout#2, CORBRP = 65535
snd_hda_codec_hdmi hdaudioC0D0: Unable to sync register 0x2f0d00. -5

There are some acpi methods (PWRD, PWG1 [4, 5]) that macOS calls when
changing the amdgpu's power state, but we don't use them and that could be
a cause. Additionally unlike previous generation Macbooks which work
better, on MacBookPro16,1 the gpu is located behind 2 pci bridges:

01:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI]
    Navi 10 XL Upstream Port of PCI Express Switch (rev 43)
02:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI]
    Navi 10 XL Downstream Port of PCI Express Switch
03:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
    Navi 14 [Radeon RX 5500/5500M / Pro 5500M] (rev 43)
03:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI]
    Navi 10 HDMI Audio

Upon attempting to power on the gpu with vga_switcheroo, all these
devices except 01:00.0 have their config space filled with 1s.
Rescanning pci makes the config space of all the devices go back to
normal, however amdgpu still fails to resume with the same logs as
above.

[1]: https://lore.kernel.org/all/3AFB9142-2BD0-46F9-AEA9-C9C5D13E68E6@live.com/
[2]: https://lore.kernel.org/platform-driver-x86/20230210044826.9834-1-orlandoch.dev@gmail.com/
[3]: https://lore.kernel.org/all/9eed8ede6f15a254ad578e783b050e1c585d5a15.1439288957.git.lukas@wunner.de/
[4]: https://gist.github.com/Redecorating/6c7136b7a4ac7ce3b77d8e41740dd87b
[5]: https://lore.kernel.org/all/20120710160555.GA31562@srcf.ucam.org/

Orlando Chamberlain (5):
  apple-gmux: use first bit to check switch state
  apple-gmux: refactor gmux types
  apple-gmux: Use GMSP acpi method for interrupt clear
  apple-gmux: support MMIO gmux on T2 Macs
  apple-gmux: add debugfs interface

 drivers/platform/x86/apple-gmux.c | 361 ++++++++++++++++++++++++++----
 include/linux/apple-gmux.h        |  52 +++--
 2 files changed, 349 insertions(+), 64 deletions(-)

-- 
2.39.1

