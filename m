Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D902B6BCC26
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjCPKMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjCPKLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:11:53 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BECB8545;
        Thu, 16 Mar 2023 03:11:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1008DCE1C53;
        Thu, 16 Mar 2023 10:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32134C4339C;
        Thu, 16 Mar 2023 10:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678961504;
        bh=g4VbYwm2U87VNVEHikViwrfEMVGrHCyOBMRblCHGpjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bMnHuqfXIksvcgkmCNMun/ogFk9jOV6Q4hbldFVuWDP5tv6GfpYQJ+CzLx8ilVFl8
         4xtoe4dN1k0vmZYvxVkB5mupm73U9+BsFZ7jtuEIsu9K6NfbCGScTeCde6KxSWsbia
         YuBItBxKYR54ZTjMEb0Mb/NAbRECA4pmp/GhsZ1OO0gRls4O0ZlDue/FcX6bjS4liC
         NNZbpsXHtBiWPQazAhoiNkrPArJ4K/BVn5qFS+YxxqdT8qW0SCjOs7lsVlX/nFTV6m
         7NzhNKzsqLqR9Eikqx/OT6IMTwqMzLODz/GIvBaKMCBzKnhulB1A69ZS9mgiaGEyEE
         nbGoQsqP3O1Mw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 08A694049F; Thu, 16 Mar 2023 07:11:42 -0300 (-03)
Date:   Thu, 16 Mar 2023 07:11:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
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
Message-ID: <ZBLrXQ7JLvxAUdmD@kernel.org>
References: <20230315145112.186603-1-leo.yan@linaro.org>
 <ZBId6CEVp4mTiFhq@kernel.org>
 <20230316031006.GC2267252@leoy-yangtze.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230316031006.GC2267252@leoy-yangtze.lan>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 16, 2023 at 11:10:06AM +0800, Leo Yan escreveu:
> On Wed, Mar 15, 2023 at 04:35:04PM -0300, Arnaldo Carvalho de Melo wrote:
> 
> [...]
> 
> > Trying to fix this:
> > 
> > ⬢[acme@toolbox perf-tools-next]$ git log --oneline -1 ; time make -C tools/perf build-test
> 
> I tried to run the build-test after I fetched the branch
> acme/tmp.perf-tools-next and found errors; seems the errors are not
> related with perf kvm but it's good to check a bit.
> 
> /usr/bin/ld: /usr/lib/llvm-15/lib/libclangSema.a(SemaRISCVVectorLookup.cpp.o): in function `clang::CreateRISCVIntrinsicManager(clang::Sema&)':
> (.text._ZN5clang27CreateRISCVIntrinsicManagerERNS_4SemaE+0x1b8): undefined reference to `clang::RISCV::RVVIntrinsic::computeBuiltinTypes(llvm::ArrayRef<clang::RISCV::PrototypeDescriptor>, bool, bool, bool, unsigned int)'
> /usr/bin/ld: (.text._ZN5clang27CreateRISCVIntrinsicManagerERNS_4SemaE+0x1f9): undefined reference to `clang::RISCV::RVVIntrinsic::computeBuiltinTypes(llvm::ArrayRef<clang::RISCV::PrototypeDescriptor>, bool, bool, bool, unsigned int)'
> /usr/bin/ld: (.text._ZN5clang27CreateRISCVIntrinsicManagerERNS_4SemaE+0x2cc): undefined reference to `clang::RISCV::RVVType::computeTypes(clang::RISCV::BasicType, int, unsigned int, llvm::ArrayRef<clang::RISCV::PrototypeDescriptor>)'
> /usr/bin/ld: (.text._ZN5clang27CreateRISCVIntrinsicManagerERNS_4SemaE+0x2ec): undefined reference to `clang::RISCV::RVVIntrinsic::getSuffixStr[abi:cxx11](clang::RISCV::BasicType, int, llvm::ArrayRef<clang::RISCV::PrototypeDescriptor>)'
> /usr/bin/ld: (.text._ZN5clang27CreateRISCVIntrinsicManagerERNS_4SemaE+0x307): undefined reference to `clang::RISCV::RVVIntrinsic::getSuffixStr[abi:cxx11](clang::RISCV::BasicType, int, llvm::ArrayRef<clang::RISCV::PrototypeDescriptor>)'
> /usr/bin/ld: (.text._ZN5clang27CreateRISCVIntrinsicManagerERNS_4SemaE+0x36c): undefined reference to `clang::RISCV::RVVType::computeTypes(clang::RISCV::BasicType, int, unsigned int, llvm::ArrayRef<clang::RISCV::PrototypeDescriptor>)'
> collect2: error: ld returned 1 exit status

Nevermind this one, it is related to linking with clang libs, something
we'll deprecated.
 
> The complete building log is in the link:
> https://termbin.com/jujt.
> 
> Later I think it would be a good habit to run build-test on my
> patches locally :)

great!
 
> Thanks,
> Leo

-- 

- Arnaldo
