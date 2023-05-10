Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E046FE5B6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237300AbjEJUwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236872AbjEJUwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:52:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122E59EE8;
        Wed, 10 May 2023 13:51:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCF9064A2A;
        Wed, 10 May 2023 20:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D53C4339B;
        Wed, 10 May 2023 20:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683751803;
        bh=u0ete4/L9qEG1j1eaFaM6cfkD+hUhRBYlzGermRhDww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AgcQD8KLSIO9cdZ+gsUrFmp6NzgO8rU1/mfMNfIlvU58IfXrB1AjVaov1ZOEqoQHl
         PtXRmcYCmsFhcdZiCkYyrihsWxbaa7lWP8SxjaaN6NaaXnZ7S+ymgKwT1MpBFHLUti
         XXmgfK5T7kRuH/wE3wXCv/Y/eV7MryGahm4Ozc8z/suBk4WTBLa8BPLfw5ynCtY6Mv
         GqKG+PyGwaZ4AUn/sZ95Z30XT/em8oXhRIeou1Cj7y6/I54vwHp4oLzlOOYWkH2ck0
         k6K4T2xPOSY/N2DViwhTxDNb+hQY98hA1T/b5PfsvuhU41ckqa6s4CQG0O692ZjeVG
         SgNj/xyEqbW7g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qiang Ning <qning0106@126.com>, Lee Jones <lee@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 6/8] mfd: dln2: Fix memory leak in dln2_probe()
Date:   Wed, 10 May 2023 16:49:47 -0400
Message-Id: <20230510204950.104873-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230510204950.104873-1-sashal@kernel.org>
References: <20230510204950.104873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

From: Qiang Ning <qning0106@126.com>

[ Upstream commit 96da8f148396329ba769246cb8ceaa35f1ddfc48 ]

When dln2_setup_rx_urbs() in dln2_probe() fails, error out_free forgets
to call usb_put_dev() to decrease the refcount of dln2->usb_dev.

Fix this by adding usb_put_dev() in the error handling code of
dln2_probe().

Signed-off-by: Qiang Ning <qning0106@126.com>
Signed-off-by: Lee Jones <lee@kernel.org>
Link: https://lore.kernel.org/r/20230330024353.4503-1-qning0106@126.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/dln2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
index 6cd0b0c752d6e..c3149729cec2e 100644
--- a/drivers/mfd/dln2.c
+++ b/drivers/mfd/dln2.c
@@ -827,6 +827,7 @@ static int dln2_probe(struct usb_interface *interface,
 	dln2_stop_rx_urbs(dln2);
 
 out_free:
+	usb_put_dev(dln2->usb_dev);
 	dln2_free(dln2);
 
 	return ret;
-- 
2.39.2

