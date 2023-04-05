Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34E36D8B18
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 01:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbjDEX3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 19:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbjDEX3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 19:29:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F0D6EAF;
        Wed,  5 Apr 2023 16:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680737351; x=1712273351;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=O6sUmwZZ6qtQYOLf/WrpXlTfT6W6Xkn84Qm8CQ5+ujI=;
  b=G0USHuAA5umxFxbLQ/bU8avlOn4c0AMjfpM0Q27Tgo8sG7PePHc2Ck1b
   KfKxUZeWTM23MkDyTAm8QKO+c9jjoOZK0Eo/ySEWkTuAxg7NSEJlVvCNO
   YZs4s4K0KLcmY64m9TJN2+OB+7/3Niv1x5vyN3M3RsggYhlyiD8zKZOJ8
   ZA9krMjwR2IFrSxFbJStgrwHcQqhjMtYpMjqaxnJUn96Z2EZqwtWvJtCX
   Q/WGE6x0nyM1F+cLj0LDrgs4mQM6rTGhZelehhup+RhJ8q1xJjKOSEa5f
   vpWjnrJ0j5Y6xWjS7OXgGYvU7+3Fj5++s9fFw1pH1wkvKHp/AUm6AFeoY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="326630555"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="326630555"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 16:29:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="776247721"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="776247721"
Received: from skansra-mobl.amr.corp.intel.com (HELO [10.209.62.228]) ([10.209.62.228])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 16:29:09 -0700
Message-ID: <f33ce1e75b5fec0a36c6670e1301fed4450d86ae.camel@linux.intel.com>
Subject: Re: [PATCH v3] Documentation: Add document for false sharing
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Feng Tang <feng.tang@intel.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Joe Mario <jmario@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, dave.hansen@intel.com,
        ying.huang@intel.com, tim.c.chen@intel.com, andi.kleen@intel.com
Date:   Wed, 05 Apr 2023 16:29:08 -0700
In-Reply-To: <2520c3d060e7b77560ea32a4b132d8e1a5f14ac9.camel@linux.intel.com>
References: <20230404052228.15788-1-feng.tang@intel.com>
         <2520c3d060e7b77560ea32a4b132d8e1a5f14ac9.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-04-05 at 15:38 -0700, Tim Chen wrote:
> Thanks for the update. Looks good.  Some minor nits to improve readabilit=
y.
>=20
> On Tue, 2023-04-04 at 13:22 +0800, Feng Tang wrote:
> >=20
> > +
> > +False sharing could easily happen unless they are intentionally
> > +checked, and it is valuable to run specific tools for performance
> > +critical workloads to detect false sharing affecting performance case
> > +and optimize accordingly.
> > +
> > +
> > +How to detect and analysis False Sharing
>=20
> s/analysis/analyse

s/analysis/analyze

Fix my typo.

Tim
