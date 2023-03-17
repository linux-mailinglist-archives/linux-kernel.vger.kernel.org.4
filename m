Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5700D6BF655
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 00:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjCQXcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 19:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCQXce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 19:32:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6A65ADFE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 16:32:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9181FB8271A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 23:32:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01A5C4339C;
        Fri, 17 Mar 2023 23:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1679095950;
        bh=/tCm1L86obOUufk7D56dkllXJJ99oTn/2aNDIJC2fAk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BVCX9tdSMxZS933gOwx+Usv49KMfIh27RkCxsC4GzCVYdqIgdRJliZfliH6R3q95o
         8yoKLv7cbeX/kZuC+x9wMBSoGGkMhvyxuG8+RRbpJtvyPJRxkpyHiLRp3Y2TVcSna8
         27GQyhBtNqnHgfkzaT4qDgEgYlsqjooYzX+ZlB34=
Date:   Fri, 17 Mar 2023 16:32:29 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Leonardo Bras <leobras@redhat.com>,
        oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 2/2] memcg: do not drain charge pcp caches on remote
 isolated cpus
Message-Id: <20230317163229.51431ba28ba82c70eaa55d81@linux-foundation.org>
In-Reply-To: <202303180617.7E3aIlHf-lkp@intel.com>
References: <20230317134448.11082-3-mhocko@kernel.org>
        <202303180617.7E3aIlHf-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Mar 2023 06:22:40 +0800 kernel test robot <lkp@intel.com> wrote:

>    mm/memcontrol.c: In function 'drain_all_stock':
> >> mm/memcontrol.c:2369:35: error: implicit declaration of function 'cpu_is_isolated' [-Werror=implicit-function-declaration]
>     2369 |                         else if (!cpu_is_isolated(cpu))
>          |                                   ^~~~~~~~~~~~~~~

Thanks.

--- a/mm/memcontrol.c~memcg-do-not-drain-charge-pcp-caches-on-remote-isolated-cpus-fix
+++ a/mm/memcontrol.c
@@ -63,6 +63,7 @@
 #include <linux/resume_user_mode.h>
 #include <linux/psi.h>
 #include <linux/seq_buf.h>
+#include <linux/sched/isolation.h>
 #include "internal.h"
 #include <net/sock.h>
 #include <net/ip.h>
_

