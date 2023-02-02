Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656BA687545
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 06:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjBBFfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 00:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjBBFe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 00:34:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EC884B5C;
        Wed,  1 Feb 2023 21:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=6xrDrgd0SgpMzq7Fih7w16pMOwi04Mj1hgwk0rtIR8g=; b=nUKgQ0CVxwQVVfCTHpke6jhRT9
        EeJlUfJzGwXz9zQ9oXDM6mjMK8Qkvqsj4L05sphwzyZRqCdrHMbvSec+aGB7iEo8FyqmPrmUpNQrR
        5pdFie01KZqO6FIVeVsJjfwKGu+cIVj7auniHEygyvyBrnwZHokJ3RzzXMR3NHA8K7xphYFZVROVH
        dDsDvCxJ4RS87XDeoS1S2kOa3sN19xd9sEVO2dGjeJlGw42jmE2Y1yas8zdYrWvOldf4mOA5m+zIY
        wrgh7inFeNY9WmCRaNf1QHl8GUJUU0wxuWNExlsfdCtHOvh7No7vM7GnYKmh/KUs+RZRvXS45m+AW
        +wo07Bvw==;
Received: from [2601:1c2:d00:6a60::9526] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNSBl-00ERl0-Q3; Thu, 02 Feb 2023 05:31:13 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2] sh: implicit access_ok() needs an #include
Date:   Wed,  1 Feb 2023 21:31:13 -0800
Message-Id: <20230202053113.2782-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building arch/sh/ has a build error/warning that is fixed by
adding an #include of a header file.

../arch/sh/include/asm/checksum_32.h: In function 'csum_and_copy_from_user':
../arch/sh/include/asm/checksum_32.h:53:14: error: implicit declaration of function 'access_ok' [-Werror=implicit-function-declaration]
   53 |         if (!access_ok(src, len))
      |              ^~~~~~~~~

Fixes: 7fe8970a78a1 ("sh32: convert to csum_and_copy_from_user()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
v2: add Subject: and patch description

 arch/sh/include/asm/checksum_32.h |    1 +
 1 file changed, 1 insertion(+)

diff -- a/arch/sh/include/asm/checksum_32.h b/arch/sh/include/asm/checksum_32.h
--- a/arch/sh/include/asm/checksum_32.h
+++ b/arch/sh/include/asm/checksum_32.h
@@ -7,6 +7,7 @@
  */
 
 #include <linux/in6.h>
+#include <asm-generic/access_ok.h>
 
 /*
  * computes the checksum of a memory block at buff, length len,
