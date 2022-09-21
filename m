Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D23F5BFB18
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiIUJgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiIUJgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:36:08 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F4E8F966;
        Wed, 21 Sep 2022 02:36:06 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 9so5312954pfz.12;
        Wed, 21 Sep 2022 02:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=EY7f1vye1qs5rWXV1baAbSmWO5OxmPowtv9FR9+ng6A=;
        b=He6eVgwxCpvM7FQUloccwnQCjSmNWQO5WVzHyHQ1TdXo7p5QPBqdmNjTcbS+9Kc+eN
         7tuXkc5/B9THod1wvklYIgD5Ubq99gLiKyNlWZ6UT6DtPjHHpTae3PIQbdHnzIFgaGUf
         IPr/aAMHNiM/F8N7iGFKvXNCLdOVJt1eLXUqIsgy5MYzuWa/k79YG7SF8Z11rlRTKC41
         06EoD6MoaOnaDr2CS4HnRyMLvn5d2uvF5Eb/Fw6kHCq8f4e1/7a6rEksLJ2/mCfyYyF0
         8dySI1AMW8az5Ssqpx8vHKdXOieTt74scGpsllToIadpaIqxCZ2D13dfLKlfXKhbhFXn
         xw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=EY7f1vye1qs5rWXV1baAbSmWO5OxmPowtv9FR9+ng6A=;
        b=QWK+VsrJibKopdkIcdrk2b58DndfBH8R/OI4JX6dw5TUIvnGhaatveY5GL3sjutvIU
         R1EHk80bgLmEGR1AVAFd/yCzkzoueYRn+q19Z1FVA9AlfnkhCjzcbvF6VuGIzXY2lcjE
         sPT2TUnjMJ5llUM4XEWmPlpDHmdDVxl38eEUVS9f4cnc3vfSglE1Za1g7ugBGde42JeP
         F6DSJahYXjjs/Vt3mGcMOxAdo5jTTz+VELyt/ZzPuUBY9Hz55Ix+5ccktUgE46Qii4oh
         WcJK1tz9F3fSn3FLZsu7KosFyqlGe2JIRGW1+isfjkoP/18q5yuA7EZOPnG3/GCZ1nsi
         TChQ==
X-Gm-Message-State: ACrzQf3fEUMnR0yegK3uj3VCFMZ1YU06fBTKuhlKyUaPDR1kGBKsQw+w
        36ycXP28Ml2G+AB4jL4KRzE=
X-Google-Smtp-Source: AMsMyM5B7rUk20yozOmMtYjdlwFX6VJiuf/VXkruaO2wVY4NOoEniG8ap3MLWcIdJcRoPsBJjVUTEQ==
X-Received: by 2002:a63:da13:0:b0:438:e3cb:7a8c with SMTP id c19-20020a63da13000000b00438e3cb7a8cmr24169179pgh.31.1663752966383;
        Wed, 21 Sep 2022 02:36:06 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id z188-20020a6265c5000000b0053e7293be0bsm1625372pfb.121.2022.09.21.02.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:36:06 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     acme@kernel.org
Cc:     mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] tools x86 machine: use strscpy() is more robust and safer
Date:   Wed, 21 Sep 2022 09:36:01 +0000
Message-Id: <20220921093601.230800-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

The implementation of strscpy() is more robust and safer.

That's now the recommended way to copy NUL terminated strings.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 tools/perf/arch/x86/util/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/machine.c b/tools/perf/arch/x86/util/machine.c
index 31679c35d493..1ff0be147205 100644
--- a/tools/perf/arch/x86/util/machine.c
+++ b/tools/perf/arch/x86/util/machine.c
@@ -40,7 +40,7 @@ static int add_extra_kernel_map(struct extra_kernel_map_info *mi, u64 start,
 	mi->maps[mi->cnt].start = start;
 	mi->maps[mi->cnt].end   = end;
 	mi->maps[mi->cnt].pgoff = pgoff;
-	strlcpy(mi->maps[mi->cnt].name, name, KMAP_NAME_LEN);
+	strscpy(mi->maps[mi->cnt].name, name, KMAP_NAME_LEN);
 
 	mi->cnt += 1;
 
-- 
2.25.1
