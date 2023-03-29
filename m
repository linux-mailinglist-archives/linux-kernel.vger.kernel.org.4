Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B196CF38E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjC2TrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjC2Tp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:45:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D540065B7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:45:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22B7BB82371
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 19:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0C5C4339E;
        Wed, 29 Mar 2023 19:45:53 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1phbk1-002Rop-0E;
        Wed, 29 Mar 2023 15:45:53 -0400
Message-ID: <20230329194552.889121252@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 29 Mar 2023 15:45:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-next][PATCH 19/25] tracing/user_events: Use write ABI in example
References: <20230329194516.146147554@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Beau Belgrave <beaub@linux.microsoft.com>

The ABI has changed to use a remote write approach. Update the example
to show the expected use of this new ABI. Also remove debugfs
path and use tracefs to ensure example works in more environments.

Link: https://lkml.kernel.org/r/20230328235219.203-9-beaub@linux.microsoft.com

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 samples/user_events/example.c | 45 +++++++----------------------------
 1 file changed, 8 insertions(+), 37 deletions(-)

diff --git a/samples/user_events/example.c b/samples/user_events/example.c
index 18e34c9d708e..28165a096697 100644
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
-
-/* Assumes debugfs is mounted */
 const char *data_file = "/sys/kernel/tracing/user_events_data";
-const char *status_file = "/sys/kernel/tracing/user_events_status";
+int enabled = 0;
 
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
2.39.1
