Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D006E0AB2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjDMJye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjDMJya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:54:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DA29772;
        Thu, 13 Apr 2023 02:54:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B67363AF8;
        Thu, 13 Apr 2023 09:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC81FC433D2;
        Thu, 13 Apr 2023 09:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681379666;
        bh=0DrIy6L0mgWBKpbiTpq/w5yQJ7iegdOLGEBJBIpU3z4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EdN+myph2daeRxjNIkFWfOM2t26TzhiMQWFyoSYKoocfQSYMVwt5SRXo47+M1kbZv
         Y1xnQKPqWNUeBYKFGYZY2NFHGl3ZzGYsbjmq3UNekcihjdKBOQ3o2mFqnNRHK8z+Kl
         7sL78rTsa/8W3U4KnUKPRtOqGmFO1Oiha6zimkCB8s+ZZREiO1GnHvwivWaYTG+lG7
         FGOBzjCckphv4nxlAuPtjuTDqm0MiQC9HiGE825z9qiNBlJlyBxGZxfYcNNsRp+Ssx
         dBvCDP9AYH/khreMqUT+Fd3C3HWkjjXJAKjTswQvrt4KsDyyKru2otjlwS4cZqPyJ+
         oHQNQ7FB0MrOg==
Date:   Thu, 13 Apr 2023 10:54:18 +0100
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
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v11 12/26] gunyah: vm_mgr: Add/remove user memory regions
Message-ID: <20230413095418.GA25922@willie-the-truck>
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
 <20230304010632.2127470-13-quic_eberman@quicinc.com>
 <20230324183659.GB28266@willie-the-truck>
 <5d1c6160-6bc4-5246-2a0b-de5ddcbbc2c4@quicinc.com>
 <20230411211940.GC23890@willie-the-truck>
 <67209a0d-1dc5-ce96-e916-85bfd8f6a7f8@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67209a0d-1dc5-ce96-e916-85bfd8f6a7f8@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 01:48:07PM -0700, Elliot Berman wrote:
> 
> 
> On 4/11/2023 2:19 PM, Will Deacon wrote:
> > On Tue, Apr 11, 2023 at 01:34:34PM -0700, Elliot Berman wrote:
> > > On 3/24/2023 11:37 AM, Will Deacon wrote:
> > > > On Fri, Mar 03, 2023 at 05:06:18PM -0800, Elliot Berman wrote:
> > > > > +
> > > > > +	pinned = pin_user_pages_fast(region->userspace_addr, mapping->npages,
> > > > > +					FOLL_WRITE | FOLL_LONGTERM, mapping->pages);
> > > > > +	if (pinned < 0) {
> > > > > +		ret = pinned;
> > > > > +		mapping->npages = 0; /* update npages for reclaim */
> > > > > +		goto reclaim;
> > > > > +	} else if (pinned != mapping->npages) {
> > > > > +		ret = -EFAULT;
> > > > > +		mapping->npages = pinned; /* update npages for reclaim */
> > > > > +		goto reclaim;
> > > > > +	}
> > > > 
> > > > I think Fuad mentioned this on an older version of these patches, but it
> > > > looks like you're failing to account for the pinned memory here which is
> > > > a security issue depending on who is able to issue the ioctl() calling
> > > > into here.
> > > > 
> > > > Specifically, I'm thinking that your kXalloc() calls should be using
> > > > GFP_KERNEL_ACCOUNT in this function and also that you should be calling
> > > > account_locked_vm() for the pages being pinned.
> > > > 
> > > 
> > > Added the accounting for the v12.
> > > 
> > > > Finally, what happens if userspace passes in a file mapping?
> > > 
> > > Userspace will get EBADADDR (-14) back when trying to launch the VM
> > > (pin_user_pages_fast returns this as you might have been expecting). We
> > > haven't yet had any need to support file-backed mappings.
> > 
> > Hmm, no, that's actually surprising to me. I'd have thought GUP would
> > happily pin page-cache pages for file mappings, so I'm intrigued as to
> > which FOLL_ flag is causing you to get an error code back. Can you
> > enlighten me on where the failure originates, please?
> 
> Ah this ended up being an error on my part. Userspace was opening the file
> as RO and Gunyah driver will unconditionally add FOLL_WRITE as part of the
> gup flags. I got the flags aligned and seemed to be able to boot the VM ok
> and it works as expected.

I suspect you can run into latent filesystem corruption issues in this case,
as the VM can dirty pages without the filesystem knowing. That's why we
restricted anonymous memory with pKVM for now.

Will
