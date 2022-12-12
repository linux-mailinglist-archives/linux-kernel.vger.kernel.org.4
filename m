Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC8864A6B4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbiLLSMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbiLLSL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:11:28 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DD0178B5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:09:51 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o12so597052pjo.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=caT/eR3o2xI61xv4gQNQ+fDkRVtZB1sOkBNJmlEN+N4=;
        b=btZ4GA2g/VsRjxBZWyd9Ot4NYl23XggbHAYppoWAJmTxlei8M5/a+b75/69vjs6/GH
         I6tP0ipoDef613AM61HoV+CINKngTjD8WS0TtXzjvi7PemuFIO0aVViEu8P6/zlMroeA
         /rz2PU13KL9/wCcPniQNnwBMvXDHGjycV7BnTq/mTjEiO803KNc18d/0d7ajvdY3QB7c
         0dxIjjg5xtkMMm5gLHj3U0CnOt1GX8A52AptPekUmyPv2lyy1JN1gm/Yf/39hMlDWIAm
         iDow4z0quQ16cubZl80/hIZjTver2Aez811DpWbpe/dWEi1fggZISJ8ob8bsgCwH30Wl
         Vy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=caT/eR3o2xI61xv4gQNQ+fDkRVtZB1sOkBNJmlEN+N4=;
        b=RjHZt/N0Q3nxGTNX3hXkpeyV7r+PjcYe/YGQGkRRKznzmymd0rRdbAEJT45qzGzzFQ
         eoz4T/nZLD6go6TXtDekkUEn3wJolT37c1J2POGCf9VIcwNFIaO8y1xFSeaePRXC+p5Q
         /bqh0Ts/e1Hwlb+1fd4Bi8O9NMDVI3REbIp6h3Wd2TQFrCJVPH6PmuN8BcNZNYAXFaTG
         ApRyRH4S3kICsJKvgdHPmf/3i07FQ/KjGeAoDiUX2WysdSqipWHbwxFrgXOPhpdCibWM
         6G4PqfD4Q75tTgxdRXydxXFG5TLxztumORgT/xGRWTlkLfGWZYPdDpriqXZPH8HGH6hm
         FtQw==
X-Gm-Message-State: ANoB5pkmFq7f3Av67Vgws97XYYFfola7MOc4LlfQv0v76wqRemQEfohD
        NQKCed0OgSt109Ye5hgLhb8PbQ==
X-Google-Smtp-Source: AA0mqf7zO/WZ6W2GV+EwOLWI4vx4kth8/QRN5S0b70Tpme+OTbmVntr3N2mA7+gmAJy9/GblRagCKg==
X-Received: by 2002:a17:90b:3b86:b0:218:84a0:65eb with SMTP id pc6-20020a17090b3b8600b0021884a065ebmr813368pjb.1.1670868583486;
        Mon, 12 Dec 2022 10:09:43 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id ep11-20020a17090ae64b00b00210c84b8ae5sm5717900pjb.35.2022.12.12.10.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:09:43 -0800 (PST)
Date:   Mon, 12 Dec 2022 18:09:39 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        zhiquan1.li@intel.com
Subject: Re: [PATCH v2 14/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
Message-ID: <Y5duYxIHtSpK1qkj@google.com>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
 <20221202183655.3767674-15-kristen@linux.intel.com>
 <Y5IBCOuF8X7jEK3+@kernel.org>
 <cb5abce531c1b14118de419ba68c2a501b016873.camel@linux.intel.com>
 <e5aff02b-713c-ccd8-7211-d07ff6d7adb2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5aff02b-713c-ccd8-7211-d07ff6d7adb2@intel.com>
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

On Fri, Dec 09, 2022, Dave Hansen wrote:
> On 12/9/22 08:05, Kristen Carlson Accardi wrote:
> > Aside from that though, I don't think that killing enclaves makes sense
> > outside the context of cgroup limits. 
> 
> I think it makes a lot of sense in theory.  Whatever situation we get
> into with a cgroup's EPC we can also get into with the whole system's EPC.
> 
> *But*, it's orders of magnitude harder to hit on the whole system.

...

> If someone wants to extend this OOM support to system-wide EPC later, then go
> ahead.  But, I don't think it makes a lot of sense to invert this series for
> it.

+1 from the peanut gallery.  With VMM EPC oversubscription suport, no sane VMM
will oversubscribe VEPC pages.  And for VA pages, supporting swap of VA pages is
likely a more userspace-friendly approach if system-wide EPC OOM is a concern.
