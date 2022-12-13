Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233ED64BDBC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 21:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbiLMUHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 15:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236458AbiLMUHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 15:07:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB22E290;
        Tue, 13 Dec 2022 12:07:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5830161714;
        Tue, 13 Dec 2022 20:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E063C433EF;
        Tue, 13 Dec 2022 20:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670962055;
        bh=GYYlwzxQ3UCGDe4WcOmFtXm8+K3DpY1ve1L3XVCcVmU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KofgOd1F40PH4rNxNB0DqLPpABTiEpu0ZdQZ0akIFU8PBSgL3kPKuUnREhGzShzOk
         FQwMU4YkKA2TvR4n/jIe3pvx/HJ/8ZRVqfuvdhLAHCUBcHELvXNzUKjfHM0H8IUZh4
         e/jT0oU0+NDN2xcx3k7cUBz9z5VLF+DZ9cmaP4RM2Idw9PY3/MjNwad4YucEnp9de+
         +48UKgpJEsTXQ6ElCMOmcZx9u5WAzJS6Fb1uJ6JGCBHjZH2tOpfoMOZwdu+DKKrPTk
         9aY1pJj2bhTEpBEZV+ZauufRAStYboO9PUduehSn3xb6WqxOuLXVNMoXOVnDYZs5DF
         cvtWPVNOvpfiQ==
Date:   Tue, 13 Dec 2022 14:07:33 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Thierry Reding <treding@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Rob Herring <robh@kernel.org>
Subject: Re: linux-next: manual merge of the pci tree with the arm-soc tree
Message-ID: <20221213200733.GA201693@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213195313.GA200257@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 01:53:13PM -0600, Bjorn Helgaas wrote:
> On Tue, Dec 13, 2022 at 10:03:10PM +0300, Serge Semin wrote:
> > On Tue, Dec 13, 2022 at 05:48:53PM +0100, Thierry Reding wrote:
> > > On Tue, Dec 13, 2022 at 10:21:03AM -0600, Bjorn Helgaas wrote:
> > > > On Mon, Dec 05, 2022 at 09:57:38AM +1100, Stephen Rothwell wrote:
> > > > > Hi all,
> > > > > 
> > > > > Today's linux-next merge of the pci tree got a conflict in:
> > > > > 
> > > > >   Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > 
> > > > > between commit:
> > > > > 
> > > > >   5c3741492d2e ("dt-bindings: PCI: tegra234: Add ECAM support")
> > > > > 
> > > > > from the arm-soc tree and commit:
> > > > > 
> > > > >   4cc13eedb892 ("dt-bindings: PCI: dwc: Add reg/reg-names common properties")
> > > > > 
> > > > > from the pci tree.
> > > > > 
> > > > > I didn't know how to fix this up, so I just used the latter (and so lost
> > > > > the addition of "ecam").
> > > > 
> > > > Did I miss a suggested resolution for this?
> > 
> > > We had a brief discussion about this in another thread. So basically
> > > Stephen's resolution is fine here and the plan is to instead add the
> > > ECAM bits that the Tegra patch does in a separate patch on top of
> > > Serge's patch. I should get around to sending that patch tomorrow.
> > 
> > Actually the discussion still goes. I haven't got a respond to my
> > last suggestion which seems to me more reasonable than extending the
> > DT-bindings with another vendor-specific reg-name. @Bjorn, please join
> > the discussion here:
> > https://lore.kernel.org/linux-pci/20221114155333.234496-2-jonathanh@nvidia.com/
> 
> Sorry, it's really too late for discussion.  I need to send the v6.2
> pull request today or at the very latest, tomorrow, so the only thing
> to decide is how to resolve the merge conflict in the simplest
> possible way.  Unless there's a very compelling reason to resolve it
> differently than Stephen did, that's going to be the answer.

To be more specific, the current answer is this (which is the same as
what's in next-20221213):

  https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/tree/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml?id=f64171fdd171

If you think it needs to be different, please respond with a patch and
explanation.

Bjorn
