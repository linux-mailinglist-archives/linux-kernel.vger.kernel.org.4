Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CF35FED96
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiJNLtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiJNLsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:48:45 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1845BEACA2;
        Fri, 14 Oct 2022 04:48:25 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 129so4100537pgc.5;
        Fri, 14 Oct 2022 04:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJyxTTeGNHxq9RsExK67ky3HBRhQX3BCNFgWjcG3gFE=;
        b=DqpDvnboUMb/w6bGJfLPTdDFZ/YKQx7wupeIaxHYmwEIldgPB3XzFqc77G4IATvUa6
         Q8mRxdlg6Pe71gPe6If/2R90wxLczssNszNlR10bzSboAgJXtneIV2Xw4Akzm3wVfftm
         AGPCV8Js6LjB6cY/AZ0E6lbYtdHQpTcCLiIc0+kV5dRqOFwMEDDUnaN39s1CV15VLsju
         YJcA3/1zJbvJBfeXbhx52uYm09Q2vTGgjf0RtqiJ0leH6mQdY1CtgMylYdZ5MUBwdrCC
         dcpXpF5TqJtzuNvj0zbI+V1jQnfxM9AdWlQ4lyPXDtBzJ80K1xkgqWTT3YZ5SY4leM7B
         Ao9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJyxTTeGNHxq9RsExK67ky3HBRhQX3BCNFgWjcG3gFE=;
        b=UBdgYcO1Ki6x+TRKjjbXMwCUYpXWv3+8LNOzRuI4X4EC52AORUpLBfgLGkoneslktf
         R0hvp/w0t0HZRwUcaf58EaLMR1ycRwCKVmUQSeM/085eYWm075KCq+dxqtAQGhj591ga
         koSLW9GWDa9t2nC8zTSuYOL6/OtuK6gFte+3tO6+1oa1GJl8X0wvYMBK0WJqcA0Hvc+x
         1AiTFuqW2FsaGbDeixQIraM/qoKLjwlme8xqH5A6apq0HPsI0EHz4QsHbt5Ov7HE5e76
         SaTNR1aLmAKT+dQ365U9Tp0DgZ5KiIPD3oC5SaHHy6FluwZIoZ8DDTuczifJQxKhcC1t
         bYZw==
X-Gm-Message-State: ACrzQf3bCAa+++E5eIGwiUz77/Xtatu2JK5qTH2yeHC1v4zfT2zGUZH+
        Yr9UoaA4T9mUaZttwyWZPTc=
X-Google-Smtp-Source: AMsMyM6rFQRJmC/gywUSv+kxLwHbldoY2wNx/nbtTPMyJ/9xjp2aZkluAsyjEfI2aDrQrfn+nGXzmQ==
X-Received: by 2002:a05:6a00:24d0:b0:563:6d36:eae8 with SMTP id d16-20020a056a0024d000b005636d36eae8mr4898735pfv.66.1665748100971;
        Fri, 14 Oct 2022 04:48:20 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e282-2aaa-c1aa-06c8-0e68-c5ee.emome-ip6.hinet.net. [2001:b400:e282:2aaa:c1aa:6c8:e68:c5ee])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902ec8800b001746f66244asm1606678plg.18.2022.10.14.04.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 04:48:20 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 24/26] mmc: sdhci-uhs2: add post-mmc_attach_sd hook
Date:   Fri, 14 Oct 2022 19:45:59 +0800
Message-Id: <20221014114601.15594-25-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014114601.15594-1-victor.shih@genesyslogic.com.tw>
References: <20221014114601.15594-1-victor.shih@genesyslogic.com.tw>
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
index 943701aef22a..e81de556cf78 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -746,6 +746,7 @@ struct sdhci_ops {
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
 	void	(*dump_uhs2_regs)(struct sdhci_host *host);
 	void    (*uhs2_pre_detect_init)(struct sdhci_host *host);
+	void    (*uhs2_post_attach_sd)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.25.1

