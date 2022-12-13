Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA8764BCA7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 20:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbiLMTDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 14:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236759AbiLMTDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 14:03:18 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 942CC64E6;
        Tue, 13 Dec 2022 11:03:13 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 9B160E0EF0;
        Tue, 13 Dec 2022 22:03:11 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-type:content-type:date
        :from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=post; bh=Hlahiv0vhz43D43ZApHb
        BCFj3/fxigTRFzeUW3mJEAc=; b=Y8zt/SjvN8egBP8Dw8md0tlwUi8Gt7v8tgLg
        +TgBGHJno0w5jQhAryFcf/DpWh4kMuQiS3bIIRZQ57t4ataastqDx3T1BySgBAGQ
        NpqJ9aShP2XE/SSQuW2mvb7Q5UN9fwgvJ/Y496VYqIX1YHo/GKLNN0MM1zmHCg51
        uEFAAPs=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 826BBE0EBD;
        Tue, 13 Dec 2022 22:03:11 +0300 (MSK)
Received: from mobilestation (10.8.30.6) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 13 Dec 2022 22:03:10 +0300
Date:   Tue, 13 Dec 2022 22:03:10 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Thierry Reding <treding@nvidia.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     Vidya Sagar <vidyas@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Rob Herring <robh@kernel.org>
Subject: Re: linux-next: manual merge of the pci tree with the arm-soc tree
Message-ID: <20221213190310.sztjn5nnwuubrtbg@mobilestation>
References: <20221205095738.607b9551@canb.auug.org.au>
 <20221213162103.GA106222@bhelgaas>
 <Y5is9cp6WdWixwgU@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y5is9cp6WdWixwgU@orome>
X-Originating-IP: [10.8.30.6]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 05:48:53PM +0100, Thierry Reding wrote:
> On Tue, Dec 13, 2022 at 10:21:03AM -0600, Bjorn Helgaas wrote:
> > On Mon, Dec 05, 2022 at 09:57:38AM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > Today's linux-next merge of the pci tree got a conflict in:
> > > 
> > >   Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > 
> > > between commit:
> > > 
> > >   5c3741492d2e ("dt-bindings: PCI: tegra234: Add ECAM support")
> > > 
> > > from the arm-soc tree and commit:
> > > 
> > >   4cc13eedb892 ("dt-bindings: PCI: dwc: Add reg/reg-names common properties")
> > > 
> > > from the pci tree.
> > > 
> > > I didn't know how to fix this up, so I just used the latter (and so lost
> > > the addition of "ecam").
> > 
> > Did I miss a suggested resolution for this?
> 

> We had a brief discussion about this in another thread. So basically
> Stephen's resolution is fine here and the plan is to instead add the
> ECAM bits that the Tegra patch does in a separate patch on top of
> Serge's patch. I should get around to sending that patch tomorrow.
> 
> Thierry

Actually the discussion still goes. I haven't got a respond to my
last suggestion which seems to me more reasonable than extending the
DT-bindings with another vendor-specific reg-name. @Bjorn, please join
the discussion here:
https://lore.kernel.org/linux-pci/20221114155333.234496-2-jonathanh@nvidia.com/

-Sergey

