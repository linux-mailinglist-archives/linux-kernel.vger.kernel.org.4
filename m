Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA396A715F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 17:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjCAQi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 11:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjCAQix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 11:38:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23A54988C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 08:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677688561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FkL7Uhy+cPKcXOPgtSYv7QM09B2YNOq91Gba4VHb6zU=;
        b=P2WHxFxRK5T+Qbm3U0DTSgnZ3Klg+C5tIrtJamAvFyIxqtLR156VCM41ENHts35oPItMUm
        MxQEM1ueS6/7K+6PmGPapE2X6tnxXLhwKmmd2DQQMwJj1V8b3b07onscCohYkib/kA2v0s
        pWr/aLNGYGfal0QJ95EeMYuNiRwEXhA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-ZjNJ2f6tPp242lnTS68P2w-1; Wed, 01 Mar 2023 11:36:00 -0500
X-MC-Unique: ZjNJ2f6tPp242lnTS68P2w-1
Received: by mail-qt1-f199.google.com with SMTP id c5-20020ac85185000000b003bfae3b8051so6913996qtn.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 08:36:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677688560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkL7Uhy+cPKcXOPgtSYv7QM09B2YNOq91Gba4VHb6zU=;
        b=XvRrUMoR3slgGvzpVVJs/7jKVUNgF27f3nMMVjrbp6SkivZNwFkUybn2wcPP7R9XxN
         LbyCNAh6dwSp8Lz5hIPuxl36C75rGhaPhZNu7BFKhTNCJY/WwbSLnoRNzBQRQ00KHx+N
         pz2imO+IyrvaCuBjHKyUBAXPpOFnBRprqgHnYFWGOjxH3uyWPCzh7fZGfpJ+FaFUhdvv
         nDChD8L+iT+KZry+ZMGlthOsqtqwgvK7vHsMkWnDlpUn4MF1a7ik8Z1PuIZ2NtE8RfZY
         DZWP+Q6wNi8SqjR4O2rQDU2zXA8kQjFnWZO/mBJuYSlPbtt8Ee17IrcQnZCdFwD9ZsC9
         hsWw==
X-Gm-Message-State: AO0yUKUFMvklSJ23phE29Q2QSplTaq8PqfEnr6sfeVaQEKHh3ATQ7WKa
        D7n5r9XXdnft7Bum7ofzTTquBGw933Fjot8O9zX8j/oUpqltjvT5gqo8PxE2RJcfOzwBD3Yse7d
        V73ryXAdjJV+KQTp1LIT2RPZq
X-Received: by 2002:a05:622a:1993:b0:3bf:be4b:8094 with SMTP id u19-20020a05622a199300b003bfbe4b8094mr14665367qtc.0.1677688559660;
        Wed, 01 Mar 2023 08:35:59 -0800 (PST)
X-Google-Smtp-Source: AK7set8Cwi0eHdFAagaPGBeMs1+so6LN11xdXVXyv7QqXkjJci2aBg5qckwzm3APFdKOk2Zt7BkRJA==
X-Received: by 2002:a05:622a:1993:b0:3bf:be4b:8094 with SMTP id u19-20020a05622a199300b003bfbe4b8094mr14665328qtc.0.1677688559357;
        Wed, 01 Mar 2023 08:35:59 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id o26-20020ac8429a000000b003b64f1b1f40sm8613002qtl.40.2023.03.01.08.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 08:35:58 -0800 (PST)
Date:   Wed, 1 Mar 2023 11:35:56 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Joey Gouly <joey.gouly@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lennart Poettering <lennart@poettering.net>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Topi Miettinen <toiwoton@gmail.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-abi-devel@lists.sourceforge.net, nd@arm.com, shuah@kernel.org
Subject: Re: [PATCH v2 2/2] kselftest: vm: add tests for
 memory-deny-write-execute
Message-ID: <Y/9+7LMtZ1c/J8JV@x1n>
References: <20230119160344.54358-1-joey.gouly@arm.com>
 <20230119160344.54358-3-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+HtziZPaMlI7+HbK"
Content-Disposition: inline
In-Reply-To: <20230119160344.54358-3-joey.gouly@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+HtziZPaMlI7+HbK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Thu, Jan 19, 2023 at 04:03:44PM +0000, Joey Gouly wrote:
> From: Kees Cook <keescook@chromium.org>
> 
> Add some tests to cover the new PR_SET_MDWE prctl.
> 
> Co-developed-by: Joey Gouly <joey.gouly@arm.com>
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Cc: Shuah Khan <shuah@kernel.org>

May need to sync prctl.h into tools/include/uapi?  Otherwise selftests/mm
build fails here.  There's also one compiler report.  A fixup attached
which works for me.

Thanks,

-- 
Peter Xu

--+HtziZPaMlI7+HbK
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-fixup-kselftest-vm-add-tests-for-memory-deny-write-e.patch"

From ce8e17c244fcc743c7006316dd431c5650480756 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Wed, 1 Mar 2023 11:33:34 -0500
Subject: [PATCH] fixup! kselftest: vm: add tests for memory-deny-write-execute

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/include/uapi/linux/prctl.h       | 6 ++++++
 tools/testing/selftests/mm/mdwe_test.c | 3 +--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index e4c629c1f1b0..759b3f53e53f 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -281,6 +281,12 @@ struct prctl_mm_map {
 # define PR_SME_VL_LEN_MASK		0xffff
 # define PR_SME_VL_INHERIT		(1 << 17) /* inherit across exec */
 
+/* Memory deny write / execute */
+#define PR_SET_MDWE			65
+# define PR_MDWE_REFUSE_EXEC_GAIN	1
+
+#define PR_GET_MDWE			66
+
 #define PR_SET_VMA		0x53564d41
 # define PR_SET_VMA_ANON_NAME		0
 
diff --git a/tools/testing/selftests/mm/mdwe_test.c b/tools/testing/selftests/mm/mdwe_test.c
index f466a099f1bf..bc91bef5d254 100644
--- a/tools/testing/selftests/mm/mdwe_test.c
+++ b/tools/testing/selftests/mm/mdwe_test.c
@@ -163,9 +163,8 @@ TEST_F(mdwe, mprotect_WRITE_EXEC)
 
 TEST_F(mdwe, mmap_FIXED)
 {
-	void *p, *p2;
+	void *p;
 
-	p2 = mmap(NULL, self->size, PROT_READ | PROT_EXEC, self->flags, 0, 0);
 	self->p = mmap(NULL, self->size, PROT_READ, self->flags, 0, 0);
 	ASSERT_NE(self->p, MAP_FAILED);
 
-- 
2.39.1


--+HtziZPaMlI7+HbK--

