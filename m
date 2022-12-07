Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A1B645EE1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiLGQ0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiLGQZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:25:52 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA24F68C52;
        Wed,  7 Dec 2022 08:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670430320; x=1701966320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5Sq055jlCLi5Ln1Yk3k2vHgwekeacL/n/QnkIrnplU4=;
  b=dAUrLmgU865qKvBmTmAq8qhBEBFl7MrjO2msPc6zNIZYvOpO6ecoL7Hv
   OurXvA834QlzWrE4nk9zCEx0f6TH3W1+Yy37k2A/qnWMpzEkyXxjhjryO
   z3l6EhcXLPhYrjVz2Rkh8NLkUBdJtEA+Mv56vtnN+1dyvKA0atNungGfj
   d40po98Ayb73QyL6ycefOXOfhBSuDlCfxZ4rkaF6LJCe94smPIxGMzo92
   uwVULnGeyzbkdA3mfjJnLKsbAMtdSAvom4kLILKb9frvei9NLXXr02TBj
   KtDsUlr2hpbbKlxZwzoPwwLjteVs2dEcCP2u7DKZKfdJCT0qoX8XGUX/2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="343972627"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="343972627"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 08:24:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="640302593"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="640302593"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga007.jf.intel.com with ESMTP; 07 Dec 2022 08:23:59 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 2B7GNwPH026724;
        Wed, 7 Dec 2022 16:23:58 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>
Subject: Re: [PATCH v3 3/5] kbuild: add read-file macro
Date:   Wed,  7 Dec 2022 17:22:08 +0100
Message-Id: <20221207162208.2200189-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221207154044.2181347-1-alexandr.lobakin@intel.com>
References: <20221126225624.751661-1-masahiroy@kernel.org> <20221126225624.751661-3-masahiroy@kernel.org> <20221207154044.2181347-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Wed, 7 Dec 2022 16:40:44 +0100

> From: Masahiro Yamada <masahiroy@kernel.org>
> Date: Sun, 27 Nov 2022 07:56:22 +0900
> 
> > Since GNU Make 4.2, $(file ...) supports the read operater '<', which
> > is useful to read a file without forking any process. No warning is
> > shown even if the input file is missing.

[...]

> Great stuff. Used it in my upcoming series to simplify things, works
> as expected.
> 
> sed-syms = $(subst $(space),\|,$(foreach file,$(sym-files-y),$(call read-file,$(file))))
> 
> The only thing that came to my mind while I was implementing the
> oneliner above: maybe add ability to read multiple files? For now,
> I used a foreach, could it be somehow incorporated into read-file
> already?

Oh, nevermind. This one also works:

sed-syms = $(subst $(space),\|,$(call read-file,$(sym-files-y)))

So I believe read-file works for an arbitrary number of files.

> 
> Besides that:
> 
> Reviewed-and-tested-by: Alexander Lobakin <alexandr.lobakin@intel.com>

[...]

> > -- 
> > 2.34.1
> 
> Thanks,
> Olek

Thanks!
Olek
