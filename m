Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676856321CD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiKUMWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKUMWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:22:07 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9AB2C114
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 04:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669033326; x=1700569326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YKC4AsIBlrcJzc9V2jYLZIn6QS66e188H3uD5Ifr8GA=;
  b=TmTkW2jjcfuScsOGlioXPUz7WKbMppNFOCmO2dAww0SFXMob0YqZdhqu
   wqLbXMTEFdTqFAo+z2JsmQB39KYYpV86BwIklt1S1tywTKoHJiG0qAUZC
   nu9B25X5NrM306pBKI0M3s7oiW0M83Gm7G/DA/PlS96o/6HZcJbalQKme
   eRZGr0IDO1hVbGvouBpkTxiZqMsHT7nZi/+YrvJ9MLYH0JarDqZoTYL8J
   Cv3/jbA8PmvWEkd8LbYQ3lGwvmM2ydzXs9aT4ltFTFcg1onFY/04ZCqEW
   KKsKf1045gIRibPO9fwxitsozTpEk0Pq0lRXvGGUxVazeofawfoPyrWK5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="399832375"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="399832375"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 04:22:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="618806451"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="618806451"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga006.jf.intel.com with ESMTP; 21 Nov 2022 04:22:03 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 2ALCM2sq004950;
        Mon, 21 Nov 2022 12:22:02 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] x86/boot: fix relying on link order
Date:   Mon, 21 Nov 2022 13:09:18 +0100
Message-Id: <20221121120918.388035-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <2993a60c-edaa-a29a-2644-3ee86c622847@intel.com>
References: <20221101161529.1634188-1-alexandr.lobakin@intel.com> <20221107125528.543764-1-alexandr.lobakin@intel.com> <2993a60c-edaa-a29a-2644-3ee86c622847@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Hansen <dave.hansen@intel.com>
Date: Tue, 8 Nov 2022 15:09:07 -0800

> On 11/7/22 04:55, Alexander Lobakin wrote:
> > Ping?
> > 
> > Also, I managed to remove .head.text at all from x86. Would it be
> > better to respin this series with the third patch or send a
> > follow-up later?
> > 
> 
> Hi Alexander,

Hey,

> 
> Things are a bit busy in the review queue at the moment.  As always,
> we'd love help reviewing stuff.  So, while you're waiting for us to
> review this, could you perhaps look around and find a series that's also
> hurting for review tags?

I've got Reviewed-by and Tested-by from Jiri, isn't that enough? Or
I need also some other group to get tags from?

Thanks,
Olek
