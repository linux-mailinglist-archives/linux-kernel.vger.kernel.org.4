Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43D56AA7E1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 04:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCDDsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 22:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjCDDsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 22:48:42 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536E012F0C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 19:48:41 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so4135330pja.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 19:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2yVYyb0m321tEQ1IEeqZTIPuPQyMbVQqDZxIADBpS5c=;
        b=NPpYK1F/sUp6Xdh6Uumxwm0qAjQQx4quuYtJoICj9CKB/S4Wdu9gMseKJjFlR6Y1Bi
         I/SmAomCv9/JZuZlTsk7Ap0VjA2LJ/RZe0fQ5/fgXhy67EwE4ZAdzxhbLUU+6Pt6turS
         wDRx9Htvf1wogmKPqRZHIylaF/Myu8cJHzq0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2yVYyb0m321tEQ1IEeqZTIPuPQyMbVQqDZxIADBpS5c=;
        b=cCD/Ky316P5pW9bB0OqWUSBFVzBcUHoUMw/3q6PyeaFXM83RjCeJHSEA23Z4pt/cL6
         dMrRd0soq8+AGvVWfUsmKmU/UJgdN4wYKSZg3k7HMDb4NlhwNcshyuwykltppZRRbNi2
         MhHfLEG2l3k8nBA2E76RQP09IAB2FKJLhQ79w6kf3vngy3WbhBsroulk54Y3DurePUWy
         4AIS0wT9rJ4URpnRmJfZitO6Q3oe1I57KpggLJFg/BJq5YphsPYR8phEAkZ1jEcfxrJo
         LU2bFPQ2JpQC4boenvpZ9RtJPh5UXNAWVor3VK5+nCUWmaAPytTc/6G1imjyUVlhC/ZD
         LBKQ==
X-Gm-Message-State: AO0yUKW7gLBnTPzs22JLPSk0Yoje1FTELXizukCkS6iotgLK1gsHqob3
        LqXUzfNW5WzGg1rCDUDTqQhtSg==
X-Google-Smtp-Source: AK7set8j7lPxnTXNsxtEvwbE5dWdxQNsueDFzcxLhlOo45FjZ4F+3AU3AnMDyE4VKWr+bIgytXnODQ==
X-Received: by 2002:a17:90b:1d04:b0:22c:4dd3:5c4b with SMTP id on4-20020a17090b1d0400b0022c4dd35c4bmr4130172pjb.19.1677901720804;
        Fri, 03 Mar 2023 19:48:40 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6ac2:6eee:5465:7ee6])
        by smtp.gmail.com with ESMTPSA id d6-20020a170902c18600b00199025284b3sm2249204pld.151.2023.03.03.19.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 19:48:40 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 0/4] zsmalloc: fine-grained fullness and new compaction algorithm
Date:   Sat,  4 Mar 2023 12:48:31 +0900
Message-Id: <20230304034835.2082479-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

Existing zsmalloc page fullness grouping leads to suboptimal page
selection for both zs_malloc() and zs_compact(). This patchset
reworks zsmalloc fullness grouping/classification.

Additinally it also implements new compaction algorithm that is
expected to use less CPU-cycles (as it potentially does fewer
memcpy-s in zs_object_copy()).

Test (synthetic) results can be seen in patch 0003.

v4:
-- fixed classes stats loop bug (Yosry)
-- fixed spelling errors (Andrew)
-- dropped some unnecessary hunks from the patches

v3:
-- reworked compaction algorithm implementation (Minchan)
-- keep existing stats and fullness enums (Minchan, Yosry)
-- dropped the patch with new zsmalloc compaction stats (Minchan)
-- report per inuse ratio group classes stats

Sergey Senozhatsky (4):
  zsmalloc: remove insert_zspage() ->inuse optimization
  zsmalloc: fine-grained inuse ratio based fullness grouping
  zsmalloc: rework compaction algorithm
  zsmalloc: show per fullness group class stats

 mm/zsmalloc.c | 358 ++++++++++++++++++++++++--------------------------
 1 file changed, 173 insertions(+), 185 deletions(-)

-- 
2.40.0.rc0.216.gc4246ad0f0-goog

