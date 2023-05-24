Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864C070EEE2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239818AbjEXHDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239850AbjEXHCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:02:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8883BE58;
        Wed, 24 May 2023 00:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2OaUTp4ZRQUOY55Yg1WPlf0hn1iqC3dU2Mbi8zTI3/k=; b=lX2m2yIkItEs056NYHTBAHhZj8
        QVvxDU0NrO9dwxgF77pA3pAWrRQ0zDCJKP4xdyXYUW9/MYTojGN6Ke/rZTwxaBFWtCaLT/D9AsAEr
        NbnKuGNH2AUaCKxPk/IA6GnNsfYCTbY/G4pjZyFT4j/DtbLSt2tyugy3AAg8Zv5Mu+V2+p6qn0E7l
        v+ZG8LiWsNELPqhyR53dCFmFN1J7oumkL4wWzPM67dE70NyGq7IsSJkQw+z+D5lz6L5clmxFycZ+U
        dSfdrhkLuF8oA+uVwnvM8DWbXRR0lfjNpoR6H2eHF6IN5WYSka3WR4Vu0EjSOSLAB3uTpSOt3qH4F
        lKtZ4Kww==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1iW0-00CYa4-1R;
        Wed, 24 May 2023 07:02:32 +0000
Date:   Wed, 24 May 2023 00:02:32 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Allen Webb <allenwebb@google.com>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, christophe.leroy@csgroup.eu,
        nick.alcock@oracle.com
Subject: Re: [PATCH v10 08/11] build: Add modules.builtin.alias
Message-ID: <ZG22iPLED+SJsEFa@bombadil.infradead.org>
References: <20221219204619.2205248-1-allenwebb@google.com>
 <20230406190030.968972-1-allenwebb@google.com>
 <20230406190030.968972-9-allenwebb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406190030.968972-9-allenwebb@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 02:00:27PM -0500, Allen Webb wrote:
> Generate modules.builtin.alias using modpost and install it with the
> modules.

Why? This is probably one of the more important commits and the
commit log is pretty slim.

> Signed-off-by: Allen Webb <allenwebb@google.com>
> ---
>  .gitignore               |  1 +
>  Makefile                 |  1 +
>  scripts/Makefile.modpost | 15 +++++++++++++++
>  3 files changed, 17 insertions(+)
> 
> diff --git a/.gitignore b/.gitignore
> index 13a7f08a3d73..ddaa622bddac 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -71,6 +71,7 @@ modules.order
>  /System.map
>  /Module.markers
>  /modules.builtin
> +/modules.builtin.alias
>  /modules.builtin.modinfo
>  /modules.nsdeps
>  
> diff --git a/Makefile b/Makefile
> index a2c310df2145..43dcc1ea5fcf 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1578,6 +1578,7 @@ __modinst_pre:
>  	fi
>  	@sed 's:^\(.*\)\.o$$:kernel/\1.ko:' modules.order > $(MODLIB)/modules.order
>  	@cp -f modules.builtin $(MODLIB)/
> +	@cp -f modules.builtin.alias $(MODLIB)/
>  	@cp -f $(objtree)/modules.builtin.modinfo $(MODLIB)/
>  
>  endif # CONFIG_MODULES
> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> index 0980c58d8afc..e3ecc17a7a19 100644
> --- a/scripts/Makefile.modpost
> +++ b/scripts/Makefile.modpost
> @@ -15,6 +15,7 @@
>  # 2) modpost is then used to
>  # 3)  create one <module>.mod.c file per module
>  # 4)  create one Module.symvers file with CRC for all exported symbols
> +# 5)  create modules.builtin.alias the aliases for built-in modules

Does everyone want that file?

>  # Step 3 is used to place certain information in the module's ELF
>  # section, including information such as:
> @@ -63,6 +64,20 @@ modpost-args += -T $(MODORDER)
>  modpost-deps += $(MODORDER)
>  endif
>  
> +ifneq ($(wildcard vmlinux.o),)
> +output-builtin.alias := modules.builtin.alias
> +modpost-args += -b .modules.builtin.alias.in
> +.modules.builtin.alias.in: $(output-symdump)
> +	@# Building $(output-symdump) generates .modules.builtin.alias.in as a
> +	@# side effect.
> +	@[ -e $@ ] || $(MODPOST) -b .modules.builtin.alias.in vmlinux.o

Does using -b create a delay in builds ? What is the effect on build
time on a typical 4-core or 8-core build? Does everyone want it?

Should we add a new option which lets people decide if they want this
at build time or not?

  Luis

> +
> +$(output-builtin.alias): .modules.builtin.alias.in
> +	sort -o $@ $^
> +
> +__modpost: $(output-builtin.alias)
> +endif
> +
>  ifeq ($(KBUILD_EXTMOD),)
>  
>  # Generate the list of in-tree objects in vmlinux
> -- 
> 2.39.2
> 
