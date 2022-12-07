Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAA96463D0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 23:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiLGWB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 17:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiLGWAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 17:00:35 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D568566A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 14:00:31 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id y25so8612945lfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 14:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlgIItFvCF5msrDlp88m7tGNEV0TXA935fU3IghSF4Y=;
        b=i6bpsbPmq58+nflCdhR5+ZbY8ILawdzrcy00RQKwE8DryMhm9jpCuzGAZ68U8fT/Yt
         2qWsZplx3WaI44mrdoZwsGCoOGEt3iIn3ZKE5H+EMB28ICbtR0g+eZyVDgYhdpoCIDUi
         tYUQcmlcXt3KbrZah4II3fdJv0pFCrAqhPGrWjn9SseqykqcmS13CuHmX6TeyvTjD6rO
         fUOBfanSZOTD72qKlsLWrJuw3stEYsbkd/3tksdijYH3uqImqRFfy5xmR12d/WB+y7pA
         a9hMG2Jul+fa/dblyA1kMTiM5y29X807iEoI/hcSQ8wMeJW6sj8uAmdHmMM2JCiuqhXp
         jlvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NlgIItFvCF5msrDlp88m7tGNEV0TXA935fU3IghSF4Y=;
        b=x4bInIdgrWdbEZCbAJ2zG1iDeKgVoRGi+XPGlkhGYNTAg10ozuVvZ3RacVX/x9Uceb
         ccWEEJ1OAovD17zOfQsVGxN4SG516US57UBsrNkUjr0K43rmilCf1EmNSgJD0Aidjz8r
         WkCM3zGKERQhld3Iwye7iIVc8C32UdzkNa/DHwEWDa5ph5imi+l3dVw2SUWzT2VmxOaC
         hGgz09g9yS/8RKQfFpKu6wJYMCw1vBh2J1zOVDQZTbyMfi8926sySowtgAdPk+/+HV4g
         JE3MKDax/EMtaNLf1txxGOCwkii8yJD26QIdWHEnDuwOr5Yu8GHAsNbOpZWFCLPzihJR
         /zNA==
X-Gm-Message-State: ANoB5pkABFmUcAUDzu9Lm40/GLorVmbqcdcUDO86Od3mgxpAvMbxiv3e
        IGgRN3Acu+0X3i9X5mvJfCA=
X-Google-Smtp-Source: AA0mqf6VQtQhD6zjrkCK3H9uqCYDOwzIx+m5vPWird8a1I/Iz6yyhWiuLm8l8OF5yhfRxbBh8kJyOg==
X-Received: by 2002:a19:5219:0:b0:4b5:9125:1432 with SMTP id m25-20020a195219000000b004b591251432mr1672355lfb.204.1670450429696;
        Wed, 07 Dec 2022 14:00:29 -0800 (PST)
Received: from grain.localdomain ([5.18.253.97])
        by smtp.gmail.com with ESMTPSA id b25-20020ac25e99000000b004b4e6dab30esm3005093lfq.222.2022.12.07.14.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 14:00:27 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 1BDE85A0020; Thu,  8 Dec 2022 01:00:27 +0300 (MSK)
Date:   Thu, 8 Dec 2022 01:00:27 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Pavel Emelyanov <xemul@parallels.com>,
        Andrew Morton <akpm@linux-foundation.org>, gnome@rvzt.net,
        drawoc@darkrefraction.com, alan@lxorguk.ukuu.org.uk,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        bugzilla-daemon@bugzilla.kernel.org
Subject: Re: [Bug 67651] Bisected: Lots of fragmented mmaps cause gimp to
 fail in 3.12 after exceeding vm_max_map_count
Message-ID: <Y5EM+zlgFvoGBG5X@grain>
References: <20140122190816.GB4963@suse.de>
 <20140122191928.GQ1574@moon>
 <20140122223325.GA30637@moon>
 <20140123103044.GE4963@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140123103044.GE4963@suse.de>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2014 at 10:30:44AM +0000, Mel Gorman wrote:
> 
> The test case passes with this patch applied to 3.13 so that appears
> to confirm that this is related to VM_SOFTDIRTY preventing merges.
> Unfortunately I did not have slabinfo tracking enabled to double check
> the number of vm_area_structs in teh system.

Hi Mel! I'm really really sorry for replying that late, somehow missed the former
bug report (note the bugzilla date message as Jan 23, 2014) so no wonder. Actually
I don't understand yet how SOFTDIRTY can prevent merging. When VMAs are to merge
we explicitly ignore softdirty flag

/*
 * If the vma has a ->close operation then the driver probably needs to release
 * per-vma resources, so we don't attempt to merge those.
 */
static inline int is_mergeable_vma(struct vm_area_struct *vma,
				struct file *file, unsigned long vm_flags,
				struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
				struct anon_vma_name *anon_name)
{
	/*
	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
	 * match the flags but dirty bit -- the caller should mark
	 * merged VMA as dirty. If dirty bit won't be excluded from
	 * comparison, we increase pressure on the memory system forcing
	 * the kernel to generate new VMAs when old one could be
	 * extended instead.
	 */
	if ((vma->vm_flags ^ vm_flags) & ~VM_SOFTDIRTY)
		return 0;
	...
}

so the softdirty flag is not preventing VMAs from being merged.

	Cyrill
