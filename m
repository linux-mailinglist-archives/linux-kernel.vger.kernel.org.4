Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9452A70241F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239538AbjEOGIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238405AbjEOGH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:07:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B847E2737
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684130590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KwvjAcU6+K06SNPtN9LrkEogqw2dJLjTTDcGRcC1x2U=;
        b=QDhTs5OWgbxykFyBMpGfkCKetU4WpKNXghq4alnlv4B8IJM3ArBMJpP3HnuWQOUkQZClOY
        9Wg9t7Za9RO/uNyl3wAUZIF09kfJlmcMvzSG1vcSh2srC4qCet6Y4ZqWtpmaV4890Y6ClB
        PEChlU7zSlhM7BPbrwRaqM5SR5xHYMY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-87bFa3QDMXu8R3FsN1FjeA-1; Mon, 15 May 2023 02:03:07 -0400
X-MC-Unique: 87bFa3QDMXu8R3FsN1FjeA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6034885A5A3;
        Mon, 15 May 2023 06:03:06 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-32.pek2.redhat.com [10.72.12.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30514400F5A;
        Mon, 15 May 2023 06:03:01 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, horms@kernel.org,
        thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v6 0/2] arm64: kdump: simplify the reservation behaviour of crashkernel=,high
Date:   Mon, 15 May 2023 14:02:57 +0800
Message-Id: <20230515060259.830662-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In v5 patch, Catalin helped review and acked the patch. However, an
uninitialized local varilable is warned out by static checker when Will
tried to merge the patch. And Will complained the code flow in
reserve_crashkernel() is hard to follow, required to refactor. While
when I tried to do the refactory, I feel it's not easy, the existing
several cases causes that.

To make the code easier understand, I try my best to compose a document
to introduce the background, concept and implementation strategies of 
crashkernel reservation. Hope it can help people to understand the code
flow a little more easily.

[PATCH v5] arm64: kdump: simplify the reservation behaviour of crashkernel=,high
https://lore.kernel.org/all/20230407022419.19412-1-bhe@redhat.com/T/#u

v5->v6:
- Fix the warning reported by static checker about "uninitialized symbol
'search_base'".
- Add a document Documentation/arm64/kdump.rst to explain how to reserve
  crashkernel.

Baoquan He (2):
  arm64: kdump: simplify the reservation behaviour of crashkernel=,high
  Documentation: add kdump.rst to present crashkernel reservation on
    arm64

 Documentation/arm64/kdump.rst | 103 ++++++++++++++++++++++++++++++++++
 arch/arm64/mm/init.c          |  44 +++++++++++----
 2 files changed, 137 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/arm64/kdump.rst

-- 
2.34.1

