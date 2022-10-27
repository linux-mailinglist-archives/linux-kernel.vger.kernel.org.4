Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30F460EF6E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 07:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbiJ0FRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 01:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbiJ0FRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 01:17:16 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE70159D51
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 22:17:15 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-369d18a90c3so3700457b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 22:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kZrV/1Wpi1+HqcfGR+b498M10ZLeStFwJCyAnig/6KY=;
        b=JUBIOI3l2EGreHiUCM4juD1059ffAruYfyWohhCAJhRFYN3hmE4smD96x0cX5bb8Wi
         /e04FmgEtbfzoyIc7Do0gLQpFdutsRVvpKY+qsQDkJzd4at42pf8SB21HNBpT77DrBTW
         EnjHuNjuLaNNNs+ved2bSLGP4jhfL5GL7FlTHRfXfafJh6F83EKHIZDyNfLTRhpvvZ11
         dPCmU7+3jEkdUR031feyIlWfKxtFEexnVmyCHKAWZ5adHa+c07+LezZF7eS1bZWIG9Ta
         kynL+Ra1pe3eh+omqJorLgdShLccEM4UiS1L0MKZBadGj/VvdKuJIfCeG/iXFLmQgBfF
         jY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kZrV/1Wpi1+HqcfGR+b498M10ZLeStFwJCyAnig/6KY=;
        b=JuMIkjyhksOHOt6Jq0jKuQwrK/lq2fSCU+k92iKYAtOttA86uc25eKZmMxuJbGeuVw
         qRc0axB8KQRIVHR6F1+Ix5TWzr3aP3W/6hUEs96THOxwuOZbmqtLLvFIKMBYt3N2Pqly
         Y7MuJxY2rrw+BNFePevvYrdltEixzqrMVHfIwKDsqtAYT+IsXCZKLbRrtEl3FTud7Bjt
         HWIn8qnFW1nCockWhXkEzuJCZ6RRBH5gXpfXD2FomYBRpOj5996TI2bBvyk7i+pOYStz
         xa7TKP1igIcBltGLH+Hz/8GIOt3dhsU2YZ6Ptmp87giBwtbrX7RHqqKef4fgVkNiOS/z
         HxHQ==
X-Gm-Message-State: ACrzQf23p/qZ4P5CJzVtF0Aqzf/gun4+DqlVCtZnSoFkS/24Uq34FEQc
        jAzoPDJUTzj/1m94cEfAXwZ+2D4o0tBxIxkwq8E=
X-Google-Smtp-Source: AMsMyM5cF0zw3ybvkEcOG3fmwEqPbYgrvZIU3jKLTIPCGz7EQqCIVsx6CoWTgFHLcNI/IyhxEjerI/Nvxvxtowsx/yM=
X-Received: from huangrandall-gl0.tao.corp.google.com ([2401:fa00:fd:203:334d:6a5:213c:f5a5])
 (user=huangrandall job=sendgmr) by 2002:a25:d24a:0:b0:6ca:4a7a:75cd with SMTP
 id j71-20020a25d24a000000b006ca4a7a75cdmr32461812ybg.89.1666847834389; Wed,
 26 Oct 2022 22:17:14 -0700 (PDT)
Date:   Thu, 27 Oct 2022 13:17:09 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221027051709.268869-1-huangrandall@google.com>
Subject: [f2fs-dev][PATCH] f2fs-tools: introduce sg_read_buffer
From:   Randall Huang <huangrandall@google.com>
To:     jaegeuk@kernel.org, yuchao0@huawei.com,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Cc:     huangrandall@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support UFS error history dumping

Signed-off-by: Randall Huang <huangrandall@google.com>
---
 tools/sg_write_buffer/Android.bp       |  19 ++
 tools/sg_write_buffer/sg_read_buffer.c | 334 +++++++++++++++++++++++++
 2 files changed, 353 insertions(+)
 create mode 100644 tools/sg_write_buffer/sg_read_buffer.c

diff --git a/tools/sg_write_buffer/Android.bp b/tools/sg_write_buffer/Android.bp
index 5222a59..f488aea 100644
--- a/tools/sg_write_buffer/Android.bp
+++ b/tools/sg_write_buffer/Android.bp
@@ -25,3 +25,22 @@ cc_binary {
         "sg_pt_linux_nvme.c",
     ],
 }
