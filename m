Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F92164E5E8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 03:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiLPCQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 21:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiLPCQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 21:16:52 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649C4554C1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 18:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671157010; x=1702693010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jD/QbTXPxTN6CwQ6H2//4+0p877WHfZeYlVMeEKuv0E=;
  b=BX1iTsCH83mVw5wJe8k12obNHY1UVN7GZmIlpx892tCHah67SfKf09hx
   s7/Y+F42Nj+KLvZyUDDE3XxGNt8887/PSxRGZjisZumF1Z3p0yKbP4kET
   dcDSik+2U7H73HPhy2+XE5Wr1Vij0xMS0Erkkc5rBPwLXtfDE1/9urfh2
   6dsCL/0T1B8aZz2Fk2MZOvpue4IY6WN2CwSQEAkEKl+KeuhzACD8t69o4
   nNQpdXKDNvEucCVWoB9yBOLDYa8bXtV5MfFILJgMliyTyhwfhn0ULLcLV
   VP5IZBsggcaTInCWSnnXcBBB7J2Ai+tN+jvmzIgYWMET00B5oSv4tT70w
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="316503067"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="316503067"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 18:16:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="791892972"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="791892972"
Received: from milawils-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.217.73])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 18:16:48 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 94E9A100557; Fri, 16 Dec 2022 05:16:45 +0300 (+03)
Date:   Fri, 16 Dec 2022 05:16:45 +0300
From:   kirill.shutemov@linux.intel.com
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Subject: Re: [GIT PULL] x86/mm for 6.2
Message-ID: <20221216021645.jn576zrhadocpt66@box.shutemov.name>
References: <20221213174234.688534-1-dave.hansen@linux.intel.com>
 <CAHk-=wi=TY3Kte5Z1_nvfcsEh+rcz86pYnzeASw=pbG9QtpJEQ@mail.gmail.com>
 <20221215123007.cagd7qiidehqd77k@box.shutemov.name>
 <CAHk-=whC_ixb3FDdMhW_wiKw7-bB700kvUyqN+_cPUNp=1hNsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whC_ixb3FDdMhW_wiKw7-bB700kvUyqN+_cPUNp=1hNsQ@mail.gmail.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 09:17:11AM -0800, Linus Torvalds wrote:
>  - make thread creation lock it (and unlock it on creating a new mm at
> execve, but not fork).
> 
> And yes, I would actually suggest that _any_ thread creation locks it,
> so that you never *EVER* have any issues with "oh, now I need to
> synchronize with other threads". A process can set its LAM state at
> startup, not in the middle of running!

By thread creation, you mean CLONE_VM, right?

Do we care to avoid locking for CLONE_VFORK case? Seems excessive.

> Note that io_uring will automatically do that locking, because it does
> that thread creation (create_io_thread()). So io_uring threads won't
> even be a special case.

I've missed that io_uring does not use kthread_use_mm() anymore. But what
about other kthread_use_mm() users?

I did not find concrete cases where missing LAM setup would breaks things,
but I cannot prove opposite too.

kthread_use_mm() usage is suspicious in amdkfd, but I donno.

io_uring was a clear before it moved away from kthread_use_mm().

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
