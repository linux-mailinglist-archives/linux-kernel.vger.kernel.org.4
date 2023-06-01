Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE6A71F4C9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjFAVdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjFAVdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:33:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3320719D;
        Thu,  1 Jun 2023 14:33:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97F6B649FE;
        Thu,  1 Jun 2023 21:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F10BC433D2;
        Thu,  1 Jun 2023 21:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685655227;
        bh=2PZNDZhyudgBBw1UYaIHU6reQUknQRHhSFn37DBiuGs=;
        h=From:To:Cc:Subject:Date:From;
        b=UhgKZQcuZKTR+h0KqnTOLA+v8IgT2UiQamqAETovgT4iRVZCIJDCwmRUfDjLA+NlQ
         vpUACaZ65gBPYLGw+Nc41zhaHhdwEjr/FWIi8+8hZORXgjXixld/zf6zdnOgoX/aRG
         HnJtRmrubSNC0lEya//iOimyD0/U9cFhL0eHFMx7lEeJvCqL0ZYTYdhaeRxlTcibvq
         kp4JDVAqFLIlu5V91IxP4cT2glLh7ZKy/qzu3oFYU9jswh2OHtuERaof0IX4W77EzL
         3qnGBa0L2LhAJqCM/H1XDhoCUgYwNI/rjtKDLcSBcOQEc0XnxF1IW8oTVewgempVJT
         cYurWSe8wW+5Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: typec: mux: Fix extraneous semicolon
Date:   Thu,  1 Jun 2023 23:33:37 +0200
Message-Id: <20230601213342.3334659-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A recent patch introduced a typo in the fwnode_typec_mux_get()
stub function that causes a build failure in some configurations:

In file included from drivers/phy/qualcomm/phy-qcom-qmp-combo.c:23:
include/linux/usb/typec_mux.h:77:1: error: expected identifier or '(' before '{' token
include/linux/usb/typec_mux.h:76:33: error: 'fwnode_typec_mux_get' used but never defined [-Werror]

Fixes: 3524fe31538c1 ("usb: typec: mux: Remove alt mode parameters from the API")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/usb/typec_mux.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/usb/typec_mux.h b/include/linux/usb/typec_mux.h
index 11bfa314529fd..2489a7857d8e1 100644
--- a/include/linux/usb/typec_mux.h
+++ b/include/linux/usb/typec_mux.h
@@ -73,7 +73,7 @@ void *typec_mux_get_drvdata(struct typec_mux_dev *mux);
 
 #else
 
-static inline struct typec_mux *fwnode_typec_mux_get(struct fwnode_handle *fwnode);
+static inline struct typec_mux *fwnode_typec_mux_get(struct fwnode_handle *fwnode)
 {
 	return NULL;
 }
-- 
2.39.2

