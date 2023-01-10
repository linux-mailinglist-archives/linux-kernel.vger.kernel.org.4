Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C526664BD2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239153AbjAJS7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239790AbjAJS6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:58:38 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9346418
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:58:33 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id d8-20020a17090a7bc800b00226eb4523ceso4564924pjl.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=krYhVfxFdN/OVvO7sdngJN4LpQA8BhAq8fwbwKihSS8=;
        b=O9ItegwgqSdf9S3Iv63GEthUTZhP5FUZI+MT3lb+9NWKW9t6zk8D2GR+Cw5akBAGQx
         /iHGnhJSx/SKzNfYYeiI3TfWQN2bkIq7eqi/iYr/knX0VFHF9648QoLTNUACE+bfgFc8
         YDKwXVbgjfk4keBM+zPZNwelyFjLMIgSTaA/Hlqkd2/+anDe3rtHSfwuGTdVBvpKMijM
         2quqNB4PIlkQwBod0JYV9epuLONJF1sCYy6qu4OqOYlggpormasntRD18lHTetmoqV9+
         XYORoo+Jswq68VuPP6dko7VH8zHAPO7ZMEKNZVC+L4L9yctXVw0UP2ucoeMPbmZ1f+he
         r+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=krYhVfxFdN/OVvO7sdngJN4LpQA8BhAq8fwbwKihSS8=;
        b=YUW8NXxsqlioCO/z5eOAnRW4EkZhMXwTzdlluK4fxa3AsmYp45c6c9hrujdi/xcznG
         tLFiDPktnpfsaRjZYqLP6YmCVtUqCyWFTplVA4i33wVy+9mX5y5hiW9L5jCio75zpuqN
         GkFZrVilcUnnRIF5yHo1fFIRfBBjEffQgeaHURG/69uZqYOjfw1juP+0AhlnXFo0mkvT
         CinMMWu4Pxc08chLkbAJbOCIQ8Uch+y2+s/75iHFpL/4rgZq3pThiANcTjBCqfmCUAlP
         qGrF2OftG6kJpRtxW5W5Kiadxkpvke0lg6rRMWBskFTYzICuK3Z2aYRZPqpxccDfsm0R
         9Nlg==
X-Gm-Message-State: AFqh2kpd9JPMA2IXD+nzX0uetmIWtj0l8NxwjdHCY3DRa43mZjbDdUaN
        pZ9LAZJsU2TG/6I9uSdiocA55wbjkqq+
X-Google-Smtp-Source: AMrXdXvCjmCa9O6/KeGFFD7GjOdnGSnZJ5JG8mXWNWnm2F7cqhMSqGBK4M+3Ys4LYImgNL219OzEklN6VRe5
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a62:6487:0:b0:587:ca14:26ae with SMTP id
 y129-20020a626487000000b00587ca1426aemr977638pfb.71.1673377113465; Tue, 10
 Jan 2023 10:58:33 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Tue, 10 Jan 2023 18:58:23 +0000
In-Reply-To: <20230110185823.1856951-1-mizhang@google.com>
Mime-Version: 1.0
References: <20230110185823.1856951-1-mizhang@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230110185823.1856951-5-mizhang@google.com>
Subject: [PATCH 4/4] KVM: selftests: x86: Repeat the checking of xheader when
 IA32_XFD[18] is set in amx_test
From:   Mingwei Zhang <mizhang@google.com>
To:     kvm@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Repeat the checking of AMX component in xheader after xsavec when
IA32_XFD[18] is set. This check calibrates the functionality scope of
IA32_XFD: it does not intercept the XSAVE state management. Regardless of
the values in IA32_XFD, AMX component state will still be managed by XSAVE*
and XRSTOR* as long as XCR[18:17] are set.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 tools/testing/selftests/kvm/x86_64/amx_test.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
index 18203e399e9d..9a80a59b64e6 100644
--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
@@ -235,6 +235,16 @@ static void __attribute__((__flatten__)) guest_code(struct tile_config *amx_cfg,
 
 	/* xfd=0x40000, disable amx tiledata */
 	wrmsr(MSR_IA32_XFD, XFEATURE_MASK_XTILEDATA);
+
+	/*
+	 * Bit 18 is cleared in XSTATE_BV but set in XCOMP_BV, this property
+	 * remains the same even when IA32_XFD disables amx tiledata.
+	 */
+	set_xstatebv(xsave_data, XFEATURE_MASK_XTILEDATA);
+	__xsavec(xsave_data, XFEATURE_MASK_XTILEDATA);
+	GUEST_ASSERT((get_xstatebv(xsave_data) & XFEATURE_MASK_XTILEDATA) == 0);
+	GUEST_ASSERT((get_xcompbv(xsave_data) & XFEATURE_MASK_XTILEDATA) == XFEATURE_MASK_XTILEDATA);
+
 	GUEST_SYNC(6);
 	GUEST_ASSERT(rdmsr(MSR_IA32_XFD) == XFEATURE_MASK_XTILEDATA);
 	set_tilecfg(amx_cfg);
-- 
2.39.0.314.g84b9a713c41-goog

