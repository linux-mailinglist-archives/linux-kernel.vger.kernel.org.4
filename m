Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F06364E381
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 22:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiLOVxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 16:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiLOVxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:53:08 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43145442F0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 13:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671141188; x=1702677188;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8pcgn+j9HMqENHDmv+AJY3/OPMa3Dt1D1xbcDVZpPSU=;
  b=bATzdPHvyuxPGJuxkYkpZXEwUdRpeIWmHtdNu2q1gPNz1ULLUkUDAhlN
   s0jmVupMJifshRvTfAStlzgyMLSIQERree0/yWSHfu5rVwuAgXy8MX94n
   uZbpismrgqSDS386dsF0kUSO5bebL0A9DM93aVL2RNl1D+fuIEbOWv0j2
   Fgfdz+VJYD3ZCVS3AuOPTJOgfePnExU/BrLQ59G/Q+AvuIQr73SwsnttV
   rMqJHJ7tEKuYr5+7tLo0KfHXBkZtI0UHbkGtrMM+NDxW4q7B+v5OFwWPe
   sej/Pne6s9A1ffir4gf3VO/mC5fn0E5saPx2CheagsrQdwzrz34gzFJkp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="319981720"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="319981720"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 13:53:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="649575075"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="649575075"
Received: from ajanssen-mobl.amr.corp.intel.com (HELO [10.209.22.168]) ([10.209.22.168])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 13:53:07 -0800
Message-ID: <242daeb2-b96b-d0dd-5597-ebf5fb2dfeca@intel.com>
Date:   Thu, 15 Dec 2022 13:53:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [GIT PULL] x86/mm for 6.2
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        kirill.shutemov@linux.intel.com
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
References: <20221213174234.688534-1-dave.hansen@linux.intel.com>
 <CAHk-=wi=TY3Kte5Z1_nvfcsEh+rcz86pYnzeASw=pbG9QtpJEQ@mail.gmail.com>
 <20221215123007.cagd7qiidehqd77k@box.shutemov.name>
 <CAHk-=whC_ixb3FDdMhW_wiKw7-bB700kvUyqN+_cPUNp=1hNsQ@mail.gmail.com>
 <CAHk-=wjyy3iKS0B=A-yAPqjE3xiUU_5AiXApCasuYKTNu842dQ@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAHk-=wjyy3iKS0B=A-yAPqjE3xiUU_5AiXApCasuYKTNu842dQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/22 09:26, Linus Torvalds wrote:
> But if you feel like all threads have to share the same LAM state, it
> does seem a lot simpler if you just say "you need to set that state
> before you start any threads". No?

That would be a lot simpler.  I have one bit of hesitation there, though.

Back in the MPX days, we had some users pop up and tell us that MPX
wasn't working for them on certain threads.  Those threads ended up
having been clone()'d even _before_ MPX got enabled which was via some
pre-main() startup code that the compiler inserted.  Since these early
threads' FPU state was copied before MPX setup was done, they never got
MPX-enabled.

Right or wrong, since then I've basically assumed that someone might be
creating threads behind my back.

Maybe we call those "early thread" folks too crazy to get LAM.  Maybe I
need to forget it ever happened, but they were actual users that got
bitten and cared enough to report it.  Or, heck, maybe I'm just
delusional because I can't find any trace of this conversation in the
list archives.

LAM _is_ slightly different than what MPX hit, though, since instead of
totally silent breakage the app can whine about the LAM prctl() having
failed.

Anyway, message heard loud and clear about the untagged_addr() races and
the interfaces.  We'll find some way to fix those up for the next merge
window.