+
+cc_binary {
+    name: "sg_read_buffer",
+    defaults: [ "sg3-utils-defaults" ],
+    srcs: [
+        "sg_read_buffer.c",
+        "sg_cmds_basic.c",
+        "sg_cmds_basic2.c",
+        "sg_cmds_extra.c",
+        "sg_cmds_mmc.c",
+        "sg_io_linux.c",
+        "sg_lib.c",
+        "sg_lib_data.c",
+        "sg_pt_common.c",
+        "sg_pt_linux.c",
+        "sg_pt_linux_nvme.c",
+    ],
+    system_ext_specific: true,
+}
diff --git a/tools/sg_write_buffer/sg_read_buffer.c b/tools/sg_write_buffer/sg_read_buffer.c
new file mode 100644
index 0000000..1924c7d
--- /dev/null
+++ b/tools/sg_write_buffer/sg_read_buffer.c
@@ -0,0 +1,334 @@
+/*
+ * Copyright (c) 2006-2013 Luben Tuikov and Douglas Gilbert.
+ * All rights reserved.
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the BSD_LICENSE file.
+ */
+
+#include <unistd.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <ctype.h>
+#include <string.h>
+#include <getopt.h>
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+#include "sg_lib.h"
+#include "sg_cmds_basic.h"
+#include "sg_cmds_extra.h"
+#include "sg_pt.h"      /* needed for scsi_pt_win32_direct() */
+
+/*
+ * This utility issues the SCSI READ BUFFER command to the given device.
+ */
+
+static const char * version_str = "1.09 20130507";
+
+
+static struct option long_options[] = {
+        {"help", 0, 0, 'h'},
+        {"hex", 0, 0, 'H'},
+        {"id", 1, 0, 'i'},
+        {"length", 1, 0, 'l'},
+        {"mode", 1, 0, 'm'},
+        {"offset", 1, 0, 'o'},
+        {"raw", 0, 0, 'r'},
+        {"verbose", 0, 0, 'v'},
+        {"version", 0, 0, 'V'},
+        {0, 0, 0, 0},
+};
+
+
+static void
+usage()
+{
+    fprintf(stderr, "Usage: "
+          "sg_read_buffer [--help] [--hex] [--id=ID] [--length=LEN] "
+          "[--mode=MO]\n"
+          "                      [--offset=OFF] [--raw] [--verbose] "
+          "[--version] DEVICE\n"
+          "  where:\n"
+          "    --help|-h           print out usage message\n"
+          "    --hex|-H            print output in hex\n"
+          "    --id=ID|-i ID       buffer identifier (0 (default) to 255)\n"
+          "    --length=LEN|-l LEN    length in bytes to read (def: 4)\n"
+          "    --mode=MO|-m MO     read buffer mode, MO is number or "
+          "acronym (def: 0)\n"
+          "    --off=OFF|-o OFF    buffer offset (unit: bytes, def: 0)\n"
+          "    --raw|-r            output response to stdout\n"
+          "    --verbose|-v        increase verbosity\n"
+          "    --version|-V        print version string and exit\n\n"
+          "  Numbers given in options are decimal unless they have a "
+          "hex indicator\n"
+          "Performs a SCSI READ BUFFER command\n"
+          );
+
+}
+
+#define MODE_HEADER_DATA        0
+#define MODE_VENDOR             1
+#define MODE_DATA               2
+#define MODE_DESCRIPTOR         3
+#define MODE_ECHO_BUFFER        0x0A
+#define MODE_ECHO_BDESC         0x0B
+#define MODE_EN_EX_ECHO         0x1A
+#define MODE_ERR_HISTORY        0x1C
+
+static struct mode_s {
+        const char *mode_string;
+        int   mode;
+        const char *comment;
+} modes[] = {
+        { "hd",         MODE_HEADER_DATA, "combined header and data"},
+        { "vendor",     MODE_VENDOR,    "vendor specific"},
+        { "data",       MODE_DATA,      "data"},
+        { "desc",       MODE_DESCRIPTOR, "descriptor"},
+        { "echo",       MODE_ECHO_BUFFER, "read data from echo buffer "
+          "(spc-2)"},
+        { "echo_desc",  MODE_ECHO_BDESC, "echo buffer descriptor (spc-2)"},
+        { "en_ex",      MODE_EN_EX_ECHO,
+          "enable expander communications protocol and echo buffer (spc-3)"},
+        { "err_hist",   MODE_ERR_HISTORY, "error history (spc-4)"},
+};
+
+#define NUM_MODES       ((int)(sizeof(modes)/sizeof(modes[0])))
+
+static void
+print_modes(void)
+{
+    int k;
+
+    fprintf(stderr, "The modes parameter argument can be numeric "
+                "(hex or decimal)\nor symbolic:\n");
+    for (k = 0; k < NUM_MODES; k++) {
+        fprintf(stderr, " %2d (0x%02x)  %-16s%s\n", modes[k].mode,
+                modes[k].mode, modes[k].mode_string, modes[k].comment);
+    }
+}
+
+static void
+dStrRaw(const char* str, int len)
+{
+    int k;
+
+    for (k = 0 ; k < len; ++k)
+        printf("%c", str[k]);
+}
+
+int
+main(int argc, char * argv[])
+{
+    int sg_fd, res, c, len, k;
+    int do_help = 0;
+    int do_hex = 0;
+    int rb_id = 0;
+    int rb_len = 4;
+    int rb_mode = 0;
+    int rb_offset = 0;
+    int do_raw = 0;
+    int verbose = 0;
+    const char * device_name = NULL;
+    unsigned char * resp;
+    int ret = 0;
+
+    while (1) {
+        int option_index = 0;
+
+        c = getopt_long(argc, argv, "hHi:l:m:o:rvV", long_options,
+                        &option_index);
+        if (c == -1)
+            break;
+
+        switch (c) {
+        case 'h':
+        case '?':
+            ++do_help;
+            break;
+        case 'H':
+            ++do_hex;
+            break;
+        case 'i':
+            rb_id = sg_get_num(optarg);
+            if ((rb_id < 0) || (rb_id > 255)) {
+                fprintf(stderr, "argument to '--id' should be in the range "
+                        "0 to 255\n");
+                return SG_LIB_SYNTAX_ERROR;
+            }
+            break;
+        case 'l':
+            rb_len = sg_get_num(optarg);
+            if (rb_len < 0) {
+                fprintf(stderr, "bad argument to '--length'\n");
+                return SG_LIB_SYNTAX_ERROR;
+             }
+             break;
+        case 'm':
+            if (isdigit(*optarg)) {
+                rb_mode = sg_get_num(optarg);
+                if ((rb_mode < 0) || (rb_mode > 31)) {
+                    fprintf(stderr, "argument to '--mode' should be in the "
+                            "range 0 to 31\n");
+                    return SG_LIB_SYNTAX_ERROR;
+                }
+            } else {
+                len = strlen(optarg);
+                for (k = 0; k < NUM_MODES; ++k) {
+                    if (0 == strncmp(modes[k].mode_string, optarg, len)) {
+                        rb_mode = modes[k].mode;
+                        break;
+                    }
+                }
+                if (NUM_MODES == k) {
+                    print_modes();
+                    return SG_LIB_SYNTAX_ERROR;
+                }
+            }
+            break;
+        case 'o':
+           rb_offset = sg_get_num(optarg);
+           if (rb_offset < 0) {
+                fprintf(stderr, "bad argument to '--offset'\n");
+                return SG_LIB_SYNTAX_ERROR;
+            }
+            break;
+        case 'r':
+            ++do_raw;
+            break;
+        case 'v':
+            ++verbose;
+            break;
+        case 'V':
+            fprintf(stderr, "version: %s\n", version_str);
+            return 0;
+        default:
+            fprintf(stderr, "unrecognised option code 0x%x ??\n", c);
+            usage();
+            return SG_LIB_SYNTAX_ERROR;
+        }
+    }
+    if (do_help) {
+        if (do_help > 1) {
+            usage();
+            fprintf(stderr, "\n");
+            print_modes();
+        } else
+            usage();
+        return 0;
+    }
+    if (optind < argc) {
+        if (NULL == device_name) {
+            device_name = argv[optind];
+            ++optind;
+        }
+        if (optind < argc) {
+            for (; optind < argc; ++optind)
+                fprintf(stderr, "Unexpected extra argument: %s\n",
+                        argv[optind]);
+            usage();
+            return SG_LIB_SYNTAX_ERROR;
+        }
+    }
+
+    if (NULL == device_name) {
+        fprintf(stderr, "missing device name!\n");
+        usage();
+        return SG_LIB_SYNTAX_ERROR;
+    }
+
+    if (rb_len > 0) {
+        resp = (unsigned char *)malloc(rb_len);
+        if (NULL == resp) {
+            fprintf(stderr, "unable to allocate %d bytes on the heap\n",
+                    rb_len);
+            return SG_LIB_CAT_OTHER;
+        }
+        memset(resp, 0, rb_len);
+    } else
+        resp = NULL;
+
+    if (do_raw) {
+        if (sg_set_binary_mode(STDOUT_FILENO) < 0) {
+            perror("sg_set_binary_mode");
+            return SG_LIB_FILE_ERROR;
+        }
+    }
+
+#ifdef SG_LIB_WIN32
+#ifdef SG_LIB_WIN32_DIRECT
+    if (verbose > 4)
+        fprintf(stderr, "Initial win32 SPT interface state: %s\n",
+                scsi_pt_win32_spt_state() ? "direct" : "indirect");
+    scsi_pt_win32_direct(SG_LIB_WIN32_DIRECT /* SPT pt interface */);
+#endif
+#endif
+
+    sg_fd = sg_cmds_open_device(device_name, 0 /* rw */, verbose);
+    if (sg_fd < 0) {
+        fprintf(stderr, "open error: %s: %s\n", device_name,
+                safe_strerror(-sg_fd));
+        return SG_LIB_FILE_ERROR;
+    }
+
+    res = sg_ll_read_buffer(sg_fd, rb_mode, rb_id, rb_offset, resp,
+                            rb_len, 1, verbose);
+    if (0 != res) {
+        ret = res;
+        switch (res) {
+        case SG_LIB_CAT_NOT_READY:
+            fprintf(stderr, "Read buffer failed, device not ready\n");
+            break;
+        case SG_LIB_CAT_UNIT_ATTENTION:
+            fprintf(stderr, "Read buffer not done, unit attention\n");
+            break;
+        case SG_LIB_CAT_ABORTED_COMMAND:
+            fprintf(stderr, "Read buffer, aborted command\n");
+            break;
+        case SG_LIB_CAT_INVALID_OP:
+            fprintf(stderr, "Read buffer command not supported\n");
+            break;
+        case SG_LIB_CAT_ILLEGAL_REQ:
+            fprintf(stderr, "bad field in Read buffer cdb\n");
+            break;
+        default:
+            fprintf(stderr, "Read buffer failed res=%d\n", res);
+            break;
+        }
+    } else if (rb_len > 0) {
+        if (do_raw)
+            dStrRaw((const char *)resp, rb_len);
+        else if (do_hex || (rb_len < 4))
+            dStrHex((const char *)resp, rb_len, ((do_hex > 1) ? 0 : 1));
+        else {
+            switch (rb_mode) {
+            case MODE_DESCRIPTOR:
+                k = (resp[1] << 16) | (resp[2] << 8) | resp[3];
+                printf("OFFSET BOUNDARY: %d, Buffer offset alignment: "
+                       "%d-byte\n", resp[0], (1 << resp[0]));
+                printf("BUFFER CAPACITY: %d (0x%x)\n", k, k);
+                break;
+            case MODE_ECHO_BDESC:
+                k = ((resp[2] & 0x1F) << 8) | resp[3];
+
+                printf("EBOS:%d\n", resp[0] & 1 ? 1 : 0);
+                printf("Echo buffer capacity: %d (0x%x)\n", k, k);
+                break;
+            default:
+                dStrHex((const char *)resp, rb_len, (verbose > 1 ? 0 : 1));
+                break;
+            }
+        }
+    }
+
+    if (resp)
+        free(resp);
+    res = sg_cmds_close_device(sg_fd);
+    if (res < 0) {
+        fprintf(stderr, "close error: %s\n", safe_strerror(-res));
+        if (0 == ret)
+            return SG_LIB_FILE_ERROR;
+    }
+    return (ret >= 0) ? ret : SG_LIB_CAT_OTHER;
+}
-- 
2.38.0.135.g90850a2211-goog

