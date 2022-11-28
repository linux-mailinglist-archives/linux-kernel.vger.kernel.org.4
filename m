Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC9A63A452
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 10:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiK1JKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 04:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiK1JKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 04:10:40 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F132EE50
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 01:10:37 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id n21so24080229ejb.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 01:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=5cvqz+ywjjARQOy84/P5RN8vJ8kenww9UeNxB2Tv1zU=;
        b=KdYLxwpXdB8uvJ4n2TshHf2Pu21znKgV7JScKdk87ufOcEbTMcNSjmEMiM31oG2lUt
         jd2mh7eczTri25hzT4q4SqsLkp4ka+0Bayy5j0iiQupXZAVZXMpU9Y1FjunSiuH/X99B
         MroTL0ZZ1orEDi/OJDbO34fcVNaP42LHfhTPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5cvqz+ywjjARQOy84/P5RN8vJ8kenww9UeNxB2Tv1zU=;
        b=d96NEYOS1m81whlYwlnJEw3ozt7koBH9KK3aYT1zhDeGDwLHVEyv7U5po09RFeV3/P
         JeqdjRFJ4kIiimbSXBtFURIzKpX8UhjEqcDGQJeatvZPP8gfteiybhkkvKkkH530ZgKC
         z/8K5h0LV7j4CflIIFEtt657aCBzH7Dg5gRnv/gruHf/ByivOKxR4f0YXdJKlrX3Z8qr
         smeBMl0wDkBjB44C0Nd3N8FP2CHcE6oGCw9RPoKycI25QCn4OnceU8UWtS8/hEOxthkU
         /81yRQmJsenSni93KydMwGSZJFvGjxbHtvkmcqca5YpdBYMixTNKZEyHDcxyCUIuY3tc
         NCcA==
X-Gm-Message-State: ANoB5pmxsZtP+WasxcudePhbUkjsaZkx7xx3WSE1o8bD7cx9LkmtHSrh
        Jp4SGyq9vDL1NmFhKSpTT0VlWQ==
X-Google-Smtp-Source: AA0mqf5/x4GVybL0srHWZCJjOvBilSnilg35I/vv/sjhbQI9fuXErANJsBWW13rn9G6s7CcZe0hqRw==
X-Received: by 2002:a17:906:583:b0:78d:9e18:b8f7 with SMTP id 3-20020a170906058300b0078d9e18b8f7mr40928913ejn.657.1669626636589;
        Mon, 28 Nov 2022 01:10:36 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id p35-20020a056402502300b00463b9d47e1fsm4932346eda.71.2022.11.28.01.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 01:10:36 -0800 (PST)
Subject: [PATCH v3 0/2] ALSA: core: Fix deadlock when shutdown a frozen userspace
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPR6hGMC/3XNQQrCMBAF0KuUrI10Jm1aXXkPcZGmYxNoE0hsQE
 vv7uBSdDX8D+/PJjIlT1mcq00kKj77GDioQyWsM2Ei6UfOAmtEAOxkDqO8J6IXSSCCRiH2CrVgMJ
 hMckgmWMckrPPMpfP5EdPz86AAn+vPrQKylm3XaDBKa7J4sS7Fxa/LMaZJ3Hip4H+NrMfeNNiSOW
 mtvvS+729I71yB6gAAAA==
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 28 Nov 2022 10:10:12 +0100
Message-Id: <20221127-snd-freeze-v3-0-a2eda731ca14@chromium.org>
To:     Takashi Iwai <tiwai@suse.com>, Len Brown <len.brown@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     alsa-devel@alsa-project.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1634; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=UZTGU/fsXJEA3ltnq4F2WvDw+A4ygx9FH7eOzblo+pg=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjhHr/j1G48WlxdIEEOXaXpHgUksIaanU3PEzs5LxT
 VFYlDcSJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4R6/wAKCRDRN9E+zzrEiDSND/
 9bYOi0gOQKQUB1Ke/4A1WAaxC+iY9PHPZmeRlE3w3S+DePSWJocIg9/hq+TqgAi2pdJaB4aKXJMsRF
 QHXNNgVQuagnDLL8x/aXINyN0DDcRt2XRJUEc7RcKym5rNFVNm+OnKqq4lINr8mzkoEFZQwHbgMllP
 R2/gr6hy0fUAp9ey/+CgymaNMPc3opkp3bExJH8l1uYcjpPEotNZveVmD13BBBNsseRdJqnBoPdbsD
 GatYAsLiPW1ahZVyqy9O+i1uSUYNlhwTqeR3m+ARMQVMnVR3mGeegtwU82B1IS3Hn77KLe5jShtayi
 aEikqMHEoVNjx0MwkvzIwl+DMPlFc0zHo32W2vmqgKojydVa0Jcz1ZXB52bLjmZTnm4d3H1ua+shv9
 5n0BNFpvpcxSFrcIKSWQsdQOplU88nw0qLKQ009fS1wvKk44vv5TkO8faZd5xspqYh7zSI4xmHHzeo
 76Qak6EHRlI8u0P7uLRxBAcOUSGdgwZTlzZxTsHrIHe7aO27Bc46iLHmBT6cYccRIH1w8322jXlOze
 TZVSTQNw7NsgV2PcQBi2xHd+waL6wUyEwDIzHjXzv7jOhL7iuXEpSSz9C87P/yaUdDaCtpPPNYgmpA
 uWZpfP286KbmC0MIgQSFj0eCZ0BnMwVWxScheBjIrE/XViLZ1nZ5d7RB7JmA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 83bfc7e793b5 ("ASoC: SOF: core: unregister clients and machine drivers in .shutdown")
we wait for userspace to close its fds.

But that will never occur with a frozen userspace (like during kexec()).

Lets detect the frozen userpace and act accordingly.

To: Jaroslav Kysela <perex@perex.cz>
To: Takashi Iwai <tiwai@suse.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
To: Len Brown <len.brown@intel.com>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v3:
- Wrap pm_freezing in a function
- Link to v2: https://lore.kernel.org/r/20221127-snd-freeze-v2-0-d8a425ea9663@chromium.org

Changes in v2:
- Only use pm_freezing if CONFIG_FREEZER 
- Link to v1: https://lore.kernel.org/r/20221127-snd-freeze-v1-0-57461a366ec2@chromium.org

---
Ricardo Ribalda (2):
      freezer: Add processes_frozen()
      ALSA: core: Fix deadlock when shutdown a frozen userspace

 include/linux/freezer.h |  2 ++
 kernel/freezer.c        | 11 +++++++++++
 sound/core/init.c       | 13 +++++++++++++
 3 files changed, 26 insertions(+)
---
base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
change-id: 20221127-snd-freeze-1ee143228326

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
