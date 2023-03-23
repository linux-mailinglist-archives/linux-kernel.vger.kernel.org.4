Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF816C62C1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjCWJGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjCWJGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:06:23 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1D821950;
        Thu, 23 Mar 2023 02:05:35 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l12so19611937wrm.10;
        Thu, 23 Mar 2023 02:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679562332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtM1/6aT9Hs8L0/Z5EjLhrB2E2q0vn+Gu2UY/Kc0m8I=;
        b=ZaQXzTUjeJuWR7nWdtwf4QSQSdcp3+kIhkGEgjk4f9tZsWJ+yaUavlgvydHIWxalI3
         HvEEDOq4X7xCsTnh3p7f8o/6hsJvrzNP/yqFTDT5Eoq1mY2RqO5Ul1b0qyxW3DGycnKS
         1rGttUrCkEzU4rRdc9roM5Xx4ENsPKbfZx84SWouYOB55n1GhB19aBnzrn0eqyHvAd+R
         AspCR5MEgXgrp+UN78HUpy9xIt3Dd3bfRXImxDWkM8Xvu8S41n6gyoV3Iz60PY+u+wMQ
         aHvIVQaZOFa7t4AcojFK5rlrVKej1wFVLTIdmTeOBIaJP0JHbzavD/fzd5MO+nTPaCVc
         8YEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679562332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZtM1/6aT9Hs8L0/Z5EjLhrB2E2q0vn+Gu2UY/Kc0m8I=;
        b=XID468YdrvNPh7yDqlY+xK/JQOmiGwMSY+WoYbO2n5bWtVdLmeh34L5cfhAJKjayVr
         FrGtQ+SRHaQ91zvqsD7dhX9urCVN9ztThkXc5IjQ2XjJXFgdqynIDjUuWUZi3QaMMP0E
         6d/tiNEOdzaKb/4+cU49AfX/eYQ0gS8mUXMhC5YxIDEZMpaaus0JbSSd+O5TDWv5HgZY
         Q7xzkUQ/qGWiRjQFQGI5KUCEo1N36CYCQNRS+DeM4lOB+6XfZ56qZ5vgOC9Nuz6elz4t
         GLWWklvtp++17oBtLmIjUXKbTpft6IDmIdpIWA12oWtqwdYubkAJ/bPQIo/C+6jHBBlp
         A1gA==
X-Gm-Message-State: AAQBX9cWIkTjBLUtnU0EuD8dog0ih+iX9yc13IbwbecJTQ3sMTYAwHgX
        Ekp0TpFZI6PkB5iSR+LT+tY=
X-Google-Smtp-Source: AKy350Z9vPGF5pLhiKFKopvx4kjzoGNumrNcki7pJup/RNEkcWBlS3eBt8/YiZoRHJr9f0BLq0yB7Q==
X-Received: by 2002:adf:dc12:0:b0:2ce:a85d:5319 with SMTP id t18-20020adfdc12000000b002cea85d5319mr1793247wri.39.1679562332546;
        Thu, 23 Mar 2023 02:05:32 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d684a000000b002d89e113691sm6623425wrw.52.2023.03.23.02.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 02:05:32 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: SOF: ipc4/intel: Fix spelling mistake "schduler" -> "scheduler"
Date:   Thu, 23 Mar 2023 09:05:31 +0000
Message-Id: <20230323090531.67679-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two spelling mistakes in dev_warn messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/sof/ipc4-topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 12775fcb6b54..de7213237b27 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -1990,7 +1990,7 @@ static int sof_ipc4_widget_setup(struct snd_sof_dev *sdev, struct snd_sof_widget
 		pipeline = swidget->private;
 
 		if (pipeline->use_chain_dma) {
-			dev_warn(sdev->dev, "use_chain_dma set for schduler %s",
+			dev_warn(sdev->dev, "use_chain_dma set for scheduler %s",
 				 swidget->widget->name);
 			return 0;
 		}
@@ -2149,7 +2149,7 @@ static int sof_ipc4_widget_free(struct snd_sof_dev *sdev, struct snd_sof_widget
 		u32 header;
 
 		if (pipeline->use_chain_dma) {
-			dev_warn(sdev->dev, "use_chain_dma set for schduler %s",
+			dev_warn(sdev->dev, "use_chain_dma set for scheduler %s",
 				 swidget->widget->name);
 			mutex_unlock(&ipc4_data->pipeline_state_mutex);
 			return 0;
-- 
2.30.2

