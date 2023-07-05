Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252CC747D24
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjGEGdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjGEGdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:33:35 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060CD171C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 23:33:22 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1b055511b85so5551706fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 23:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688538801; x=1691130801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtlHSYlk61uE8OQ84nuywDVrRHfSI4oOT81ysMvjyFA=;
        b=YwXhEKM0bu8FLh1wIz59SqsCgWkobp8aMDaj1CHNsuATyIC4RfmsCuv+E2a0nBcO3E
         WDTMK08X82N1aLjr5w800Rmi5KkdfuSXoG5l/ZsyDV8RgeW0Y9gk8RsRABpvUrPPItNC
         oAJPB8tv5xMpX8RQvRgMYbfppt/cgVN4dJ6u4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688538801; x=1691130801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OtlHSYlk61uE8OQ84nuywDVrRHfSI4oOT81ysMvjyFA=;
        b=T8bOjXvQ9FTK6EypuDsPtkYgzcamUIs+o03wiiUwRmEfqHtG/7NjaOalhX2mteqBks
         U7+KENg5Rna8w8C0Rki8vFvniDZI7Ek3yQuhxMJcvfwaC5G2Nh/fd3+jYnuXfuqTX8QD
         f9wZo8lVGUujz/QfrK+ZK1RFIVXb+t5Mfn/aCW+L9ZmmVY3tSsnYKXgRfWRibJdQHEsk
         804UvTq+33tKSpqCXNpvaVjyEMIYHcfNWtwjt//7kzXXcllyOkrKfvW9fEb1TIIZ8URI
         COB9TVjNBo3yohXLtt1fJK54mH3oTyuMQzzNfGQe2daHGNPikJgOV5mvwuLa8nmoXio1
         8+8g==
X-Gm-Message-State: ABy/qLZb0ZgEj8t9GD72WarPSMuI03SbVN29ziIEPaX44367sm01V2dd
        fldlmxpywNeOYUgOsfiRuxwQyTF5giUtx9W/7aA=
X-Google-Smtp-Source: APBJJlGWMaUVY0TTBQBklTknGLh3stDvEgk0pSskAi32YTtDZEDoFGMo+Ddm6TezqBzUtzqDD1VujQ==
X-Received: by 2002:a05:6870:ac9a:b0:1ad:4d4:34c5 with SMTP id ns26-20020a056870ac9a00b001ad04d434c5mr17360781oab.39.1688538801499;
        Tue, 04 Jul 2023 23:33:21 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id h18-20020a63f912000000b0051b36aee4f6sm17145711pgi.83.2023.07.04.23.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 23:33:20 -0700 (PDT)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, asmadeus@codewreck.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 2/2] selftests/memfd: sysctl: fix MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
Date:   Wed,  5 Jul 2023 06:33:15 +0000
Message-ID: <20230705063315.3680666-3-jeffxu@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230705063315.3680666-1-jeffxu@google.com>
References: <20230705063315.3680666-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

Add selftest for sysctl vm.memfd_noexec is 2
(MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED)

memfd_create(.., MFD_EXEC) should fail in this case.

Reported-by: Dominique Martinet <asmadeus@codewreck.org>
Closes: https://lore.kernel.org/linux-mm/CABi2SkXUX_QqTQ10Yx9bBUGpN1wByOi_=gZU6WEy5a8MaQY3Jw@mail.gmail.com/T/
Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 tools/testing/selftests/memfd/memfd_test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index dba0e8ba002f..dbdd9ec5e397 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -1147,6 +1147,11 @@ static void test_sysctl_child(void)
 	sysctl_assert_write("2");
 	mfd_fail_new("kern_memfd_sysctl_2",
 		MFD_CLOEXEC | MFD_ALLOW_SEALING);
+	mfd_fail_new("kern_memfd_sysctl_2_MFD_EXEC",
+		MFD_CLOEXEC | MFD_EXEC);
+	fd = mfd_assert_new("", 0, MFD_NOEXEC_SEAL);
+	close(fd);
+
 	sysctl_fail_write("0");
 	sysctl_fail_write("1");
 }
-- 
2.41.0.255.g8b1d071c50-goog

