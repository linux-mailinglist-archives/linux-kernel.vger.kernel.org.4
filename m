Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0E7731795
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344502AbjFOLno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344340AbjFOLmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:42:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81ECF3A8F;
        Thu, 15 Jun 2023 04:39:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0820639F2;
        Thu, 15 Jun 2023 11:39:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5269C433CD;
        Thu, 15 Jun 2023 11:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686829176;
        bh=IT2ZpffyqEISnL6NLd+96omR6hfrvOlCcRzPt2a66jQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lys3S4+NVs781W+Qv4nT695cHotqAHksrDoWrZFKGjW5myLZfas23uFs76cS0JdF2
         bvw39+cnsZpnvTxpvmjl1EDExwHJeCoSBLdttlnpvTNecG0vbGc/G1tbQrF5Mn7wgy
         mV4g3cILKJxtL1Il7yJIUcT24Y4gh7+k0e5xpDJsfweUAv2xqsLiI5RhBzQSQCLb+i
         GOMq308fQa/sCubbrqkWtimyjKSbq4wcURHLXYuCS7GlQ9nEzR58KylTSMe4+QE3Kw
         8tJwQnWH3rPaLXrT5yKOqXhWIbLqWGKSUbGMsD18cHYgivr/OpgsizOiZhDlYlfs//
         zWNG9HkWSDnVA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 8/9] usb: gadget: udc: fix NULL dereference in remove()
Date:   Thu, 15 Jun 2023 07:39:16 -0400
Message-Id: <20230615113917.649505-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615113917.649505-1-sashal@kernel.org>
References: <20230615113917.649505-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.184
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 016da9c65fec9f0e78c4909ed9a0f2d567af6775 ]

The "udc" pointer was never set in the probe() function so it will
lead to a NULL dereference in udc_pci_remove() when we do:

	usb_del_gadget_udc(&udc->gadget);

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/ZG+A/dNpFWAlCChk@kili
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/amd5536udc_pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/udc/amd5536udc_pci.c b/drivers/usb/gadget/udc/amd5536udc_pci.c
index c80f9bd51b750..a36913ae31f9e 100644
--- a/drivers/usb/gadget/udc/amd5536udc_pci.c
+++ b/drivers/usb/gadget/udc/amd5536udc_pci.c
@@ -170,6 +170,9 @@ static int udc_pci_probe(
 		retval = -ENODEV;
 		goto err_probe;
 	}
+
+	udc = dev;
+
 	return 0;
 
 err_probe:
-- 
2.39.2

