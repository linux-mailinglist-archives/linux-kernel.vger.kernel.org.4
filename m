Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEFF6F3E80
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 09:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbjEBHqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 03:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjEBHqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 03:46:38 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46701BC7
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 00:46:36 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f09b4a1584so20913625e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 00:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683013595; x=1685605595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OR9YpJn1XmXl3Ur0RRGrvM6I+ArJCgZTqUBRtnIQvME=;
        b=FJ3zAj+RDHf4b7+E9OTJr+7SDCvUicN1UEdSiMGqfFqCL6r8rfn5/zDeQwMngS4IRR
         yUb4a5inKTmz9Ef++XRGQYTKa8WYnY9XW/G5qKCcP3/cjBxYTpb6G0X16cHr3DlY117Y
         emsAuKhus2tM9OAWNLO3SbALLsw64qBfgY2WBUEPzbFNTn2oc6FZVkXiEtkFv/r7N0ZH
         5iMpGgcyV6WzvbA/td/yr/rnb36RxLlcaHdNHSMEA7MGKjJJkTZ97AE6Jnav5ce7vlj4
         rnHJy1E+mhO4YryXCDy+NSnVthbiFlvHvMxxIHKF9izPSS4Xp56/KCr4yqeHH8j9q8tj
         5QFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683013595; x=1685605595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OR9YpJn1XmXl3Ur0RRGrvM6I+ArJCgZTqUBRtnIQvME=;
        b=WVrPvKww5eaiqNvDGrK9Nt2X5mCHJ9/SH67qM8puCf+saqf4d6JJT90iGvyTq4VUn7
         lqoPUHKain3xk4KpP2VBVW/1KkuBz6K+RlTEYfZ/HW762nb3Ma2d9vsqkn0meKx/dck+
         12rXeB977fAAauSX0nfvb4Yk5EDb2Hy6gbvuHE4s50ch3yPPgUnsWRVu+ei4s97FBHdt
         YI304Z7NZS4CDE9hRePL9wvv2rd1VJ8q0tPJ1pSYiUqb6oDWmn4IKfXuWZKG71WLTXvO
         dBCvlCE8yWqHhBPq/U39JuwvO1pLHJgRroWpnkJxjqdw+VIFFd675BMcP7WiEUHoEjHa
         cOrQ==
X-Gm-Message-State: AC+VfDy3Y1i+YSXBR09/FZhPdRLW2e96OcIT8o0wmyLLFReDIuuh6OAr
        MK9qqjn0OnTSSiDIDJCa2gU=
X-Google-Smtp-Source: ACHHUZ4Z/HfrPUlnrmtGlOLEbKEp7/fLkwmU2jsyp311hPN2hRmhdn1ZW0lpXljWY1CXaFwbFQ4akQ==
X-Received: by 2002:a05:6000:11c5:b0:2f5:83a8:a9a9 with SMTP id i5-20020a05600011c500b002f583a8a9a9mr10911632wrx.16.1683013594719;
        Tue, 02 May 2023 00:46:34 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id o3-20020a05600c378300b003ef5f77901dsm34412183wmr.45.2023.05.02.00.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 00:46:33 -0700 (PDT)
Date:   Tue, 2 May 2023 08:46:33 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Topel <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v6 3/3] mm/gup: disallow FOLL_LONGTERM GUP-fast writing
 to file-backed mappings
Message-ID: <db733020-c6c7-43f9-9cbf-0e5fb18b2f01@lucifer.local>
References: <dee4f4ad6532b0f94d073da263526de334d5d7e0.1682981880.git.lstoakes@gmail.com>
 <202305021142.vBYXxxEh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202305021142.vBYXxxEh-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 11:33:29AM +0800, kernel test robot wrote:
> Hi Lorenzo,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on akpm-mm/mm-everything]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/mm-mmap-separate-writenotify-and-dirty-tracking-logic/20230502-071520
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/dee4f4ad6532b0f94d073da263526de334d5d7e0.1682981880.git.lstoakes%40gmail.com
> patch subject: [PATCH v6 3/3] mm/gup: disallow FOLL_LONGTERM GUP-fast writing to file-backed mappings
> config: arm-randconfig-r013-20230502 (https://download.01.org/0day-ci/archive/20230502/202305021142.vBYXxxEh-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project b1465cd49efcbc114a75220b153f5a055ce7911f)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://github.com/intel-lab-lkp/linux/commit/602bb9fab888bd9176b8eeb80a0da68499c343ed
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Lorenzo-Stoakes/mm-mmap-separate-writenotify-and-dirty-tracking-logic/20230502-071520
>         git checkout 602bb9fab888bd9176b8eeb80a0da68499c343ed
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202305021142.vBYXxxEh-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
> >> mm/gup.c:114:49: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
>    static bool stabilise_mapping_rcu(struct folio *)
>                                                    ^
>    1 warning generated.
>
>
> vim +114 mm/gup.c
>
>    108
>    109	static void unlock_rcu(void)
>    110	{
>    111		rcu_read_unlock();
>    112	}
>    113	#else
>  > 114	static bool stabilise_mapping_rcu(struct folio *)
>    115	{
>    116		return true;
>    117	}
>    118
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests

Am slightly surprised that's a C2x extension :)

-fix patch attached

----8<----
From 829cb87ddd84e4496310b12d26e65de11d5b9e53 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lstoakes@gmail.com>
Date: Tue, 2 May 2023 08:40:48 +0100
Subject: [PATCH] mm/gup: disallow FOLL_LONGTERM GUP-fast writing to
 file-backed mappings

Fix compiler warning.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index 431618048a03..ffc3caf120fc 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -111,7 +111,7 @@ static void unlock_rcu(void)
 	rcu_read_unlock();
 }
 #else
-static bool stabilise_mapping_rcu(struct folio *)
+static bool stabilise_mapping_rcu(struct folio *folio)
 {
 	return true;
 }
--
2.40.1
