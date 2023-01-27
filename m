Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CF267DAA6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 01:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjA0AUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 19:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjA0AUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 19:20:34 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6CD1EFC7;
        Thu, 26 Jan 2023 16:19:55 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id b10so3082460pjo.1;
        Thu, 26 Jan 2023 16:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=9ypUj7POs4xLGtv/nfXnLdHLn8gFaHVzUgoNscw+Tec=;
        b=RIlkHk2aXkP/O3krmxrSzlACAjpJhRCK2ToAy+db7cSN/JHAwdNVLnFrUkEMlyzJvy
         NQ4Fwm52DTCWFcTlEvh77GcPXBcrhGiVEJnsBHhMgXMM8MYK7ZbIZ9a+/1un62a3dUQw
         WAjFEKjWtGzlH42ev4GzudmOffwZq4GB+YJk7mF2VPW9yRwTDDVg4F/r6+vV7F+49E7c
         Jqzg9aqaR1y+OTsTD72Qotu+QgaO4Ps44vFQ8poJf8pB7tLC2NXVZRYD1nB1stLG7RjO
         Xu+iQ/n225Mc7DB5Gz+bfRh2Lw/MC8xy+BtLZ12Ic7mAFYBVSabtBEnnxb2xHyTs//2D
         ZRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ypUj7POs4xLGtv/nfXnLdHLn8gFaHVzUgoNscw+Tec=;
        b=xqjxrmZ6y9SL5f6Dv1otIde0UdweODWE8lFhkBazEFdSSYjoUJ2n/Khjvqnc7KfqiI
         iH+w8KyCaS8fCwLE84RSGMpDN1AzaA5yWAPi0Sq6BLhgmVQZLcDcO7HGarIeEPpTSfa3
         l2ZhDHVye1DjPiXcSMH8O5nBgpRIGp86tRmlQQgQ+xUIefF6EXiaCHLAZk6KApDLWeZt
         UKp59gtRqyItHChkfh8UkysHgf3Zm/AjxSQMQq++ctnOjsQ8tBjDZvgePEqoURlTQ4fS
         bbCopzo4fSE+xFaE3RvQfIHUIw1cdL6Ws9iFXM5hus+vI8O1mw6xzLArjg2m+X8PwQgB
         HXcg==
X-Gm-Message-State: AO0yUKU/Zh4mzP+sdWjG1awmGXsQR8Z6hV7ubd97+Hp84ho22p863UqP
        brpL6bTY6/cbh132M2JJ6WwAkWuptVg=
X-Google-Smtp-Source: AK7set+BXWkl1vPW5g4/U41YPLTDMjd4zuqi2RC830Au2ATreQJUiX+BoLmk8k6aKa8x0Fq3e1p88g==
X-Received: by 2002:a17:90a:1a10:b0:22c:23b5:4977 with SMTP id 16-20020a17090a1a1000b0022c23b54977mr4448751pjk.14.1674778795102;
        Thu, 26 Jan 2023 16:19:55 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:1f5d:eee8:d409:8a17])
        by smtp.gmail.com with ESMTPSA id v15-20020a17090a088f00b00229f7376247sm1567270pjc.57.2023.01.26.16.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 16:19:54 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 0/4] perf intel-pt: Fix the pipe mode (v1)
Date:   Thu, 26 Jan 2023 16:19:47 -0800
Message-Id: <20230127001951.3432374-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I found some problems in Intel-PT and auxtrace in general with pipe.
In the past it used to work with pipe, but recent code fails.  As it
also touches the generic code, other auxtrace users like ARM SPE will
be affected too.  I added a test case to verify it works with pipes.

At last, I can run this command without a problem.

  $ perf record -o- -e intel_pt// true | perf inject -b | perf report -i- --itrace=i1000

The code is available at 'perf/auxtrace-pipe-v1' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung

Namhyung Kim (4):
  perf inject: Use perf_data__read() for auxtrace
  perf intel-pt: Do not try to queue auxtrace data on pipe
  perf session: Avoid calling lseek(2) for pipe
  perf test: Add pipe mode test to the Intel PT test suite

 tools/perf/builtin-inject.c             |  6 +++---
 tools/perf/tests/shell/test_intel_pt.sh | 17 +++++++++++++++++
 tools/perf/util/auxtrace.c              |  3 +++
 tools/perf/util/session.c               |  9 +++++++--
 4 files changed, 30 insertions(+), 5 deletions(-)


base-commit: 5670ebf54bd26482f57a094c53bdc562c106e0a9
prerequisite-patch-id: 4ccdf9c974a3909075051f4ffe498faecab7567b
-- 
2.39.1.456.gfc5497dd1b-goog

