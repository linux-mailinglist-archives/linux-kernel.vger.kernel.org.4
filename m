Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FC8728554
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbjFHQjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236044AbjFHQj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:39:27 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC89359A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:38:56 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30aebe2602fso622775f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 09:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686242333; x=1688834333;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uw4JCOlggtaSPwBTDTjp07y/EtwINur5skPlUaghmwA=;
        b=7f/9tOEXwXQllKsibzf7pBBpDrRxyepaLdPYMWKrNI+nUAC2S2heOkLiE8b1golsfi
         /3y5yT7tEVpuby2LSMdNeK3M5Ok4gYfW2vUkCBjUSYPvID/C0RulqBL7klbMCSR0QV+F
         DrqKWN58R/d15SS9BKYpOIy/j/Gasaz6ggF3tSetbdtqzO0zSIibgMuhjmFjsLMjUj7M
         oJC2TKJTGHagvhcmx4lujd7M1yDR3zstbvHi54nqFMcMzyxbYNy72WbAlCHUOu5kgIch
         NlD699UAwPFamOenwsp1Dsv7Nv/oHI/sZRl1I9BRe0TwvLbUnPuV9rhFqtp4Bvv+yXIo
         47cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686242333; x=1688834333;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uw4JCOlggtaSPwBTDTjp07y/EtwINur5skPlUaghmwA=;
        b=LDNBAdU6OZeclVVAuG/M8iJPiG0P89Zs9Ug2q2c/9UPa2gqdBifx1GVh9EKFVpW0T6
         zdpjyJjRjdJjAXVZbiFGYOtq6nOeJ/lHcq3zOf3RlaOJuTfirgcXXR4wIO5fcPg0A1kF
         n3kM640JPxWUxJLuG5aWXDhQPYAOirc+bMsKVCmemnJcuvEsSMvz0fb9mz2qSS71jkKS
         MJvkHql/qbItmkJS5Ws0AQ1aChhPQD3DluhU016fmXOb/pzgl1dFvA1uCzIVCM+dPRl1
         oAk9f9DVfeVdxjN1ikOvLdiHWq1jtaDcDllrCoy492bTU1bJ3HM4NR6sO3BCAqEYqpKh
         NC3g==
X-Gm-Message-State: AC+VfDzSM1yQ5ki2kTsG0mOqnQ7/T+1cAbGaXC1nam6DubIa0zNCQ4LJ
        wsBK3tBMrXiC8HTDIL5n+8Qp+g==
X-Google-Smtp-Source: ACHHUZ5v1EQxmdq5Wru7kw4Z39LM+198M8ioOAVIaKEJnfkNxZ86ROj4YT9I982x0uPwVAA+mFTVSw==
X-Received: by 2002:a5d:4538:0:b0:306:368d:8a1c with SMTP id j24-20020a5d4538000000b00306368d8a1cmr6731624wra.45.1686242333282;
        Thu, 08 Jun 2023 09:38:53 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id e13-20020adfef0d000000b0030aeb3731d0sm2038215wro.98.2023.06.08.09.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:38:52 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Thu, 08 Jun 2023 18:38:43 +0200
Subject: [PATCH net 01/14] selftests: mptcp: lib: skip if missing symbol
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230608-upstream-net-20230608-mptcp-selftests-support-old-kernels-part-2-v1-1-20997a6fd841@tessares.net>
References: <20230608-upstream-net-20230608-mptcp-selftests-support-old-kernels-part-2-v1-0-20997a6fd841@tessares.net>
In-Reply-To: <20230608-upstream-net-20230608-mptcp-selftests-support-old-kernels-part-2-v1-0-20997a6fd841@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Davide Caratti <dcaratti@redhat.com>,
        Dmytro Shytyi <dmytro@shytyi.net>,
        Menglong Dong <imagedong@tencent.com>,
        Geliang Tang <geliang.tang@suse.com>,
        Kishen Maloor <kishen.maloor@intel.com>
