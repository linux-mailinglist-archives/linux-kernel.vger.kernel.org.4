Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863F86488E9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 20:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiLITSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 14:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLITSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 14:18:50 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6861C13FBE
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 11:18:45 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id gt4so4109833pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 11:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XfOr98Gg1w98gjZZv7cU/ZVXNVv/sf1pm17+6ERdbfI=;
        b=SE7XAp8c6oDiwmvA7y/76JgCoO3m7hFicezI9MsUfyTS1hKXDNxs3msUsuBraXBIUX
         k+KQlnGOUoRa/5iGFv9I9m3LUPmPJEDbL3W3B7rDiuZdVCv23JLsLTG94ZHkzIQxwDYA
         WzXvzZ85cOtw0kmXSWzXrlPv5CD1E7sn+VAVxH0e5P/uB4NYJEAA0RauegPu3wcINuSo
         Vm+AAs0pU1hu76asMdtn1kXCukr8TUnbQsUSHrs07aLSqi3PUBqN7YPsBvdzJfT41p2d
         Lag0w06+ga97PYsMeFGBK9axzDhKms73qmbUYyjWPvD2aiO+7d4bEL6IQhocozKVRaen
         NWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XfOr98Gg1w98gjZZv7cU/ZVXNVv/sf1pm17+6ERdbfI=;
        b=v271hTpao5MxrhM1U+4gUepRMza5gx81/eSTWKi4ShJFy/Auz5aQx06dBX16ri9eSZ
         ue2lpmjWzvPtGZ8NKDMNrHwM4e+r9VPMrsYcfMvyGjQsGEuosVNRTeKc0IguKx00AXnS
         n3T4bTVdihiAfsb2tdgLQr1FI4v/RWZcstIMFK7nUto1eeyxXlSe0RYePc3iaR3X1ZmT
         9Xq0unrcVkQDB5LtJsoweprCCO/t66PL44fegz+xl384yeAv9bst36n4G6FLE/fVNg1N
         rGjPSnjIL2hhG4QECQQWZTauB59HHSmP6MF7JUbg3+PH+32GbwHvWqRNAWmKUjaI/Fv8
         6Zkg==
X-Gm-Message-State: ANoB5pkHcqnoYJ/4RPfcl9YqXKiv+vHHjr/zfEs7926PGhv9JRWDM+5D
        1cXziXOC/OfG30iJZgXvD1Q=
X-Google-Smtp-Source: AA0mqf5WOB5tLIukWr7Fp4nOVzEeN+7xKq62fBPUShW+r2Kf7W5OaNnyRBzc8hrE5Jx7pOGHebK+fw==
X-Received: by 2002:a17:903:31d6:b0:189:b170:233c with SMTP id v22-20020a17090331d600b00189b170233cmr1625359ple.3.1670613524931;
        Fri, 09 Dec 2022 11:18:44 -0800 (PST)
Received: from mail.google.com (125-237-37-88-fibre.sparkbb.co.nz. [125.237.37.88])
        by smtp.gmail.com with ESMTPSA id jb1-20020a170903258100b00180033438a0sm1663934plb.106.2022.12.09.11.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 11:18:44 -0800 (PST)
Date:   Sat, 10 Dec 2022 08:18:38 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Vipin Sharma <vipinsh@google.com>
Cc:     linux-kernel@vger.kernel.org,
        paulo.miguel.almeida.rodenas@gmail.com
Subject: [PATCH] scripts/tags.sh: allow only selected directories to be
 indexed
Message-ID: <Y5OKDvbGk4Kro6MK@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's common for drivers that share same physical components to also
duplicate source code (or at least portions of it). A good example is
both drivers/gpu/drm/amdgpu/* and drivers/gpu/drm/radeon/* have a header
file called atombios.h.

While their contents aren't the same, a lot of their structs have
the exact same names which makes navigating through the code base a bit
messy as cscope will show up 'references' across drivers which aren't
exactly correct.

This patch makes it possible for the devs to specify which folders
they want to include as part of the find_other_sources function if a
makefile variable OTHERSRCDIRS is present, otherwise the original
behaviour is kept.

Example:
	make ARCH=x86 OTHERSRCDIRS=drivers/gpu/drm/radeon,tools cscope

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
 scripts/tags.sh | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index e137cf15aae9..958c07c4ac4a 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -59,12 +59,17 @@ find_include_sources()
 }
 
 # find sources in rest of tree
-# we could benefit from a list of dirs to search in here
 find_other_sources()
 {
-	find ${tree}* $ignore \
-	     \( -path ${tree}include -o -path ${tree}arch -o -name '.tmp_*' \) -prune -o \
-	       -name "$1" -not -type l -print;
+	find_def_params="-name $1 -not -type l -print"
+	if [ -n "${OTHERSRCDIRS}" ]; then
+		exp_src_dirs=$(sed 's/,/ /g' <<< ${OTHERSRCDIRS})
+		find ${exp_src_dirs} ${ignore} ${find_def_params};
+	else
+		find ${tree}* ${ignore} \
+		     \( -path ${tree}include -o -path ${tree}arch -o -name '.tmp_*' \) \
+		     -prune -o ${find_def_params};
+	fi
 }
 
 find_sources()
-- 
2.38.1

