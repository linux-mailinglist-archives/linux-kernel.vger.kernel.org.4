Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFED731F1C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjFORcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjFORc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:32:28 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559101FDD
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 10:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686850347; x=1718386347;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=gj1PE8jgcTAjvU5QpELZ2BVDX+vgouCIrJw6XJgXAGI=;
  b=GqFT9P00Zbh0a2/lpaNRpar0aXHALKvhhx6hveRRBeOtrL+PVeEfWY1B
   M5cCX1UPlUJLQF6uJuMiL3AoGgIlMuSmDVVE3RZ1gCGMyOQNNV5Y75GfQ
   t+vn3olJLL8c8zJL2VATcnmK8JTTme5VPaPWNE6/sAdXgexC4pm6fNRx3
   B5s+B/LhkXb8MzpgGyLE4PeIWawGUEvx+xjIXia4Mjp1qv7LSulf4OHcd
   9HS+7fgptj7b8Cnq+Quh6iM52qu39UyFbSohXy8fKpPw3tMgdrYigRiXZ
   SOkmEozxPP78Npv3AZBVgQ9h9crlIr/uyZONw8rse2TOvYEhciDsbibEI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="362402750"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="362402750"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 10:21:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="706764961"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="706764961"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by orsmga007.jf.intel.com with ESMTP; 15 Jun 2023 10:21:55 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 86E65302A4D; Thu, 15 Jun 2023 10:21:55 -0700 (PDT)
From:   Andi Kleen <ak@linux.intel.com>
To:     Breno Leitao <leitao@debian.org>
Cc:     pawan.kumar.gupta@linux.intel.com, jpoimboe@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, bp@alien8.de,
        leit@fb.com, hpa@zytor.com, x86@kernel.org, mingo@redhat.com,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] x86/bugs: Break down mitigations configurations
References: <20230615164417.3588162-1-leitao@debian.org>
Date:   Thu, 15 Jun 2023 10:21:55 -0700
In-Reply-To: <20230615164417.3588162-1-leitao@debian.org> (Breno Leitao's
        message of "Thu, 15 Jun 2023 09:44:11 -0700")
Message-ID: <87352shc98.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Breno Leitao <leitao@debian.org> writes:

> There is no way to compile a kernel today with some of the speculative
> mitigations disabled. Even if the kernel has
> CONFIG_SPECULATION_MITIGATIONS=n, some Intel mitigations, such as MDS, TAA,
> MMIO are still enabled and can only be disabled using a kernel parameter.
>
> This patchset creates a way to choose what to enable or disable, and,
> get the mitigations disable if CONFIG_SPECULATION_MITIGATIONS is not
> set, as the rest of other mitigations.
>
> Also, we want to print a warning message letting users know that these
> mitigations are disabled.
>
> This is a follow up to this discussion: https://lkml.org/lkml/2023/6/12/798
>

Isn't this all roughly equivalent to CONFIG_CMDLINE="mitigations=..." ?

-Andi
