Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2498A7275D9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 05:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbjFHDjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 23:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbjFHDjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 23:39:16 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C0026A2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 20:39:14 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230608033912epoutp03d8471f29e4f5a75518aeacb4b26c2cd9~mkevflIz_1553315533epoutp03y
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 03:39:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230608033912epoutp03d8471f29e4f5a75518aeacb4b26c2cd9~mkevflIz_1553315533epoutp03y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686195552;
        bh=6nJ2t3VVgL0nHyGCKJE2K8Shh1n5XLj/IHAtXZmwry0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ivtcVoM8n1geplLvFw6yXSpEWNnPsqgSNLjOkWHq2zexfEaN3putNrSc6kzzw7bWp
         WTsffZrceNUHMEJGw+V5fz8fuFVbSRWM8L9DQMyGdDy5KRe5YOw/ZRBzsSO4eWvJBo
         nGziipUxNqZSl+PnTu5jr5DrUV2BuAiQdJn+W6wQ=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230608033911epcas5p410175e75ccd1998c9c329641e0119b4f~mkeuvsd8f0548405484epcas5p4l;
        Thu,  8 Jun 2023 03:39:11 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6D.4F.16380.F5D41846; Thu,  8 Jun 2023 12:39:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230608033140epcas5p1a1a04da5a0c78f888afbf54b00519f1e~mkYJ5KDNt2176021760epcas5p1P;
        Thu,  8 Jun 2023 03:31:40 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230608033140epsmtrp200e0b5498e6ac14874b891e205b18018~mkYJ3Fl520782807828epsmtrp2E;
        Thu,  8 Jun 2023 03:31:40 +0000 (GMT)
X-AuditID: b6c32a4b-56fff70000013ffc-84-64814d5f4b49
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F7.F2.28392.B9B41846; Thu,  8 Jun 2023 12:31:39 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230608033134epsmtip137cbc9d25b0f59e91a7c217bacad7218~mkYEdLklZ0748207482epsmtip1d;
        Thu,  8 Jun 2023 03:31:34 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, thunder.leizhen@huawei.com, mcgrof@kernel.org,
        boqun.feng@gmail.com, vincenzopalazzodev@gmail.com,
        ojeda@kernel.org, jgross@suse.com, brauner@kernel.org,
        michael.christie@oracle.com, samitolvanen@google.com,
        glider@google.com, peterz@infradead.org, keescook@chromium.org,
        stephen.s.brennan@oracle.com, alan.maguire@oracle.com,
        pmladek@suse.com
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Maninder Singh <maninder1.s@samsung.com>,
        Onkarnath <onkarnath.1@samsung.com>
Subject: [PATCH v5 2/2] kallsyms: make kallsyms_show_value() as generic
 function
