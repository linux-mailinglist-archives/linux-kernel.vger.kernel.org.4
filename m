Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2885E63449E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 20:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbiKVTcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 14:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbiKVTcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 14:32:24 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E52991514
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:31:50 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id f9so10688546pgf.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=siXftGv8ycXrMRraGh3XeU6UKcxAd+GukaGf1635NmA=;
        b=GASSlv0OoBHyhUZ3KS/fwCsfs7Jig2vXCU1qaEKmESBDmEIt1VtkDZ9AAC5dGybsAX
         LQ9Vvf2KkUpnEtoH6/6g320s0QsDrkjOa0pSGCpyy6Qu2qPyVvs45HeBmvPoibRnusaU
         tgyJEA4JkyC6uFROTJ2sSabgEOuSfYRUnn1Ky97/AV+Yo7TEJapcEghis5cmDGiNR/QA
         PR0MHcFFKA/LOJYGNoh72+ZPUzPoL8SzZNi9T1akV11xop1A9LbCrD7S1cvL12K5Aeff
         pOZ/JfyChc1IDiDEy/SVrf2j2zTsXskVuD9Juqhzk+1vYSxO8jg9/ni/A9ASsuX7WAx+
         7TCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siXftGv8ycXrMRraGh3XeU6UKcxAd+GukaGf1635NmA=;
        b=TG3zGvVqwAaUS3HeKOd0ReRklVvcubBqjFF94pWYH1F7fdq4FjmkLuIULywdAnHt5E
         TsIeWYnmGCz1kmi/cofuOlxTdX57wSbekJ1s5owzI/AqBoAhGn6vQFuGA/Z5VU3V33M+
         Wfc6XJWnBSDHHUuMm2AI9et4KUFN5mo6TghRzfyCBKAqw7B5sG73xipPPU5IaKbEaFzQ
         txb/U4iKeLnWUIA71sQxUII1uElVHu3tkZmvYKIy8cnz9wU5evCt5/7bvOIxSETNoIFz
         yvEmo3pTswYTatvhDTcqWTtV+4J9d+J5sWx09M+EER3O3nNNueqeBJy7doaWmFpe+bV1
         a7ZQ==
X-Gm-Message-State: ANoB5pnRfv4GxsHfY4ltFbYB/ZDvqXrJvwqPNGh9XXKddih+3LMlZ9fd
        9FrVAEy+eMmr8AAuYureCvty9Q==
X-Google-Smtp-Source: AA0mqf7ksi6xnXTmcjIJCDhYhx70OWpjNJdfDF1pfmrBdIFzUVxRoF/w+K9uQSCTT8eYiFfpB+3BZg==
X-Received: by 2002:aa7:9057:0:b0:573:1d31:2b78 with SMTP id n23-20020aa79057000000b005731d312b78mr7551599pfo.61.1669145500962;
        Tue, 22 Nov 2022 11:31:40 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id o14-20020a170902d4ce00b00186acb14c4asm12529380plg.67.2022.11.22.11.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 11:31:40 -0800 (PST)
Date:   Tue, 22 Nov 2022 19:31:36 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kai Huang <kai.huang@intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-mm@kvack.org, pbonzini@redhat.com,
        dave.hansen@intel.com, dan.j.williams@intel.com,
        rafael.j.wysocki@intel.com, kirill.shutemov@linux.intel.com,
        ying.huang@intel.com, reinette.chatre@intel.com,
        len.brown@intel.com, tony.luck@intel.com, ak@linux.intel.com,
        isaku.yamahata@intel.com, chao.gao@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, bagasdotme@gmail.com,
        sagis@google.com, imammedo@redhat.com
Subject: Re: [PATCH v7 06/20] x86/virt/tdx: Shut down TDX module in case of
 error
Message-ID: <Y30jmKOOsvtzt6UT@google.com>
References: <cover.1668988357.git.kai.huang@intel.com>
 <48505089b645019a734d85c2c29f3c8ae2dbd6bd.1668988357.git.kai.huang@intel.com>
 <Y3yUdcJjrY2LhUWJ@hirez.programming.kicks-ass.net>
 <87bkozgham.ffs@tglx>
 <Y30dujuXC8wlLwoQ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y30dujuXC8wlLwoQ@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022, Peter Zijlstra wrote:
> On Tue, Nov 22, 2022 at 04:06:25PM +0100, Thomas Gleixner wrote:
> > On Tue, Nov 22 2022 at 10:20, Peter Zijlstra wrote:
> > 
> > > On Mon, Nov 21, 2022 at 01:26:28PM +1300, Kai Huang wrote:
> > >
> > >> Shutting down the TDX module requires calling TDH.SYS.LP.SHUTDOWN on all
> > >> BIOS-enabled CPUs, and the SEMACALL can run concurrently on different
> > >> CPUs.  Implement a mechanism to run SEAMCALL concurrently on all online
> > >> CPUs and use it to shut down the module.  Later logical-cpu scope module
> > >> initialization will use it too.
> > >
> > > Uhh, those requirements ^ are not met by this:
> > 
> >   Can run concurrently != Must run concurrently
> >  
> > The documentation clearly says "can run concurrently" as quoted above.
> 
> The next sentense says: "Implement a mechanism to run SEAMCALL
> concurrently" -- it does not.
> 
> Anyway, since we're all in agreement there is no such requirement at
> all, a schedule_on_each_cpu() might be more appropriate, there is no
> reason to use IPIs and spin-waiting for any of this.

Backing up a bit, what's the reason for _any_ of this?  The changelog says

  It's pointless to leave the TDX module in some middle state.

but IMO it's just as pointless to do a shutdown unless the kernel benefits in
some meaningful way.  And IIUC, TDH.SYS.LP.SHUTDOWN does nothing more than change
the SEAM VMCS.HOST_RIP to point to an error trampoline.  E.g. it's not like doing
a shutdown lets the kernel reclaim memory that was gifted to the TDX module.

In other words, this is just a really expensive way of changing a function pointer,
and the only way it would ever benefit the kernel is if there is a kernel bug that
leads to trying to use TDX after a fatal error.  And even then, the only difference
seems to be that subsequent bogus SEAMCALLs would get a more unique error message.
