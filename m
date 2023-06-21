Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FA5739060
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjFUTrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjFUTrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:47:06 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0264FE65;
        Wed, 21 Jun 2023 12:47:06 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-25efb821778so2340487a91.3;
        Wed, 21 Jun 2023 12:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687376825; x=1689968825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B1YrRd+md0IIhC3jIqeqxvAewmHxT4sxnDw+1V2ULFc=;
        b=Jr0xlHsOkdoU24dUH2EQoSvufaYjE1yWgtUt8I2Jx0sijY8ZUrSXUVM6DsMB828nDo
         jgpEM1KFVJ5nKeyQInPLRlWwIC4rGSmP0IJP4ygA7G5qcbJg++ICAMit4/EqluArmWhA
         0UhPD0eGYW0NXqcqrUYXifWtqjyVZgcdr1EHD7hG586+JSil7/X3SDV+YPnRutk5AYR4
         Yv5n2/GGimGq7XO8gdVzxQmNvriTeUCa/PNokBHLXe4bnCqHinGthbHQoHrRgGqvp0QI
         lvciLdqOyBcwhauFFqkqXJ3w/exq2KtUqbQXdiOwx/+WNVxTe9FY9yrvUpQNa6bP2mJy
         5pSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687376825; x=1689968825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1YrRd+md0IIhC3jIqeqxvAewmHxT4sxnDw+1V2ULFc=;
        b=bXZIADFE3lgwcZNqKvHXwklhENI9hKpQGuJzckQr1Zysak4sxSKu4wIOYqXuEVroYO
         ksSApflJJTY1ukHuqiQ+PxDjhuLfDVZVwPH2Rc4aTLyOlLtBvfv3fVM90waPpukQ+v1M
         /YDn46uw0nnME2LCgShhzNmLu60Ffc0dbVlQaClo/Aj5QRWeBb9qVsV9ZVrI7HJwQbIr
         hYCQ1W2hDb/eh5JE1IkHr2GMQ3hWDU0GLZ8CLSloaGAE4StPOxXTBarhfWZ3nxjyOsD6
         HyO+OqSqB12UU5Jvc6qVG7uDGD0jaXzMLbIVs7GhXHI6UsQhntBR88p/vrS+Cph1LWVN
         AY4Q==
X-Gm-Message-State: AC+VfDzPTMw7lNkNZrKdmKTIU/tHEX5DVE1ukUWMwt1ni0rJrXfDLwFo
        Nf3hWlhM2KfuRwp/SmPKKwY=
X-Google-Smtp-Source: ACHHUZ7A246q0F+vrrSBzrKVUZzrMoFxIbVfGCbZvsqftZZTM9zITohw5HsdzBdD1yW+NJZtvAUpEw==
X-Received: by 2002:a17:90b:3cc:b0:25e:b055:220c with SMTP id go12-20020a17090b03cc00b0025eb055220cmr11655495pjb.33.1687376825323;
        Wed, 21 Jun 2023 12:47:05 -0700 (PDT)
Received: from yoga ([2400:1f00:13:6258:556c:aad7:2240:7612])
        by smtp.gmail.com with ESMTPSA id iq22-20020a17090afb5600b00259b729eea9sm3558879pjb.8.2023.06.21.12.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:47:05 -0700 (PDT)
Date:   Thu, 22 Jun 2023 01:16:58 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anup Sharma <anupnewsmail@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] scripts: python: Add temporary main function for testing
 purposes
Message-ID: <796905fa13aeb7621825d8a5a370f1fc78bbf298.1687375189.git.anupnewsmail@gmail.com>
References: <cover.1687375189.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687375189.git.anupnewsmail@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit introduces a temporary main function for ease of testing.
Please note that this function is not intended to be a permanent
part of the codebase.

The output is serialized as JSON and printed to the standard output
(stdout) with an indentation of 2 for better readability.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 tools/perf/scripts/python/firefox-gecko-converter.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
index 385a8b77a70a..0f133d9acee9 100644
--- a/tools/perf/scripts/python/firefox-gecko-converter.py
+++ b/tools/perf/scripts/python/firefox-gecko-converter.py
@@ -236,3 +236,14 @@ def convertPerfScriptProfile(profile):
         'pausedRanges': []
     }
 
+def main():
+#   inputFile = input('Enter input file name: ')
+    with open('perf_data.txt') as f:
+        profile = f.read()
+    isPerfScript = isPerfScriptFormat(profile)
+    output = convertPerfScriptProfile(profile)
+    json.dump(output, sys.stdout, indent=2)
+#   print('isPerfScript: {}'.format(isPerfScript))
+
+if __name__ == '__main__':
+    main()
-- 
2.34.1

