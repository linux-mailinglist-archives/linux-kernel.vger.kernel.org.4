Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D66632857
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiKUPfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiKUPfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:35:50 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9683D1C5;
        Mon, 21 Nov 2022 07:35:49 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 578811F8B9;
        Mon, 21 Nov 2022 15:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669044948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=6ocNcGwK/Y2iSIdEXIO9ZkjGW+WA1lMnkjU9VzpIMFk=;
        b=mQxG+3LGmo8DdhwECAPDk+YaRdfEwU2+AKKh79zgjdJM6XHidRrZX9CRAfDbLFrNTsvWAz
        yVt2U720jZQld9Lc7BohomLBnx05O92QSyCv6jD7W41S9p4eTAfGXZxGoSyLZ7CXH6Frg2
        9erxvtLJ+jCjM5I/2KAGwcuyYfCguB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669044948;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=6ocNcGwK/Y2iSIdEXIO9ZkjGW+WA1lMnkjU9VzpIMFk=;
        b=jKQQkVwi8uG07D5plRTSG99r5sDVWfTWforxomfh/a1BPkYwxS5lDymAqbBWrW6H2HzR/L
        DvnQQY9RrwjsUQAA==
Received: from linux-ni6k.suse.de (unknown [10.163.29.78])
        by relay2.suse.de (Postfix) with ESMTP id 1805B2C143;
        Mon, 21 Nov 2022 15:35:48 +0000 (UTC)
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH] cpufreq: intel_pstate: Add Sapphire Rapids support in no-HWP mode
Date:   Mon, 21 Nov 2022 16:35:40 +0100
Message-Id: <20221121153540.10494-1-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.31.1
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

Users may disable HWP in firmware, in which case intel_pstate wouldn't load
unless the CPU model is explicitly supported.

See also the following past commits:

commit d8de7a44e11f ("cpufreq: intel_pstate: Add Skylake servers support")
commit 706c5328851d ("cpufreq: intel_pstate: Add Cometlake support in
no-HWP mode")
commit fbdc21e9b038 ("cpufreq: intel_pstate: Add Icelake servers support in
no-HWP mode")
commit 71bb5c82aaae ("cpufreq: intel_pstate: Add Tigerlake support in
no-HWP mode")

Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
---
 drivers/cpufreq/intel_pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 6ff73c30769f..181cd6b045ff 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2378,6 +2378,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 	X86_MATCH(COMETLAKE,		core_funcs),
 	X86_MATCH(ICELAKE_X,		core_funcs),
 	X86_MATCH(TIGERLAKE,		core_funcs),
+	X86_MATCH(SAPPHIRERAPIDS_X,	core_funcs),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
-- 
2.31.1

