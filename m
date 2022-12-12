Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC7764A386
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 15:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbiLLOiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 09:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiLLOiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 09:38:07 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21765642B;
        Mon, 12 Dec 2022 06:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670855886; x=1702391886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vAEVzSLtXIZQ9GTdELdfiXrluYt+Y98lyKQftRQQEiY=;
  b=kcvB4t7HLfUTClYv00wqS+ZsBZ2QL8YgQEBnf7IUDV9s9x/ACYXDpO0e
   6yhHMC2XUXGLmMMqvMJVgSS3L8Wm+S7DIbJ+D8GPqqRUisVMHxsJwpzLS
   5y07diDPBueHjCUT8eaX+4wfNNWJiBvMlOMSYgwUe77B8DhU0ModlEirM
   0j2vjV4B3WQDb083hUX2MD2//V2e29Xf8XSDBbMFuWfA0G0ONa4Ecl51K
   Ezy2DJ5PR2pFnzB3NkTOLhG5k8y4OfG68AMyqAhs+2vT4N9NzikfiLSqP
   fZWCqDi+GhxNASBKpQ0uoIyP+aKOojoG/tgxzXBt0cwzsb3K3oAZBDrOZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="319007100"
X-IronPort-AV: E=Sophos;i="5.96,238,1665471600"; 
   d="scan'208";a="319007100"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 06:37:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="625921899"
X-IronPort-AV: E=Sophos;i="5.96,238,1665471600"; 
   d="scan'208";a="625921899"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga006.jf.intel.com with ESMTP; 12 Dec 2022 06:37:16 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 2BCEbF7p025134;
        Mon, 12 Dec 2022 14:37:15 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v3 3/5] kbuild: add read-file macro
Date:   Mon, 12 Dec 2022 15:37:11 +0100
Message-Id: <20221212143711.3536777-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <Y5Tz+MBfYMVkqAn3@fjasle.eu>
References: <20221126225624.751661-1-masahiroy@kernel.org> <20221126225624.751661-3-masahiroy@kernel.org> <20221207154044.2181347-1-alexandr.lobakin@intel.com> <20221207162208.2200189-1-alexandr.lobakin@intel.com> <CAK7LNAQbGaXDRzeByOcJhMX4y-ShA6Qtpcqhr4gNZ5t8vX-PPw@mail.gmail.com> <Y5Tz+MBfYMVkqAn3@fjasle.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Schier <nicolas@fjasle.eu>
Date: Sat, 10 Dec 2022 22:02:48 +0100

> On Sat, Dec 10, 2022 at 11:10:12PM +0900 Masahiro Yamada wrote:
> > On Thu, Dec 8, 2022 at 1:25 AM Alexander Lobakin
> > <alexandr.lobakin@intel.com> wrote:
> > >
> > > From: Alexander Lobakin <alexandr.lobakin@intel.com>
> > > Date: Wed, 7 Dec 2022 16:40:44 +0100
> > >
> > > > From: Masahiro Yamada <masahiroy@kernel.org>
> > > > Date: Sun, 27 Nov 2022 07:56:22 +0900
> > > >
> > > > > Since GNU Make 4.2, $(file ...) supports the read operater '<', which
> > > > > is useful to read a file without forking any process. No warning is
> > > > > shown even if the input file is missing.
> > >
> > > [...]
> > >
> > > > Great stuff. Used it in my upcoming series to simplify things, works
> > > > as expected.
> > > >
> > > > sed-syms = $(subst $(space),\|,$(foreach file,$(sym-files-y),$(call read-file,$(file))))
> > > >
> > > > The only thing that came to my mind while I was implementing the
> > > > oneliner above: maybe add ability to read multiple files? For now,
> > > > I used a foreach, could it be somehow incorporated into read-file
> > > > already?
> > >
> > > Oh, nevermind. This one also works:
> > >
> > > sed-syms = $(subst $(space),\|,$(call read-file,$(sym-files-y)))
> > >
> > > So I believe read-file works for an arbitrary number of files.
> > 
> > 
> > 
> > Really?
> > 
> > 
> > In my understanding, $(call read-file, foo bar) reads a single file "foo bar".
> > (a space in the file name).
> 
> yes, except for make < 4.2, due to:
> 
> read-file = $(shell cat $1 2>/dev/null)

$ make --version
GNU Make 4.3
Built for x86_64-redhat-linux-gnu

But breh, I forgot to port test-ge, so Kbuild was always calling
cat :D :clownface:
Correct, current implementation (as of v3) reads only single file.
Not sure whether read-file should handle multiple at a time.

Thanks,
Olek
