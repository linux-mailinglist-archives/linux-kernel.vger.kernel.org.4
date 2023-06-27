Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F4A73EF8C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 02:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjF0ACd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 20:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjF0ACc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 20:02:32 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0986C5;
        Mon, 26 Jun 2023 17:02:30 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-3458a08310aso13579005ab.3;
        Mon, 26 Jun 2023 17:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687824150; x=1690416150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qg2KUH6YMBj2eN2aEtzkgtiYkQL1wDcya22Dq84KAL0=;
        b=eXnqbSBJDFJjfibslGCyT1NTo95GSTccgHpecgbt9FV06Tj4exgC8MK5RgRV9qzkbh
         fONb1dLS5svxkwKRcl4dng+/E1mkVJiVlGxBflnMVFWGEpD5XMZU+vCdHkuFs44CHGEI
         HkPUjyyWkhGG6qWt/vnyrJ8IK8p7Dk0KSY0jzFLGo8jerAno9zrSkvy0dzLrdtNLXKh+
         zES3WNmWuJRFTYoJ5kmE0Qd/4Eghiq313pN+GyM7G6C6rKAKDYJOBt/S+qBpaNZmdIJj
         HS04TWkCcHtk01GqwmCukA11r9gxpIGHnxkiyjkIL7KEE/p9RnMqe5JX2fuGcdCXr5+v
         darA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687824150; x=1690416150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qg2KUH6YMBj2eN2aEtzkgtiYkQL1wDcya22Dq84KAL0=;
        b=OMW6Mg4/ez239CDlSua/AjSINIp8CmQEZ4JqZVMBCoVTStA/7qavZqFlakI00IYyim
         uu2T1gXQVfQ3Wh/mRCEiiRV12g3EdICzV8Bn5Utp+pzRCxUc18u+XxDXEEJKcms3ZJru
         uldvcfOijQxP/d6Vw5i6Zr+000S2zMquxNcFZyB0rMSCJU8sEvQ/X5inYmXottCMcMQp
         Y+Nawj4v0UCJAKXSF4FMyVAIxH5nhpQascb+8QVK67w7jpBvybUQWy1aV8W6sc5QfkMV
         sxnnHkuZSasRbVhwUrCaEJwRoSbBXgY96XPD4i7j+NziH4FpiPoK5oBBPvu2mP3BETbf
         UPiw==
X-Gm-Message-State: AC+VfDxE9mFvwj5UXrz7cd+X3/wQ3KZ/J6PAeNfImeoKv9u1QPdnlCke
        jEYJloVGX1bC4tnHjg3HLMQ=
X-Google-Smtp-Source: ACHHUZ4gqFGGIbB8wJk/toxi8obZ6ktxvt7geu159xIwH2eJFNvwUssm2izOVDiVcBkitWUuwXJYPQ==
X-Received: by 2002:a92:cc0b:0:b0:343:47fb:e68a with SMTP id s11-20020a92cc0b000000b0034347fbe68amr23232190ilp.26.1687824150172;
        Mon, 26 Jun 2023 17:02:30 -0700 (PDT)
Received: from google.com ([2601:647:6700:7f00:83fb:9433:2220:da46])
        by smtp.gmail.com with ESMTPSA id e13-20020a62aa0d000000b0067526282193sm2770730pff.157.2023.06.26.17.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 17:02:29 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
Date:   Mon, 26 Jun 2023 17:02:27 -0700
From:   Namhyung Kim <namhyung@kernel.org>
To:     James Clark <james.clark@arm.com>, Ian Rogers <irogers@google.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] perf report: Don't add to histogram when there is no
 thread found
Message-ID: <ZJonE3ZZ2cBUq0U8@google.com>
References: <20230626161059.324046-1-james.clark@arm.com>
 <20230626161059.324046-3-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230626161059.324046-3-james.clark@arm.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 05:10:58PM +0100, James Clark wrote:
> thread__find_map() chooses to exit without assigning a thread to the
> addr_location in some scenarios, for example when there are samples from
> a guest and perf_guest == false. This results in a segfault when adding
> to the histogram because it uses unguarded accesses to the thread member
> of the addr_location.

Looking at the commit 0dd5041c9a0ea ("perf addr_location: Add
init/exit/copy functions") that introduced the change, I'm not sure if
it's the intend behavior.

It might change maps and map, but not thread.  Then I think no reason
to not set the al->thread at the beginning.

How about this?  Ian?
(I guess we can get rid of the duplicate 'al->map = NULL' part)

Thanks,
Namhyung


---8<---
 
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 3860b0c74829..4cbb092e0684 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -581,15 +581,14 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 	maps__zput(al->maps);
 	map__zput(al->map);
 	thread__zput(al->thread);
+	al->thread = thread__get(thread);
 
 	al->addr = addr;
 	al->cpumode = cpumode;
 	al->filtered = 0;
 
-	if (machine == NULL) {
-		al->map = NULL;
+	if (machine == NULL)
 		return NULL;
-	}
 
 	if (cpumode == PERF_RECORD_MISC_KERNEL && perf_host) {
 		al->level = 'k';
@@ -605,7 +604,6 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 		al->level = 'u';
 	} else {
 		al->level = 'H';
-		al->map = NULL;
 
 		if ((cpumode == PERF_RECORD_MISC_GUEST_USER ||
 			cpumode == PERF_RECORD_MISC_GUEST_KERNEL) &&
@@ -619,7 +617,6 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 		return NULL;
 	}
 	al->maps = maps__get(maps);
-	al->thread = thread__get(thread);
 	al->map = map__get(maps__find(maps, al->addr));
 	if (al->map != NULL) {
 		/*
