Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6891D6C745F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 01:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjCXAMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 20:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjCXAMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 20:12:34 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA478A274
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 17:12:32 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1a2104d8b00so39545ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 17:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679616752;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jvv9C59rhc8VgAfSWzkEFKj/ARn+/A5rkg8I++37eXY=;
        b=bOpzTcaUIpEBaVQFPK/sVBc1GSndpeuTUzy/by0x8jqGw5u0dF7MsmhEApFashkigh
         tfkRvaqMkQ0J76yegFVddAElJW2mDrKd/QEQPHqZWt+7TXgRC33ibqLsKx9yXCgZiMsw
         oNAWunzSvqJufJGunPqeCaFeSzDXiqdGObPuswowsfMgnIk4YoyvGQZNpKGfbIry1wV2
         2IKO8LhSFP2fQbPt6NiFB1PSn/jE/2nYgQ6s+SRa4cU4+7Rm+tkmU+SxU556A/CediPt
         zHJrGrcf7oremXiqh9QJNyBaHjxKiqZKaLdDR3WKQjQpG4k5+6GRCvUx7mL6XRqAy93o
         QZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679616752;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jvv9C59rhc8VgAfSWzkEFKj/ARn+/A5rkg8I++37eXY=;
        b=V0WzsS6SM1s3IkZwChaGBHz1HyGmTznQrM2wEfzSs2xvAA0YovdcG1KtSD0b5e48zJ
         453gMEoSz5X7cjYoLNtxnWVoF28AmMO1ckeCs6v/7e9ivbtmMdLvpxeAtseP4FINOIaE
         VlycI4UHPb/cv6sjW6ISSlOqNbf7zWRiI0gxFKIWZmDSh0sO/q24mlCb/JwhkoG3PFWf
         9JBinuDP8I1kktBvGw/2vlo/b4zEJyQwvK8xAsRP8PZdvwdF03Am5tBH4zGtGs0YSN74
         H4/xDK9CWxGt3tO30hRdSJYsLW0y9GEUugPiPyVkOrrzsUiNihZRMUooLWzOoTxB24Dg
         jLxQ==
X-Gm-Message-State: AAQBX9c2AwL7WjE1cGYAJNIFuszxJkUm9FsEBfyRUEfsRvBzFiokjucP
        FkxGi+0v0QL6Qgzmscsw4/COHQ==
X-Google-Smtp-Source: AKy350ZxqpPVJkrcYQZ1RvTrYL+a5BUqYJfiNDt+nIZjVtmaZEKVdwgnQZOrGGGQwBnQ5tUcTzW59g==
X-Received: by 2002:a17:902:d345:b0:1a2:78f:a858 with SMTP id l5-20020a170902d34500b001a2078fa858mr120214plk.8.1679616751812;
        Thu, 23 Mar 2023 17:12:31 -0700 (PDT)
Received: from google.com (25.11.145.34.bc.googleusercontent.com. [34.145.11.25])
        by smtp.gmail.com with ESMTPSA id ay6-20020a1709028b8600b0019a997bca5csm12802991plb.121.2023.03.23.17.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 17:12:31 -0700 (PDT)
