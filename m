Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE36A73DACC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjFZJGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjFZJGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:06:30 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5444209
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 02:03:42 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f973035d60so3555839e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 02:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687770220; x=1690362220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBtvdyg3zPGmDTEDFgfwW8EkoCJT54ipAPsex1tB6pY=;
        b=Ch01q1nycQLv4qbgUZej9DL+CNVp2IBIcH15X/TZFlb7e+L8+LJxswcHRRqU3wiHZC
         auVFwf4j0Us7fJA7XVFSC3sOEdbJWObR7/mF63Qcn4xWnMfzZJK9gtkGvPWvDz6yogGL
         u/vd87asULKVevsgUzq0tPHtOkIlOX5Fjy2kIDZaWDOs0m7OVioRGMTacF0g/sGjs/L2
         XgM13Iakqa0Hcnh/IVjWsOy1dCJCBPs6K4IFjP6catJ9m5BCVI0kax5CVcAvLcJumHPY
         9GWlBXIWFpVtdJWE16W5TzfpJFEQKSSLZszykHNtrY62kcYtoX+JMzjNYVRX8a+Ew6Zk
         k1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687770220; x=1690362220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBtvdyg3zPGmDTEDFgfwW8EkoCJT54ipAPsex1tB6pY=;
        b=XVbBBC2I85IYvLyWlefMdyhnhyEDrHbRsMCs9cjQfT7V/7Sy8LU3m6mFg595T64mCf
         RWFYxvoz2wHL1JNgKkyNzYLahq9heoakKAYNLiV9xItu96ZuegaTgUvKTtM5TsQmGfCb
         to0UMzPbd/rYmevAwyVCe2hcbJiud7WRlcA9wdrNbgMbEuob/H7yPDmcVbGDlEUskK+n
         63ylYuk45Et9cgSqrfYosGMJMuE7r6zOnVzeRt/2K2vFxDOy9RDBudzQSitxjYt0Vatb
         oFeCyE7t03PiydhEswUJBYOWoQMX6hMGoC4Ly8TrWGJWeFxiUajylZxTMg4t3fIeD+Ij
         FDyg==
X-Gm-Message-State: AC+VfDynEhYln7yeXv5oLQRVVh/9w6NdjsNtz4sKpXFDAckfSL9IN9bA
        osLzQTVVs91/N1NW7HqV9lL4rQ==
X-Google-Smtp-Source: ACHHUZ5w0hp4mnWZXJ8kfFD2rbwHISXlWAk8s9fce2zv3Gv/aCxy6IeBh13DWs26De5D+rjokJ2msg==
X-Received: by 2002:a19:4353:0:b0:4f9:586b:dba6 with SMTP id m19-20020a194353000000b004f9586bdba6mr8099792lfj.10.1687770220302;
        Mon, 26 Jun 2023 02:03:40 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id u19-20020a4ad0d3000000b0054fe8b73314sm631887oor.22.2023.06.26.02.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 02:03:39 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     dhowells@redhat.com
Cc:     acme@kernel.org, adrian.hunter@intel.com,
        alexander.shishkin@linux.intel.com, bpf@vger.kernel.org,
        davem@davemloft.net, irogers@google.com, jolsa@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        netdev@vger.kernel.org, peterz@infradead.org, sfr@canb.auug.org.au,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH net-next] perf trace: fix MSG_SPLICE_PAGES build error
