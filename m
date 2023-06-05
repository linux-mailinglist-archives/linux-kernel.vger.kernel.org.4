Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B1E7228A4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjFEOTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbjFEOS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:18:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AAB10C;
        Mon,  5 Jun 2023 07:18:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 347D66241A;
        Mon,  5 Jun 2023 14:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632DBC433EF;
        Mon,  5 Jun 2023 14:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685974727;
        bh=zq25hJ0fHK6GtehEcofkCZeAy8jNCWwt6NKJQEwBpSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FvbA7sETZUW5ZcfTxbhvBaQKfBV28xcoqYaInME55BvENaD8mTZnOhJJubLqBfwas
         S2+KfwHil+AQh6U5BY7kxfxfsXzIRbc9Fm1jsuCYqwhPzADC3AiOKBuPyMSCT0XqyT
         cedzg8Vp/4wtQVT4K8gDNrunucZWVy+D0nvntkUiCe89JGFnvfxB/ML5apb7lEPBog
         eBDa4Md6P6ZWalE+1acYuyw8GgqeNvLOy8glnwIMA+6yqLP4YDQl+3oF6ZExl56ExD
         mffuTaNBhr+08U3L0Mdi2mJLHbRxkINhvTP/Ijb/8ECezrov4sJ5PhAhCoLumjP55S
         unYQlpAMd6HmQ==
Date:   Mon, 5 Jun 2023 15:18:39 +0100
From:   Will Deacon <will@kernel.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, qperret@google.com
Subject: Re: [PATCH v13 10/24] gunyah: vm_mgr: Add/remove user memory regions
Message-ID: <20230605141839.GD21212@willie-the-truck>
References: <20230509204801.2824351-1-quic_eberman@quicinc.com>
 <20230509204801.2824351-11-quic_eberman@quicinc.com>
 <20230519115948.GB2637@willie-the-truck>
 <e22c31bd-10ed-f242-3e72-debf40e01e3c@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e22c31bd-10ed-f242-3e72-debf40e01e3c@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elliot,

[+Quentin since he's looked at the MMU notifiers]

Sorry for the slow response, I got buried in email during a week away.

On Fri, May 19, 2023 at 10:02:29AM -0700, Elliot Berman wrote:
> On 5/19/2023 4:59 AM, Will Deacon wrote:
> > On Tue, May 09, 2023 at 01:47:47PM -0700, Elliot Berman wrote:
> > > +	ret = account_locked_vm(ghvm->mm, mapping->npages, true);
> > > +	if (ret)
> > > +		goto free_mapping;
> > > +
> > > +	mapping->pages = kcalloc(mapping->npages, sizeof(*mapping->pages), GFP_KERNEL_ACCOUNT);
> > > +	if (!mapping->pages) {
> > > +		ret = -ENOMEM;
> > > +		mapping->npages = 0; /* update npages for reclaim */
> > > +		goto unlock_pages;
> > > +	}
> > > +
> > > +	gup_flags = FOLL_LONGTERM;
> > > +	if (region->flags & GH_MEM_ALLOW_WRITE)
> > > +		gup_flags |= FOLL_WRITE;
> > > +
> > > +	pinned = pin_user_pages_fast(region->userspace_addr, mapping->npages,
> > > +					gup_flags, mapping->pages);
> > > +	if (pinned < 0) {
> > > +		ret = pinned;
> > > +		goto free_pages;
> > > +	} else if (pinned != mapping->npages) {
> > > +		ret = -EFAULT;
> > > +		mapping->npages = pinned; /* update npages for reclaim */
> > > +		goto unpin_pages;
> > > +	}
> > 
> > Sorry if I missed it, but I still don't see where you reject file mappings
> > here.
> > 
> 
> Sure, I can reject file mappings. I didn't catch that was the ask previously
> and thought it was only a comment about behavior of file mappings.

I thought the mention of filesystem corruption was clear enough! It's
definitely something we shouldn't allow.

> > This is also the wrong interface for upstream. Please get involved with
> > the fd-based guest memory discussions [1] and port your series to that.
> > 
> 
> The user interface design for *shared* memory aligns with
> KVM_SET_USER_MEMORY_REGION.

I don't think it does. For example, file mappings don't work (as above),
you're placing additional rlimit requirements on the caller, read-only
memslots are not functional, the memory cannot be swapped or migrated,
dirty logging doesn't work etc. pKVM is in the same boat, but that's why
we're not upstreaming this part in its current form.

> I understood we want to use restricted memfd for giving guest-private memory
> (Gunyah calls this "lending memory"). When I went through the changes, I
> gathered KVM is using restricted memfd only for guest-private memory and not
> for shared memory. Thus, I dropped support for lending memory to the guest
> VM and only retained the shared memory support in this series. I'd like to
> merge what we can today and introduce the guest-private memory support in
> tandem with the restricted memfd; I don't see much reason to delay the
> series.

Right, protected guests will use the new restricted memfd ("guest mem"
now, I think?), but non-protected guests should implement the existing
interface *without* the need for the GUP pin on guest memory pages. Yes,
that means full support for MMU notifiers so that these pages can be
managed properly by the host kernel. We're working on that for pKVM, but
it requires a more flexible form of memory sharing over what we currently
have so that e.g. the zero page can be shared between multiple entities.

Will
