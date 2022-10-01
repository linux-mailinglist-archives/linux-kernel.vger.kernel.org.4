Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FA05F1DEB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 18:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJAQw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 12:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJAQw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 12:52:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B81236DCA
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 09:52:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C5750CE0764
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 16:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F00C433D7;
        Sat,  1 Oct 2022 16:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664643142;
        bh=CgtcYHhcdLVkuCN2SEuadSin01psP91z/dkpxhLpe/M=;
        h=From:To:Cc:Subject:Date:From;
        b=hgjjZoaqAcWw0RhCCvy+EN91ePbRYYzsZe7a6d8AoFM3UwjZyymIOkdumGNAGFZV4
         O5r07R2JLdITz4Q/I3bXnsBuvcUSOzvZn3SSJo3d+HQa0hxcaxc8lOqMq+VoTazcNd
         G4nsObUqZsCoeo54pQqzRYndRiEdrsSM8TeyWPG4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] driver core: make kobj_to_dev() take a const pointer
Date:   Sat,  1 Oct 2022 18:52:18 +0200
Message-Id: <20221001165218.2689122-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=941; i=gregkh@linuxfoundation.org; h=from:subject; bh=CgtcYHhcdLVkuCN2SEuadSin01psP91z/dkpxhLpe/M=; b=owGbwMvMwCRo6H6F97bub03G02pJDMkWBY4uyit+V2fxS1dpWrvuW3usVfWos7pE7qqj721arsZY 5Fd1xLIwCDIxyIopsnzZxnN0f8UhRS9D29Mwc1iZQIYwcHEKwERuXGeYpzE7qyjpv1F2nIpf+Lbt6y J1d/Z8Z5jDkzzt0YIbbK2TlqyMP95TzvPYcL0cAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doing pointer math does not modify the pointer itself, so it is safe to
say that the kobject passed into kobj_to_dev() is const.  Now the
pointer passed out of it does loose the const capability, but for now
that's ok, we are allowing this so that const kobjects can call this
function successfully.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 424b55df0272..b855b2e74cd3 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -680,7 +680,7 @@ struct device_link {
 	bool supplier_preactivated; /* Owned by consumer probe. */
 };
 
-static inline struct device *kobj_to_dev(struct kobject *kobj)
+static inline struct device *kobj_to_dev(const struct kobject *kobj)
 {
 	return container_of(kobj, struct device, kobj);
 }
-- 
2.37.3