Date:   Thu,  8 Jun 2023 09:01:19 +0530
Message-Id: <20230608033119.1543638-2-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230608033119.1543638-1-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0xTVxTHd997fS0dJW+FjDtwTjuJgqwMpe6aMdky4l7m3FSWLCFZpLNP
        qNDatDJkZKEFogEFESGD0gEdY9SGH1JhVBw/LDUdLThAtlUJDh2KSCBAVeag2ygPMv/7nHO+
        3/PNubk8XNhAhvDkyhOMWilNE5F84sfe8PA3Du/Xyd50D0Uit01HoMWlShw9fjbKRQ2tOgx5
        7A4STfcuAFRrfIqj0/OdOLI5urnIcGsHyrGaMGQv1eOo/4wCTXYVYuhmh4FEvdWnCNSQf5GD
        3MX3AfKWuDnoYnU9QKazcxzkKOzB0L9/PuGgOtMMBw3/NU0gR72XRF77NQxN/L1AoqKBQ+jh
        9+Xg3Y10pXaIoM/nznLpK/oxLl1jSafz7DMc+rIpgi5wD+O0xZxP0kZtGU7P379N0EWtZkA3
        t/5K0B7LxgOCRH6sjEmTf8moo/Yk8VOu1/6Oq5YCT/YXxWqBnSoAfjxIxUDP4jlOAeDzhNRV
        AD35/RhbLABYNjrM9amElAfArksb1h0/PDOtiToAvNAwRrLFYwCbppcJn4qkxNDc8RPhGwRR
        VgIOtoyvWnDqFICVVddWVYHUIXivp470MUGFwck6E+5jAbUH3u3Wctm812DF8OIq+1FxsO07
        F5fVvAT7KiZW9+Armty2StwXAKmrftB5xU2y5nhY02LEWQ6Ejxyta0tDoGe2c0XDW+EM2Fac
        zXrzAOw2lK554+DEkJHj0+BUOGzuiGLbr8IyZxPG5gbAwqUJjO0LoLVqncNg3q1LHJZDoWd+
        nmCZhk7jz2tvVwLgDdcwVgw26Z+7R//cPfr/o2sAbgavMCqNIpnRSFQ7lUyGWCNVaNKVyeIj
        xxUWsPqhI/ZZwb3xObENYDxgA5CHi4IEx+KyZUKBTJr5FaM+flidnsZobCCUR4iCBVvf6Tsi
        pJKlJ5hUhlEx6vUpxvML0WKS8sFNWW3tkjqJEhOfbRHFfPOy9nXXHSZme22WeWRwe3DzBztk
        4zu34LGPoierc+rl18eCDMC17w+uP38xUnBU9tYLugemm327ovx3PwhuulB2w3nsn6lvQ/Rh
        KV+nLhQn/dK/RWKaSUgbmUqP9vofbOiZDZN1uqwbLifAgM9Mmw32xDlOafnU+fgZ1e74JMXb
        n6q3Zop3PUyiImOWTx/8eHCuajRB2ajNGBk90Hg3sutcaMkn7U+Et+8sQ2ZzXF4IL9G5//2p
        F1Or5cv2ASJnIDg8+/Mzchp3Kk4m6t778Km51tIo+EJ/NACEbnNkeo3tcyV2897cjI9St/3W
        l7W3Qi8iNCnS6AhcrZH+B4BQVek/BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRiH+59zdo3VaWodXZktKxm4Mrr8oyvShxNBhVigSLrcQS2na/OW
        GM4sa0vXUvO28lruglbqKgvzMmdTKjGjstTAmllk2VbZVKx0I+jbA8/D7/3yMlHuW8yHGZeQ
        RMkSRPF8Ohu728n3DdTuzxJveFe0GQ6YszD4a0aLwh9TgwxYZ8pC4HeLlQ4/dzoArKmaROF5
        +0MUmq1tDHj19UZ4plmPQEthGQqfXJTAsdY8BD5/cJUOOytyMFinNNDggGYUwNn8ARo0VOgA
        1Od+o0FrXjsC/7z/SYM39F9osN/5GYNW3Swdzlo6EGibdtCh+mkI/Hi9BOzxJbWKZxh5Ofsr
        g7xfNswgKxuTybOWLzSySS8gVQP9KNloVNLJKsUVlLSPvsFItckIyFumFxj5vdH3ECecvUNM
        xcelULL1u6LYsV01r1DpjEfaE/UOBbDgKsBiEvgmonZKj6gAm8nFmwHRND2CuAWPmPo9gbnZ
        gzD8HmO4Iwcg6nPKXREdFxLGBy3YvPDEhzCi9VODq0LnxomRD3WM+coDP0SU6GpcUxi+hhi7
        oUfnmYPvIkbaFAz3iZVEaf8vF7Pw3cSd6scu5s41XRef09z9EqKn1ObaQef67DtaVAPwsv9U
        2X+qEiBG4E1J5ZIYiTxIujGBShXKRRJ5ckKMMDpR0ghcLyAQNIMW4zehGSBMYAYEE+V7co7v
        zhRzOWLRqXRKlhgpS46n5GbAY2L8ZZw+VU8kF48RJVEnKEpKyf5ZhMnyUSDK5ChUGl3cIdv6
        RutkaVqDW3peiMMzJ/aZbnd52ybzB4vrA/oMzqOLcnMLnCn27tWcJFtBxOEMOyuCs+Z+SHdk
        6StueaikSZN7rVX9Seuv87gZ7rWN200bEl5Qw9KZ19tte1/6qoIKH53uuB6c95G3qNc5faw6
        pPoozzGewvZpGs8nGUO1DZkfBtMreqUm/7ENngav9L4S/bq2e3uDy9O+hsVQCvE98Xg3UmMM
        1Z1bsTRtMjVjS9TOhctPnTxpX1r1dK3qmPIgDGyoLGi/sjhggeZISHqhWWC91h7tF3pp+DK6
        9rDfj4Dhc6tqjbiyyHHgLVIbumkJ78BQWKoiJ5uPyWNFQQJUJhf9BRGZefdxAwAA
