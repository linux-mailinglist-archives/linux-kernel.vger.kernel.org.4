Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56232641C56
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 11:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiLDKf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 05:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiLDKfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 05:35:25 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7088313F64
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 02:35:24 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id b81so4142138vkf.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 02:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fwuyG1HCJWJUAjK5O9FsiBCTfvXzIT2aWcUKCXdWWN4=;
        b=CpyJ8vLaUSAZg7MijqTf4h8l0yIWc1ZOuPN0pPN9nIcjtaeaWmvUxvn2jSBl9w9Ov7
         sibY2yTERj780ey2qljF1gWHZUoIXS3E9dqXR6Y8FD3X0G1h4/AqZEzkfFHSQBZ0w4t3
         2hfEzkCE3fJYPaD00/rsiAPMLKZxYb6Orw+zaKeByVz0af3mvsrsx0lH7ai0VNow+xJA
         yP5cfdjmHDRkuqRuO7o5R1Tmqlqz+lvqvb24lbVc/1Lb3Orty4lUVDCM1bQVpuOcTrxC
         W8e9a5/Jf1maApFLxsHnX+8Zsp0N+F8exxj6dbponu2nN5yUqn3OTbXqlRQpqmParZT3
         Tfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fwuyG1HCJWJUAjK5O9FsiBCTfvXzIT2aWcUKCXdWWN4=;
        b=1awpA1aH1SgpAyu1gwxA+K4+tW21VGfwYyU3nHBB/eeKPcFmRijO4zCs4DxJymwSyn
         QtTnMNqCV161VEWfWWejlgcbLwOH3/fPHJmkU8Uc8zFrX/PsMqJg2+TuqCDGNDa7c0bg
         2FqwwV1lfEz9xVQEc81TdHg5XLQh+z/bSFu0giviWjcDX3q8TxCiRCLwxCW4e+D+q+bU
         wootkpbiaUtMpFayfdsUMrVhd1nvxQry6FznDloGtHZNujuFANG23s7jOoZjYEU3AzE3
         CJW8AjaF7BdQNV49m6Ifsl25+pqeV0oOsjeZDp0frs6Wzv4wi2VYVPfVrKCOAgba+NCT
         0xkA==
X-Gm-Message-State: ANoB5pmJWv083H55/zVuk0gTL2C2l46OiQJ6ZOdXpxv1ug+2VJHcq8zv
        XieNu5mwSRyYWM9ViUCopuplqzrY/kw6c/++U8dd3g==
X-Google-Smtp-Source: AA0mqf4dtADW7mbQ5Zigm+6+B4ZVoLuCxmqE1LTovGR4O/kBxKKU5EgktsStOE3CKlurP+OhDrikoCRrq+VJDY/+2HE=
X-Received: by 2002:a1f:2348:0:b0:3bd:51f6:1f3 with SMTP id
 j69-20020a1f2348000000b003bd51f601f3mr6544287vkj.35.1670150123478; Sun, 04
 Dec 2022 02:35:23 -0800 (PST)
MIME-Version: 1.0
References: <20221204093008.2620459-1-almasrymina@google.com> <202212041833.kNUaRUeq-lkp@intel.com>
In-Reply-To: <202212041833.kNUaRUeq-lkp@intel.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Sun, 4 Dec 2022 02:35:12 -0800
Message-ID: <CAHS8izNFF+kYihrRru=w5P+bBYHJfJVNYf=6LZ3RtSNcMcuLzQ@mail.gmail.com>
Subject: Re: [PATCH v2] [mm-unstable] mm: Fix memcg reclaim on memory tiered systems
To:     kernel test robot <lkp@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, weixugc@google.com,
        fvdl@google.com, linux-kernel@vger.kernel.org
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

On Sun, Dec 4, 2022 at 2:32 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Mina,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on akpm-mm/mm-everything]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Mina-Almasry/mm-Fix-memcg-reclaim-on-memory-tiered-systems/20221204-173146
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20221204093008.2620459-1-almasrymina%40google.com
> patch subject: [PATCH v2] [mm-unstable] mm: Fix memcg reclaim on memory tiered systems
> config: alpha-buildonly-randconfig-r005-20221204
> compiler: alpha-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/332f41fcb1b1d6bc7dafd40e8c1e10a1a0952849
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Mina-Almasry/mm-Fix-memcg-reclaim-on-memory-tiered-systems/20221204-173146
>         git checkout 332f41fcb1b1d6bc7dafd40e8c1e10a1a0952849
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    mm/vmscan.c: In function 'demote_folio_list':
> >> mm/vmscan.c:1618:9: error: too many arguments to function 'node_get_allowed_targets'
>     1618 |         node_get_allowed_targets(pgdat, &allowed_mask, demote_from_nodemask);
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~
>    In file included from mm/vmscan.c:46:
>    include/linux/memory-tiers.h:94:20: note: declared here
>       94 | static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
>          |                    ^~~~~~~~~~~~~~~~~~~~~~~~
>

I missed updating this function signature. Will fix it in v3.

>
> vim +/node_get_allowed_targets +1618 mm/vmscan.c
>
>   1587
>   1588  /*
>   1589   * Take folios on @demote_folios and attempt to demote them to another node.
>   1590   * Folios which are not demoted are left on @demote_folios.
>   1591   */
>   1592  static unsigned int demote_folio_list(struct list_head *demote_folios,
>   1593                                        struct pglist_data *pgdat,
>   1594                                        nodemask_t *demote_from_nodemask)
>   1595  {
>   1596          int target_nid = next_demotion_node(pgdat->node_id);
>   1597          unsigned int nr_succeeded;
>   1598          nodemask_t allowed_mask;
>   1599
>   1600          struct migration_target_control mtc = {
>   1601                  /*
>   1602                   * Allocate from 'node', or fail quickly and quietly.
>   1603                   * When this happens, 'page' will likely just be discarded
>   1604                   * instead of migrated.
>   1605                   */
>   1606                  .gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) | __GFP_NOWARN |
>   1607                          __GFP_NOMEMALLOC | GFP_NOWAIT,
>   1608                  .nid = target_nid,
>   1609                  .nmask = &allowed_mask
>   1610          };
>   1611
>   1612          if (list_empty(demote_folios))
>   1613                  return 0;
>   1614
>   1615          if (target_nid == NUMA_NO_NODE)
>   1616                  return 0;
>   1617
> > 1618          node_get_allowed_targets(pgdat, &allowed_mask, demote_from_nodemask);
>   1619
>   1620          /* Demotion ignores all cpuset and mempolicy settings */
>   1621          migrate_pages(demote_folios, alloc_demote_page, NULL,
>   1622                        (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
>   1623                        &nr_succeeded);
>   1624
>   1625          __count_vm_events(PGDEMOTE_KSWAPD + reclaimer_offset(), nr_succeeded);
>   1626
>   1627          return nr_succeeded;
>   1628  }
>   1629
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
