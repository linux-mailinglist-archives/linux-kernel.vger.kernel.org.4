Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6E07266D4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjFGRLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjFGRLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:11:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA7A1BC2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 10:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686157872; x=1717693872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nn861VFp35Q9ZBleEYgKaQLtJQsWGLX2Vj1qxZbrt3k=;
  b=H1Uf/yfpRjn861OyFBqw0GPObq/mW4DmAVt/1y3VoXA12KyNklR7i9V+
   +WRCriW3UZ9ZHWBRRfUY38Xdz9cQys2Xi+AmuDWuB8uExpZ2fbNn8DmeY
   Xj8z4QYv2vLm35ZnJbDoYd5/zqmP0ABXcWEHqQ6Y275SaNTVO0j3wIDqx
   TZVOR0YuMk3MC0s4002Me9dcscYMBj2V0acaSUCLtyZHSkmeKEqNNUDH8
   WHs4M1utJsKYC0g4VNxeBLIPvLGRQ7jC6YzKIxQcdUKmusn/eVKv3UfQ4
   8XlAdFzv30zuyzSBVParwRK9uLS66mElZRQsiHze/zjAuSknWUJek+i6c
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="443418006"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="443418006"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 10:11:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="779541683"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="779541683"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.213.10.174])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 10:11:06 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Andi Shyti <andi.shyti@linux.intel.com>,
        intel-gfx@lists.freedesktop.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: Re: [PATCH v2] x86/mm: Fix PAT bit missing from page protection modify mask
Date:   Wed, 07 Jun 2023 19:11:04 +0200
Message-ID: <38324471.J2Yia2DhmK@jkrzyszt-mobl2.ger.corp.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <a20344fd-8130-013e-e773-acae81aad55a@intel.com>
References: <20230607152308.125787-2-janusz.krzysztofik@linux.intel.com>
 <a20344fd-8130-013e-e773-acae81aad55a@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 7 June 2023 17:31:24 CEST Dave Hansen wrote:
> On 6/7/23 08:23, Janusz Krzysztofik wrote:
> > 
> > Extend bitmask used by pgprot_modify() for selecting bits to be preserved
> > with _PAGE_PAT bit.  However, since that bit can be reused as _PAGE_PSE,
> > and the _PAGE_CHG_MASK symbol, primarly used by pte_modify(), is likely
> > intentionally defined with that bit not set, keep that symbol unchanged.
> 
> I'm really having a hard time parsing what that last sentence is saying.
> 
> Could you try again, please?

OK, but then I need to get my doubts addressed by someone first, otherwise I'm 
not able to provide a better justification from my heart.

The issue needs to be fixed by including _PAGE_PAT bit into a bitmask used 
by pgprot_modify() for selecting bits to be preserved.  We can either do 
that internally to pgprot_modify() (my initial proposal, which my poorly 
worded paragraph was still trying to describe and justify), or by making 
_PAGE_PAT a part of _PAGE_CHG_MASK, as suggested by Borislav and reflected in 
my v2 changelog.  But for the latter, I think we need to make sure that we 
don't break other users of _PAGE_CHG_MASK.  Maybe Borislav can confirm that's 
the case.

Since _PAGE_PAT is the same as _PAGE_PSE, _HPAGE_CHG_MASK -- a huge pmds' 
counterpart of _PAGE_CHG_MASK, introduced by commit c489f1257b8c ("thp: add 
pmd_modify"), defined as (_PAGE_CHG_MASK | _PAGE_PSE) -- will no longer differ 
from _PAGE_CHG_MASK as soon as we add _PAGE_PAT bit to the latter.  If such 
modification of _PAGE_CHG_MASK was irrelevant to its users then one may ask 
why a new symbol was introduced instead of reusing the existing one with that 
otherwise irrelevant bit (_PAGE_PSE in that case) added.  I've initially 
assumed that keeping _PAGE_CHG_MASK without _PAGE_PSE (vel _PAGE_PAT) included 
into it was intentional for some reason.  Maybe Johannes Weiner, the author of 
that patch (adding him to Cc:), could shed more light on that.

Thanks,
Janusz





