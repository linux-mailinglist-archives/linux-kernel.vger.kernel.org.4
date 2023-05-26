Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6752712CD0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242910AbjEZSt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjEZSt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:49:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359AAAD
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:49:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEE2060FB1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 18:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E42C433D2;
        Fri, 26 May 2023 18:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685126965;
        bh=tkpHxCySJ3FJBX5kaoTY+4iXxZ0QxSXXGTPhb5xqyh4=;
        h=Date:From:To:Cc:Subject:From;
        b=Sfn85BE4oBFWa9dRoooLwSG4syrrhrPf/PLeE6sq56DDXpxOPDH7lCkuNxofxx297
         Krn9/7zwMTpwyRcterSwfo4huf7iNkaXRJ+Eyu5Ijb1OOGDJ2aoWEcXfNLLO2am1S/
         +DTAUm5lYwb3c1tEagg/QzX4VD/S8PRqrIg9+Pr+M4n7LSeSpkcBIJ88/qO/R4bOxT
         c4d+LUJdI/9+dgEA4Nkd5WzwXB8xUe0bsFgNceqd8k5sYeVTJDhTmPRK8saNo92E05
         g0nIfikvgTLvu1LbybcDNR8xKRP6F95/RtSStePDH+ErYwzD/EpSjVkRBHPjbbeNN7
         YBClZxpR+isvA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 48010403B5; Fri, 26 May 2023 15:49:22 -0300 (-03)
Date:   Fri, 26 May 2023 15:49:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 1/1 fyi] tools headers UAPI: Sync the linux/in.h with the
 kernel sources
Message-ID: <ZHD/Ms0DMq7viaq+@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Picking the changes from:

  3632679d9e4f879f ("ipv{4,6}/raw: fix output xfrm lookup wrt protocol")

That includes a define (IP_PROTOCOL) that isn't being used in generating
any id -> string table used by 'perf trace'.

Addresses this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/in.h' differs from latest version at 'include/uapi/linux/in.h'
  diff -u tools/include/uapi/linux/in.h include/uapi/linux/in.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/in.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/linux/in.h b/tools/include/uapi/linux/in.h
index 4b7f2df66b995ba8..e682ab628dfa66bc 100644
--- a/tools/include/uapi/linux/in.h
+++ b/tools/include/uapi/linux/in.h
@@ -163,6 +163,7 @@ struct in_addr {
 #define IP_MULTICAST_ALL		49
 #define IP_UNICAST_IF			50
 #define IP_LOCAL_PORT_RANGE		51
+#define IP_PROTOCOL			52
 
 #define MCAST_EXCLUDE	0
 #define MCAST_INCLUDE	1
-- 
2.37.1

