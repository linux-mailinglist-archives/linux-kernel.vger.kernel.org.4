Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC8F60D075
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbiJYPYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbiJYPYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:24:00 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A95F8981E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:22:05 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-13b103a3e5dso15995533fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ctYQV4GxDN3REGC5Ngr89qvWAy02hVp5badprvw3WCQ=;
        b=mSQF/N9y2bXCI2cFsPTQ2tvdTQgio88yRqSzfeG3jVdts8YZHTKnCnhNB8c+i1XsBH
         VIu6Jl7VeNlSaITQKqwCw6W3UK31VubatllDFBlCLM8Az3kR4QyQ7KGjeR6AYo/hYVJx
         XhNNv/xk/4qaGFyHCvAcAySpvpyn5GcX4IvSu4b00QMXZY4u1776kU/sg9//Q0DZl1RN
         LSsqudIXjLRQYcpidAOqKJZjE8uUzOtE25umOFEsx76r8qmT712XW2ttpSmF+SFmxnjp
         RFN/SJ6eOGNUST+bnxvPVb2nJ+aFervp2wNoCF7W85kWDM996IyPA7DkmNtlIVAlnBpt
         MeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ctYQV4GxDN3REGC5Ngr89qvWAy02hVp5badprvw3WCQ=;
        b=U3+5dGFfaxjDfgaueict5iqlGvkPVfv8IF9OVoKqFCjNwCgOFyyrii9eViwOeSx1j/
         YnNwb3vQuoQ6DIF7mpfJbyXzFZtSHFo4zoVKDW0qWkomhm/TZAYuSyCl4pt61moveI9S
         IEDUCVtr3opCFR51II8HzIpoUQvs/kRiozKj36FSkJhNAx7SgLEJS6l9VDkIggdZgNMi
         NmzBKfch4rJs0YXlcg9nXV0VDH6ma+fpk2kW0cgLid5jjKSbFTQprqRIJaOgDycFRLYI
         yEFRQSwzm/DitJncYDEno298jPV/ccKQKLAJ9L9kq1LsdkoJD2XPFKCAOMcvDdvunF9E
         ECug==
X-Gm-Message-State: ACrzQf0/YMSNLM8nERCFGD9hYHAv+1KOqN6JgVgVFFkhLlnAGGIUhzTt
        hQoj2UBfLLiX8QWwP0mULgY=
X-Google-Smtp-Source: AMsMyM4aKW0CDfLbQiqBQV3T348HiQLRQFJKr8AlwvkNDFfbN+VpzSEwElVmbQsrHaP37VHukNj9Qg==
X-Received: by 2002:a05:6870:438d:b0:13b:aeb6:d119 with SMTP id r13-20020a056870438d00b0013baeb6d119mr6214274oah.142.1666711324558;
        Tue, 25 Oct 2022 08:22:04 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id g4-20020a4ab044000000b0044b0465bd07sm1207767oon.20.2022.10.25.08.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 08:22:04 -0700 (PDT)
From:   arnaldo.melo@gmail.com
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 98CC3404BE; Tue, 25 Oct 2022 12:22:01 -0300 (-03)
Date:   Tue, 25 Oct 2022 12:22:01 -0300
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH FYI 1/1] tools headers uapi: Update linux/in.h copy
Message-ID: <Y1f/Ge6vjQrGjYiK@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
  	[0] = "NORMAL",
  	[1] = "RANDOM",
  	[2] = "SEQUENTIAL",
  	[3] = "WILLNEED",
  	[4] = "DONTNEED",
  	[5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

---

To get the changes in:

  65b32f801bfbc54d ("uapi: move IPPROTO_L2TP to in.h")
  5854a09b49574da5 ("net/ipv4: Use __DECLARE_FLEX_ARRAY() helper")

That ends up automatically adding the new IPPROTO_L2TP to the socket
args beautifiers:

  $ tools/perf/trace/beauty/socket.sh > before
  $ cp include/uapi/linux/in.h tools/include/uapi/linux/in.h
  $ tools/perf/trace/beauty/socket.sh > after
  $ diff -u before after
  --- before	2022-10-25 12:17:02.577892416 -0300
  +++ after	2022-10-25 12:17:10.806113033 -0300
  @@ -20,6 +20,7 @@
   	[98] = "ENCAP",
   	[103] = "PIM",
   	[108] = "COMP",
  +	[115] = "L2TP",
   	[132] = "SCTP",
   	[136] = "UDPLITE",
   	[137] = "MPLS",
  $

Now 'perf trace' will decode that 115 into "L2TP" and it will also be
possible to use it in tracepoint filter expressions.

Addresses this tools/perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/in.h' differs from latest version at 'include/uapi/linux/in.h'
  diff -u tools/include/uapi/linux/in.h include/uapi/linux/in.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/in.h | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/tools/include/uapi/linux/in.h b/tools/include/uapi/linux/in.h
index 14168225cecdc74c..f243ce665f74f82d 100644
--- a/tools/include/uapi/linux/in.h
+++ b/tools/include/uapi/linux/in.h
@@ -68,6 +68,8 @@ enum {
 #define IPPROTO_PIM		IPPROTO_PIM
   IPPROTO_COMP = 108,		/* Compression Header Protocol		*/
 #define IPPROTO_COMP		IPPROTO_COMP
+  IPPROTO_L2TP = 115,		/* Layer 2 Tunnelling Protocol		*/
+#define IPPROTO_L2TP		IPPROTO_L2TP
   IPPROTO_SCTP = 132,		/* Stream Control Transport Protocol	*/
 #define IPPROTO_SCTP		IPPROTO_SCTP
   IPPROTO_UDPLITE = 136,	/* UDP-Lite (RFC 3828)			*/
@@ -188,21 +190,13 @@ struct ip_mreq_source {
 };
 
 struct ip_msfilter {
+	__be32		imsf_multiaddr;
+	__be32		imsf_interface;
+	__u32		imsf_fmode;
+	__u32		imsf_numsrc;
 	union {
-		struct {
-			__be32		imsf_multiaddr_aux;
-			__be32		imsf_interface_aux;
-			__u32		imsf_fmode_aux;
-			__u32		imsf_numsrc_aux;
-			__be32		imsf_slist[1];
-		};
-		struct {
-			__be32		imsf_multiaddr;
-			__be32		imsf_interface;
-			__u32		imsf_fmode;
-			__u32		imsf_numsrc;
-			__be32		imsf_slist_flex[];
-		};
+		__be32		imsf_slist[1];
+		__DECLARE_FLEX_ARRAY(__be32, imsf_slist_flex);
 	};
 };
 
-- 
2.37.3

