Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57684632DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 21:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiKUU1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 15:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiKUU1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 15:27:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3FB58BEB;
        Mon, 21 Nov 2022 12:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uKbsr33W30m4J+0Jk1Glse5h34czrPw3vqZWTn4S1fs=; b=qUQGx4ob2hG2hcgYxJ0MCNjniK
        KXhHGc6O9mheLkdOzZeYXXFX9UtILDAtK4dKEP2s/G1ZyyZJrADugUvCD9HVXUDAWL/17hhYhromc
        idcByhhIr5LwLwxymlXbrLcrl02U8Q3qQ7iuMRWDi5FrpsLXhheoHUd5WfCaOeXCYWxmq+gMCsd/V
        BvrhZp0QJ1cyEWpgKIK1CHCVj5E8moJRGcVNmss2ttkhg8yOcrGj5DXG/SEcV+1qmP64QHq8NcwBg
        r/NfGceqD/AwvN26pQ54L7Z03a9sjxIK9GqOmBO9bivtxrZBgvMUjWx9Md00u2FP7JSU81lpBZFpG
        3hfnWgJA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxDNm-00HaOW-GX; Mon, 21 Nov 2022 20:27:10 +0000
Date:   Mon, 21 Nov 2022 12:27:10 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Petr Pavlu <petr.pavlu@suse.com>,
        Prarit Bhargava <prarit@redhat.com>, pmladek@suse.com,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Message-ID: <Y3vfHm1Cr1Q6NSDJ@bombadil.infradead.org>
References: <d0bc50e3-0e42-311b-20ed-7538bb918c5b@suse.com>
 <Y277Jb9i2VeXQoTL@bombadil.infradead.org>
 <e070839f-c224-047b-9411-91143c1d8394@redhat.com>
 <Y3Jg8X7qv2AKPU1J@bombadil.infradead.org>
 <5467e66d-55de-ca8f-c1ae-ffe6efe7290d@redhat.com>
 <Y3Pol5H4kJioAV9W@bombadil.infradead.org>
 <c2e841b7-e2b3-09f9-8187-328131d72c5d@redhat.com>
 <049a8f8a-baf8-744d-6250-575fc0dc533e@suse.com>
 <Y3vLbDAeILx7gJPT@bombadil.infradead.org>
 <11f65f51-5d77-e1cc-8f8a-779e35dd6af3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11f65f51-5d77-e1cc-8f8a-779e35dd6af3@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 08:50:11PM +0100, David Hildenbrand wrote:
> On 21.11.22 20:03, Luis Chamberlain wrote:
> > On Mon, Nov 21, 2022 at 05:00:49PM +0100, Petr Pavlu wrote:
> > > On 11/16/22 17:03, Prarit Bhargava wrote:
> > > > On 11/15/22 14:29, Luis Chamberlain wrote:
> > > > > On Mon, Nov 14, 2022 at 04:45:05PM +0100, David Hildenbrand wrote:
> > > > > > Note that I don't think the issue I raised is due to 6e6de3dee51a.
> > > > > > I don't have the machine at hand right now. But, again, I doubt this will
> > > > > > fix it.
> > > > > 
> > > > > There are *more* modules processed after that commit. That's all. So
> > > > > testing would be appreciated.
> > > > > 
> > > > 
> > > > Can anyone tell us if
> > > > 
> > > > https://lore.kernel.org/linux-pm/20221102195957.82871-1-stuart.w.hayes@gmail.com/
> > > > 
> > > > resolves the module loading delay problem?
> > > 
> > > This patch unfortunately makes no difference on my test system. In my case,
> > > the kernel has already intel_pstate loaded when udev starts inserting a burst
> > > of acpi_cpufreq modules. It then causes the init function acpi_cpufreq_init()
> > > to immediately return once the check cpufreq_get_current_driver() fails. The
> > > code modified by the patch is not reached at all.
> > 
> > To be clear I don't care about the patch mentioned in the above URL, I care
> > about this:
> > 
> > https://lkml.kernel.org/r/d0bc50e3-0e42-311b-20ed-7538bb918c5b@suse.com
> > 
> > David was this the on you tested too?
> 
> Yes, that's the one I tried without luck.

OK thanks. I'm just trying to sort out the regression first before we go
out and fix another issue. We will chase that issue down though and I
hav some other ideas to help with this further too.

  Luis
