Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C61764FB1C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 17:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiLQQxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 11:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiLQQxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 11:53:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6785D120A9
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 08:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671295963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=VtiAFXUoxPGVWbrfrF2d0QiTT9pcM+3AnAGNlWeoaSw=;
        b=PiVL90qE9mvYz4Q0R+srTADYUmDuhjJAvYBowdjOFpViEdRMsfTVrn09n4nP+rg2x5b9qf
        M0R93EdtRSytN1oVjBbBXiIJMq6rliNqhg76CcVX89n7ay3SNhzoiaecThqFGMY13fkHCH
        8s8xK11mUj7pSRBEHUeuhZ2N0i6Qho4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-L_OKN2wJMPycZbZxOl4drA-1; Sat, 17 Dec 2022 11:52:37 -0500
X-MC-Unique: L_OKN2wJMPycZbZxOl4drA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D7CB88F46A;
        Sat, 17 Dec 2022 16:52:37 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E62F14171C5;
        Sat, 17 Dec 2022 16:52:36 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     linux-modules@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] kmod: configure.ac: In _Noreturn check, include <stdlib.h>
 for exit
Date:   Sat, 17 Dec 2022 17:52:34 +0100
Message-ID: <877cyq6kh9.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise, an implicit functiona declaration is used, causing
a C99 compatibility issue.

Signed-off-by: Florian Weimer <fweimer@redhat.com>

---
 configure.ac | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 6989e93..12e0518 100644
--- a/configure.ac
+++ b/configure.ac
@@ -68,7 +68,8 @@ AC_COMPILE_IFELSE(
 
 AC_MSG_CHECKING([whether _Noreturn is supported])
 AC_COMPILE_IFELSE(
-	[AC_LANG_SOURCE([[_Noreturn int foo(void) { exit(0); }]])],
+	[AC_LANG_SOURCE([[#include <stdlib.h>
+	_Noreturn int foo(void) { exit(0); }]])],
         [AC_DEFINE([HAVE_NORETURN], [1], [Define if _Noreturn is available])
 	 AC_MSG_RESULT([yes])],
 	[AC_MSG_RESULT([no])])

base-commit: 6c5f2f13689e6a4668f87171752d7818bed4b602

