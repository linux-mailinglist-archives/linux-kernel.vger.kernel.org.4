Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C777632C96
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 20:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiKUTDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 14:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiKUTDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:03:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03053627D7;
        Mon, 21 Nov 2022 11:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JBM6P9/8GIhR4EwsVnymcej4u+05QBzB6q6S+C9qT1o=; b=BrhwzfyE6e/l09sfSmYIdYlUz8
        uKB6a4rcWpJJJ/PAcs/yEne8H5J2M20KaEPdLpcFqfNV0WX73ddET6dKFBwn/0wRIVO3a9OQgqjnj
        joIRLBDSpcq/LihJCQ2lJSklFy8kQ2CLRAF1UQf59TlKEPb2fHiQcFWkkfzBKKZXn4A0e87rLXpOu
        xqVdYtVr/jxtU8i+A6+BoL1wg9+lqoRTjAHtVi8yWY/Zxe8Tmi6W5XixLgRl6+iT3xmWDxn931V2y
        KVrp8h/xJqpq6veqIfuTI9Q5BxHQ+BK/QlY0kUM+XXwrFVXZUlRBHAWMpUkk33Jdino4kwSLdKQ1h
        QvinXbsg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxC4S-00HB4h-2A; Mon, 21 Nov 2022 19:03:08 +0000
Date:   Mon, 21 Nov 2022 11:03:08 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     Prarit Bhargava <prarit@redhat.com>, pmladek@suse.com,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Message-ID: <Y3vLbDAeILx7gJPT@bombadil.infradead.org>
References: <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
 <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
 <d0bc50e3-0e42-311b-20ed-7538bb918c5b@suse.com>
 <Y277Jb9i2VeXQoTL@bombadil.infradead.org>
 <e070839f-c224-047b-9411-91143c1d8394@redhat.com>
 <Y3Jg8X7qv2AKPU1J@bombadil.infradead.org>
 <5467e66d-55de-ca8f-c1ae-ffe6efe7290d@redhat.com>
 <Y3Pol5H4kJioAV9W@bombadil.infradead.org>
 <c2e841b7-e2b3-09f9-8187-328131d72c5d@redhat.com>
 <049a8f8a-baf8-744d-6250-575fc0dc533e@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <049a8f8a-baf8-744d-6250-575fc0dc533e@suse.com>
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

On Mon, Nov 21, 2022 at 05:00:49PM +0100, Petr Pavlu wrote:
> On 11/16/22 17:03, Prarit Bhargava wrote:
> > On 11/15/22 14:29, Luis Chamberlain wrote:
> >> On Mon, Nov 14, 2022 at 04:45:05PM +0100, David Hildenbrand wrote:
> >>> Note that I don't think the issue I raised is due to 6e6de3dee51a.
> >>> I don't have the machine at hand right now. But, again, I doubt this will
> >>> fix it.
> >>
> >> There are *more* modules processed after that commit. That's all. So
> >> testing would be appreciated.
> >>
> > 
> > Can anyone tell us if
> > 
> > https://lore.kernel.org/linux-pm/20221102195957.82871-1-stuart.w.hayes@gmail.com/
> > 
> > resolves the module loading delay problem?
> 
> This patch unfortunately makes no difference on my test system. In my case,
> the kernel has already intel_pstate loaded when udev starts inserting a burst
> of acpi_cpufreq modules. It then causes the init function acpi_cpufreq_init()
> to immediately return once the check cpufreq_get_current_driver() fails. The
> code modified by the patch is not reached at all.

To be clear I don't care about the patch mentioned in the above URL, I care
about this:

https://lkml.kernel.org/r/d0bc50e3-0e42-311b-20ed-7538bb918c5b@suse.com

David was this the on you tested too?

Prarit, so you're left to please test, the hope would be that at the
very least it still fixes your issue.

Petr, you had mentioned in the commit log for your second patch in this
thread that your change fixes a regression. What I asked for was for a
patch that fixes that regression alone first so we can send to stable.
So what issue is that alternative patch fixing?

  Luis
