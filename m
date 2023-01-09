Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9869D66268E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236950AbjAINJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbjAINJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:09:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20DBCD6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 05:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673269574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yuxtE6t14gy3tVXwdyxvVM0sGn8D53ZO/t0J8L72Fkc=;
        b=Hr12mDgeev+OIXWl/nsNUVd3N9hTNuLZCQyTPaRQZzet/7H1Ov6ty/U0q3HEAz7e1LU/Vu
        5p6ss/39iwmLJSgb5230BcjZMV2Y7M/VSbWq5aonbgugAxa/dQTmYPCD2CuaAkR8B6lo5+
        6VtqqFoY5L5spprxVDzNZMTLXv6bWyo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-6imM__lmOb2ZsDDmOZbzLw-1; Mon, 09 Jan 2023 08:06:09 -0500
X-MC-Unique: 6imM__lmOb2ZsDDmOZbzLw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C5471C02D36;
        Mon,  9 Jan 2023 13:06:09 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B9EC175AD;
        Mon,  9 Jan 2023 13:06:08 +0000 (UTC)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        Gautam Menghani <gautammenghani201@gmail.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Zeng Guang <guang.zeng@intel.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 0/2] xapic: make sure x2APIC -> xapic transition correctly
Date:   Mon,  9 Jan 2023 08:06:03 -0500
Message-Id: <20230109130605.2013555-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The root cause is kvm_lapic_set_base() failing to handle x2APIC -> xapic ID
switch, which is addressed by patch 1.
Patch 2 provides a selftest to verify this behavior.

This serie is an RFC because I think that commit ef40757743b47 already tries to
fix one such effect of the error made in kvm_lapic_set_base, but I am not sure
how such error described in the commit message is triggered, nor how to
reproduce it using a selftest. I don't think one can enable/disable x2APIC using
KVM_SET_LAPIC, and kvm_lapic_set_base() in kvm_apic_set_state() just takes care
of updating apic->base_address, since value == old_value.
The test in patch 2 fails with the fix in ef40757743b47.

Thank you,
Emanuele

Emanuele Giuseppe Esposito (2):
  KVM: x86: update APIC_ID also when disabling x2APIC in
    kvm_lapic_set_base
  KVM: selftests: APIC_ID must be correctly updated when disabling
    x2apic

 arch/x86/kvm/lapic.c                          |  8 ++-
 .../selftests/kvm/x86_64/xapic_state_test.c   | 64 +++++++++++++++++++
 2 files changed, 70 insertions(+), 2 deletions(-)

-- 
2.31.1

