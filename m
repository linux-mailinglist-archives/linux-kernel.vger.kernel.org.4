Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966D95FE370
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 22:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJMUl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 16:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJMUl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 16:41:57 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A713E169CCE
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 13:41:56 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id t12-20020a17090a3b4c00b0020b04251529so2905106pjf.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 13:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6JICtmZ5L3A0h8C6yvptMu+Lji/U285FLCGFhTH6x80=;
        b=c7sKjaguGko9z/IakH5Gg5HPgMLMewRVpBvxxI+jDkspawnziECrx81yX5ZHRTBahW
         P9qjQbMWBHhm33q5lsrqAbzKBVGz4GFaJ3ZHF/GuFLwPxu2sMvI1E5uvXOi9ruj3JasX
         GPddpp8SSY5p/tXZavJAVe4QiHGxiFmToBeUWGh4DsT0/f+yNPCd5R4PDqsprt8aeCvR
         kC7oyxxAa3Mz4GN2hCjzi9kqoEK3W9OupXKm6LgrtU4r9TnyeNwkZGU909VoOUF7qK+y
         Km2eTbusk/bJ//WR/Hi8wEhRUoqHAI5DznKxZkhUMWsr67W0oiMUHkbWKcMoIh21l0uC
         0ifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JICtmZ5L3A0h8C6yvptMu+Lji/U285FLCGFhTH6x80=;
        b=iz7jVHFkwCVFmhLNUc7YbEYPXTu4NkAH0KzYTLucHE8sTtyoztPKxAvUW7oA5rqIIV
         i8QLKxHtfH1M5gLK7wGMHDcAbEBv2xgUmpQJPk//1vWq9Cr6g9NRl/gpgWjPu+osoz6e
         hIeDUQ/lcKxx+C1FzhggggSL7pbwBlacebjbLfRynexP6bhaEqLUcc22LS47djSUwi+x
         wRpHUCig22t6Xtc3NHqcs4VziLEUqmJNP2oPVi+GoV7ahpnnKB9FsnOA93RLI77r36L0
         4MUptVOJ84RuidRyjE3RHBCbu4etLVzYxKKuzHrNwYnFITyMyS4JA6sfJxr8P9Shbz+z
         vQlg==
X-Gm-Message-State: ACrzQf2Kc1d6fdhx7L2c/PUVTj6uZPIW8pif7lRs3kQ0BMGSs8UpmtYy
        UGS1fDCT+ZSc6K0nvIq2UZiVeg==
X-Google-Smtp-Source: AMsMyM6WTSYmWdPGI+Pjzy9fAYqwoSziLTAE+lOU9CD+8wcAlDFUz8PUopg4+rDzf1a7QHLj65fqcA==
X-Received: by 2002:a17:902:ec91:b0:182:8eca:ade2 with SMTP id x17-20020a170902ec9100b001828ecaade2mr1525554plg.12.1665693716000;
        Thu, 13 Oct 2022 13:41:56 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:9ffc:cb04:293c:acec])
        by smtp.gmail.com with ESMTPSA id k5-20020aa79985000000b0054223a0185asm109694pfh.161.2022.10.13.13.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 13:41:54 -0700 (PDT)
Date:   Thu, 13 Oct 2022 13:41:51 -0700
From:   Fangrui Song <maskray@google.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Tom Rix <trix@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] kbuild: add -fno-discard-value-names to cmd_cc_ll_c
Message-ID: <20221013204151.skzateatn2keencb@google.com>
References: <20221007203236.1750890-1-ndesaulniers@google.com>
 <Y0htZDJoTuQegVQR@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Y0htZDJoTuQegVQR@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-13, Nathan Chancellor wrote:
>On Fri, Oct 07, 2022 at 01:32:36PM -0700, Nick Desaulniers wrote:
>> When debugging LLVM IR, it can be handy for clang to not discard value
>> names used for local variables and parameters. Compare the generated IR.
>>
>> Implicit Default (-fdiscard-value-names):
>>   define i32 @core_sys_select(i32 %0, ptr %1, ptr %2, ptr %3, ptr %4) {
>>     %6 = alloca i64
>>     %7 = alloca %struct.poll_wqueues
>>     %8 = alloca [64 x i32]
>>
>> Explicit -fno-discard-value-names:
>>   define i32 @core_sys_select(i32 %n, ptr %inp, ptr %outp, ptr %exp,
>>                               ptr %end_time) {
>>     %expire.i = alloca i64
>>     %table.i = alloca %struct.poll_wqueues
>>     %stack_fds = alloca [64 x i32]
>>
>> The rule for generating human readable LLVM IR (.ll) is only useful as a
>> debugging feature:
>>
>> $ make LLVM=1 fs/select.ll
>>
>> Clang defaults to -fdiscard-value-names to save memory when generating
>> LLVM IR. For debugging purposes, the improvement in readability at a
>> cost of more verbose IR is a cost we're happy to pay.

A LLVM_ENABLE_ASSEERTIONS=off build of Clang defaults to -fdiscard-value-names.

A LLVM_ENABLE_ASSEERTIONS=on build of Clang defaults to -fno-discard-value-names.

See clang/lib/Driver/ToolChains/Clang.cpp:5030

>> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
>Thanks for the patch!
>
>Link: https://github.com/ClangBuiltLinux/linux/issues/1467
>Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Fangrui Song <maskray@google.com>

>> ---
>>  scripts/Makefile.build | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
>> index 27be77c0d6d8..d0e4f476dfee 100644
>> --- a/scripts/Makefile.build
>> +++ b/scripts/Makefile.build
>> @@ -140,7 +140,7 @@ $(obj)/%.symtypes : $(src)/%.c FORCE
>>  # LLVM assembly
>>  # Generate .ll files from .c
>>  quiet_cmd_cc_ll_c = CC $(quiet_modtag)  $@
>> -      cmd_cc_ll_c = $(CC) $(c_flags) -emit-llvm -S -o $@ $<
>> +      cmd_cc_ll_c = $(CC) $(c_flags) -emit-llvm -S -fno-discard-value-names -o $@ $<
>>
>>  $(obj)/%.ll: $(src)/%.c FORCE
>>  	$(call if_changed_dep,cc_ll_c)
>>
>> base-commit: 93ed07a23fd08b8613f64cf0a15d7fbdaca010fd
>> --
>> 2.38.0.rc2.412.g84df46c1b4-goog
>>
>