X-CMS-MailID: 20230608033140epcas5p1a1a04da5a0c78f888afbf54b00519f1e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20230608033140epcas5p1a1a04da5a0c78f888afbf54b00519f1e
References: <20230608033119.1543638-1-maninder1.s@samsung.com>
        <CGME20230608033140epcas5p1a1a04da5a0c78f888afbf54b00519f1e@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change makes function kallsyms_show_value() as
generic function without dependency on CONFIG_KALLSYMS.

Now module address will be displayed with lsmod and /proc/modules.

Earlier:
=======
/ # insmod  test.ko
/ # lsmod
test 12288 0 - Live 0x0000000000000000 (O)  // No Module Load address
/ #

With change:
==========
/ # insmod test.ko
/ # lsmod
test 12288 0 - Live 0xffff800000fc0000 (O)  // Module address
/ # cat /proc/modules
test 12288 0 - Live 0xffff800000fc0000 (O)

Co-developed-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 include/linux/kallsyms.h | 11 +++--------
 kernel/ksyms_common.c    |  2 --
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 1037f4957caa..c3f075e8f60c 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -65,6 +65,9 @@ static inline void *dereference_symbol_descriptor(void *ptr)
 	return ptr;
 }
 
+/* How and when do we show kallsyms values? */
+extern bool kallsyms_show_value(const struct cred *cred);
+
 #ifdef CONFIG_KALLSYMS
 unsigned long kallsyms_sym_address(int idx);
 int kallsyms_on_each_symbol(int (*fn)(void *, const char *, unsigned long),
@@ -94,9 +97,6 @@ extern int sprint_backtrace_build_id(char *buffer, unsigned long address);
 
 int lookup_symbol_name(unsigned long addr, char *symname);
 
-/* How and when do we show kallsyms values? */
-extern bool kallsyms_show_value(const struct cred *cred);
-
 #else /* !CONFIG_KALLSYMS */
 
 static inline unsigned long kallsyms_lookup_name(const char *name)
@@ -154,11 +154,6 @@ static inline int lookup_symbol_name(unsigned long addr, char *symname)
 	return -ERANGE;
 }
 
-static inline bool kallsyms_show_value(const struct cred *cred)
-{
-	return false;
-}
-
 static inline int kallsyms_on_each_symbol(int (*fn)(void *, const char *, unsigned long),
 					  void *data)
 {
diff --git a/kernel/ksyms_common.c b/kernel/ksyms_common.c
index 3840fa1c9c86..cf1a73cbf2f6 100644
--- a/kernel/ksyms_common.c
+++ b/kernel/ksyms_common.c
@@ -6,7 +6,6 @@
 #include <linux/kallsyms.h>
 #include <linux/security.h>
 
-#ifdef CONFIG_KALLSYMS
 static inline int kallsyms_for_perf(void)
 {
 #ifdef CONFIG_PERF_EVENTS
@@ -42,4 +41,3 @@ bool kallsyms_show_value(const struct cred *cred)
 		return false;
 	}
 }
-#endif
-- 
2.17.1

