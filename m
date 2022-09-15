Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0775B9E4E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 17:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiIOPIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 11:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiIOPGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 11:06:43 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F58915C5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:05:34 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id r11-20020a05640251cb00b004516feb8c09so10385366edd.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=ZKRhstpgJFHnwQb7wa4PSp1fP2zpnAEklrA/+6U+C6A=;
        b=ThD5yyzHqBsvDfd8Iyv19jyZ2sM12IYTnbGoqnXN5npRxs4Zmln7VoA0117GVlyvP+
         L1Rc2EkzfIcjXC3nUcY1fYQ+w1h7v1L8lLr+gl/b+Stf6tF7TTC0ieLLTB5H9+8MJwTV
         cPTvprpV3Hin238+XDy2bE/nJu/b+H/Bo1Gl9VC7zPy+I29iyDswAthi3+gScTUunW0f
         D99hzKEENBt+eup4SX3Ru+YBC5gcmF6lpKUFHmW/SZGEqpj0JNmM0Xg4CfE2Gt4d5QDl
         B5MQFU94qthIy3W4Vl2BeQjxRVxR6rhsIvHEco9D+hMSTS0FjckD4QYWcZtWhUe10Los
         eI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=ZKRhstpgJFHnwQb7wa4PSp1fP2zpnAEklrA/+6U+C6A=;
        b=iXZHyfKWtNl/JZEu3gcqfQa+tJNq+rIqIT8SezuTo2ZIh/iHOr+0JR0OgU3/evylBC
         IqYT3vuTZoBJgUjjMtQqSqyJ+Ot4c9iiCi10QcJ90u5hwC8y1gwasc25BXoO59vy4d9n
         XJGLg0XFo7cGb8gagqzVkEK79SPZDOgPietOe/lLh9yByIKlWqPQZdyvVV3BxnCPLhkG
         s6lXV9fkOU44y7L53ULbTwsFAVELpUqIQAPq5x6XAjmDpnBgvOU/Br6oYdsVvfkAhWaq
         uzRyPpbRObqp8WNckCoq2N07KzvdDoErrMf8XGVZeh5Ma/czTTy8mIRxmoZzmethrxzl
         Dh6A==
X-Gm-Message-State: ACrzQf3feXcMvAoJpGMijcZ7lGA9/Pkx1arHWvfOh2dgvHjGlCVMUQaU
        hxvnEWTTo7+cwuvOLumNhCddWDbKO+8=
X-Google-Smtp-Source: AMsMyM4m3KxavKH5nPSgfXzlvt1xeKFIhjuoRkROmKkrPr/lpTSHT0pnpGf9Q4HdyY1KjTTGhTSnJGDa6K8=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:686d:27b5:495:85b7])
 (user=glider job=sendgmr) by 2002:a05:6402:3509:b0:452:20c7:5a95 with SMTP id
 b9-20020a056402350900b0045220c75a95mr237534edd.427.1663254333337; Thu, 15 Sep
 2022 08:05:33 -0700 (PDT)
Date:   Thu, 15 Sep 2022 17:03:54 +0200
In-Reply-To: <20220915150417.722975-1-glider@google.com>
Mime-Version: 1.0
References: <20220915150417.722975-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220915150417.722975-21-glider@google.com>
Subject: [PATCH v7 20/43] Input: libps2: mark data received in __ps2_command()
 as initialized
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

KMSAN does not know that the device initializes certain bytes in
ps2dev->cmdbuf. Call kmsan_unpoison_memory() to explicitly mark them as
initialized.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I2d26f6baa45271d37320d3f4a528c39cb7e545f0
---
 drivers/input/serio/libps2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
index 250e213cc80c6..3e19344eda93c 100644
--- a/drivers/input/serio/libps2.c
+++ b/drivers/input/serio/libps2.c
@@ -12,6 +12,7 @@
 #include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/input.h>
+#include <linux/kmsan-checks.h>
 #include <linux/serio.h>
 #include <linux/i8042.h>
 #include <linux/libps2.h>
@@ -294,9 +295,11 @@ int __ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command)
 
 	serio_pause_rx(ps2dev->serio);
 
-	if (param)
+	if (param) {
 		for (i = 0; i < receive; i++)
 			param[i] = ps2dev->cmdbuf[(receive - 1) - i];
+		kmsan_unpoison_memory(param, receive);
+	}
 
 	if (ps2dev->cmdcnt &&
 	    (command != PS2_CMD_RESET_BAT || ps2dev->cmdcnt != 1)) {
-- 
2.37.2.789.g6183377224-goog

