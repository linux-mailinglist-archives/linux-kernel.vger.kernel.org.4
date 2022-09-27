Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332235ECAEA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiI0Rgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiI0Rgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:36:36 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B0B5F7D6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:36:35 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id b75so10301359pfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=YvDuPsFOyzRquHOz07w9Zdf7b3JPyOcExQmvq44UjLw=;
        b=cmptD7FaYRvka6KAWsT05xJBszUQoEiLBTSZKLNsEXWp1FR7b3p3yJ0A7nZbYah+mq
         1X2bx93o+Umyx6YmfoSDj3R9x3cP399oqO8PFPUf79/tyyMLU5YJD4gS89fxIXkAXHZj
         4CZr92irZhEgDDsHV3Yg752JflcrYn/1F61u6PY9ncvA+fIFdpI05wIDPbfr3rxhliv5
         3lTT3FP9J3IM5Qn2Z0jNx8+O+vGt41UW7CdyhWtcVBtLQzvtjxNiGKWJ3H+rmRNqYe12
         nurZynZP8V0ECDHAER+j9NvVTkVmT6onkE8W/fLTg2MW4TiOwYzJjeTy47ovubCBCVoL
         WgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=YvDuPsFOyzRquHOz07w9Zdf7b3JPyOcExQmvq44UjLw=;
        b=oejq6HbeBcNykxcnIRhdtKn+ZlwH77UBFyvM92aZrBf9WzoS8ToXZtvGewzIwvKNmF
         Sc2Llc8QA5Ec+3kCxLyrlop7tDMA7h9sqf7HCyrTQ+lqBlfoxGSkuaO8bU4Ug+9BcJ6q
         tpofXIELhUF/1D2SmHq+bRJKkw08KuShtOQG8ttkh1J7Ea1v2A7+7kRffLwHwKicp9Zr
         b4fcAScDXaGk8yqFLPNM9ri+gHMbJIdOCxRW/7fRhnRqfju7InpMFdZPyauojBZHIkrZ
         inQnpEgg1AOnveo0NwF+sL9FLQZeFXABkKW1MSPvihsQXabOYNBWQLFOi4oJPjM1NELh
         tjcg==
X-Gm-Message-State: ACrzQf2LbsPf43/Dp6f0OXsa/earusgCcq0x3aoCwT+OrTgmEporJRal
        4/ReLgNVE1jjFQdmO1QwUic=
X-Google-Smtp-Source: AMsMyM5hIxWPo0iyx71Ob9H7igOdgxwEcAbGAHj3T24PCENb7LsaqK2WO0EtzYbqqG1vZzzwBTGC4A==
X-Received: by 2002:a05:6a00:170e:b0:550:dc52:4647 with SMTP id h14-20020a056a00170e00b00550dc524647mr30041774pfc.19.1664300195213;
        Tue, 27 Sep 2022 10:36:35 -0700 (PDT)
Received: from strix-laptop (2001-b011-20e0-1b32-d148-19d6-82fa-6094.dynamic-ip6.hinet.net. [2001:b011:20e0:1b32:d148:19d6:82fa:6094])
        by smtp.gmail.com with ESMTPSA id n11-20020a170902e54b00b00176ca74c58bsm1836627plf.245.2022.09.27.10.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 10:36:34 -0700 (PDT)
Date:   Wed, 28 Sep 2022 01:36:27 +0800
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Li kunyu <kunyu@nfschina.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Song Liu <song@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>
Subject: Re: [RFC PATCH v2 1/9] mm: Add new mm flags for Copy-On-Write PTE
 table
Message-ID: <YzM0m2eYsjMRJSqn@strix-laptop>
References: <20220927162957.270460-1-shiyn.lin@gmail.com>
 <20220927162957.270460-2-shiyn.lin@gmail.com>
 <60437F8E-F4A6-4008-9385-F8DAA9C2EA5E@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60437F8E-F4A6-4008-9385-F8DAA9C2EA5E@vmware.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 05:23:58PM +0000, Nadav Amit wrote:
> On Sep 27, 2022, at 9:29 AM, Chih-En Lin <shiyn.lin@gmail.com> wrote:
> 
> > Add MMF_COW_PTE{, _READY} flags to prepare the subsequent
> > implementation of Copy-On-Write for the page table.
> > 
> > Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
> > ---
> > include/linux/sched/coredump.h | 8 +++++++-
> > 1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
> > index 4d0a5be28b70f..f03ff69c90c8c 100644
> > --- a/include/linux/sched/coredump.h
> > +++ b/include/linux/sched/coredump.h
> > @@ -84,7 +84,13 @@ static inline int get_dumpable(struct mm_struct *mm)
> > #define MMF_HAS_PINNED		28	/* FOLL_PIN has run, never cleared */
> > #define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
> > 
> > +#define MMF_COW_PTE_READY	29
> > +#define MMF_COW_PTE_READY_MASK	(1 << MMF_COW_PTE_READY)
> > +
> > +#define MMF_COW_PTE		30
> > +#define MMF_COW_PTE_MASK	(1 << MMF_COW_PTE)
> 
> I am not sure how much sense it makes to put it in a separate patch, and it
> is rather hard to understand the new flags without proper documentation and
> comments.
> 

I had considered putting it with the sysctl patch, but since these two
flags are not related to the sysctl, so I put it in a separate patch.
Maybe I can put those (sysctl and this patch) together and take a
suitable commit message. I will consider it again.
For the proper documentation/comments, I will also add it in next
version.

Thanks,
Chih-En Lin
