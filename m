Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F05C6E0961
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 10:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjDMIxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 04:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjDMIxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:53:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A90180
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 01:53:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E520F218D6;
        Thu, 13 Apr 2023 08:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681375984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ear+cnYjNr0Xxid0IYuEKGOWEhCYOcJOGEYisWpZTKo=;
        b=C24EABfNHbEBMqwr4/h+JHYgokjsw8ix4LML/cy29uP6URY6CKIXQsggFcmNAC9QsfJGpU
        X52ksK0IOlpxdAss2WvoLFj1A9ykM94mO0hTAN5knLcUGqJDQD02zRLBhN+4CNc6WFmi+M
        mRMzY4KOXbeddISQ/2wSbPa9PVCp/uo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681375984;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ear+cnYjNr0Xxid0IYuEKGOWEhCYOcJOGEYisWpZTKo=;
        b=9NIL9C8KqTMIlIlDJ8DPR26DM/xiQezNmGfZN0od/ZvM40T5Uwn+UBLnv7nBBPtJzRfRUA
        jWez3NnzQWfRmdBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D1664139D3;
        Thu, 13 Apr 2023 08:53:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EH/jMvDCN2RyIAAAMHmgww
        (envelope-from <iivanov@suse.de>); Thu, 13 Apr 2023 08:53:04 +0000
From:   "Ivan T. Ivanov" <iivanov@suse.de>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Ivan T . Ivanov" <iivanov@suse.de>
Subject: [PATCH v2 1/2] nvmem: rmem: Use NVMEM_DEVID_AUTO
Date:   Thu, 13 Apr 2023 11:52:05 +0300
Message-Id: <20230413085206.149730-2-iivanov@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230413085206.149730-1-iivanov@suse.de>
References: <20230413085206.149730-1-iivanov@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phil Elwell <phil@raspberrypi.com>

It is reasonable to declare multiple nvmem blocks. Unless a unique 'id'
is passed in for each block there may be name clashes.

Avoid this by using the magic token NVMEM_DEVID_AUTO.

Fixes: 5a3fa75a4d9cb ("nvmem: Add driver to expose reserved memory as nvmem")

Signed-off-by: Phil Elwell <phil@raspberrypi.com>
Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
---
 drivers/nvmem/rmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/rmem.c b/drivers/nvmem/rmem.c
index 80cb187f1481..752d0bf4445e 100644
--- a/drivers/nvmem/rmem.c
+++ b/drivers/nvmem/rmem.c
@@ -71,6 +71,7 @@ static int rmem_probe(struct platform_device *pdev)
 	config.dev = dev;
 	config.priv = priv;
 	config.name = "rmem";
+	config.id = NVMEM_DEVID_AUTO;
 	config.size = mem->size;
 	config.reg_read = rmem_read;
 
-- 
2.35.3