Cc:     Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2475;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=d9kMX7C5QhFsCiyZaTdMhXR8W0fg17bpTpuLqXSu/Go=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkggQZth7JIHgU9JOMhTUTPn5Xm/sA0h+5GLjjs
 zo69zq3rb6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZIIEGQAKCRD2t4JPQmmg
 c9g4EADCNFnAktQKkp9vmKC6KoWHc9kkDX8zDn8jFhjyHrn2BcXD6RHrl4cTuG2SJABsK1sKMOw
 Q60U3F6cScwWpZs1v9bUKs7hdT8oACQSdepJ7ZS3DWS2aZhXk+lsbLfgIbO5ZKngjvHjTMK4tAs
 /GALvC1gYpPIJ9HYSpH3tDD6XcSJo42uR/n/2QaR7q0vTvX+gL/wJocZM2XZfpt9iNO3DCdJ9s5
 nL8uGTybl/zZ0kRLTXtn7h0JTEvhF4QSzWH66aLBEi7V9uxclPliIVJwBrFSGbC5RfzAjRKbdmP
 BPz61HpXNXhC46U9RjaJGr+0oFGalFM7BkLUrwb93LiznEhKGe4ICNwjcQa1GcMbVf9BW5wb0MN
 PQFJeMqWtl8XQr7KeF8mhdE8kjbuoCDaDowKvgaDMTfqa1aLioN8Sp5ASWH/RihWKHQEXzt/OP8
 veqC6Lsalwg6IeABME8tTQMaFd5gEDxVGSd+tOeUA4WyBPu+RbcptFxvROCf7qOms4/EXhglVTt
 LkuLVIdW4bJBKxBjACTSmFvDJFSpJ6RsnDtGxr0EEUFuIKTC5O1htzbrCsPkyvrw6ToiGEuojUU
 KEO7TsFSuYcmZ5OBFzlNqsi72+bKOZS/aGaXHK2OuFYkOXNnJaE4DFg2zRypcRoHYnlbAUUNux1
 rMP5xwNib7xhs3g==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

New functions are now available to easily detect if a certain feature is
missing by looking at kallsyms.

These new helpers are going to be used in the following commits. In
order to ease the backport of such future patches, it would be good if
this patch is backported up to the introduction of MPTCP selftests,
hence the Fixes tag below: this type of check was supposed to be done
from the beginning.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/config       |  1 +
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 38 ++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 38021a0dd527..6032f9b23c4c 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -1,3 +1,4 @@
+CONFIG_KALLSYMS=y
 CONFIG_MPTCP=y
 CONFIG_IPV6=y
 CONFIG_MPTCP_IPV6=y
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 3286536b79d5..29b65f4b73b2 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -38,3 +38,41 @@ mptcp_lib_check_mptcp() {
 		exit ${KSFT_SKIP}
 	fi
 }
+
+mptcp_lib_check_kallsyms() {
+	if ! mptcp_lib_has_file "/proc/kallsyms"; then
+		echo "SKIP: CONFIG_KALLSYMS is missing"
+		exit ${KSFT_SKIP}
+	fi
+}
+
+# Internal: use mptcp_lib_kallsyms_has() instead
+__mptcp_lib_kallsyms_has() {
+	local sym="${1}"
+
+	mptcp_lib_check_kallsyms
+
+	grep -q " ${sym}" /proc/kallsyms
+}
+
+# $1: part of a symbol to look at, add '$' at the end for full name
+mptcp_lib_kallsyms_has() {
+	local sym="${1}"
+
+	if __mptcp_lib_kallsyms_has "${sym}"; then
+		return 0
+	fi
+
+	mptcp_lib_fail_if_expected_feature "${sym} symbol not found"
+}
+
+# $1: part of a symbol to look at, add '$' at the end for full name
+mptcp_lib_kallsyms_doesnt_have() {
+	local sym="${1}"
+
+	if ! __mptcp_lib_kallsyms_has "${sym}"; then
+		return 0
+	fi
+
+	mptcp_lib_fail_if_expected_feature "${sym} symbol has been found"
+}

-- 
2.40.1

