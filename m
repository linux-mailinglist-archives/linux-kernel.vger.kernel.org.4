Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422C97358CC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjFSNm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjFSNm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:42:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400F8E59
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687182131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Vk302f39rRkI3sCTLAPNFkOrhjgiDmscCE65ATB/Apo=;
        b=hifi/w+3aABiqsjA/JuIAwxxyBYff023nzkttrVH6nH7VEPH5PghJEm0CiUI8/Iq4I72lt
        OgYyLW6uWc/AXPLfqEWIKuuNFUfOn680l5zkp4GIfZ1eURLYoOtwhoPaQJyMvYx5gr7o79
        ZHHZHui30OFglmd/11+Vy/qDYQNM2II=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-257-tQFX428lNvKBr4q8ftaEaQ-1; Mon, 19 Jun 2023 09:42:09 -0400
X-MC-Unique: tQFX428lNvKBr4q8ftaEaQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 912E51C08DAF;
        Mon, 19 Jun 2023 13:42:08 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCA7D112132C;
        Mon, 19 Jun 2023 13:42:07 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] afs: Fix writeback
Date:   Mon, 19 Jun 2023 14:42:02 +0100
Message-ID: <20230619134204.922713-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you apply these fixes to AFS writeback code from Vishal?

 (1) Release the acquired batch before returning if we got >=5 skips.

 (2) Retry a page we had to wait for rather than skipping over it after the
     wait.

The patches can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-fixes

Thanks,
David

---
%(shortlog)s
%(diffstat)s

Vishal Moola (Oracle) (2):
  afs: Fix dangling folio ref counts in writeback
  afs: Fix waiting for writeback then skipping folio

 fs/afs/write.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

