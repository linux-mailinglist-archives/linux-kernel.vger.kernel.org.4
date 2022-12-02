Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D18F63FD21
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 01:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbiLBAdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 19:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiLBAcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:32:45 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E5418340
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 16:31:47 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id k2-20020a17090a4c8200b002187cce2f92so6806443pjh.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 16:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aSqvQJ0r+p8u1Rw63qJBl5IXkE2qQ7qq7yw5MIhA6Vg=;
        b=hRo4cH3NdrgJYtHz2zuqiIhKDpaIbVnLZSSaOpnURDdSwno6JVGbQ7sbRiyma4ID5p
         yak5WLuD9BpCyMdRbRYLcSsZzQM2ryqSUUUOSEKtTA+d4BJKSwimD0yAdnj/qihgXXrR
         xWF8NsCINgzkXi6gYlB3KJ0GCOnfMBmWziTK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aSqvQJ0r+p8u1Rw63qJBl5IXkE2qQ7qq7yw5MIhA6Vg=;
        b=vwUvho3ImrUu1IJ04aYCYSrW3Cl7drqGsyMo+7pC+/0EfzA+G4w+D8kOxYTQpW9Qty
         AXYYmDwKlt7o1x426JN7hlCZbzTRABfXL4vqYP3biXBG7XqXmlIAi7t8dp0oNZuMWNRa
         JtzqJJ3iuitS5FwPyV6l45Z5Fh/snrIt8R+r31PejDNSq/qaH0OWvC4wgsVFVnxqK35b
         SCfBPPeHGg1dk+QpuEbX+YQpdiKuA28H+WEtEtVT+Goz4g2R0KTGOL4rmHVtvaIB25Oi
         7OVC7AG6aoDqLgzhFcLyMFGVRFprTuDx4V7ILZFhY2Ovxg9thhhw3JEFROIz2tuGBjMS
         kkdg==
X-Gm-Message-State: ANoB5pnIO4Vy+DkgTO9whv2GQyls/PpLIvexhW1ukwyyhFq7iEJqky2C
        0YSf7lcZ3IaGaGRLgelHU9WtiA==
X-Google-Smtp-Source: AA0mqf6LVRpqR8NBytmtT7u31/qaDNdBjLsbDJ8yBeh+AlyAyqNWNLgWfS0QZIwBvqjayllQfetnag==
X-Received: by 2002:a17:902:e20c:b0:189:a934:ee37 with SMTP id u12-20020a170902e20c00b00189a934ee37mr11428560plb.141.1669941107286;
        Thu, 01 Dec 2022 16:31:47 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id cp6-20020a170902e78600b0018986ba1db9sm4194500plb.284.2022.12.01.16.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:31:46 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-um@lists.infradead.org, stable@vger.kernel.org,
        David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] um: virt-pci: Avoid GCC non-NULL warning
