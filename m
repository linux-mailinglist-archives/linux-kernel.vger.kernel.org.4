Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FBC6A3F00
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjB0J7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjB0J7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:59:16 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB66D1DBB1;
        Mon, 27 Feb 2023 01:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677491956; x=1709027956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jR91B98qom+5gzYhQGkhIgN06B7vIdWxDnI3INGZGCs=;
  b=BsxIg7k0v3M1jV4470HDihWCqyLv1+MNESts87+xvkfr5e2cRoeHJCwe
   MRNQ2I8pB/1FTBFfhDUgcJEhsEkz/zrJKMmuDl/IgSxoq+GdftovZmJz5
   n8ZJ+L17wsawWJ0mTcKyMo9uLN4H0PkByBsTGCJL8feKkxYQFAVprxndW
   i4l3l759AA6UAPnOR99Q2S1Z4+/tTTDf3pdcrA1QXA26ORvF9LqTL0kuY
   SEowQ41opWvZ0vgamVTMUFLDTeomyRdeIqlKvYXrMBzCHENl9M11SiyOI
   LL3gnISY3ohq4bt4NZHeaMZgzTLXNYTxqKEzk7GIkSVH6Mp+A0OYMo3VN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="335304382"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="335304382"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 01:59:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="737604557"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="737604557"
Received: from jrissane-mobl2.ger.corp.intel.com (HELO intel.com) ([10.249.41.42])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 01:59:08 -0800
Date:   Mon, 27 Feb 2023 10:59:04 +0100
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [Intel-gfx] [PATCH v5 5/7] io_uring: use __xchg if possible
Message-ID: <Y/x+6KutaJKGv+Zz@ashyti-mobl2.lan>
References: <20230118153529.57695-1-andrzej.hajda@intel.com>
 <20230118154450.73842-1-andrzej.hajda@intel.com>
 <20230118154450.73842-5-andrzej.hajda@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118154450.73842-5-andrzej.hajda@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrzej,

On Wed, Jan 18, 2023 at 04:44:48PM +0100, Andrzej Hajda wrote:
> Recently introduced helper simplifies the code.
> 
> Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
