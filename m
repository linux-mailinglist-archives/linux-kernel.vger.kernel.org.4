Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C72D6930D0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 13:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjBKMPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 07:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjBKMO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 07:14:57 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6282023106
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 04:14:56 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o18so7723487wrj.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 04:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yx4QveUkxsZ076CSy140ixdXzrbrRAsprIFkOwOHph8=;
        b=frRGdTqBZv/KsdKobxihqMiDzGE6yzyL6O4P/bithC+kcSrWbWHlVRvVaCcWtI47ie
         PsYGjy56QaKtblrUA7PFmyb57yZvWPzJ/i03UJrBVa5OWkyRcpfA71u97ZAu4OfVSHaV
         GNdnS8f80DPjyK5Tf6qb1K0KBuOlciDjx7u3VaqevispGEWgy3L5IvqF7jqT9+S6sdjl
         2HlSJlqy0XgTo5SVNUHyANUzLH5D7woVFh6jD14llKkOk0wiMFHwlPWD9qnEjJX/eJSM
         hRCthdwnTN0RnmKnDurb+ybb4lQfVVowQgOmrF1jD8dm03rDYcP/1axGjKa1Q5SUx2Px
         ZtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yx4QveUkxsZ076CSy140ixdXzrbrRAsprIFkOwOHph8=;
        b=C3ymP/lsS32ASR8BnIRJhLdEjnGN8piaxkHZSWWG4/YLz6XRXwStp0pEQ2tXQsVJd4
         sw2n165VO/8rbk6D1W29NlCCgbd/7pGC/zYCiXt+CF0Y2lUgH/4cf3Z4I9xyinG44o5m
         w2oau7DfxLbubOPNTtWRe93OlVKdEDim/MVq0wyERFncI0OtJkvZwDysurHaQ5eu8cyh
         tvyKpbWdg7U4X58eZfVcB1DwRgBXNNs2h2w6sfmkTkX6pXN0jFNjkNaXNxpzRg4uZaKB
         kUjjbhvEjEYARV/8pZ1mL+BorLEqWk/RanU1w31NdfZYlKK6/QIMi2o1Ebi2zS+gsGFh
         2J6Q==
X-Gm-Message-State: AO0yUKUyOMJv9M6bjeWQDkr8Du/cZI2wDWhaOdENRXq7LcbpZ4OnTgXE
        /rDV1SQ9o43fxe5ofMLzqrrwwg==
X-Google-Smtp-Source: AK7set/Aj2QihFd7CLc49bJP+9LWC9eUVOuAma/o3Sf7yPxUcDQ0gUmtylPSPvsMTGJoLzFpyH2x+w==
X-Received: by 2002:adf:cf0d:0:b0:2c5:4ccc:a770 with SMTP id o13-20020adfcf0d000000b002c54ccca770mr3055463wrj.7.1676117695014;
        Sat, 11 Feb 2023 04:14:55 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h12-20020adff4cc000000b002be505ab59asm6041645wrp.97.2023.02.11.04.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 04:14:54 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] get_maintainer: add email addresses from dts files
Date:   Sat, 11 Feb 2023 13:14:41 +0100
Message-Id: <20230211121441.64359-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DTS/DTSI files represent hardware description for Linux kernel,
which is necessary to properly recognize and configure hardware by
Linux.  DTS is usually created by people having the actual hardware and
having interest in keeping it in good shape.  Such people can provide
review (they might have board schematics) and testing.  Unfortunately
they mostly do not appear in MAINTAINERS file.  Adding per-DTS entries
to MAINTAINERS would quickly make it bloated (hundreds of new per-DTS
entries).

On the other hand there is no point in CC-ing every Copyright email
appearing in files, because it might be outdated.  Add new in-file
pattern for storing maintainers dedicated to specific boards:

  Maintainer: John Smith <email>

Suggested-by: Joe Perches <joe@perches.com>
Suggested-by: Shawn Guo <shawnguo@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

This is rework of earlier approach:
Link: https://lore.kernel.org/r/20210809080204.8381-1-shawnguo@kernel.org
---
 scripts/get_maintainer.pl | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index ab123b498fd9..f02a2a80c3bc 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -445,6 +445,17 @@ sub maintainers_in_file {
 	my @poss_addr = $text =~ m$[A-Za-zÀ-ÿ\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
 	push(@file_emails, clean_file_emails(@poss_addr));
     }
+
+    # Match "Maintainer: email" entries only in DTS sources
+    if (-f $file && ($email_file_emails || $file =~ /\.dtsi?$/)) {
+	open(my $f, '<', $file)
+	    or die "$P: Can't open $file: $!\n";
+	my $text = do { local($/) ; <$f> };
+	close($f);
+
+	my @poss_addr = $text =~ m$Maintainer: [A-Za-zÀ-ÿ\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
+	push(@file_emails, clean_file_emails(@poss_addr));
+    }
 }
 
 #
-- 
2.34.1

