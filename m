Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77B569DA90
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 07:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjBUGI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 01:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjBUGIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 01:08:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2DA24133
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 22:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676959654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=A2giW3bT8cm75k/LWtJ7T2CNx/fQyX6UZRlac4+D5AE=;
        b=aQ1i/cSt9qU6/pfKmUBf7U2MkOdWKcDcnDgHYRYvuKTtodLkdPaIMS46ckJ423IScBUq7P
        u6az3l1Ydob2L4HjzGpHOjlRqRFyqHLqJu1ttXOn4esapQ+YlEfKVXiu9iSmczoJMyWeor
        QKazWAaWpvvmjJ4e/zHZ5EH5jlCU+kk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-3v5XzhKZNzeoIoT0UyYacw-1; Tue, 21 Feb 2023 01:07:30 -0500
X-MC-Unique: 3v5XzhKZNzeoIoT0UyYacw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 46CE11C04347;
        Tue, 21 Feb 2023 06:07:30 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-7.pek2.redhat.com [10.72.13.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E9E1492B04;
        Tue, 21 Feb 2023 06:07:26 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, arnd@arndb.de, hch@infradead.org,
        mcgrof@kernel.org, Baoquan He <bhe@redhat.com>
Subject: [RFC PATCH 0/2] arch/*/io.h: remove ioremap_uc in some architectures
Date:   Tue, 21 Feb 2023 14:07:21 +0800
Message-Id: <20230221060723.26291-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a patchset reviewing, Arnd suggested removing arch specific ioremap_uc()
and using default one defined in asm-generic/io.h instead, other than
x86 and ia64. Please see below link for more details:

https://lore.kernel.org/all/056cc71f-7fb9-4d38-a442-a05de6f7d437@app.fastmail.com/T/#u

And Arnd also provided an old link where people earlier discussed this.

https://lore.kernel.org/all/20191111192258.2234502-1-arnd@arndb.de/

So in this patchset, I firstly add including asm-generic/io.h for mips,
then remove all arch specific ioremap_uc() definitions, except of x86
ans ia64. With the removing, those ARCH-es will have default
ioremap_uc() defined in asm-generic/io.h.

Baoquan He (2):
  mips: add <asm-generic/io.h> including
  arch/*/io.h: remove ioremap_uc in some architectures

 arch/alpha/include/asm/io.h    |  1 -
 arch/hexagon/include/asm/io.h  |  3 ---
 arch/m68k/include/asm/kmap.h   |  1 -
 arch/mips/include/asm/io.h     | 47 +++++++++++++++++++++++++++++++++-
 arch/mips/include/asm/mmiowb.h |  2 --
 arch/parisc/include/asm/io.h   |  2 --
 arch/powerpc/include/asm/io.h  |  1 -
 arch/sh/include/asm/io.h       |  2 --
 arch/sparc/include/asm/io_64.h |  1 -
 9 files changed, 46 insertions(+), 14 deletions(-)

-- 
2.34.1

