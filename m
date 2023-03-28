Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BBB6CCE41
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 01:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjC1Xws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 19:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjC1Xw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 19:52:29 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 416F92D51;
        Tue, 28 Mar 2023 16:52:28 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 840C020FDC26;
        Tue, 28 Mar 2023 16:52:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 840C020FDC26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1680047547;
        bh=dmkEXknb1A0Qhw2AWPTXryudmpuAFo4IqxhDoe6dNiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fw5Hu2PHEUphs88pUUTVc1A++7+3aYnR0xPiH7iapsn3ImWO0zjYiFI1POXN/rGK+
         IyFSibY7nreLfH+9/gTtweT0J02Xe+1Dazlnwne3kXXuxztr3jowfd0h8ZKAovdhhk
         sJzvvVFl1u2gHKPj8svpyDZsVB9/Un6iIlU0Mae4=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, dcook@linux.microsoft.com,
        alanau@linux.microsoft.com, brauner@kernel.org,
        akpm@linux-foundation.org, ebiederm@xmission.com,
        keescook@chromium.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH v10 08/12] tracing/user_events: Use write ABI in example
Date:   Tue, 28 Mar 2023 16:52:15 -0700
Message-Id: <20230328235219.203-9-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230328235219.203-1-beaub@linux.microsoft.com>
References: <20230328235219.203-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ABI has changed to use a remote write approach. Update the example
to show the expected use of this new ABI. Also remove debugfs
path and use tracefs to ensure example works in more environments.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 samples/user_events/example.c | 47 +++++++----------------------------
 1 file changed, 9 insertions(+), 38 deletions(-)

diff --git a/samples/user_events/example.c b/samples/user_events/example.c
index d06dc24156ec..28165a096697 100644
--- a/samples/user_events/example.c
+++ b/samples/user_events/example.c
@@ -9,51 +9,28 @@
 #include <errno.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
+#include <sys/uio.h>
 #include <fcntl.h>
 #include <stdio.h>
 #include <unistd.h>
-#include <asm/bitsperlong.h>
-#include <endian.h>
 #include <linux/user_events.h>
 
-#if __BITS_PER_LONG == 64
-#define endian_swap(x) htole64(x)
-#else
-#define endian_swap(x) htole32(x)
-#endif
+const char *data_file = "/sys/kernel/tracing/user_events_data";
+int enabled = 0;
 
-/* Assumes debugfs is mounted */
-const char *data_file = "/sys/kernel/debug/tracing/user_events_data";
-const char *status_file = "/sys/kernel/debug/tracing/user_events_status";
-
-static int event_status(long **status)
-{
-	int fd = open(status_file, O_RDONLY);
-
-	*status = mmap(NULL, sysconf(_SC_PAGESIZE), PROT_READ,
-		       MAP_SHARED, fd, 0);
-
-	close(fd);
-
-	if (*status == MAP_FAILED)
-		return -1;
-
-	return 0;
-}
-
-static int event_reg(int fd, const char *command, long *index, long *mask,
-		     int *write)
+static int event_reg(int fd, const char *command, int *write, int *enabled)
 {
 	struct user_reg reg = {0};
 
 	reg.size = sizeof(reg);
+	reg.enable_bit = 31;
+	reg.enable_size = sizeof(*enabled);
+	reg.enable_addr = (__u64)enabled;
 	reg.name_args = (__u64)command;
 
 	if (ioctl(fd, DIAG_IOCSREG, &reg) == -1)
 		return -1;
 
-	*index = reg.status_bit / __BITS_PER_LONG;
-	*mask = endian_swap(1L << (reg.status_bit % __BITS_PER_LONG));
 	*write = reg.write_index;
 
 	return 0;
@@ -62,17 +39,12 @@ static int event_reg(int fd, const char *command, long *index, long *mask,
 int main(int argc, char **argv)
 {
 	int data_fd, write;
-	long index, mask;
-	long *status_page;
 	struct iovec io[2];
 	__u32 count = 0;
 
-	if (event_status(&status_page) == -1)
-		return errno;
-
 	data_fd = open(data_file, O_RDWR);
 
-	if (event_reg(data_fd, "test u32 count", &index, &mask, &write) == -1)
+	if (event_reg(data_fd, "test u32 count", &write, &enabled) == -1)
 		return errno;
 
 	/* Setup iovec */
@@ -80,13 +52,12 @@ int main(int argc, char **argv)
 	io[0].iov_len = sizeof(write);
 	io[1].iov_base = &count;
 	io[1].iov_len = sizeof(count);
-
 ask:
 	printf("Press enter to check status...\n");
 	getchar();
 
 	/* Check if anyone is listening */
-	if (status_page[index] & mask) {
+	if (enabled) {
 		/* Yep, trace out our data */
 		writev(data_fd, (const struct iovec *)io, 2);
 
-- 
2.25.1

