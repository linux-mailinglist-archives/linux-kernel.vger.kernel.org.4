Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D976119CE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiJ1SBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiJ1SBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:01:33 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8F61E8B84;
        Fri, 28 Oct 2022 11:01:32 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id l6so5342409pjj.0;
        Fri, 28 Oct 2022 11:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=E5Fawjdz//CY913JJ5jwFxvwPuQZcfdesxaOJNGqcAY=;
        b=o+GFBerinI2XeQJSXO2qlJ5+Du+CeHTM9pXn2DZeJNlGYjzpa5pAqbVUuN67AfrRmS
         N45NOKjC8F1cIWVHLxCv1Vobk0gPZbiZNWXiDO0vePMHt6ubtCed+StgebAf8NumhDQL
         4o2EEEotQw7chMXocG3G0nX/Vr0ctP+OKNetj5EIaXuC0m6h9mIgdOGCjaKD6k8Vr1oZ
         Q6QDTTpExSmzd+V2W99oIxZ9sSc6azIrbL3o/iGVViTAYMQbO933epSAqRp7DDjy0ybS
         lKzJnioXaQ4g1VG6kC1AzQIfseSSfzuuWFGVVb3h7XQNdfKHRCUd28ofKlvI72HtOETG
         yYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5Fawjdz//CY913JJ5jwFxvwPuQZcfdesxaOJNGqcAY=;
        b=J0vj2qM6RsKEnb/qGmsJvnaePlAm1GndJmK8D8or+wiBS/EC8wrHCrjNMUVy1EtMj8
         raW5+83WV3cM0RGChwqYzU/A+bG2zfgybpv006xlfVH9WNleHgqvWRHuVmJm8GgUEaD4
         itv3wTmVk4SPUGs8nq9Ki54ZVOvXyMvxChFfhsSSoaKRKiwpLqO9JjFxa0s1VbsXFLmc
         QEhD93gIE4flfFP+vLShyGjiHJxWAlLldQUKMcP4uIuN8jjScMyW77/er3g8qIXk5sRE
         wKmD8K3D0mhWv+PuLoZJZRSKlGptVvzZEQ+2gtRRYxbGiGTDt1OGGg5OuQfK+9FgLA7N
         gDWw==
X-Gm-Message-State: ACrzQf1H22ZcLvil2Y5gLHA7O2lSVvdrxsFNHz7ss/3dRhcdSU2EnzAQ
        m4VFZpz6mQJNSR6Dv0dKfKc=
X-Google-Smtp-Source: AMsMyM4Yz+hWIamQ2+lA+U58v4U0s1y77GCqHp+7UcWi8sepqbBImbOH+JfT+TdORqkeQzCKSyfUIQ==
X-Received: by 2002:a17:90b:4b46:b0:20a:e906:426d with SMTP id mi6-20020a17090b4b4600b0020ae906426dmr533181pjb.48.1666980091847;
        Fri, 28 Oct 2022 11:01:31 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:976f:f075:7c14:87a2])
        by smtp.gmail.com with ESMTPSA id n3-20020a170903110300b00186b86ed450sm3400236plh.156.2022.10.28.11.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 11:01:30 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 0/4] perf lock contention: Small random fixes
Date:   Fri, 28 Oct 2022 11:01:24 -0700
Message-Id: <20221028180128.3311491-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is a small update for the perf lock contention command.

The first issue is from msan (memory sanitizer) related to uninitialized
memory access and use of variable length array.

The other is to increase the default stack skip count to find appropriate
callers in most cases.

You can get it from 'perf/lock-con-fix-v1' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (4):
  perf lock contention: Fix memory sanitizer issue
  perf lock contention: Check --max-stack option
  perf lock contention: Avoid variable length arrays
  perf lock contention: Increase default stack skip to 4

 tools/perf/builtin-lock.c             | 30 +++++++++++++++++--
 tools/perf/util/bpf_lock_contention.c | 43 ++++++++++++++++++---------
 tools/perf/util/lock-contention.h     |  2 +-
 3 files changed, 57 insertions(+), 18 deletions(-)


base-commit: a3a365655a28f12f07eddf4f3fd596987b175e1d
-- 
2.38.1.273.g43a17bfeac-goog

