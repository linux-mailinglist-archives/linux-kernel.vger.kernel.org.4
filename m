Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB76D706356
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjEQIvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjEQIvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:51:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D611BC3;
        Wed, 17 May 2023 01:51:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB90C63821;
        Wed, 17 May 2023 08:51:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B5EC433EF;
        Wed, 17 May 2023 08:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684313466;
        bh=8BhycqlJAWzVNQ8w1EwRwdnYUlS3UWhW4kfx4xXZ0b8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sOjSHfCZ48rD2SR98tO++PRNtsXhs6EKNm0br8Hqx+xvy5HUKhtRxZCbI3YATetfY
         fRdfyk4RlHM6Yk2pAk11e9YOWJQj/3k+vMoO1UX97D1QBScn7FYIi5/9YZ5CBX1EFd
         Z5zMgsNwvdAlS9M8CizEpLOeM2qjnZqmIR+5ipYI=
Date:   Wed, 17 May 2023 10:51:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de
Subject: Re: [PATCH 5.10 000/381] 5.10.180-rc1 review
Message-ID: <2023051711-thespian-sponsor-8878@gregkh>
References: <20230515161736.775969473@linuxfoundation.org>
 <ZGNJfAPd8eeVoCJ3@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGNJfAPd8eeVoCJ3@debian>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 10:14:36AM +0100, Sudip Mukherjee (Codethink) wrote:
> Hi Greg,
> 
> On Mon, May 15, 2023 at 06:24:11PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.10.180 release.
> > There are 381 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> 
> Build test (gcc version 11.3.1 20230511):
> mips: 63 configs -> no failure
> arm: 104 configs -> no failure
> arm64: 3 configs -> 1 failure
> x86_64: 4 configs -> no failure
> alpha allmodconfig -> no failure
> powerpc allmodconfig -> no failure
> riscv allmodconfig -> no failure
> s390 allmodconfig -> no failure
> xtensa allmodconfig -> no failure
> 
> arm64 allmodconfig build fails with the error:
> 
> /gcc/bin/aarch64-linux-ld: arch/arm64/kvm/hyp/nvhe/kvm_nvhe.o: in function `__kvm_nvhe___kvm_tlb_flush_vmid_ipa':
> (.hyp.text+0x1a4c): undefined reference to `__kvm_nvhe_memset'
> /gcc/bin/aarch64-linux-ld: arch/arm64/kvm/hyp/nvhe/kvm_nvhe.o: in function `__kvm_nvhe___kvm_tlb_flush_vmid':
> (.hyp.text+0x1b20): undefined reference to `__kvm_nvhe_memset'
> /gcc/bin/aarch64-linux-ld: arch/arm64/kvm/hyp/nvhe/kvm_nvhe.o: in function `__kvm_nvhe___kvm_flush_cpu_context':
> (.hyp.text+0x1b80): undefined reference to `__kvm_nvhe_memset'

That's odd, I don't see that symbol anywhere in the tree at all.

And the only arm-related kvm changes don't have those symbols either
(the other kvm changes are x86-only)

Also, no one else has seen this issue.  Can you bisect?

thanks,

greg k-h
