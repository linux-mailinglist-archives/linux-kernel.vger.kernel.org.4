Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CF274F806
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 20:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjGKS2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 14:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjGKS2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 14:28:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA638171C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 11:28:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F0EF615C1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 18:28:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E93C433C8;
        Tue, 11 Jul 2023 18:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1689100105;
        bh=Q63ErUhKx/B8A6oY/cTvhH9I36Jjdmsq5mKxh0Ap7gA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CSH7LPGqrEdpjtkdclZcxbTuw+ib2iklGOxdCpbY1snhbwHXsJ/uRKmSHrm57Uebr
         gx1PwFYI6t1Xovi1RBuiOvAxW4V3VDF6YKorvkJVhyx5AatHT0EqFMr4ug0++qI3mL
         KMRPTumraPS1vi63DCc4W7wjIIsMX4oLhq3cfaeQ=
Date:   Tue, 11 Jul 2023 11:28:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yu Ma <yu.ma@intel.com>
Cc:     Liam.Howlett@Oracle.com, kirill@shutemov.name,
        dan.j.williams@intel.com, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        lipeng.zhu@intel.com, pan.deng@intel.com, shakeelb@google.com,
        tianyou.li@intel.com, tim.c.chen@intel.com,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH v2] mm/mmap: move vma operations to mm_struct out of the
 critical section of file mapping lock
Message-Id: <20230711112824.e559065488b08ce649cccfd7@linux-foundation.org>
In-Reply-To: <20230711172020.562250-1-yu.ma@intel.com>
References: <SN7PR11MB75902EEF55E7ABE8189C6CABE12CA@SN7PR11MB7590.namprd11.prod.outlook.com>
        <20230711172020.562250-1-yu.ma@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2023 13:20:20 -0400 Yu Ma <yu.ma@intel.com> wrote:

> UnixBench/Execl represents a class of workload where bash scripts are
> spawned frequently to do some short jobs. When running multiple parallel
> tasks, hot osq_lock is observed from do_mmap and exit_mmap. Both of them
> come from load_elf_binary through the call chain
> "execl->do_execveat_common->bprm_execve->load_elf_binary". In do_mmap,it will
> call mmap_region to create vma node, initialize it and insert it to vma
> maintain structure in mm_struct and i_mmap tree of the mapping file, then
> increase map_count to record the number of vma nodes used. The hot osq_lock
> is to protect operations on file’s i_mmap tree. For the mm_struct member
> change like vma insertion and map_count update, they do not affect i_mmap
> tree. Move those operations out of the lock's critical section, to reduce
> hold time on the lock.
> 
> With this change, on Intel Sapphire Rapids 112C/224T platform, based on
> v6.0-rc6, the 160 parallel score improves by 12%. The patch has no
> obvious performance gain on v6.4-rc4 due to regression of this benchmark
> from this commit f1a7941243c102a44e8847e3b94ff4ff3ec56f25 (mm: convert
> mm's rss stats into percpu_counter). Related discussion and conclusion
> can be referred at the mail thread initiated by 0day as below:
> Link: https://lore.kernel.org/linux-mm/a4aa2e13-7187-600b-c628-7e8fb108def0@intel.com/

Could you please redo/retest this against a kernel which has
1c7873e3364 ("mm: lock newly mapped VMA with corrected ordering")? 
mainline, mm-unstable or linux-next.

Thanks.
