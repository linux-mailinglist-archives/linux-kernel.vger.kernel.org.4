Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBE5609C3E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiJXIP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiJXIPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:15:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9015A2CE23
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666599287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=44cZmrRUYKd8kbBbqHcKNXFtZXAyzTbLTE72fc+7sfs=;
        b=edx/Mq/b9BtqJD1GxqBNKkxR2WTfvQr31ajCU0W/yxfdJv2cRPXp/ufswCEK9BqrnnC2MQ
        Yl7VBSpsXiv+SSCOAY7m0vfaur/vvDi9SD1c1VK0sUhveMbvwIakuOphK9GerxDW9sIO+K
        4WNVxxT/L1VOcn5lWlGFOQCEdSgQ4Lw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-67-iFjvOs_BP1Wx4mxaeEbGnA-1; Mon, 24 Oct 2022 04:14:43 -0400
X-MC-Unique: iFjvOs_BP1Wx4mxaeEbGnA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78808811E84;
        Mon, 24 Oct 2022 08:14:42 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-35.pek2.redhat.com [10.72.12.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2FE7140C6F9F;
        Mon, 24 Oct 2022 08:14:38 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 0/8] Cleanup and optimization patches for percpu
Date:   Mon, 24 Oct 2022 16:14:27 +0800
Message-Id: <20221024081435.204970-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These were found out when reading percpu code, and queued in my local
branch for long time. Send them out for reviewing.

Baoquan He (8):
  mm/percpu: remove unused pcpu_map_extend_chunks
  mm/percpu: use list_first_entry_or_null in pcpu_reclaim_populated()
  mm/percpu: Update the code comment when creating new chunk
  mm/percpu: add comment to state the empty populated pages accounting
  mm/percpu: replace the goto with break
  mm/percpu.c: remove the lcm code since block size is fixed at page
    size
  mm/percpu: remove unused PERCPU_DYNAMIC_EARLY_SLOTS
  mm/slub, percpu: correct the calculation of early percpu allocation
    size

 include/linux/percpu.h |  7 +++----
 mm/percpu.c            | 44 +++++++++++++++++-------------------------
 mm/slub.c              |  3 ++-
 3 files changed, 23 insertions(+), 31 deletions(-)

-- 
2.34.1

