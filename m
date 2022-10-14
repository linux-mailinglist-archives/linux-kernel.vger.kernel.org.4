Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECF15FE95D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 09:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiJNHTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 03:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiJNHTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 03:19:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6762E60C3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 00:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665731984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=D8s16tiZuYHA8WakFIbdUv+5nE3Pxop3GoZh9YyYHgw=;
        b=Se+b6eXymRJx193JKXEQjjhYRPyNjYB2EdiVKaDJAdtBleXPW8Lj9TvivKNeMLrgp7ESNo
        lN3YJIj1uE45KavWEkyARpjSajQptWwGIQ3AJ8YlpGttbhlOt9NKJBzg/pSqLvx0Pt62vj
        tKIql6Yh12Bg+WKlRwKIJr83hDFoLt8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-cVPqaDGcOoClOmvlftlLug-1; Fri, 14 Oct 2022 03:19:43 -0400
X-MC-Unique: cVPqaDGcOoClOmvlftlLug-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C64ED833A0D;
        Fri, 14 Oct 2022 07:19:42 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-52.bne.redhat.com [10.64.54.52])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 40B36C06224;
        Fri, 14 Oct 2022 07:19:36 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.linux.dev
Cc:     kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ajones@ventanamicro.com,
        pbonzini@redhat.com, maz@kernel.org, shuah@kernel.org,
        oliver.upton@linux.dev, seanjc@google.com, peterx@redhat.com,
        maciej.szmigiero@oracle.com, ricarkol@google.com,
        zhenyzha@redhat.com, shan.gavin@gmail.com
Subject: [PATCH 0/6] KVM: selftests: memslot_perf_test: aarch64 cleanup/fixes
Date:   Fri, 14 Oct 2022 15:19:08 +0800
Message-Id: <20221014071914.227134-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvm/selftests/memslots_perf_test doesn't work with 64KB-page-size-host
and 4KB-page-size-guest on aarch64. In the implementation, the host and
guest page size have been hardcoded to 4KB. It's ovbiously not working
on aarch64 which supports 4KB, 16KB, 64KB individually on host and guest.

This series tries to fix it. After the series is applied, the test runs
successfully with 64KB-page-size-host and 4KB-page-size-guest.

   # ./memslots_perf_tests -v -s 512

Since we're here, the code is cleaned up a bit as PATCH[1-3] do. The
other patches are fixes to handle the mismatched host/guest page
sized.

Gavin Shan (6):
  KVM: selftests: memslot_perf_test: Use data->nslots in prepare_vm()
  KVM: selftests: memslot_perf_test: Consolidate loop conditions in
    prepare_vm()
  KVM: selftests: memslot_perf_test: Probe memory slots for once
  KVM: selftests: memslot_perf_test: Support variable guest page size
  KVM: selftests: memslot_perf_test: Consolidate memory sizes
  KVM: selftests: memslot_perf_test: Report optimal memory slots

 .../testing/selftests/kvm/memslot_perf_test.c | 286 +++++++++++-------
 1 file changed, 183 insertions(+), 103 deletions(-)

-- 
2.23.0

