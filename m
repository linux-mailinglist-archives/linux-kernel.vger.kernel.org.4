Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1169766D52A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 04:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbjAQDub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 22:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbjAQDu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 22:50:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF72234D2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 19:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673927376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=d6j1pwwcrVA2VMufpYBThaFRk5AuLZLztdhG3ETtdEQ=;
        b=B6B4q2quBl0RLf3y9f/7eeoKaDbl8DpYa8w54LinuRZ1A5oJRmR7qy24ySjSVGPnFbG5bI
        Br6ooMv/1i2ln5vhHOKiWZbGvJzbsb1OGK84CiO4AlpJVoxAWjJrkBagIYq79xzhtwk3BS
        sc19MVDefyUtzf4NSeKfzx0d0uyqHlE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-m9NhwEysOritgPQaMb4Hkg-1; Mon, 16 Jan 2023 22:49:30 -0500
X-MC-Unique: m9NhwEysOritgPQaMb4Hkg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D72FD185A794;
        Tue, 17 Jan 2023 03:49:29 +0000 (UTC)
Received: from fedora.redhat.com (ovpn-12-229.pek2.redhat.com [10.72.12.229])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 336091415108;
        Tue, 17 Jan 2023 03:49:24 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org,
        thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
        wangkefeng.wang@huawei.com, Baoquan He <bhe@redhat.com>
Subject: [PATCH 0/2] arm64: kdump: simplify the reservation behaviour of crashkernel=,high
Date:   Tue, 17 Jan 2023 11:49:19 +0800
Message-Id: <20230117034921.185150-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
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

After crashkernel=,high support was added, our QE engineer surprisingly
found the reserved crashkernel high region could cross the high low
memory boundary. E.g on system with 4G as boundary, the crashkernel high
region is [4G-64M, 4G+448M]. After investigation, I noticed on arm64,
the area near 4G is contiguous. Not like x86, its firmware occupies the
cpu address space below 4G. When memblock searches for available memory
region top down, it could find a region across 4G boundary. Finally, we
actually got two memory regions in low memory. This complicates the
crashkernel=,high behaviour, people will be confused by this.

In this patchset, simpliyfy the behaviour of crashkernel=,high. When
trying to reserve memory region for crashkernel high, we only search for
the region in high memory, e.g above 4G. If failed, try searching in low
memory. This makes sure the crashkernel high memory limited in high
memory, confusion is removed.

In patch 2, I add code comment above several crashkernel reservation
case to ease code reading. I put them in a separate patch 2 because I
want the code change in patch 1 to be straightforward and simpler for
reviewing.

Please help review and check if this is helpful and worth.

Baoquan He (2):
  arm64: kdump: simplify the reservation behaviour of crashkernel=,high
  arm64/kdump: add code comments for crashkernel reservation cases

 arch/arm64/mm/init.c | 43 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

-- 
2.34.1

