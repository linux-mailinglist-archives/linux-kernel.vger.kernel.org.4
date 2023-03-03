Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D121E6A91BB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 08:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjCCHbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 02:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjCCHbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 02:31:37 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD57F3B86D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 23:31:36 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id ce7so984431pfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 23:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YzELe6tbzHF+U+jaQa/Is388A8sqVUSz/+d91Se8xhs=;
        b=UOw/0iAjT/bHbvi3k8Rt1ao6u6z2+J1u4g9mXoK2hbpJNugvvb4GZT6PH2xsZR/5Ip
         iZMsaHmX/SHkZ914ZVExtLFo2wsSyHys8gdT0bRf+/GMJr4WHUm4YrJKl6qGMl0S4cR2
         SdiyeV72ptPVummoHcxP1OiNCjGXZ+yv9OOrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YzELe6tbzHF+U+jaQa/Is388A8sqVUSz/+d91Se8xhs=;
        b=xnnWjudYn7ebuEEoztYDEyTgGny9kDDagzZbuyKIR6uG2r/EklIFMPeEbBv/XEIggE
         GxVIfO7vuP4+IqdchVz/uTZKnnyQNb5Nbybg6HAP05hDfDnZtszDEz6R6/rq0u3uIZob
         ZckQhjCo3rRPAmch1OTWJo/0cfw5CT437sKVZzyyxhHi+qj6KvqOXx98uuS46BHTN9kK
         MOnI78IOXfZDp9s5wQ63ooUj48vCjN0TwJsBytowBvVePxQ7Fv7Fq4jhxT5tRdInjqa6
         Y0fu4mGrLpgH62fv/Rw4Y7vdr3yG3/lU+zhUAcUXMM/uKgGu6x/NCLvnRBV1oSZVd4NU
         aB4A==
X-Gm-Message-State: AO0yUKUopJycVU1/NUw9Ei4DSSB087pAGq8+/9jjbdocN8xXRCKB3RoV
        8Q5BGPw9qGdKydAO42LClBcI5rPU2GoVgzLu
X-Google-Smtp-Source: AK7set+HuY7xqseDrwLyzR/faOcmNeG81ro2icCnnTG12AeL2JWXQ/4SF2pBiE27fCEn5xxh3YTQwA==
X-Received: by 2002:a62:1781:0:b0:5a9:c43a:5810 with SMTP id 123-20020a621781000000b005a9c43a5810mr1097796pfx.25.1677828696221;
        Thu, 02 Mar 2023 23:31:36 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:badf:7e3e:d3f9:4956])
        by smtp.gmail.com with ESMTPSA id c18-20020aa781d2000000b005a8b4dcd21asm933439pfn.15.2023.03.02.23.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 23:31:35 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 0/4] zsmalloc: fine-grained fullness and new compaction algorithm
Date:   Fri,  3 Mar 2023 16:31:26 +0900
Message-Id: <20230303073130.1950714-1-senozhatsky@chromium.org>
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

 mm/zsmalloc.c | 362 ++++++++++++++++++++++++--------------------------
 1 file changed, 175 insertions(+), 187 deletions(-)

-- 
2.40.0.rc0.216.gc4246ad0f0-goog

