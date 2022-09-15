Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF655B9E29
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 17:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiIOPGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 11:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiIOPF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 11:05:27 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025585723D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:05:00 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id r11-20020a05640251cb00b004516feb8c09so10383997edd.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=eIK0S734s+WuMuzHGxUrnoQabUzsOPxTYvMm/ke78tI=;
        b=XJ1NrdN4cE67qY8hURHcVMHDPQGupt4q/cUx1wA/HOiuLu51Fa8NOdGrL8VY2zFx6+
         8lRaRnc4ndVN0vHKZv8f+yMlsJHhkeysfQSbADbjj48OFzy6utjli2LCXqgO1W6q0KWs
         u8Y4BILUyHfMx3esbYPqIQ8idS1ZbqJP9fwLBBBIi6DYlYVdmCAHB4heTSfomXizMsZk
         GyLXvDmJRoIf7JWGAzwX+W+HzcNjI8SDif7R9oq0eb8sItwTAzK0jsJFXez5DVZ5MROh
         8LodpxcePlcNUPrjrWggRF7+H/HHXuGZxlaBMNl1MIbEqokJuDf/bfbt1xR8wVM3a5yK
         Xh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=eIK0S734s+WuMuzHGxUrnoQabUzsOPxTYvMm/ke78tI=;
        b=Xvsxlt49tK6oGtIz/NkP1gwEpC4BATw82XUeeDVw6SrQllXGbps0P+woYTSxHeozpL
         dZabO2AYmSxgMhpsSQ/SI3Peyq5kqEg2OP8XeTQgUR0pGx3bTGNlhL801VIsVAdwFbxr
         ncvJRugGcMC9R7JxZ/1mI/Ez+d+uv7eZMAppBVy9bmUUaT6mBvMewioXjDedQGb4R+SZ
         XbOU9lysxpHSR+uSAJsDKfyAHItNkqUch4xxtwt+azDmiXNgjHaBSfhuB1KA/a2kwCvE
         mtAg0athILg7nmLaBQUdVErwhux2jNqXGZ6d54vEYFC5/QBEOncP7fEcVZZg2pOm+CgB
         rh4g==
X-Gm-Message-State: ACrzQf0c4MZsFZRv5+uh4MmzWyUbnc42FYTcVYwUQWsVu6lcMjulf1Xe
        TXJMTlNXU4JaVoYxGto0SNlzc078TDE=
X-Google-Smtp-Source: AMsMyM48IxUnhOyact6I+qmIgU38+68zbAYlQB/H/hsqJ5msHgmA0uWrdQMTcWETwn+9Nr3+eHzpivVfQRk=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:686d:27b5:495:85b7])
 (user=glider job=sendgmr) by 2002:a17:906:9bd3:b0:76f:8cce:7a61 with SMTP id
 de19-20020a1709069bd300b0076f8cce7a61mr282972ejc.345.1663254300266; Thu, 15
 Sep 2022 08:05:00 -0700 (PDT)
Date:   Thu, 15 Sep 2022 17:03:42 +0200
In-Reply-To: <20220915150417.722975-1-glider@google.com>
Mime-Version: 1.0
References: <20220915150417.722975-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220915150417.722975-9-glider@google.com>
Subject: [PATCH v7 08/43] kmsan: mark noinstr as __no_sanitize_memory
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

noinstr functions should never be instrumented, so make KMSAN skip them
by applying the __no_sanitize_memory attribute.

Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Marco Elver <elver@google.com>

---
v2:
 -- moved this patch earlier in the series per Mark Rutland's request

Link: https://linux-review.googlesource.com/id/I3c9abe860b97b49bc0c8026918b17a50448dec0d
---
 include/linux/compiler_types.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 4f2a819fd60a3..015207a6e2bf5 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -229,7 +229,8 @@ struct ftrace_likely_data {
 /* Section for code which can't be instrumented at all */
 #define noinstr								\
 	noinline notrace __attribute((__section__(".noinstr.text")))	\
-	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
+	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage \
+	__no_sanitize_memory
 
 #endif /* __KERNEL__ */
 
-- 
2.37.2.789.g6183377224-goog

