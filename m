Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C2E719210
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 07:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjFAFDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 01:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjFAFD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:03:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B96912F;
        Wed, 31 May 2023 22:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=V8kaecF6y4TaR0T6wLxAFyrl6r7hQF77k4cBDuWtj4o=; b=jLXR+1KrPVb+JRj3t14srJCkdV
        L1y1gVn7wztz/VXvhcrAmleYxiP/JEfPUIK+fxWeUtgANBCByShUv5kMS9bGKpKkuzfYHdWTmNc2b
        vOd1yv18xRkjVWBe9nJICrL0xi4Chlk9YEU1H/clwZJHCDi5qWeqx2kmgj/8csS/B/Zx8xZve+iPY
        tc8Oig0TN722dkWGmpTiQmQ4Jimw2H9P2dJykFD1+2/yUcFCnvRKmnoq/PrfOeiAjQGJl2Sy5/bhq
        eP4Iz6WW8vgLBMbMw+pelRspHBsmnBvN7wvh1DzYfxJaPwj7lnAsD7Y24p+c+pVzrT+UWLdlmP65+
        DHmLVIyA==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4aT8-001z4C-2g;
        Thu, 01 Jun 2023 05:03:26 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH] usb: typec: mux: fix static inline syntax error
Date:   Wed, 31 May 2023 22:03:25 -0700
Message-Id: <20230601050325.26883-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build error when USB_SUPPORT is not set or TYPEC is not set
by dropping an extraneous semi-colon:

In file included from ../drivers/phy/qualcomm/phy-qcom-qmp-combo.c:23:
../include/linux/usb/typec_mux.h:77:1: error: expected identifier or '(' before '{' token
   77 | {
      | ^
../include/linux/usb/typec_mux.h:76:33: warning: 'fwnode_typec_mux_get' used but never defined
   76 | static inline struct typec_mux *fwnode_typec_mux_get(struct fwnode_handle *fwnode);
      |                                 ^~~~~~~~~~~~~~~~~~~~

Fixes: 3524fe31538c ("usb: typec: mux: Remove alt mode parameters from the API")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
---
 include/linux/usb/typec_mux.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/include/linux/usb/typec_mux.h b/include/linux/usb/typec_mux.h
--- a/include/linux/usb/typec_mux.h
+++ b/include/linux/usb/typec_mux.h
@@ -73,7 +73,7 @@ void *typec_mux_get_drvdata(struct typec
 
 #else
 
-static inline struct typec_mux *fwnode_typec_mux_get(struct fwnode_handle *fwnode);
+static inline struct typec_mux *fwnode_typec_mux_get(struct fwnode_handle *fwnode)
 {
 	return NULL;
 }
