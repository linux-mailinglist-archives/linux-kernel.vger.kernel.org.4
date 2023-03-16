Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E076BC43D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 04:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjCPDKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 23:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjCPDKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 23:10:17 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423F520568
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 20:10:16 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id a2so341096plm.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 20:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678936216;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qdTpg3Vl/G//xMzeyCbPzh8UIOf3V5q7hPMjnAsDuG4=;
        b=O005cU5dJsRih8ktI4SN6TV2OUApRrnoRcaWVToeUttS/lrimEXxRnrLoJyU3ZmEV0
         ArbV8lY4vZn3rBZCMSd4aTGZqfKCvcU+14V/mY12/2PRrGS+1Qj9wwRG2PO9yII+P/r5
         b8HvQFWG+xgFO5xbsRfAHBxpXXbgYusE1zQk+NDtjrQNsGMfbhNS89u7LzVwVtzT9odP
         WB+nCdU4HnCdVmfcG5BPi4yQHuCZl3JJEcCnUnSR+YcSSaBn8lWbO6T2TknbC5d4o84b
         JifdmI0mp4YTWtiIFMefKlJcI4E3KAWPT2o+DKL4y0xnJZvOZrR7VYWrs7nUIA/iTyI8
         VnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678936216;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qdTpg3Vl/G//xMzeyCbPzh8UIOf3V5q7hPMjnAsDuG4=;
        b=uG2wKhNde1qd5gZXSS8PhwEm4J78Bj9yRFR72A2zi3muBygyvqMMRR2f2IE//0u6ZA
         jYxg5dLp+JIncaBFVgJFRomuz2eYfRZZzhY6nTwnIK8XhgvCzUJ9wuKozTaYekz4rJ6H
         Nx3pSMgaR2J7Bb5+FZS6Yv7xnyI/RKhIvoL9548r7tOyh1BazEeC8y7O0hJgR4aFqxRR
         xVQVqnraZ16d+An9OxqRNCHqxGQ/1mG+gK6t4O4g8hH78V1wyVm+XV34QePZvqqyEJHA
         fVyKxV4RCFCXx4zE/e7THCDibH5kiezeNjASy3mUJHuu3HtDdS/ssr/0+EELIuMzn6wD
         TOKg==
X-Gm-Message-State: AO0yUKX1fEgQODLG35Gg/z++R0CEFRNs8of9+70Y+6AfN6jys03D9lrG
        9ZE7xdAGD541tpNYHT5FiuvHfg==
X-Google-Smtp-Source: AK7set//ovEB2NXtKp5RwZmadOOvHLadL6LO61G9fAXmSu+4SfMssw+lhhSHsOpjIR6kKqqWG/v7wQ==
X-Received: by 2002:a17:90b:3902:b0:234:a88e:d67e with SMTP id ob2-20020a17090b390200b00234a88ed67emr1977794pjb.34.1678936215450;
        Wed, 15 Mar 2023 20:10:15 -0700 (PDT)
Received: from leoy-yangtze.lan ([107.151.177.133])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902bd4300b0019682e27995sm4310109plx.223.2023.03.15.20.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 20:10:14 -0700 (PDT)
Date:   Thu, 16 Mar 2023 11:10:06 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 00/16] perf kvm: Support histograms and TUI mode
Message-ID: <20230316031006.GC2267252@leoy-yangtze.lan>
References: <20230315145112.186603-1-leo.yan@linaro.org>
 <ZBId6CEVp4mTiFhq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZBId6CEVp4mTiFhq@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 04:35:04PM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> Trying to fix this:
> 
> ⬢[acme@toolbox perf-tools-next]$ git log --oneline -1 ; time make -C tools/perf build-test

I tried to run the build-test after I fetched the branch
acme/tmp.perf-tools-next and found errors; seems the errors are not
related with perf kvm but it's good to check a bit.

/usr/bin/ld: /usr/lib/llvm-15/lib/libclangSema.a(SemaRISCVVectorLookup.cpp.o): in function `clang::CreateRISCVIntrinsicManager(clang::Sema&)':
(.text._ZN5clang27CreateRISCVIntrinsicManagerERNS_4SemaE+0x1b8): undefined reference to `clang::RISCV::RVVIntrinsic::computeBuiltinTypes(llvm::ArrayRef<clang::RISCV::PrototypeDescriptor>, bool, bool, bool, unsigned int)'
/usr/bin/ld: (.text._ZN5clang27CreateRISCVIntrinsicManagerERNS_4SemaE+0x1f9): undefined reference to `clang::RISCV::RVVIntrinsic::computeBuiltinTypes(llvm::ArrayRef<clang::RISCV::PrototypeDescriptor>, bool, bool, bool, unsigned int)'
/usr/bin/ld: (.text._ZN5clang27CreateRISCVIntrinsicManagerERNS_4SemaE+0x2cc): undefined reference to `clang::RISCV::RVVType::computeTypes(clang::RISCV::BasicType, int, unsigned int, llvm::ArrayRef<clang::RISCV::PrototypeDescriptor>)'
/usr/bin/ld: (.text._ZN5clang27CreateRISCVIntrinsicManagerERNS_4SemaE+0x2ec): undefined reference to `clang::RISCV::RVVIntrinsic::getSuffixStr[abi:cxx11](clang::RISCV::BasicType, int, llvm::ArrayRef<clang::RISCV::PrototypeDescriptor>)'
/usr/bin/ld: (.text._ZN5clang27CreateRISCVIntrinsicManagerERNS_4SemaE+0x307): undefined reference to `clang::RISCV::RVVIntrinsic::getSuffixStr[abi:cxx11](clang::RISCV::BasicType, int, llvm::ArrayRef<clang::RISCV::PrototypeDescriptor>)'
/usr/bin/ld: (.text._ZN5clang27CreateRISCVIntrinsicManagerERNS_4SemaE+0x36c): undefined reference to `clang::RISCV::RVVType::computeTypes(clang::RISCV::BasicType, int, unsigned int, llvm::ArrayRef<clang::RISCV::PrototypeDescriptor>)'
collect2: error: ld returned 1 exit status

The complete building log is in the link:
https://termbin.com/jujt.

Later I think it would be a good habit to run build-test on my
patches locally :)

Thanks,
Leo
