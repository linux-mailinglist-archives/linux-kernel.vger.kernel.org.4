Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70535726D76
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbjFGUmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbjFGUmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:42:08 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED501BE2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 13:42:05 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-ba8151a744fso9002832276.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 13:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686170525; x=1688762525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yWwtq3EN4Ayk9MRMU2aK6WIfQbDPRAXpQBsu+vmlHD8=;
        b=VlupK4S4g8N6JnMM7bHTUHteuIhAS5+rMiRJCCm9KQoOmsMDF6tPsFNOuTj8mWKi5X
         89FWeTAmKE7NdcQ3aFJcB4+meZ0t31tVN9ir/+haQnVVJEjrYvf5NCIqarWtJ3hzI+DV
         idHDY+fR7z5r+RJbZ0qYw0AKAubEr2HW5YAavhqtwYoA1TpBi4lVvACSvgOwYogIn6vI
         UhdswjOuw11I7HNc5I0H/sSANQ9p/ZpvYKqLs9TpchPYFdt1cvDpiRPDlujm2Nr8cehN
         C2v5AJe9vtJ2cjRq5wN9iHUHo3l9hThIts+UUCoZso+nrGWyPQ5kSSYQLQ8eQEaR5sRt
         mtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686170525; x=1688762525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yWwtq3EN4Ayk9MRMU2aK6WIfQbDPRAXpQBsu+vmlHD8=;
        b=HdMGPxmbjWpFf5lgbyi41tgnlIWA0KxR8W7+CFaZjm9wJnEcRPRooco98ZiGJgQ/1z
         jpbje43jMeXuDtr/hpZXf/UQ2JHWMMFO/vMOL5O8Q0q85Z1DYM37Lrj0cjTpmM9qpybf
         8ukVI4bbeOAeez20RujH/whL1oc2j4CN/nHu0JuiGvp+0W8UJSGZ7kWuo3KTu7i+LhQB
         jp2HXr2+9dS6VyRKm9PO7dUsk3CNP3ZVU+n+iXTgynNfBmx7hWwHv/4ceytSZUIA7PGx
         2yZyKhfXni5973p4/hAgp0ZG26SYl8Gs84odM+TGJ3GyfUEK9aDKPD66lGaY0n/AceRz
         kb7Q==
X-Gm-Message-State: AC+VfDxmcbgM7hnXek3YmVjtLi0PKPJNFOL42b8Nx9UPqEKzK0TyqceL
        gCK6OVD1RzHX6waBY/4TYPc=
X-Google-Smtp-Source: ACHHUZ5b9oKpc/9P/4d9g1IGrJ6Fuj98eZ8a/NfWFdocTSO4SW42biyrOIyh0jNZ51kEnUUY8nULlg==
X-Received: by 2002:a81:8a85:0:b0:565:6acc:995c with SMTP id a127-20020a818a85000000b005656acc995cmr8000349ywg.15.1686170524839;
        Wed, 07 Jun 2023 13:42:04 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::36])
        by smtp.googlemail.com with ESMTPSA id v16-20020a814810000000b005688deeefc2sm4972938ywa.20.2023.06.07.13.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 13:42:03 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-afs@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, dhowells@redhat.com,
        akpm@linux-foundation.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH] afs: Fix dangling folio ref counts in writeback
Date:   Wed,  7 Jun 2023 13:41:19 -0700
Message-Id: <20230607204120.89416-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit acc8d8588cb7 converted afs_writepages_region() to write back a
folio batch. If writeback needs rescheduling, the function exits without
dropping the references to the folios in fbatch. This patch fixes that.

This has only been compile tested.

Fixes: acc8d8588cb7 ("afs: convert afs_writepages_region() to use filemap_get_folios_tag()")
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/afs/write.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index c822d6006033..a724228e4d94 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -764,6 +764,7 @@ static int afs_writepages_region(struct address_space *mapping,
 					if (skips >= 5 || need_resched()) {
 						*_next = start;
 						_leave(" = 0 [%llx]", *_next);
+						folio_batch_release(&fbatch);
 						return 0;
 					}
 					skips++;
-- 
2.40.1

