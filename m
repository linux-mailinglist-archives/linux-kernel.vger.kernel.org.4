Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758206A647F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 01:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjCAAzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 19:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjCAAzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 19:55:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7823C37B5E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 16:55:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39080B80EF4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 00:55:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F226C433D2;
        Wed,  1 Mar 2023 00:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677632123;
        bh=voMkNK1f6oVYmLyyFA6E1CLB/bXoNzaI4PWC7kFH4zQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lLnGKyZdLjtE6Xe4SeVIOyEwpRETIj8W0uctOJnG5a0TXPZYz82Y8doA3oXz4OTKw
         Rr4y9O7spms9jhNekJwnty4drAo1gxZ2j/Q+t3uJh/Idrpg1qzssSkfYWh9FZocRCG
         VwLp/CEet3GyCkvu52zc5PARcInP7cPOo4hCzD1Xx8cYYu2IoHsRd5cIeZJN1aiOIL
         xJoZjuYIjBgGzy1VZpAeRgxmLyW4OGKDnnsLbUiSABFFBUd50ZiGUdpErJbQyyKy+F
         OpBYPlXzi6KFkNlMn7Ie3XufX/hDl/LOiwH635dZInnmsd5qP1XfQpIVFQnigNS+vR
         HWtUSQpfaelKA==
From:   SeongJae Park <sj@kernel.org>
To:     "Pulavarty, Badari" <badari.pulavarty@intel.com>
Cc:     SeongJae Park <sj@kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "damon@lists.linux.dev" <damon@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [LSF/MM/BPF TOPIC] DAMON Updates and Future Plans
Date:   Wed,  1 Mar 2023 00:55:21 +0000
Message-Id: <20230301005521.78027-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <DM6PR11MB397833DB2DF869EB50D5E92F9CAD9@DM6PR11MB3978.namprd11.prod.outlook.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Badari,

On Wed, 1 Mar 2023 00:24:54 +0000 "Pulavarty, Badari" <badari.pulavarty@intel.com> wrote:

> Hi SJ,
> 
> We discussed this earlier. 
> 
> - Are there plans to make DAMON monitor/manage cgroup instead of individual pids? 

Yes.

For moniroting cgroups, there are only rough ideas at the moment, and no much
progress has made so far.  I hope to discuss about real needs of this feature
(I didn't make much progress here mainly because there was no many people
pushing this) and the best way for implementing it during the session if
possible.

For monitoring-based memory management of cgroups (via DAMOS), however, DAMOS
provides cgroup-based management action target memory filtering[1].  Using the
feature, you can do cgroups-based access-aware memory management.  The patchset
has merged into the mainline a few days ago.

[1] https://lore.kernel.org/damon/20221205230830.144349-1-sj@kernel.org/


Thanks,
SJ

> 
> Thanks,
> Badari
> 
> -----Original Message-----
> From: SeongJae Park <sj@kernel.org> 
> Sent: Monday, February 13, 2023 4:33 PM
> To: lsf-pc@lists.linux-foundation.org
> Cc: SeongJae Park <sj@kernel.org>; damon@lists.linux.dev; linux-mm@kvack.org; linux-kernel@vger.kernel.org
> Subject: [LSF/MM/BPF TOPIC] DAMON Updates and Future Plans
> 
> Hi all,
> 
> 
> DAMON has merged into mainline as a data access monitoring tool that equips a best-effort overhead-accuracy tradeoff mechanism, and then extended for data access-aware system operations.  I'd like to briefly introduce current state of DAMON and share/discuss about 2023 plans including below.
> 
> - Finer and easier-to-use DAMOS tuning
>   - tuning aggressiveness based on user or kernel feed (e.g., QPS or PSI)
> - Merging DAMON user space tool into the mainline
> - Extending DAMON
>   - Page-granularity monitoring
>     - LRU-lists based page-granulariy monitoring
>   - CPU-specific access monitoring
>   - Read/Write-only access monitoring
> - More DAMON-based Operation Schemes
>   - Tiered memory management
>   - THP memory footprint reduction
>   - NUMA balancing
> 
> I hope to hear concerns/interests about the plans for prioritizing each work items and get some suggestions of future works and collaboration with other kernel subsystems/hackers.
> 
> 
> Thanks,
> SJ
> 
