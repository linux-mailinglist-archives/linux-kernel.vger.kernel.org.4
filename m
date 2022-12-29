Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559BD658888
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 03:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbiL2CI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 21:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbiL2CI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 21:08:27 -0500
Received: from out-221.mta0.migadu.com (out-221.mta0.migadu.com [91.218.175.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE17B877
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 18:08:24 -0800 (PST)
Message-ID: <ce9e05f5-4752-7f70-9355-da881565b96c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1672279702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XoA8wcm8vNDF3JjdWU9rkQ7IGGhq07pfPELEbL9sYWw=;
        b=absds2v6QAAfiAjI6jEc4rGbjuwy9Yt9NI/fGrLEJAgIZBdRSms9UpEDzJLI9QZBtk6UAU
        O+51xoTcwlc/SrcKaVcoI9rH7jZFSu93vqsXrNgD42QqSOuA7Qw/JBOD9fnfTaXm6+DMnH
        Y1bukPIa6w/vyfvMtPgwtk8N5KPeE6E=
Date:   Thu, 29 Dec 2022 10:08:18 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] kbuild: rpm-pkg: add libelf-devel as alternative for
 BuildRequires
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ivan Vecera <ivecera@redhat.com>,
        Jonathan Toppins <jtoppins@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
References: <20221228191014.659746-1-masahiroy@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <20221228191014.659746-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/29/22 03:10, Masahiro Yamada wrote:
> Guoqing Jiang reports that openSUSE cannot compile the kernel rpm due
> to "BuildRequires: elfutils-libelf-devel" added by commit 8818039f959b
> ("kbuild: add ability to make source rpm buildable using koji").
> The relevant package name in openSUSE is libelf-devel.
>
> Add it an alternative package.
>
> BTW, if it is impossible to solve the build requirement, the final
> resort would be:
>
>      $ make RPMOPTS=--nodeps rpm-pkg
>
> This passes --nodeps to the rpmbuild command so it will not verify
> build dependencies. This is useful to test rpm builds on non-rpm
> system. On Debian/Ubuntu, for example, you can install rpmbuild by
> 'apt-get install rpm'.
>
> NOTE1:
>    Likewise, it is possible to bypass the build dependency check for
>    debian package builds:
>
>      $ make DPKG_FLAGS=-d deb-pkg
>
> NOTE2:
>    The 'or' operator is supported since RPM 4.13. So, old distros such
>    as CentOS 7 will break. I suggest installing newer rpmbuild in such
>    cases.
>
> Link: https://lore.kernel.org/linux-kbuild/ee227d24-9c94-bfa3-166a-4ee6b5dfea09@linux.dev/T/#u
> Fixes: 8818039f959b ("kbuild: add ability to make source rpm buildable using koji")
> Reported-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>   scripts/package/mkspec | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> index dda00a948a01..adab28fa7f89 100755
> --- a/scripts/package/mkspec
> +++ b/scripts/package/mkspec
> @@ -51,7 +51,8 @@ sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
>   	URL: https://www.kernel.org
>   $S	Source: kernel-$__KERNELRELEASE.tar.gz
>   	Provides: $PROVIDES
> -$S	BuildRequires: bc binutils bison dwarves elfutils-libelf-devel flex
> +$S	BuildRequires: bc binutils bison dwarves
> +$S	BuildRequires: (elfutils-libelf-devel or libelf-devel) flex
>   $S	BuildRequires: gcc make openssl openssl-devel perl python3 rsync
>   
>   	# $UTS_MACHINE as a fallback of _arch in case

Thanks for the quick fix! I verified the above works for openSUSE leap 15.4.

Tested-by: Guoqing Jiang <guoqing.jiang@linux.dev>

Thanks,
Guoqing
