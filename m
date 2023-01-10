Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C8D664E4F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjAJVw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjAJVwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:52:24 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5018D4435F
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:52:23 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id u2-20020a17090341c200b00192bc565119so9213691ple.16
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l82ntIFd7MfJAb7UiGfLmOAfwMt4TTGXS4HxL44y3uE=;
        b=Uz9zoI5PIuJEA3ZBY0NKTCrxWY1gEr3XrAkrjbc0mNIWWEKtyjhjkJbdAWwFHsA5mz
         42BBPxGHZOuY1lZXGJ8yo7K4veyW+s+7BDy00DwsX81abu/bJLJvQTyDLFNksvvnqHrY
         Ss0cd47ymETSaSkxU2VtFh/UunHB1akrwCg4KcTsRV+2KAcpx45/1Y45D5+bQX2Oi+Ew
         DDiPDHUQINNAXGRYONFlkS8VHXXSzrHUhusni7eGl2JPO9fpeGLmsKNNdgV/gDwacsWh
         LFXCZ0NI7yjO/A5Kbrs8iQUInwWmRt3pU/ufQNBFCS03eoIWa8DmPo6pKlGhZ4/5MxtT
         WA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l82ntIFd7MfJAb7UiGfLmOAfwMt4TTGXS4HxL44y3uE=;
        b=3NksegOAkK7+Qk68WKiTG08o9tWIl63bLXIuFrkp0SaHtLLpZoVGw9Ka/s8oc2iBwo
         1FRj9mak+xIo2CYZ43YLEAMx1oJQmeqWkcTo5rk69KYISDr9JmtYAwYO4MrqSCJVO9nQ
         u5Ul0GdN9cLuAWlnINaN7yV0pfsRst0Uw05i6jhjA/vVl2IWGQPY344NBAG+wKB7YBpt
         DOIPHl8hPIO1izbPUSvU2qY93Lt/6MWv3cIXrEIHlZK8ez0XvpRRRY6JxK3QEU788uVO
         FdzARIMQ2R79rzjv4k25OR2rA92+wUf2HadIZFHrf0M6VeL4NbPraePj/6d8JKWy1qLO
         r/qQ==
X-Gm-Message-State: AFqh2kpB39h2A7ZxWTZdZBTP2SCn9h44Wlp/JTf0XQQ2L61OjysaQzLj
        fKRx6i1m91aRrZdCHb56ZloaifO5mb9/
X-Google-Smtp-Source: AMrXdXstAIFHK82xxA5xKyMtQGZenpxd6q1WUBPtqRilf0ydCgzQse3nEmc5uf3aIs86K21xX17SjCa3bzB9
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:aa7:82cb:0:b0:578:3ec0:f264 with SMTP id
 f11-20020aa782cb000000b005783ec0f264mr5821763pfn.22.1673387542828; Tue, 10
 Jan 2023 13:52:22 -0800 (PST)
Date:   Tue, 10 Jan 2023 13:52:03 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230110215203.4144627-1-vipinsh@google.com>
Subject: [Patch] KVM: selftests: Make reclaim_period_ms input always be positive
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

reclaim_period_ms used to be positive only but the commit 0001725d0f9b
("KVM: selftests: Add atoi_positive() and atoi_non_negative() for input
validation") incorrectly changed it to non-negative validation.

Change validation to allow only positive input.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Reported-by: Ben Gardon <bgardon@google.com>
---
 tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
index ea0978f22db8..251794f83719 100644
--- a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
+++ b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
@@ -241,7 +241,7 @@ int main(int argc, char **argv)
 	while ((opt = getopt(argc, argv, "hp:t:r")) != -1) {
 		switch (opt) {
 		case 'p':
-			reclaim_period_ms = atoi_non_negative("Reclaim period", optarg);
+			reclaim_period_ms = atoi_positive("Reclaim period", optarg);
 			break;
 		case 't':
 			token = atoi_paranoid(optarg);
-- 
2.39.0.314.g84b9a713c41-goog