Date:   Fri, 24 Mar 2023 00:12:28 +0000
From:   Fangrui Song <maskray@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Collingbourne <pcc@google.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] Makefile: use -z pack-relative-relocs
Message-ID: <20230324001228.z3d6ljonhqwphrux@google.com>
References: <20230323204427.3594372-1-maskray@google.com>
 <CAKwvOd=W49oqB7qg5Cv+MUVfQYixmdQY4FRSsMPTyecE9w0EzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOd=W49oqB7qg5Cv+MUVfQYixmdQY4FRSsMPTyecE9w0EzQ@mail.gmail.com>
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-23, Nick Desaulniers wrote:
>Hi Fangrui,
>Thanks for the patches!
>
>On Thu, Mar 23, 2023 at 1:44 PM Fangrui Song <maskray@google.com> wrote:
>>
>> Commit 27f2a4db76e8 ("Makefile: fix GDB warning with CONFIG_RELR")
>> added --use-android-relr-tags to fix a GDB warning
>>
>> BFD: /android0/linux-next/vmlinux: unknown type [0x13] section `.relr.dyn'
>>
>> The GDB warning has been fixed in version 11.2.
>>
>> The DT_ANDROID_RELR tag was deprecated since DT_RELR was standardized.
>> Thus, --use-android-relr-tags should be removed. While making the
>> change, replace --pack-dyn-relocs=relr with -z pack-relative-relocs,
>> which is supported since LLD 15.
>
>Looks like
>commit 4a8de2832a2a ("[ELF] Add -z pack-relative-relocs")
>
>>
>> As of today, GNU ld supports the latter option for x86 and powerpc64
>> ports and has no intention to support --pack-dyn-relocs=relr. In the
>> absence of the glibc symbol version GLIBC_ABI_DT_RELR,
>> --pack-dyn-relocs=relr and -z pack-relative-relocs are identical in
>> ld.lld.
>
>Won't this regress support for CONFIG_TOOLS_SUPPORT_RELR for LLD
>11-14? (which we still support, see Documentation/process/changes.rst;
>I guess we don't list LLD explicitly, but it's effectively under the
>llvm umbrella there).
>
>IIUC, looks like lld 7.0+ should support SHT_RELR based on looking at
>commit 11479daf2f06 ("lld: add experimental support for SHT_RELR sections.")
>
>So we might want to invoke the linker twice, once with the new flag,
>and again with the old if we fail the first time?

Yes, I am aware of the increased linker and debugger requirement and was
thinking the CONFIG_RELR=y case with ld.lld<15 did not matter.

Since you raised this, it seems that we should ld.lld<15. How about the following diff?


diff --git a/Makefile b/Makefile
index a2c310df2145..e23a85476d5d 100644
--- a/Makefile
+++ b/Makefile
@@ -1113,7 +1113,8 @@ LDFLAGS_vmlinux	+= -X
  endif
  
  ifeq ($(CONFIG_RELR),y)
-LDFLAGS_vmlinux	+= --pack-dyn-relocs=relr --use-android-relr-tags
+# ld.lld before 15 did not support -z pack-relative-relocs.
+LDFLAGS_vmlinux	+= $(call ld-option,--pack-dyn-relocs=relr,-z pack-relative-relocs)
  endif
  
  # We never want expected sections to be placed heuristically by the
diff --git a/scripts/tools-support-relr.sh b/scripts/tools-support-relr.sh
index cb55878bd5b8..355a9b1eb150 100755
--- a/scripts/tools-support-relr.sh
+++ b/scripts/tools-support-relr.sh
@@ -7,8 +7,9 @@ trap "rm -f $tmp_file.o $tmp_file $tmp_file.bin" EXIT
  cat << "END" | $CC -c -x c - -o $tmp_file.o >/dev/null 2>&1
  void *p = &p;
  END
-$LD $tmp_file.o -shared -Bsymbolic --pack-dyn-relocs=relr \
-  --use-android-relr-tags -o $tmp_file
+# ld.lld before 15 did not support -z pack-relative-relocs.
+$LD $tmp_file.o -shared -Bsymbolic -z pack-relative-relocs -o $tmp_file || \
+	$LD $tmp_file.o -shared -Bsymbolic --pack-dyn-relocs=relr -o $tmp_file
  
  # Despite printing an error message, GNU nm still exits with exit code 0 if it
  # sees a relr section. So we need to check that nothing is printed to stderr.
-- 
2.40.0.348.gf938b09366-goog


>>
>> Link: https://github.com/ClangBuiltLinux/linux/issues/1057
>> Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=a619b58721f0a03fd91c27670d3e4c2fb0d88f1e
>> Signed-off-by: Fangrui Song <maskray@google.com>
>> ---
>>  Makefile                      | 2 +-
>>  scripts/tools-support-relr.sh | 3 +--
>>  2 files changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index a2c310df2145..30c2edc35813 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1113,7 +1113,7 @@ LDFLAGS_vmlinux   += -X
>>  endif
>>
>>  ifeq ($(CONFIG_RELR),y)
>> -LDFLAGS_vmlinux        += --pack-dyn-relocs=relr --use-android-relr-tags
>> +LDFLAGS_vmlinux        += -z pack-relative-relocs
>>  endif
>>
>>  # We never want expected sections to be placed heuristically by the
>> diff --git a/scripts/tools-support-relr.sh b/scripts/tools-support-relr.sh
>> index cb55878bd5b8..58c2e8b02ce8 100755
>> --- a/scripts/tools-support-relr.sh
>> +++ b/scripts/tools-support-relr.sh
>> @@ -7,8 +7,7 @@ trap "rm -f $tmp_file.o $tmp_file $tmp_file.bin" EXIT
>>  cat << "END" | $CC -c -x c - -o $tmp_file.o >/dev/null 2>&1
>>  void *p = &p;
>>  END
>> -$LD $tmp_file.o -shared -Bsymbolic --pack-dyn-relocs=relr \
>> -  --use-android-relr-tags -o $tmp_file
>> +$LD $tmp_file.o -shared -Bsymbolic -z pack-relative-relocs -o $tmp_file
>>
>>  # Despite printing an error message, GNU nm still exits with exit code 0 if it
>>  # sees a relr section. So we need to check that nothing is printed to stderr.
>> --
>> 2.40.0.348.gf938b09366-goog
>>
>
>
>-- 
>Thanks,
>~Nick Desaulniers