Date:   Thu,  1 Dec 2022 16:31:41 -0800
Message-Id: <20221202003137.never.887-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3245; h=from:subject:message-id; bh=hW5b+KjTlhouCD6j7qImof+KSRreUfVk0FReUZhRGoc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjiUdt7k5NB8JKjV1GuvCZKo99RzxrLKkWs3CIhEoZ Yq0gvHqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY4lHbQAKCRCJcvTf3G3AJjb8D/ 0bdy8kTQRSRZfyYIeJyp7oCXVcKdUFnjAq+L0zfS54vo7VwW8jT61/ZKz0yR1mmLGvzBvj3orLFcWR iKTNhv9doXjX+zJwgQpDHWYIn4Scxpa6SL2qj0DZFK096DFP5K2wJGfXNiyBmvCgNG1iVhqIHw2UJX FVBFoDrenCDo8YeiNxanR5Bsaj8ymv73WfL6L0St8d5wVc2A5KQOk0iJVWPDkH8oNUMxeRSZEsxzxM Wm3IzXEn+BKBJaOLenZjBVV4eGza5V6tTDWPs1R+pOAjocB1xhbnslwG7FkW3ji4IBckWJYhsZ9C41 iWfJ9JxbDi6QluS/fD442ldJQpc7xqcHEQjckRK1vvzMa1KL+5hCoJFyo5nWkKY7seL3ohOfdPtUdz rc5aVt/af7aB0TydI0BYvedhriFKbHDYfhA9dUkccQeuzVgkXcxO1CxBax7orPIWouspRQNr4al36K PtSyqJfKNOO+q/UcsT1WPmn2FgKgB9adsggH37j0MDNXiO6dqkFa5EGQ0vIzSM4C9oU2FkTbERbK1z E2Md4XHyRnMmz6cBwAAtSx2TcOIjT1aTJUySGZ2PqLthuyzyPj9O8sIVbvWcUgxe9CF37InmRO5k6k /LG391zGyuXB2PuVLbbfVIlxz3msT11T+igz3B4mvf/jecCOcCIv9C1noyZQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC gets confused about the return value of get_cpu_var() possibly
being NULL, so explicitly test for it before calls to memcpy() and
memset(). Avoids warnings like this:

   arch/um/drivers/virt-pci.c: In function 'um_pci_send_cmd':
   include/linux/fortify-string.h:48:33: warning: argument 1 null where non-null expected [-Wnonnull]
      48 | #define __underlying_memcpy     __builtin_memcpy
         |                                 ^
   include/linux/fortify-string.h:438:9: note: in expansion of macro '__underlying_memcpy'
     438 |         __underlying_##op(p, q, __fortify_size);                        \
         |         ^~~~~~~~~~~~~
   include/linux/fortify-string.h:483:26: note: in expansion of macro '__fortify_memcpy_chk'
     483 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
         |                          ^~~~~~~~~~~~~~~~~~~~
   arch/um/drivers/virt-pci.c:100:9: note: in expansion of macro 'memcpy'
     100 |         memcpy(buf, cmd, cmd_size);
         |         ^~~~~~

While at it, avoid literal "8" and use stored sizeof(buf->data) in
memset() and um_pci_send_cmd().

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/202211271212.SUZSC9f9-lkp@intel.com
Fixes: ba38961a069b ("um: Enable FORTIFY_SOURCE")
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: linux-um@lists.infradead.org
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
I can take this via the hardening tree, since that's where I introduced
the warning. :)
---
 arch/um/drivers/virt-pci.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index acb55b302b14..3ac220dafec4 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -97,7 +97,8 @@ static int um_pci_send_cmd(struct um_pci_device *dev,
 	}
 
 	buf = get_cpu_var(um_pci_msg_bufs);
-	memcpy(buf, cmd, cmd_size);
+	if (buf)
+		memcpy(buf, cmd, cmd_size);
 
 	if (posted) {
 		u8 *ncmd = kmalloc(cmd_size + extra_size, GFP_ATOMIC);
@@ -182,6 +183,7 @@ static unsigned long um_pci_cfgspace_read(void *priv, unsigned int offset,
 	struct um_pci_message_buffer *buf;
 	u8 *data;
 	unsigned long ret = ULONG_MAX;
+	size_t bytes = sizeof(buf->data);
 
 	if (!dev)
 		return ULONG_MAX;
@@ -189,7 +191,8 @@ static unsigned long um_pci_cfgspace_read(void *priv, unsigned int offset,
 	buf = get_cpu_var(um_pci_msg_bufs);
 	data = buf->data;
 
-	memset(buf->data, 0xff, sizeof(buf->data));
+	if (buf)
+		memset(data, 0xff, bytes);
 
 	switch (size) {
 	case 1:
@@ -204,7 +207,7 @@ static unsigned long um_pci_cfgspace_read(void *priv, unsigned int offset,
 		goto out;
 	}
 
-	if (um_pci_send_cmd(dev, &hdr, sizeof(hdr), NULL, 0, data, 8))
+	if (um_pci_send_cmd(dev, &hdr, sizeof(hdr), NULL, 0, data, bytes))
 		goto out;
 
 	switch (size) {
-- 
2.34.1

