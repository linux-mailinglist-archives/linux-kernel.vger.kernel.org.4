Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E775F3FD9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiJDJgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiJDJgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:36:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B892058B50
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 02:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664875902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nTkCQ2u/hk2Qw23dtQU+Mt7xL3eUScwz3JvpzjfBuoU=;
        b=fnrWUWTdJD5t+a8j1FOHhyde3T7Ig+aLRD3Raj6duJhITawmC1PQszwsiK8ax0JM2ZvV46
        3MFpCfWmU3O4bT762ATECpUJzQvox7ULYzvhbK6VsEB+B+SJVn8cYutEFy53nrqzESJhul
        COYKnLgFG/+TgZA+AXfixbyru1KOOeQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-237-k9AG00p4OEqwo6WqU1VaVg-1; Tue, 04 Oct 2022 05:31:36 -0400
X-MC-Unique: k9AG00p4OEqwo6WqU1VaVg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C984862FE2;
        Tue,  4 Oct 2022 09:31:36 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA9F52166B26;
        Tue,  4 Oct 2022 09:31:34 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] Use TAP in some more KVM selftests
Date:   Tue,  4 Oct 2022 11:31:28 +0200
Message-Id: <20221004093131.40392-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many KVM selftests are completely silent. This has the disadvantage
for the users that they do not know what's going on here. For example,
some time ago, a tester asked me how to know whether a certain new
sub-test has been added to one of the s390x test binaries or not (which
he didn't compile on his own), which is hard to judge when there is no
output. So I finally went ahead and implemented TAP output in the
s390x-specific tests some months ago.

Now I wonder whether that could be a good strategy for the x86 and
generic tests, too? As a little RFC patch series, I've converted
three more KVM selftests to use TAP output. If we decide that this
is the right way to go, I can work on other tests later, too.

Thomas Huth (3):
  KVM: selftests: Use TAP interface in the kvm_binary_stats_test
  KVM: selftests: x86: Use TAP interface in the sync_regs test
  KVM: selftests: x86: Use TAP interface in the tsc_msrs_test

 .../selftests/kvm/kvm_binary_stats_test.c     |  11 +-
 .../selftests/kvm/x86_64/sync_regs_test.c     | 113 ++++++++++++++----
 .../selftests/kvm/x86_64/tsc_msrs_test.c      |  16 ++-
 3 files changed, 114 insertions(+), 26 deletions(-)

-- 
2.31.1

