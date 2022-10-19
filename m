Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C39604351
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiJSLeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbiJSLdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:33:36 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A310D17FD46;
        Wed, 19 Oct 2022 04:10:16 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 3so16899911pfw.4;
        Wed, 19 Oct 2022 04:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrEBp5QmNrnZYt41Gp66axmOqQ69sRG3FcJjgrOaYzk=;
        b=cb5dMlQjDlZIaEK3c9eft9qECZSiiyzM0T6mSptf0FWSeJMmj1zvyD8GMSlpBw7KTY
         +sK/G1ODDx1XYu51kO02GWAMzpy0z9X9gtErHP6TWqRQmuHC+p+7sC7/hBbxEH285u+H
         7CBWumIIX0Y5f1Ev3zNHmiZcozQB1KbFj2XmP45ZbCbtALuzK17dheN/eeyRDBAc2IzV
         NivfxYeciUL91Xi3XWsma53p+scKcK8uITENME/42Wp0e0R+Bm1KiXIXYzgYyA1LINFw
         VgQC2jhbwKPdh+oam+bTQ8RrYvvWqLxgoqvwDs1UrNXsOECSrk3JRDTJt6z1lhlylakg
         nqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PrEBp5QmNrnZYt41Gp66axmOqQ69sRG3FcJjgrOaYzk=;
        b=3fTK6LStgMezI+QTJf1pJhAQ8hL9P2WAjkfwNn6chdBuNKJIC/CnK0s24/yp9vONwO
         DEWwsWbsl+4ZYKHDYZyQh83qAcXu9fOnFX2Ki8EOH+JF4G2uaqshERyNH40b/fKUlWIo
         HgXU2Xhb3KaW4G15ixzHIlhNYk0HCCpwecQ/C5M4L6ueIsgle0k2aI9+UYWfHiA4QD7Y
         O8gX/Zv9OZT+xC4a1HgY0n40VwlTdMbRfumsYJmTdimk4AVz81zy0eVop3bNCcI8cAdk
         vpS960bl7BV/0eXCMYs7myw5sER+F97p1FD0ld1Bh2PJ95201a0VcAU0ZDnF5jtasbZt
         g9zA==
X-Gm-Message-State: ACrzQf2xFCxS91ljQFX1Rqbfagy5DJedNcFU7jGFkbyas9d7qc4oiT0R
        FioDs2t4rmN1tK61IRjvLCI=
X-Google-Smtp-Source: AMsMyM6jb23AE50f/5uKNODgxSht3o3GJrRiqNU7aS2t7V8VqOIfoe9whf7BvqLSJVPSY2CbEPV6qQ==
X-Received: by 2002:a63:814a:0:b0:460:9025:6e4a with SMTP id t71-20020a63814a000000b0046090256e4amr6788798pgd.135.1666177690457;
        Wed, 19 Oct 2022 04:08:10 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e258-8c34-821b-9613-557f-bd8d.emome-ip6.hinet.net. [2001:b400:e258:8c34:821b:9613:557f:bd8d])
        by smtp.gmail.com with ESMTPSA id cc11-20020a17090af10b00b0020dc318a43esm8696225pjb.25.2022.10.19.04.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 04:08:10 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 24/26] mmc: sdhci-uhs2: add post-mmc_attach_sd hook
Date:   Wed, 19 Oct 2022 19:06:45 +0800
Message-Id: <20221019110647.11076-25-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
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

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

This "post" hook for mmc_attach_sd(), uhs2_post_attach_sd, will be required
to enable UHS-II support, at least, on GL9755.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 97728eee5b25..180b4f0548e2 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -744,6 +744,7 @@ struct sdhci_ops {
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
 	void	(*dump_uhs2_regs)(struct sdhci_host *host);
 	void    (*uhs2_pre_detect_init)(struct sdhci_host *host);
+	void    (*uhs2_post_attach_sd)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.25.1

