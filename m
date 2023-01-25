Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647F967BA6F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 20:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236049AbjAYTLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 14:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235770AbjAYTLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 14:11:39 -0500
X-Greylist: delayed 1801 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Jan 2023 11:11:30 PST
Received: from cheetah.elm.relay.mailchannels.net (cheetah.elm.relay.mailchannels.net [23.83.212.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4111759E46
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 11:11:29 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 802BC142016
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 18:34:21 +0000 (UTC)
Received: from pdx1-sub0-mail-a306.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 1B034141741
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 18:34:21 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1674671661; a=rsa-sha256;
        cv=none;
        b=Lv6iqSh0vruuM6JWALSQp45x+nXLIgb1+GI8qcdkuX7HIpNAozI7ntKwHICnC+46fB1GaM
        Nbu90rIe/HtGoTBKwBF18dArGwIZ5znma/YPh6yncXhzh7DzrJ58ZULO56MoiCTR4Ys/ZB
        0QOJ9wk0wEFXKIJ8cnvp8NDQdwkPpKwWAtDWvB0tQDwrcCWSNBQDKxs8IYmFj3lH1G23U6
        lENnKwlqrHg9E2jnvQu/myHgxTjuD121SLESGxAaj0Yh2qtvywjVMPv7Y5nZVnev5Fdkf9
        +YlFb0eDfwrUQYE6dphQbvG0lld6DDe5MsyvS9jDG3NyqADye0mSV9/7/B0xyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1674671661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=LkeKleEDMVCNjKIW3DlOQ6z6V0h2UxZNTVRuJ7I3Uy8=;
        b=4NIIse/tdLklFLwuZPBj7a6Cm97zsCqivJP9Ltt+hs/a3smM8v/+7+yWGbCqyAjR3CAt/9
        CmWYnfCuhibrnsu57bi7y02boaN1s5eUDRFCWjq2jWE7ZWRAsdJxuvLImRXlXHfoitZqDQ
        0tKo8IVLdKVyDLxcUtiaFABygzOnnO4bInivNkN6gOmFzEIF81l7PBP7jwQuoyW0tr9WxR
        KGF9xJtrMUZgCVfV474fc/TwNUGFUEr/YdVHy5fCK3MUxcdReb90bsKugVOiQIaC9HSyAP
        D57pKaMGz2hMNMEMpbCavGNMIaxVyjjdfcsCi8TbN8VNSkzPweWbChx7XWCw8Q==
ARC-Authentication-Results: i=1;
        rspamd-65f5b7cf85-p88lq;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Cellar-Fearful: 19f0e2196ef9d892_1674671661345_1297264958
X-MC-Loop-Signature: 1674671661345:1215867327
X-MC-Ingress-Time: 1674671661345
Received: from pdx1-sub0-mail-a306.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.30.49 (trex/6.7.1);
        Wed, 25 Jan 2023 18:34:21 +0000
Received: from kmjvbox (c-76-102-200-71.hsd1.ca.comcast.net [76.102.200.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a306.dreamhost.com (Postfix) with ESMTPSA id 4P2CDD1nY6zK2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 10:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1674671660;
        bh=LkeKleEDMVCNjKIW3DlOQ6z6V0h2UxZNTVRuJ7I3Uy8=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=A8KtaZKkUDU0VW7aIb+A21v1hNAq7FyF4xiS1eKqVQk6vPU1pXyTxmJU9gWvgmZqx
         OjDqxyi79pRvB7gFUN/YSUa4QXEzipJyUuzJtWNxbeSWC+a9CeJku6mn2AxP7S8xU6
         C3EA/6ipl+na3DRKPqwSFTFHVdzkUQe9aiUjbYBE=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e00e2
        by kmjvbox (DragonFly Mail Agent v0.12);
        Wed, 25 Jan 2023 10:34:18 -0800
Date:   Wed, 25 Jan 2023 10:34:18 -0800
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        David Reaver <me@davidreaver.com>
Subject: [PATCH v2] perf/util: Symbol lookup with kcore can fail if multiple
 segments match stext
Message-ID: <20230125183418.GD1963@templeofstupid.com>
References: <20230124223531.GB1962@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124223531.GB1962@templeofstupid.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This problem was encountered on an arm64 system with a lot of memory.
Without kernel debug symbols installed, and with both kcore and kallsyms
available, perf managed to get confused and returned "unknown" for all
of the kernel symbols that it tried to look up.

On this system, stext fell within the vmalloc segment.  The kcore symbol
matching code tries to find the first segment that contains stext and
uses that to replace the segment generated from just the kallsyms
information.  In this case, however, there were two: a very large
vmalloc segment, and the text segment.  This caused perf to get confused
because multiple overlapping segments were inserted into the RB tree
that holds the discovered segments.  However, that alone wasn't
sufficient to cause the problem. Even when we could find the segment,
the offsets were adjusted in such a way that the newly generated symbols
didn't line up with the instruction addresses in the trace.  The most
obvious solution would be to consult which segment type is text from
kcore, but this information is not exposed to users.

Instead, select the smallest matching segment that contains stext
instead of the first matching segment.  This allows us to match the text
segment instead of vmalloc, if one is contained within the other.

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
---
v2:
  - Correct whitespace, add comments, and fix-up subject. (Feedback from Adrian
    Hunter)
---
 tools/perf/util/symbol.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a3a165ae933a..98014f937568 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1368,10 +1368,23 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 
 	/* Find the kernel map using the '_stext' symbol */
 	if (!kallsyms__get_function_start(kallsyms_filename, "_stext", &stext)) {
+		u64 replacement_size = 0;
+
 		list_for_each_entry(new_map, &md.maps, node) {
-			if (stext >= new_map->start && stext < new_map->end) {
+			u64 new_size = new_map->end - new_map->start;
+
+			if (!(stext >= new_map->start && stext < new_map->end))
+				continue;
+
+			/*
+			 * On some architectures, ARM64 for example, the kernel
+			 * text can get allocated inside of the vmalloc segment.
+			 * Select the smallest matching segment, in case stext
+			 * falls within more than one in the list.
+			 */
+			if (!replacement_map || new_size < replacement_size) {
 				replacement_map = new_map;
-				break;
+				replacement_size = new_size;
 			}
 		}
 	}
-- 
2.25.1

