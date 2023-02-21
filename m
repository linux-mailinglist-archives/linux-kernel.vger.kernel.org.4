Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5832869E59B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbjBURKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjBURKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:10:41 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1ED52E817
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:10:33 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id v3so5020507vse.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b6Z7dmeluzCAiXgEQohTxdBXDJvxu0eI/vMtlc7BYzQ=;
        b=PEZyD8AW0uavJc+OwmuKHKTnU/dSX6x9oirBQFAyNkBDFQCzrBeiyYC+lWnpPOrMnl
         xQ9MJPmXSOhB0OF+6YxF4T1UhH29htPE1All5rTN1Y9yumdLuN23x6Vr3OeR3BJ4+GCx
         mxcFbA7lfQRuSMV6EolNsZODky5dETgI5JlxZBevVGabafp4Qir2SkKC/HHFgxq/ftsG
         ikeHv4EUs5LpZu/Q/lBnkw5pnsaWBTiftR9W9ROMHHk1Aj5TW66Tv5pgnj4ot5sKtAut
         5uRrQCPQjQWxf+X63oVWHWyZGfj0bfHwuag4XNY9pbX7ledN+WWlVTWibheZvRa4tzU8
         nubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b6Z7dmeluzCAiXgEQohTxdBXDJvxu0eI/vMtlc7BYzQ=;
        b=RcExr5+69fLdT4UH4weUGleC25RMcyV6K4ceq8jnaUUPWNa6XLgeR1FMuLRpw1Igtr
         +FYSZmfn+eEFH9H8kcuhxF8umOdJl0Xazf+NUQbo4q6WsgxJQQyNrb0vulF6eB12j+zV
         9a+W9QoAcn6vpSPtVUlhaA/hYn4RMDLnMNVYQqBhi+Zo0Nryb9RmVjRobFUntQJQH/VT
         z2RRXVdAIsoS5/VCLQ4L+MnRKbXYi7HC6t/KIlu5ALa1yyPBvlc+qT01H7QgRcUNCSeR
         8KzMttYw75eHpBZWWVJuwCaxPafXzBgZrsB9Bpw9rDdR2J1Kr6ZGzBb9TfjKenTU9p3e
         71Xw==
X-Gm-Message-State: AO0yUKXkNwkmUutayf2tj0gcDr0ukjZ8qbkYbDDEOTe2oUYAGSQNtu97
        ZaGVXe2jmm9rU6hQZSxde5BGIR0TV9cY40H8tLR/DA==
X-Google-Smtp-Source: AK7set/+2d7/pDH2gBHaBTDsVZHn4cw+WNlqroT0kOhVtkqaUEZMH8N+JmyQ9waxXjg/uhUTXMph1YPwvGuCshiNcYc=
X-Received: by 2002:a67:dc81:0:b0:41b:ed91:4d51 with SMTP id
 g1-20020a67dc81000000b0041bed914d51mr1402409vsk.84.1676999432910; Tue, 21 Feb
 2023 09:10:32 -0800 (PST)
MIME-Version: 1.0
References: <20230218002819.1486479-14-jthoughton@google.com> <202302190101.aoXrbN26-lkp@intel.com>
In-Reply-To: <202302190101.aoXrbN26-lkp@intel.com>
From:   James Houghton <jthoughton@google.com>
Date:   Tue, 21 Feb 2023 09:09:56 -0800
Message-ID: <CADrL8HXFMW4_7N+p_aLudcpkeR+0Gb4M0YSJyeQ-dPdvUZqZ1Q@mail.gmail.com>
Subject: Re: [PATCH v2 13/46] hugetlb: add hugetlb_hgm_walk and hugetlb_walk_step
To:     kernel test robot <lkp@intel.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Sat, Feb 18, 2023 at 10:08 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi James,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on next-20230217]
> [cannot apply to kvm/queue shuah-kselftest/next shuah-kselftest/fixes arnd-asm-generic/master linus/master kvm/linux-next v6.2-rc8 v6.2-rc7 v6.2-rc6 v6.2-rc8]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/James-Houghton/hugetlb-don-t-set-PageUptodate-for-UFFDIO_CONTINUE/20230218-083216
> patch link:    https://lore.kernel.org/r/20230218002819.1486479-14-jthoughton%40google.com
> patch subject: [PATCH v2 13/46] hugetlb: add hugetlb_hgm_walk and hugetlb_walk_step
> config: arm64-randconfig-r005-20230217 (https://download.01.org/0day-ci/archive/20230219/202302190101.aoXrbN26-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://github.com/intel-lab-lkp/linux/commit/7e55fe945a1b5f042746277050390bdeba9e22d2
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review James-Houghton/hugetlb-don-t-set-PageUptodate-for-UFFDIO_CONTINUE/20230218-083216
>         git checkout 7e55fe945a1b5f042746277050390bdeba9e22d2
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202302190101.aoXrbN26-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> ld.lld: error: undefined symbol: hugetlb_walk_step
>    >>> referenced by hugetlb.c
>    >>>               mm/hugetlb.o:(__hugetlb_hgm_walk) in archive vmlinux.a
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
>

This is fixed by providing a trivial definition of __hugetlb_hgm_walk
when !CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING. Will be done for v3.
hugetlb_walk_step() is only defined by architectures that support HGM.
