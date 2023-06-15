Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD5A731755
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344326AbjFOLl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344266AbjFOLlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:41:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32884203;
        Thu, 15 Jun 2023 04:39:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92D38639F5;
        Thu, 15 Jun 2023 11:39:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597EDC433C8;
        Thu, 15 Jun 2023 11:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686829154;
        bh=IT2ZpffyqEISnL6NLd+96omR6hfrvOlCcRzPt2a66jQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iw0dL7taTwAS0V0JdZ5zgtWGfyvROelxRpGswDZ9qy4nqK5jgJSZeLEyOa2iQOcFy
         WmgWGj41zZ3NDlDkV/R4mYwsjOuLHa+zYwBNkoUvNh6WRa7sj+rpUvN45V2Qbi5v+e
         dOI7a0GKM+jPrXyGzxe6+dFxje/VvJcYxO6SqR+Fm0i7xMViFQah5U/Y+sIlCa6+cu
         3oscWVXx3RFLyC3pLE1fHfhcNyYc2KyIQnm7WmCr1hpEeTc2LlADxdirORjPd7FUBI
         pYOTExr6cDnBlqKh8kgmuBa3rRG3/4g4k66WB9G4IxJPZSbBo7Jw0yND2Gw4PTMKEE
         yc9DE+sdpxgxw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 08/10] usb: gadget: udc: fix NULL dereference in remove()
Date:   Thu, 15 Jun 2023 07:38:52 -0400
Message-Id: <20230615113854.649370-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615113854.649370-1-sashal@kernel.org>
References: <20230615113854.649370-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.117
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

