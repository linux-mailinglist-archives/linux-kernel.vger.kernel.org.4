Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C5E634321
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 18:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbiKVR7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 12:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbiKVR6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 12:58:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC28D2FA;
        Tue, 22 Nov 2022 09:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZNAd/L3ZgbNcQldFxZ5AePOKH80viQBr86CXLFlx6Ts=; b=TetgmfMnLO+t/MSK8WjlM7+buV
        x/rspsf3QkTVdnAMmVqRS4qlbyvCq8wfvLFPEdIlNJkQZmuSP5oBZ080ZsMFnMjju7rypbiLPZyMH
        I85xIRN3zmD/jn7psUWSCvUubMy13OsjB+bOg9LIGlOLLs5ziLdC4+cyvTUaCa79oqLt3liRzU251
        uY8GGWyafwiOmp8uZrO9c+jcewcyEAIxL9qfRbZ/BKN3CMAh3KofPMcG0G2WX6HEGjOj+DMXcLkdM
        2STYJvtebyvaKjHS1SRsJYzC7WTsuQi6lskyOqAwthiQKCpf7Jpe/8wwI1FuV1KgVviZ1W5xSITKm
        C0TgWq/A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxXXf-00BC0Q-7s; Tue, 22 Nov 2022 17:58:43 +0000
Date:   Tue, 22 Nov 2022 09:58:43 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     Prarit Bhargava <prarit@redhat.com>, pmladek@suse.com,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Message-ID: <Y30N06kggeZKT8VD@bombadil.infradead.org>
References: <d0bc50e3-0e42-311b-20ed-7538bb918c5b@suse.com>
 <Y277Jb9i2VeXQoTL@bombadil.infradead.org>
 <e070839f-c224-047b-9411-91143c1d8394@redhat.com>
 <Y3Jg8X7qv2AKPU1J@bombadil.infradead.org>
 <5467e66d-55de-ca8f-c1ae-ffe6efe7290d@redhat.com>
 <Y3Pol5H4kJioAV9W@bombadil.infradead.org>
 <c2e841b7-e2b3-09f9-8187-328131d72c5d@redhat.com>
 <049a8f8a-baf8-744d-6250-575fc0dc533e@suse.com>
 <Y3vLbDAeILx7gJPT@bombadil.infradead.org>
 <3f50021f-2dbf-4e5e-d85f-bf41a02b6b6a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f50021f-2dbf-4e5e-d85f-bf41a02b6b6a@suse.com>
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

On Tue, Nov 22, 2022 at 02:59:18PM +0100, Petr Pavlu wrote:
> On 11/21/22 20:03, Luis Chamberlain wrote:
> > To be clear I don't care about the patch mentioned in the above URL, I care
> > about this:
> > 
> > https://lkml.kernel.org/r/d0bc50e3-0e42-311b-20ed-7538bb918c5b@suse.com
> > [...]
> > 
> > Petr, you had mentioned in the commit log for your second patch in this
> > thread that your change fixes a regression. What I asked for was for a
> > patch that fixes that regression alone first so we can send to stable.
> > So what issue is that alternative patch fixing?
> 
> This alternative patch fixes the discussed regression with failing inserts of
> acpi_cpufreq and pcc_cpufreq delaying boot. As mentioned, the situation can in
> the worst case prevent udev from loading drivers for other devices and might
> cause timeouts of services waiting on them and subsequently a failed boot.
> 
> The patch attempts a different solution for the problem that 6e6de3dee51a was
> trying to solve. Rather than waiting for the unloading to complete, it returns
> a different error code (-EBUSY) for modules in the GOING state. This should
> avoid the error situation that was described in 6e6de3dee51a (user space
> attempting to load a dependent module because the -EEXIST error code would
> suggest to user space that the first module had been loaded successfully),
> while avoiding the delay issue too.

Great, can you send a proper patch now with a proper commit log and Cc
stable tag?

  Luis
