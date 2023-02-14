Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6C4696EA6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 21:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjBNUmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 15:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBNUmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 15:42:06 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953768A47
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 12:42:03 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-507aac99fdfso172111487b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 12:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BOmpvodct+bEQ6/XphOX6E6eTGDxLhq0Xmkyo1qSMF8=;
        b=srecc2beG278ZhC5jZOANd7du1DGZeY/KL51jh5SWdjBmwWk+gXVwCbZWlGBU+Bd+Y
         wBtQfTxrU9igtJg04vIhvh+yQ2Z2thqte/Jt4VspmhYfVdMate1sWQz0HDf1Z23OkDKU
         C0rQbJe9YmHFktIvQn/leObJUgO22AStsVXWSIn7A6H5rdTtW9OoRcKYvabaIm0teeva
         wN6x6w4eXzZN2IbBWohut7KA1yV7H6R2R6l9CW9cNepKodC0/xMlgM4h472fNLyFbIjF
         nbV1Twvv31ozxWg7dLf3P4pL3+GszPp4frIRuXNVn98pzL978HLKpSTz4o46ceaLyUxE
         rGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BOmpvodct+bEQ6/XphOX6E6eTGDxLhq0Xmkyo1qSMF8=;
        b=Pmc32nEQKXsNwN6FpDqpAVm933xeBU+3AWmSN8GoIQRySZG51jStzndon9VCuLp5cT
         Sca7Vf+6JX5DZP08tzi8trkz4upvH3KR/z8vOQ9j4NOdLOV3+giLoXx24eekFSnBBaKy
         BKAPDu5H04dvDh7c3xtKL8Hs+vLOqFL+ecvc1xiFhODux2ALKQC7+hkZX3QZZylcbfWy
         pwPFmk4SciJ59RNjh5VGnH1Bfc/bKcP0nKq5TwbdtpO2KhfnVMZIFtt8ct6n2fcxViza
         eR6YoNgg9u3FyfIHfL9e/bCrdWXxCvd1u8BIpAeUzXsEMkHTBvaEE3r3YrdLbp1eOOos
         2omw==
X-Gm-Message-State: AO0yUKUKfH8DtJQ252oQFZnWszGJ2WsLACbudjPyUBgUr2JSBBBgiTwu
        h+A9rLFi7jku1OFmzkRD2IMIiyebIT7mvQ==
X-Google-Smtp-Source: AK7set/EtkrRI0DUed8Ogo8bkFWrFZ/iKSMXTNNzp1tt/B5izlEKOUEWRMwJPJR622OxphM2iuVAaarACP3d8w==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a81:7cf:0:b0:52f:b5a:9643 with SMTP id
 198-20020a8107cf000000b0052f0b5a9643mr5ywh.8.1676407322500; Tue, 14 Feb 2023
 12:42:02 -0800 (PST)
Date:   Tue, 14 Feb 2023 20:41:42 +0000
In-Reply-To: <Y+snZioVyo82mAUj@kroah.com>
Mime-Version: 1.0
References: <Y+snZioVyo82mAUj@kroah.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230214204142.1514599-1-cmllamas@google.com>
Subject: [PATCH] scripts/tags.sh: fix incompatibility with PCRE2
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Carlos Llamas <cmllamas@google.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jialu Xu <xujialu@vimux.org>, Vipin Sharma <vipinsh@google.com>
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

Starting with release 10.38 PCRE2 drops default support for using \K in
lookaround patterns as described in [1]. Unfortunately, scripts/tags.sh
relies on such functionality to collect all_compiled_soures() leading to
the following error:

  $ make COMPILED_SOURCE=1 tags
    GEN     tags
  grep: \K is not allowed in lookarounds (but see PCRE2_EXTRA_ALLOW_LOOKAROUND_BSK)

The usage of \K for this pattern was introduced in commit 4f491bb6ea2a
("scripts/tags.sh: collect compiled source precisely") which speeds up
the generation of tags significantly.

In order to fix this issue without compromising the performance we can
switch over to an equivalent sed expression. The same matching pattern
is preserved here except \K is replaced with a backreference \1.

[1] https://www.pcre.org/current/doc/html/pcre2syntax.html#SEC11

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Jialu Xu <xujialu@vimux.org>
Cc: Vipin Sharma <vipinsh@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 scripts/tags.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index e137cf15aae9..0d045182c08c 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -91,7 +91,7 @@ all_compiled_sources()
 	{
 		echo include/generated/autoconf.h
 		find $ignore -name "*.cmd" -exec \
-			grep -Poh '(?(?=^source_.* \K).*|(?=^  \K\S).*(?= \\))' {} \+ |
+			sed -n -E 's/^source_.* (.*)/\1/p; s/^  (\S.*) \\/\1/p' {} \+ |
 		awk '!a[$0]++'
 	} | xargs realpath -esq $([ -z "$KBUILD_ABS_SRCTREE" ] && echo --relative-to=.) |
 	sort -u
-- 
2.39.1.581.gbfd45094c4-goog

