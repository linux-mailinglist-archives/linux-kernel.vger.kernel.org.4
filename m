Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276AA6917C5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 05:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjBJEwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 23:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjBJEvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 23:51:50 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A6477159;
        Thu,  9 Feb 2023 20:51:17 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id n3so2959119pgr.9;
        Thu, 09 Feb 2023 20:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5Ha95DZYK/aP/j52BgmRVv3D+Ht1XBi+RBwbRpPJAA=;
        b=jeRCbikd0l+NYcX61eSocwQ1WUxxnAWy9jXktGeo2f1Ks/WWMN6X5HONHK7QeGRFVt
         iOUduMbJJxxI+2VxjAve5WkgVa4Z8HQaJBB2RcPWhn9YEPeT1sC2wS0FJVXrcYX9rxuA
         Tn6jmBhZ2gZC8wfNCWtA8AtXpd5hbTGVhN/DYmqHGTf0a4gt1sTPPQUBMAzsmYB0YX+I
         d8Ee/B6UJqkuoQgF6ommsJa/FZIrubLdFKhd1po/LM+Zq0QPNY35bBSY9MRxn9TiBdWW
         TaE0Dw6cX55x7gagXpw485WSPfiwCzg6t2bL883xOej+5KbppjICobrr2oOeAvOAbz6C
         exQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5Ha95DZYK/aP/j52BgmRVv3D+Ht1XBi+RBwbRpPJAA=;
        b=usGtuKZsa4Ixfe4xZQzeREsVXjLN7FwFW7KV65pIIea9JrcCY8d4IflSRD00jyyNUK
         yh6SmjaxXmHHbih2UIZNVnWBpqb+7fvEiP0ptS2SYJLSY2aFxRpnMIyjjgcUTsOwFfZ+
         JVmkM1Dyw65mOHmgi2/0thlaWJ5ow13csLio8qEtUqjcFt/sWOyLb7mMfmq/NADn3MgC
         GoR7fcTV31S9iwF13c1uzxZ6zK8NkWysXmuQzUwYZufWgG8bAnK9RJFInzJlvWAorfkV
         wSnGitMmj8wP2B0scjPqZRO4wPVWY0XLMk2XLZOZG9NkxeInrQvn13rTMpJCdgBlMnEF
         t1tg==
X-Gm-Message-State: AO0yUKWZAQPWAhnVzPvXH0NQ/5MFczZotngzI2GkOZVpH7E1VozHa+o4
        XGlTkrIkRmPqc7pUQ+MfKKmyCHjxguihdg==
X-Google-Smtp-Source: AK7set8TZvXWIyGcQ3NgifffV8KYbOTEXt34sxsX5/J/r2MfeRhwM5bCgQOPxLHbQqGiay9vdFRZTg==
X-Received: by 2002:a62:6d85:0:b0:590:7616:41eb with SMTP id i127-20020a626d85000000b00590761641ebmr10365952pfc.30.1676004676892;
        Thu, 09 Feb 2023 20:51:16 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id t13-20020a62ea0d000000b0057fec210d33sm2269218pfh.152.2023.02.09.20.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 20:51:16 -0800 (PST)
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>,
        Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Bokun Zhang <Bokun.Zhang@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>, Evan Quan <evan.quan@amd.com>,
        Kerem Karabay <kekrby@gmail.com>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: [RFC PATCH 8/9] hda/hdmi: Register with vga_switcheroo on Dual GPU Macbooks
Date:   Fri, 10 Feb 2023 15:48:25 +1100
Message-Id: <20230210044826.9834-9-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210044826.9834-1-orlandoch.dev@gmail.com>
References: <20230210044826.9834-1-orlandoch.dev@gmail.com>
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

Commit 586bc4aab878 ("ALSA: hda/hdmi - fix vgaswitcheroo detection for
AMD") caused only AMD gpu's with PX to have their audio component register
with vga_switcheroo. This meant that Apple Macbooks with apple-gmux as the
gpu switcher no longer had the audio client registering, so when the gpu is
powered off by vga_switcheroo snd_hda_intel is unaware that it should have
suspended the device:

amdgpu: switched off
snd_hda_intel 0000:03:00.1:
    Unable to change power state from D3hot to D0, device inaccessible
snd_hda_intel 0000:03:00.1: CORB reset timeout#2, CORBRP = 65535

Simialar to ATPX, we use the presence of an acpi method (PWRD in this
case) to ensure we only register with the correct devices.

Fixes: 586bc4aab878 ("ALSA: hda/hdmi - fix vgaswitcheroo detection for AMD")
Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
---
 sound/pci/hda/hda_intel.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 87002670c0c9..c97bbe60e603 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1435,11 +1435,25 @@ static bool atpx_present(void)
 	}
 	return false;
 }
+
+static bool pwrd_present(struct pci_dev *pci)
+{
+	acpi_handle pwrd_handle;
+	acpi_status status;
+
+	status = acpi_get_handle(ACPI_HANDLE(&pci->dev), "PWRD", &pwrd_handle);
+	return ACPI_FAILURE(status) ? false : true;
+}
 #else
 static bool atpx_present(void)
 {
 	return false;
 }
+
+static bool pwrd_present(struct pci_dev *pci)
+{
+	return false;
+}
 #endif
 
 /*
@@ -1461,9 +1475,12 @@ static struct pci_dev *get_bound_vga(struct pci_dev *pci)
 				 * rather than the dGPU's namespace. However,
 				 * the dGPU is the one who is involved in
 				 * vgaswitcheroo.
+				 *
+				 * PWRD is in the dGPU's ACPI namespace on Apple
+				 * Macbooks with dual gpu's.
 				 */
 				if (((p->class >> 16) == PCI_BASE_CLASS_DISPLAY) &&
-				    atpx_present())
+						(atpx_present() || pwrd_present(p)))
 					return p;
 				pci_dev_put(p);
 			}
-- 
2.39.1

