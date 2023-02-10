Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38966917B6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 05:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjBJEuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 23:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjBJEuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 23:50:10 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F775B74E;
        Thu,  9 Feb 2023 20:50:09 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id q9so2973528pgq.5;
        Thu, 09 Feb 2023 20:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mAzAHTdZsC5IqNul3xJsl6wPXmAHfKwZ27VCzKXGF4=;
        b=JVtiloj7yRa4BQFYW86RmJebSQYTmr6ulQWbaNdE813YnQNwxXxigdeqKGwJ547OA9
         iKneGqYybribFvactjWAxLOC1FFyHyE+vrJN9XEm4Abm2yHTeo6rcn+1OgEhy5wP98gZ
         +ThcUd3YSIgv/n1tSUkAQD0bQGEO9epBP65UtYfzB4TDt5HkYEHAUsO9ybZHG+TDzu0u
         hqJKP33cLtrVl0eYH6Qi6HmbIoL1D0nmoU8eLgaP0zLDynkeKmwUzTLzZaRDN3rU0PL/
         En5vvM6GmtpTk46YMQcS55SP+xFg1xh1ZcTgKWrbYfmIOMTZVYpC6OIy+kKwcbJ4fUCF
         NfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mAzAHTdZsC5IqNul3xJsl6wPXmAHfKwZ27VCzKXGF4=;
        b=QsU4lTjw8OkLlk8yMyhfB/0Au9kN822s3nOScVY9NuQMCAav7klgBpMFNkNpzMPyd1
         +YXXu1kBm8LeznkG6+hakTDxVLL/fnbwGpaSJjGWtKJRlbDU581LiXn4iuwBePBIN93E
         7cvYgGVjoqST/LejMIqUuRJ+QYm0slKEAhRuxaJeTOm914hD06o0IMhFiHBmtAlPQLgF
         2/43wFFSiM6d4nn6YLBpEOjXy3rVG5LP5P3JrXDmFTk6AnxcKjO5UDxA/JJZek0ePA9h
         fujqrIGGRUj7h+EpnXY+BPeAfw9HgtQje4nf88/cWnnCWIgRI6NQZRXMh6sPx0Ypr0gQ
         hnSg==
X-Gm-Message-State: AO0yUKX9pwwzJJd6Iu8gWfGpb4CdmvIGl5owLMpAfSE7P+lb+uSB5b7E
        619dkjR5HU1G7Ljk6LZUpPLKrRHBA14tBw==
X-Google-Smtp-Source: AK7set8TKp+XoOdzFSSniCiSLofONjJNjijxRgei3TQG94xGgDFfQ+8mh0QAUiI4aSA+indqTsT/jA==
X-Received: by 2002:a62:1c13:0:b0:593:2289:f01c with SMTP id c19-20020a621c13000000b005932289f01cmr11514678pfc.25.1676004609052;
        Thu, 09 Feb 2023 20:50:09 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id t13-20020a62ea0d000000b0057fec210d33sm2269218pfh.152.2023.02.09.20.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 20:50:08 -0800 (PST)
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
Subject: [RFC PATCH 1/9] apple-gmux: use cpu_to_be32 instead of manual reorder
Date:   Fri, 10 Feb 2023 15:48:18 +1100
Message-Id: <20230210044826.9834-2-orlandoch.dev@gmail.com>
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

Currently it manually flips the byte order, but we can instead use
cpu_to_be32(val) for this.

Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 9333f82cfa8a..e8cb084cb81f 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -94,13 +94,7 @@ static u32 gmux_pio_read32(struct apple_gmux_data *gmux_data, int port)
 static void gmux_pio_write32(struct apple_gmux_data *gmux_data, int port,
 			     u32 val)
 {
-	int i;
-	u8 tmpval;
-
-	for (i = 0; i < 4; i++) {
-		tmpval = (val >> (i * 8)) & 0xff;
-		outb(tmpval, gmux_data->iostart + port + i);
-	}
+	outl(cpu_to_be32(val), gmux_data->iostart + port);
 }
 
 static int gmux_index_wait_ready(struct apple_gmux_data *gmux_data)
@@ -177,16 +171,8 @@ static u32 gmux_index_read32(struct apple_gmux_data *gmux_data, int port)
 static void gmux_index_write32(struct apple_gmux_data *gmux_data, int port,
 			       u32 val)
 {
-	int i;
-	u8 tmpval;
-
 	mutex_lock(&gmux_data->index_lock);
-
-	for (i = 0; i < 4; i++) {
-		tmpval = (val >> (i * 8)) & 0xff;
-		outb(tmpval, gmux_data->iostart + GMUX_PORT_VALUE + i);
-	}
-
+	outl(cpu_to_be32(val), gmux_data->iostart + GMUX_PORT_VALUE);
 	gmux_index_wait_ready(gmux_data);
 	outb(port & 0xff, gmux_data->iostart + GMUX_PORT_WRITE);
 	gmux_index_wait_complete(gmux_data);
-- 
2.39.1