Date:   Mon, 26 Jun 2023 11:02:39 +0200
Message-Id: <20230626090239.899672-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2947430.1687765706@warthog.procyon.org.uk>
References: <2947430.1687765706@warthog.procyon.org.uk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2321; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=sxG8xrhdK31/co0Ub/5kGgaE5z4tmRlqcKfVFKr3vdg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkmVQvPws0wIwv8RrKWRoYg8xng7wy3W2AYbR3U
 Dg5nRJiEmSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJlULwAKCRD2t4JPQmmg
 c4Y3D/4pt5+NOQTMEBuLpy0Qs1pmmByxefhcjQqCzSLmUzbXXs1eoijTEp9MEOcp0G4dkiktEmn
 xwITEZDORpziIlAktNX3B/f30qVyONF06Y7+pfGoYbReuL5heqzqWeI0Zv/oOtpP0cgI5dTQiUM
 yKzQ41AIFbNK51cQFwxJuEDwlwblDEmGAR2985PtwOsiJ5PKQT4ESCxEz6EpKU12wL0eSlJBSZj
 2rrb/+yGn5BOAEREd3Gnp8418+f+TTR/HMcpUEUsEb/+pfnKRI5FO1rRAuSoWK8calMXHHE5Ji2
 HhTUQsDdUqzZOGFvbm+JroUh0vihUnZNKm56RlZcieBm8xXJqs31kngBGzt/yqzau4p0Z6xZy3b
 0DWPt/1l5JTKMIHymZBiSy5/GLhSk4AB2Y4n+skUSi7rJOda1g3QzkuAti+0E2Bi+9K7AkCiY2A
 icsVVgH8u9e9bv2SQDfmIli2HaM6bVp0J2FNAeREQP/zuy/OWDl9ezgQJDxHFC/5eGOXcovFVJL
 SbGDNlbDqYYZarMGWLi7Gjh18W8fS3WKmdGIBfB1skxrwm1orlpx9adAdLcFr6TQVqsl71xeab2
 u2KH28JxLSkPD7Zy9SNVKyJG9AQpPcICghi5tbOaWYpViXcDT+90hy+2EYei9NRXt2j28YUOus8 BzeysYSKbjZCKIg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our MPTCP CI and Stephen got this error:

    In file included from builtin-trace.c:907:
    trace/beauty/msg_flags.c: In function 'syscall_arg__scnprintf_msg_flags':
    trace/beauty/msg_flags.c:28:21: error: 'MSG_SPLICE_PAGES' undeclared (first use in this function)
       28 |         if (flags & MSG_##n) {           |                     ^~~~
    trace/beauty/msg_flags.c:50:9: note: in expansion of macro 'P_MSG_FLAG'
       50 |         P_MSG_FLAG(SPLICE_PAGES);
          |         ^~~~~~~~~~
    trace/beauty/msg_flags.c:28:21: note: each undeclared identifier is reported only once for each function it appears in
       28 |         if (flags & MSG_##n) {           |                     ^~~~
    trace/beauty/msg_flags.c:50:9: note: in expansion of macro 'P_MSG_FLAG'
       50 |         P_MSG_FLAG(SPLICE_PAGES);
          |         ^~~~~~~~~~

The fix is similar to what was done with MSG_FASTOPEN: the new macro is
defined if it is not defined in the system headers.

Fixes: b848b26c6672 ("net: Kill MSG_SENDPAGE_NOTLAST")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/r/20230626112847.2ef3d422@canb.auug.org.au/
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    @David: I solved it like that in MPTCP tree. Does it work for you too?

    I guess tools/perf/trace/beauty/include/linux/socket.h file still needs
    to be updated, not just to add MSG_SPLICE_PAGES but also other
    modifications done in this file. Maybe best to sync with Arnaldo because
    he might do it soon during the coming merge window I guess.

Cc: David Howells <dhowells@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>

 tools/perf/trace/beauty/msg_flags.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/trace/beauty/msg_flags.c b/tools/perf/trace/beauty/msg_flags.c
index 5cdebd7ece7e..aa9934020232 100644
--- a/tools/perf/trace/beauty/msg_flags.c
+++ b/tools/perf/trace/beauty/msg_flags.c
@@ -8,6 +8,9 @@
 #ifndef MSG_WAITFORONE
 #define MSG_WAITFORONE		   0x10000
 #endif
+#ifndef MSG_SPLICE_PAGES
+#define MSG_SPLICE_PAGES	0x8000000
+#endif
 #ifndef MSG_FASTOPEN
 #define MSG_FASTOPEN		0x20000000
 #endif

base-commit: 9ae440b8fdd6772b6c007fa3d3766530a09c9045
-- 
2.40.1

