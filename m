Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E526BEFAF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCQR2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjCQR2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:28:50 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEF7193D6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679074129; x=1710610129;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QK7/B/07o0c3ZAXEEtbDsb8P9IEhQTe6HtAvuqAHZNU=;
  b=fOZQtD+2kcZUwZ86vbefAKrhjUX+YuY6645Nm4vNZQU0GMTay7q+fshJ
   i5E2lnEojRoG2MqyVCMf7yvao0HpvsR89q4BYbEkSsa6r+oMnco22DNSn
   nM2jlnx2UuLFPeS3l0ZaPlwWo4vlfhZfhMQOJVv1CF00KIWVfVBSMKZtX
   pUS6TipRVvX8US61WXf4riRcfIRqwAC1VECyuGHgkRdVYolWAMfZm12Av
   f+MrblzIm9xyAGBQ4ZOiuwSqgOBDPW0XOmGysLkwcUzInmjafnwKvDPqF
   wLjwL3lPLdJ3NXIbmKt9fE7aZOtNPlR4cWvAUNZP0x8K3bwMXl6UrcW0C
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="424590280"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="424590280"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 10:28:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="712821876"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="712821876"
Received: from dlacbain-mobl.amr.corp.intel.com (HELO [10.209.46.45]) ([10.209.46.45])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 10:28:48 -0700
Message-ID: <06c24686-fcc5-22bf-8a35-e7e18244e94b@intel.com>
Date:   Fri, 17 Mar 2023 10:28:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCHv16 00/17] Linear Address Masking enabling
Content-Language: en-US
To:     Alexander Potapenko <glider@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20230312112612.31869-1-kirill.shutemov@linux.intel.com>
 <CAG_fn=UHz93odccvRFo5H2yKq9URTcQs2jWWc5Yehioq-QC8hA@mail.gmail.com>
 <CAG_fn=XE-iDrPEB=bsnAqxYkRi+nFvTSbywOz56W_xQWLHeCAQ@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAG_fn=XE-iDrPEB=bsnAqxYkRi+nFvTSbywOz56W_xQWLHeCAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/23 10:21, Alexander Potapenko wrote:
> On Fri, Mar 17, 2023 at 6:18 PM Alexander Potapenko <glider@google.com> wrote:
>> Dear x86 maintainers,
>>
>> the series looks pretty mature now, any chance it can be considered
>> for upstream?
>>
> (Adding the maintainers just to be sure)

Yes, I'm running it through a few tests right now actually.  If
everything looks good, I'm planning on queueing it.
