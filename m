Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848586CFD20
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjC3Hmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 03:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjC3Hmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:42:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80A94213;
        Thu, 30 Mar 2023 00:42:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 98CB121B00;
        Thu, 30 Mar 2023 07:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680162169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=dcdGBGxLxQLdtnHwDzVvtW66/+5pqTVU2RqRlNoXsE4=;
        b=HS5TVwF3MwExjn1RvabFUF3zDzV5HdDpiKPIHLnj3un+d7MqwJtYQ28vwgRAXUk3C16rw1
        j4x8fW18uk+W3tBOH2FCvfFRws5zLG+vlrWIoAQqNcPnTdw0r5MPer/F4yh7KprhSpG8Be
        hy5HgMGnRt/T5wCccKsv6qw1d8a2MnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680162169;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=dcdGBGxLxQLdtnHwDzVvtW66/+5pqTVU2RqRlNoXsE4=;
        b=BKcGeabqCKyWL1Lzx3puVPICoCpl9wBcoKhmNmhi3r85r3eJaEFvXNYDDph19/SoSxEn/r
        RgjtYTrnQvuhqoDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 702071348E;
        Thu, 30 Mar 2023 07:42:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CWjZGXk9JWQIfgAAMHmgww
        (envelope-from <aherrmann@suse.de>); Thu, 30 Mar 2023 07:42:49 +0000
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: [PATCH] perf bench numa: Fix for loop in do_work
Date:   Thu, 30 Mar 2023 09:42:02 +0200
Message-Id: <20230330074202.14052-1-aherrmann@suse.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

j is of type int and start/end are of type long. Thus j might become
negative and cause segfault in access_data(). Fix it by using long for
j as well.

Signed-off-by: Andreas Herrmann <aherrmann@suse.de>
---
 tools/perf/bench/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Example of segfault (with 6.3.0-rc4) is:

# ./perf bench numa mem -d -m -p 2 -t 12 -P 25425
...
 threads initialized in 6.052135 seconds.
 #
perf: bench/numa.c:1654: __bench_numa: Assertion `!(!(((wait_stat) & 0x7f) == 0))' failed.
Aborted (core dumped)
# dmesg | grep segfault
[78812.711311] thread 1/3[43215]: segfault at 7f07936c9ec0 ip 00000000004ab6d0 sp 00007f0acb1f9cb0 error 4
[78812.711309] thread 1/9[43221]: segfault at 7f08bda71a70 ip 00000000004ab6d0 sp 00007f0ac81f3cb0 error 4
[78812.711316] thread 1/4[43216]: segfault at 7f07ccf76a08 ip 00000000004ab6d0 sp 00007f0aca9f8cb0 error 4
[78812.711325] thread 1/2[43214]: segfault at 7f08be2f44b0 ip 00000000004ab6d0 sp 00007f0acb9facb0 error 4
[78812.711328] thread 1/8[43220]: segfault at 7f06d3096b20 ip 00000000004ab6d0 sp 00007f0ac89f4cb0 error 4
[78812.711345] thread 1/6[43218]: segfault at 7f0774b46a18 ip 00000000004ab6d0 sp 00007f0ac99f6cb0 error 4 in perf[400000+caa000] likely on CPU 6 (core 8, socket 0)
[78812.711366] thread 0/0[43224]: segfault at 7f08a936b130 ip 00000000004ab6d0 sp 00007f0acc9fccb0 error 4 in perf[400000+caa000] likely on CPU 1 (core 1, socket 0)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 9717c6c17433..1fbd7c947abc 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -847,7 +847,7 @@ static u64 do_work(u8 *__data, long bytes, int nr, int nr_max, int loop, u64 val
 
 	if (g->p.data_rand_walk) {
 		u32 lfsr = nr + loop + val;
-		int j;
+		long j;
 
 		for (i = 0; i < words/1024; i++) {
 			long start, end;
-- 
2.39.1

