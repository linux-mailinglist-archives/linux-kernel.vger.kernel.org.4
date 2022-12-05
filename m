Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E4264240E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbiLEIFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiLEIEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:04:41 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3C315A0E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 00:04:37 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 59CAA1FE3B;
        Mon,  5 Dec 2022 08:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670227476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Nh84MA+lVhZ7z9Z8LG77iUxFcSy159whvB1ZvGTu3GY=;
        b=Jx65H9wZh1k4AML23zrMZNqCXD99qyoaPitPkLev5jn9+WS6X8ubfhm3p56JkvoRzxovLV
        t3Fv9zXYw5nWD27k+xs2axBffuAsOBidg8IWg1cXH/Usnt9OjSJe1MGK6qCmDXQIb4WNh/
        7LIDU79nFZsgKJsuu+hVhATys5TxkJk=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id F21A61348F;
        Mon,  5 Dec 2022 08:04:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id H/y5OROmjWM4NAAAGKfGzw
        (envelope-from <jgross@suse.com>); Mon, 05 Dec 2022 08:04:35 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     kirill@shutemov.name, Juergen Gross <jgross@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 0/2] x86: fixes for MTRR/PAT decoupling
Date:   Mon,  5 Dec 2022 09:04:31 +0100
Message-Id: <20221205080433.16643-1-jgross@suse.com>
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

Two small fixes for the decoupling of MTRR and PAT.

Juergen Gross (2):
  x86/pat: fix TDX guest PAT initialization
  x86/mtrr: make message for disabled MTRRs more descriptive

 arch/x86/kernel/cpu/mtrr/mtrr.c | 4 +++-
 arch/x86/mm/pat/memtype.c       | 6 +++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.35.3

