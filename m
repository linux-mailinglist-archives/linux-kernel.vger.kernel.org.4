Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBD370877F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 20:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjERSHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 14:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjERSHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 14:07:13 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5A1C2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 11:07:12 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-518d6f87a47so1353093a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 11:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684433231; x=1687025231;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lTIchLKkhkuJtgpo7em2rL9kgrrw91pXkSmSWyT/RdI=;
        b=Idp8cFqfBlWY+INgm7z9CVNp+7XJ9yFe3SFdWSgIX9fKcKk0prX9TW/XDxGotusptU
         yXgikV4CY5oNEnDISBGqPmMqqWg+Lh01Ix5TO9Wm4909knBLRDG4zr6GoBNUrQBoQKqr
         EeDN+COXGVbnGNOeQKpW91lsyRpyCUnAKzhxCMcj/YCYKDga4vZyC0UeHWZaft6g1Gb9
         RcZFeipG0rG1mUUpi8lr1fZPAtC3OVW7N06LajQYKed6/4sH3oSB+nBwBIh8qROZNG+p
         6/pN0jQLZYtlXGSsJm3Tie6D/uQWxdDQ73l6x+v5TzCB49P97EChWJ6eax0S10jBPOBE
         7TEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684433231; x=1687025231;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lTIchLKkhkuJtgpo7em2rL9kgrrw91pXkSmSWyT/RdI=;
        b=QwdbQiOhvLrMFMBknMNjAPp1El1usvbz+p9VpopYinERLlrtTAoGYhpNZsJc0x7Yz1
         oDIL8YbPHaro3Uzol+tX/AmvqXu/1h94L9dQwGClmSyFTeGHlNtcLTAnrY4W8hj+EqLA
         /dGkgBPjsJujOYMdR/vple5pHLPJDdEoYLntuQ0T79gSC2WjYRTFgcu4BnxlbCfr6lib
         m3OHWuhhBUU4juqFxrRj4oyEkEQvKw1aZpGmyayFi8TF4CkGptKxVQ1dpQrwlSaEdcKT
         Jf3sthYV0mTly1LfP0STyLONro6ZhdiCHWQ8aoPLRpNA/dpF6gheZ6p5RL+xd8ZFRhjU
         vMWw==
X-Gm-Message-State: AC+VfDyBNDJ+5grdnbQYgjA0YirgbLT59vLp4s6zAyyh5kfYm16sPd0a
        HOxqMvQUobCrAF9q5lEVCE+HFBuSdJw=
X-Google-Smtp-Source: ACHHUZ7txDEkWdPCv8JldSwnFXdV5NEwOXHlioAaJZ7SDPT2Qwf6R442e5501qKU1HgMkPPpNHOjyKNATcA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:5864:0:b0:530:8be8:5ab6 with SMTP id
 i36-20020a635864000000b005308be85ab6mr764038pgm.8.1684433231581; Thu, 18 May
 2023 11:07:11 -0700 (PDT)
Date:   Thu, 18 May 2023 11:07:09 -0700
In-Reply-To: <ZGV2vF0MQwQ+LZRX@yzhao56-desk.sh.intel.com>
Mime-Version: 1.0
References: <20230516093007.15234-1-yan.y.zhao@intel.com> <ZGTwaP6peRcpl+GA@google.com>
 <ZGV2vF0MQwQ+LZRX@yzhao56-desk.sh.intel.com>
Message-ID: <ZGZpTWnnbzAr+AwN@google.com>
Subject: Re: [PATCH] vfio/type1: check pfn valid before converting to struct page
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex.williamson@redhat.com, kevin.tian@intel.com, jgg@nvidia.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023, Yan Zhao wrote:
> On Wed, May 17, 2023 at 08:19:04AM -0700, Sean Christopherson wrote:
> > On Tue, May 16, 2023, Yan Zhao wrote:
> > > vfio_pin_page_external() can return a phys_pfn for vma with VM_PFNMAP,
> > > e.g. for MMIO PFNs.
> > > 
> > > It's necessary to check if it's a valid pfn before calling pfn_to_page().
> > > 
> > > Fixes: 34a255e67615 ("vfio: Replace phys_pfn with pages for vfio_pin_pages()")
> > 
> > Might be worth adding a blurb to call out that this is _not_ ABI breakage.  Prior
> Do you mean "_not_ ABI breakage" with
> 34a255e67615 ("vfio: Replace phys_pfn with pages for vfio_pin_pages()")
> or with this fix commit?

Mostly the former.  I brought it up because _if_ there was breakage in that commit,
then this fix would be "wrong" in the sense that it wouldn't undo any breakage, and
would likely make it harder to restore the previous behavior.
