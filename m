Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF2B6A4238
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjB0NGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjB0NFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:05:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA6517177
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677503107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IrBksrjGGrO7Pe4rnel32zeNt4JHO/Z42+RfOEvS6Hg=;
        b=V4tTBDokm3n71AbjjMZqguyVdV4gjRl2niE/DIZD87q65GQx0LhjnoKzhCWAQ5/ncRz1NE
        /fa+vAjmQF8Z43rkcyZ4w37yjb9ohApZ7TlH+q3eSfH4y8Od2V8Bqv6ST3DfWNaYr0s+Jt
        xEPMibj4ZdWp3427k0+GQ/9xV9SpW/o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-ksird7C0MBWvJ_egAW0PtA-1; Mon, 27 Feb 2023 08:05:04 -0500
X-MC-Unique: ksird7C0MBWvJ_egAW0PtA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 113273C14841;
        Mon, 27 Feb 2023 13:05:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 752E618EC7;
        Mon, 27 Feb 2023 13:05:01 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        Steve French <sfrench@samba.org>, linux-cachefs@redhat.com
Subject: [PATCH 2/2] iov: Fix netfs_extract_user_to_sg()
Date:   Mon, 27 Feb 2023 13:04:54 +0000
Message-Id: <20230227130454.2673622-3-dhowells@redhat.com>
In-Reply-To: <20230227130454.2673622-1-dhowells@redhat.com>
References: <20230227130454.2673622-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the loop check in netfs_extract_user_to_sg() for extraction from
user-backed iterators to do the body if npages > 0, not if npages < 0
(which it can never be).

This isn't currently used by cifs, which only ever extracts data from BVEC,
KVEC and XARRAY iterators at this level, user-backed iterators having being
decanted into BVEC iterators at a higher level to accommodate the work
being done in a kernel thread.

Found by smatch:
	fs/netfs/iterator.c:139 netfs_extract_user_to_sg() warn: unsigned 'npages' is never less than zero.

Fixes: 018584697533 ("netfs: Add a function to extract an iterator into a scatterlist")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/oe-kbuild-all/202302261115.P3TQi1ZO-lkp@intel.com/
---
 fs/netfs/iterator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
index f00d43b8ac0a..e9a45dea748a 100644
--- a/fs/netfs/iterator.c
+++ b/fs/netfs/iterator.c
@@ -134,7 +134,7 @@ static ssize_t netfs_extract_user_to_sg(struct iov_iter *iter,
 		npages = DIV_ROUND_UP(off + len, PAGE_SIZE);
 		sg_max -= npages;
 
-		for (; npages < 0; npages--) {
+		for (; npages > 0; npages--) {
 			struct page *page = *pages;
 			size_t seg = min_t(size_t, PAGE_SIZE - off, len);
 

