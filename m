Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3CA6E106E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 16:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjDMOzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 10:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjDMOzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 10:55:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D567D8E;
        Thu, 13 Apr 2023 07:55:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B615A63F53;
        Thu, 13 Apr 2023 14:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9961C433EF;
        Thu, 13 Apr 2023 14:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681397714;
        bh=KGlany+US6LfDP1amF3+rZoFz/qh48FD/kxGZ/UN5d4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gpGDyMhikHhUMLjt91TRb9YruyTO3qzro1+3GvoXFb23oQKJeqIr71Hx1Kcr/1MCi
         SwPecrMC25LtD6GG+CKcOZT1JdV+tWypiSluy0w/LZhDiZkfRZgoPqpnqSMSH+MPJk
         6PrRE0RlFpqMaTv0z62qYAIs0wuv1MysTd088juw9t4MtwTsEtClNpFd6Hm+oxAyYl
         DDjSuYGVtVo7GlPnJDWKZ+zthr07jaJbqDsaY4W2YilIXPKuJG3D8Tq1vB7EEia/kP
         VlSf+FzWTeH8RC+xKvYNlbv7IUB7eTmtZK6xLLhb0g3Pnt8CE5v5AXe/oyLsE4G6ug
         WROy2L9mQFUHQ==
Date:   Thu, 13 Apr 2023 15:55:09 +0100
From:   Will Deacon <will@kernel.org>
To:     Fangrui Song <maskray@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH v3] Makefile: use -z pack-relative-relocs
Message-ID: <20230413145508.GC26421@willie-the-truck>
References: <20230411200944.2591330-1-maskray@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411200944.2591330-1-maskray@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 08:09:44PM +0000, Fangrui Song wrote:
> Commit 27f2a4db76e8 ("Makefile: fix GDB warning with CONFIG_RELR")
> added --use-android-relr-tags to fix a GDB warning
> 
> BFD: /android0/linux-next/vmlinux: unknown type [0x13] section `.relr.dyn'
> 
> The GDB warning has been fixed in version 11.2.
> 
> The DT_ANDROID_RELR tag was deprecated since DT_RELR was standardized.
> Thus, --use-android-relr-tags should be removed. While making the
> change, try -z pack-relative-relocs, which is supported since LLD 15.
> Keep supporting --pack-dyn-relocs=relr as well for older LLD versions.
> There is no indication of obsolescence for --pack-dyn-relocs=relr.
> 
> As of today, GNU ld supports the latter option for x86 and powerpc64
> ports and has no intention to support --pack-dyn-relocs=relr. In the
> absence of the glibc symbol version GLIBC_ABI_DT_RELR,
> --pack-dyn-relocs=relr and -z pack-relative-relocs are identical in
> ld.lld.
> 
> GNU ld and newer versions of LLD report warnings (instead of errors) for
> unknown -z options. Only errors lead to non-zero exit codes. Therefore,
> we should test --pack-dyn-relocs=relr before testing
> -z pack-relative-relocs.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1057
> Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=a619b58721f0a03fd91c27670d3e4c2fb0d88f1e
> Signed-off-by: Fangrui Song <maskray@google.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  Makefile                      | 3 ++-
>  scripts/tools-support-relr.sh | 8 ++++++--
>  2 files changed, 8 insertions(+), 3 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Masahiro -- are you happy to pick this one up? If not, I can take it via
arm64 (as the only arch currently using this reloc format).

Cheers,

Will
