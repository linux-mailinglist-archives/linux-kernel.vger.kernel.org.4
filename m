Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3069643CC0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 06:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiLFFoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 00:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLFFoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 00:44:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C639122B08;
        Mon,  5 Dec 2022 21:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=8d8E8Zxi4DqG9crOyp7Wd4237RTp+YfV9h1RI5HT8ns=; b=YbqO6NipmViunyBd6gU24DjXkn
        QG8F3ldjr1F0ffg3hmymn24e4QBZ3QRgGGp8LT3EA9gug5C1IpZ4o7gKUBpPyHZ8fRefsOr6SJvr6
        5kfx5WRJyUcODSVhMZ1Rtwb1eTCTYAOSAqxj0Z1+JsmqToI7LxKKaAa6qkMPHxOcGBku5Ur2uwsYK
        gGiPrEDtLTZTI0NQgwgjYVUPI9O38yd3WFAi2DLalgEgqH7cIJVTuNQjvOU1PZ/kjD2G25d9CBEK8
        l2vWvdXJs1F57sq8kjc3Sksr8d7TgLhz4GooK8myupvDUvOzpfxUEItd9M0YEjVvRD0qf2TGeDvLO
        KvkqMgqA==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p2QkY-001T07-0K; Tue, 06 Dec 2022 05:44:14 +0000
Message-ID: <f8c49457-7f7a-b8bf-b212-b607a1ecf346@infradead.org>
Date:   Mon, 5 Dec 2022 21:44:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH next v2] kbuild: add ability to make source rpm buildable
 using koji
Content-Language: en-US
To:     Jonathan Toppins <jtoppins@redhat.com>,
        linux-kbuild@vger.kernel.org
Cc:     masahiroy@kernel.org, dzickus@redhat.com, ihuguet@redhat.com,
        ivecera@redhat.com, jtornosm@redhat.com, kheib@redhat.com,
        linux-kernel@vger.kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com, Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
References: <d6d5ce3169da8559cd20d20889849546cc69be50.1669042125.git.jtoppins@redhat.com>
 <88901065-469f-0988-f56b-c84d1fabbe8a@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <88901065-469f-0988-f56b-c84d1fabbe8a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/5/22 21:37, Jonathan Toppins wrote:
> On 11/21/22 09:48, Jonathan Toppins wrote:
>> From: Ivan Vecera <ivecera@redhat.com>
>>
>> Changes:
>> - added new target 'srcrpm-pkg' to generate source rpm
>> - added required build tools to spec file
>> - removed locally compiled host tools to force their re-compile
>>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>> Signed-off-by: Jonathan Toppins <jtoppins@redhat.com>
>> Acked-by: Íñigo Huguet <ihuguet@redhat.com>
>> Tested-by: Ivan Vecera <ivecera@redhat.com>
>> ---
>>
>> Notes:
>>      v2:
>>       * updated UTS_MACHINE to be $(UTS_MACHINE)-linux
>>         suggested by Masahiro Yamada
> 
> Quick ping, wanted to make sure I didn't miss any requests. Looking at patchwork there appear to be no replies to this version. Would it be reasonable to assume this version will be accepted and make it into the next kernel?

I have a request:
Tell us what "koji" is. I'm surprised that that word is not in the
patch description at all.

Thanks.

>>
>>   scripts/Makefile.package | 10 ++++++++++
>>   scripts/package/mkspec   |  7 +++++++
>>   2 files changed, 17 insertions(+)
>>
>> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
>> index 8bbcced67c22..1290f1c631fb 100644
>> --- a/scripts/Makefile.package
>> +++ b/scripts/Makefile.package
>> @@ -62,6 +62,16 @@ rpm-pkg:
>>       +rpmbuild $(RPMOPTS) --target $(UTS_MACHINE)-linux -ta $(KERNELPATH).tar.gz \
>>       --define='_smp_mflags %{nil}'
>>   +# srcrpm-pkg
>> +# ---------------------------------------------------------------------------
>> +PHONY += srcrpm-pkg
>> +srcrpm-pkg:
>> +    $(MAKE) clean
>> +    $(CONFIG_SHELL) $(MKSPEC) >$(objtree)/kernel.spec
>> +    $(call cmd,src_tar,$(KERNELPATH),kernel.spec)
>> +    +rpmbuild $(RPMOPTS) --target $(UTS_MACHINE)-linux -ts $(KERNELPATH).tar.gz \
>> +    --define='_smp_mflags %{nil}' --define='_srcrpmdir $(srctree)'
>> +
>>   # binrpm-pkg
>>   # ---------------------------------------------------------------------------
>>   PHONY += binrpm-pkg
>> diff --git a/scripts/package/mkspec b/scripts/package/mkspec
>> index 70392fd2fd29..dda00a948a01 100755
>> --- a/scripts/package/mkspec
>> +++ b/scripts/package/mkspec
>> @@ -33,6 +33,8 @@ EXCLUDES="$RCS_TAR_IGNORE --exclude=*vmlinux* --exclude=*.mod \
>>   --exclude=*.o --exclude=*.ko --exclude=*.cmd --exclude=Documentation \
>>   --exclude=.config.old --exclude=.missing-syscalls.d --exclude=*.s"
>>   +test -n "$LOCALVERSION" && MAKE="$MAKE LOCALVERSION=$LOCALVERSION"
>> +
>>   # We can label the here-doc lines for conditional output to the spec file
>>   #
>>   # Labels:
>> @@ -49,6 +51,9 @@ sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
>>       URL: https://www.kernel.org
>>   $S    Source: kernel-$__KERNELRELEASE.tar.gz
>>       Provides: $PROVIDES
>> +$S    BuildRequires: bc binutils bison dwarves elfutils-libelf-devel flex
>> +$S    BuildRequires: gcc make openssl openssl-devel perl python3 rsync
>> +
>>       # $UTS_MACHINE as a fallback of _arch in case
>>       # /usr/lib/rpm/platform/*/macros was not included.
>>       %define _arch %{?_arch:$UTS_MACHINE}
>> @@ -80,6 +85,8 @@ $S$M    against the $__KERNELRELEASE kernel package.
>>   $S$M
>>   $S    %prep
>>   $S    %setup -q
>> +$S    rm -f scripts/basic/fixdep scripts/kconfig/conf
>> +$S    rm -f tools/objtool/{fixdep,objtool}
>>   $S
>>   $S    %build
>>   $S    $MAKE %{?_smp_mflags} KBUILD_BUILD_VERSION=%{release}
> 

-- 
~Randy
