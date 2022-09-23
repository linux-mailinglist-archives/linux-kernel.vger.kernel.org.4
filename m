Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4869C5E79A9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiIWLeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiIWLel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:34:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECA89FE7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 04:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663932877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4X3wisODltpxscZtCSRmTQy5pbD/XdZXOSG0hYXXj4k=;
        b=d+rlQrrcxAK3iCy9I3xEtWUsCC1ndP+UxbAYVj6bb+elqDhpkN5KHB5QR6aXncYX6aPZ9g
        bbLxniH8jEWAIZPNWdBGAk2kzQtwCJqmdMBje1R6qvtx59lpRPDfLuxME50Mv+770xP+Gx
        RTYCQURhX37WzhwkE9SmXnGvlbY6Wgc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-381-WxR3GrKZOCqkUD7z_oVV3g-1; Fri, 23 Sep 2022 07:34:33 -0400
X-MC-Unique: WxR3GrKZOCqkUD7z_oVV3g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B7D83806721;
        Fri, 23 Sep 2022 11:34:32 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 78889492B06;
        Fri, 23 Sep 2022 11:34:27 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Akira Yokosawa <akiyks@gmail.com>,
        Kalle Valo <kvalo@kernel.org>, "Daniel K ." <daniel@cluded.net>
Subject: [PATCH v2 0/2] coding-style.rst: document BUG() and WARN() rules
Date:   Fri, 23 Sep 2022 13:34:23 +0200
Message-Id: <20220923113426.52871-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it seems to be rather unclear if/when to use BUG(), BUG_ON(),
VM_BUG_ON(), WARN_ON_ONCE(), ... let's try to document the result of a
recent discussion.

Details can be found in patch #1.

v1 -> v2:
* "coding-style.rst: document BUG() and WARN() rules ("do not crash the
   kernel")"
 -> Minor rephrasing / reference fix [John]
 -> Compile fix [Akira]
* "powerpc/prom_init: drop PROM_BUG()"
 -> Dropped because it will go upstream via a different tree
* "checkpatch: warn on usage of VM_BUG_ON() and other BUG variants"
 -> Rephrase warning message and remove trailing period [John+Joe]

RFC -> v1:
* "coding-style.rst: document BUG() and WARN() rules ("do not crash the
   kernel")"
 -> Rephrase/extend according to John
 -> Add some details regarding the use of panic()
* powerpc/prom_init: drop PROM_BUG()
 -> Added
* "checkpatch: warn on usage of VM_BUG_ON() and other BUG variants"
 -> Warn on more variants


Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Daniel K. <daniel@cluded.net>

David Hildenbrand (2):
  coding-style.rst: document BUG() and WARN() rules ("do not crash the
    kernel")
  checkpatch: warn on usage of VM_BUG_ON() and other BUG variants

 Documentation/process/coding-style.rst | 62 ++++++++++++++++++++++++++
 scripts/checkpatch.pl                  |  6 +--
 2 files changed, 65 insertions(+), 3 deletions(-)

-- 
2.37.3

