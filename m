Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51E46383FE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 07:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiKYGcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 01:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKYGcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 01:32:53 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BEA27DF9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 22:32:52 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D2DD61FD6A;
        Fri, 25 Nov 2022 06:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669357970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=fZrAaP9FxcQcpFDkMAFfQgOSXJ+0iWC8i07BQBQ2SXo=;
        b=qAMYWpJANmBzfUWnws2e+o51bVKp5OfZVCLdN1sqq6oUe7plzRkRxFH7v1ti+YPOfKqDij
        DeqpeP5zWgrZ+zlIuvzVqn/rGFayVzBoQ8uHZB36Zy2RxspaDt63/0Ry37qukLJfQslZGt
        m/vD0GB7HhzRyhYNuyATnQ0xKCggbNQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6DC2B13A08;
        Fri, 25 Nov 2022 06:32:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fllnGZJhgGMicgAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 25 Nov 2022 06:32:50 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/2] x86/xen: don't return from xen_pv_play_dead()
Date:   Fri, 25 Nov 2022 07:32:46 +0100
Message-Id: <20221125063248.30256-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All play_dead() functions but xen_pv_play_dead() don't return to the
caller.

Adapt xen_pv_play_dead() to behave like the other play_dead() variants.

Juergen Gross (2):
  x86/xen: don't let xen_pv_play_dead() return
  x86/xen: mark xen_pv_play_dead() as __noreturn

 arch/x86/xen/smp.h      |  2 ++
 arch/x86/xen/smp_pv.c   | 17 ++++-------------
 arch/x86/xen/xen-head.S |  7 +++++++
 tools/objtool/check.c   |  1 +
 4 files changed, 14 insertions(+), 13 deletions(-)

-- 
2.35.3

