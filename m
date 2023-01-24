Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5F5679421
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 10:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbjAXJ0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 04:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbjAXJ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 04:26:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645BE44AF;
        Tue, 24 Jan 2023 01:26:38 -0800 (PST)
Date:   Tue, 24 Jan 2023 09:26:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674552396;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ffzPjEy2sw3F+U9zZT0NkTE5wNW5Hk1FQglbUV6Arfs=;
        b=gKd+k0xJy4PgcJbVPXbeoA9ikZeli/pjtGJPtQ/3QoBVIy6QrFwLhkNANkHL38akXzblHo
        aVZvzaPSiEvdR+ij9RmTe/9+OPN26zWmzDHC4eCM0/LM5FllluJ3KJuHnD66ozxLB0CvcI
        afidoP/M0d1tNWIU0lXb3WjLrRS8ArzYh8FbafBsxcGO2iy5Gw3G1oW65Pknp5caw8N4sj
        7ROHTSb13+qh69FfgZAEngoQQRA3av3NirGfp2Ey/bqG1uzN+F6OK95qb0RwZR13TqYJOt
        0NESa72SbS0U4jb6io9IrEaEtwZa2KLuJgD5tf6CMapp5N51w9QhbMWg4opkOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674552396;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ffzPjEy2sw3F+U9zZT0NkTE5wNW5Hk1FQglbUV6Arfs=;
        b=Nt5Ne9eLzpPZl4D9KsXC3dAqvZSYJchTBVaSQs/SqXkKTcp1rc8DqkqI8A0/e3njZfM+Tl
        YSR77wpWKINr7HDw==
From:   "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Add interface to write mbm_local_bytes_config
Cc:     Babu Moger <babu.moger@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230113152039.770054-13-babu.moger@amd.com>
References: <20230113152039.770054-13-babu.moger@amd.com>
MIME-Version: 1.0
Message-ID: <167455239576.4906.10640440043928057415.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     4fe61bff5a4100e92f81427dab06b7f3a025f6a2
Gitweb:        https://git.kernel.org/tip/4fe61bff5a4100e92f81427dab06b7f3a025f6a2
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 13 Jan 2023 09:20:38 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 23 Jan 2023 17:40:32 +01:00

x86/resctrl: Add interface to write mbm_local_bytes_config

The event configuration for mbm_local_bytes can be changed by the
user by writing to the configuration file
/sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config.

The event configuration settings are domain specific and will affect all
the CPUs in the domain.

Following are the types of events supported:

  ====  ===========================================================
  Bits   Description
  ====  ===========================================================
  6      Dirty Victims from the QOS domain to all types of memory
  5      Reads to slow memory in the non-local NUMA domain
  4      Reads to slow memory in the local NUMA domain
  3      Non-temporal writes to non-local NUMA domain
  2      Non-temporal writes to local NUMA domain
  1      Reads to memory in the non-local NUMA domain
  0      Reads to memory in the local NUMA domain
  ====  ===========================================================

For example, to change the mbm_local_bytes_config to count all the non-temporal
writes on domain 0, the bits 2 and 3 needs to be set which is 1100b (in hex
0xc).
Run the command:

  $echo  0=0xc > /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config

To change the mbm_local_bytes to count only reads to local NUMA domain 1,
the bit 0 needs to be set which 1b (in hex 0x1). Run the command:

  $echo  1=0x1 > /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/r/20230113152039.770054-13-babu.moger@amd.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 27 ++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 03284a6..5990589 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1638,6 +1638,30 @@ static ssize_t mbm_total_bytes_config_write(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
+static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
+					    char *buf, size_t nbytes,
+					    loff_t off)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+	int ret;
+
+	/* Valid input requires a trailing newline */
+	if (nbytes == 0 || buf[nbytes - 1] != '\n')
+		return -EINVAL;
+
+	mutex_lock(&rdtgroup_mutex);
+
+	rdt_last_cmd_clear();
+
+	buf[nbytes - 1] = '\0';
+
+	ret = mon_config_write(r, buf, QOS_L3_MBM_LOCAL_EVENT_ID);
+
+	mutex_unlock(&rdtgroup_mutex);
+
+	return ret ?: nbytes;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
@@ -1745,9 +1769,10 @@ static struct rftype res_common_files[] = {
 	},
 	{
 		.name		= "mbm_local_bytes_config",
-		.mode		= 0444,
+		.mode		= 0644,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= mbm_local_bytes_config_show,
+		.write		= mbm_local_bytes_config_write,
 	},
 	{
 		.name		= "cpus",
