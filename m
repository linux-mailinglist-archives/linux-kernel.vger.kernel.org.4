Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3127730C4F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 02:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237547AbjFOAlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 20:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237006AbjFOAlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 20:41:14 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5EBEB26A1;
        Wed, 14 Jun 2023 17:41:13 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 1222292009D; Thu, 15 Jun 2023 02:41:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 0AE5092009C;
        Thu, 15 Jun 2023 01:41:11 +0100 (BST)
Date:   Thu, 15 Jun 2023 01:41:10 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        linux-rdma@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        Stefan Roese <sr@denx.de>, Jim Wilson <wilson@tuliptree.org>,
        netdev@vger.kernel.org
Subject: Re: [PATCH v9 00/14] pci: Work around ASMedia ASM2824 PCIe link
 training failures
In-Reply-To: <20230614231203.GA1451606@bhelgaas>
Message-ID: <alpine.DEB.2.21.2306150124010.64925@angie.orcam.me.uk>
References: <20230614231203.GA1451606@bhelgaas>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023, Bjorn Helgaas wrote:

> >  This is v9 of the change to work around a PCIe link training phenomenon 
> > where a pair of devices both capable of operating at a link speed above 
> > 2.5GT/s seems unable to negotiate the link speed and continues training 
> > indefinitely with the Link Training bit switching on and off repeatedly 
> > and the data link layer never reaching the active state.
> > 
> >  With several requests addressed and a few extra issues spotted this
> > version has now grown to 14 patches.  It has been verified for device 
> > enumeration with and without PCI_QUIRKS enabled, using the same piece of 
> > RISC-V hardware as previously.  Hot plug or reset events have not been 
> > verified, as this is difficult if at all feasible with hardware in 
> > question.
> > 
> >  Last iteration: 
> > <https://lore.kernel.org/r/alpine.DEB.2.21.2304060100160.13659@angie.orcam.me.uk/>, 
> > and my input to it:
> > <https://lore.kernel.org/r/alpine.DEB.2.21.2306080224280.36323@angie.orcam.me.uk/>.
> 
> Thanks, I applied these to pci/enumeration for v6.5.

 Great, thanks!

> I tweaked a few things, so double-check to be sure I didn't break
> something:
> 
>   - Moved dev->link_active_reporting init to set_pcie_port_type()
>     because it does other PCIe-related stuff.
> 
>   - Reordered to keep all the link_active_reporting things together.
> 
>   - Reordered to clean up & factor pcie_retrain_link() before exposing
>     it to the rest of the PCI core.
> 
>   - Moved pcie_retrain_link() a little earlier to keep it next to
>     pcie_wait_for_link_status().
> 
>   - Squashed the stubs into the actual quirk so we don't have the
>     intermediate state where we call the stubs but they never do
>     anything (let me know if there's a reason we need your order).
> 
>   - Inline pcie_parent_link_retrain(), which seemed like it didn't add
>     enough to be worthwhile.

 Ack, I'll double-check and report back.  A minor nit I've spotted below:

>  static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>  {
> -	bool retrain = true;
>  	int delay = 1;
> +	bool retrain = false;
> +	struct pci_dev *bridge;
> +
> +	if (pci_is_pcie(dev)) {
> +		retrain = true;
> +		bridge = pci_upstream_bridge(dev);
> +	}

 If doing it this way, which I actually like, I think it would be a little 
bit better performance- and style-wise if this was written as:

	if (pci_is_pcie(dev)) {
		bridge = pci_upstream_bridge(dev);
		retrain = !!bridge;
	}

(or "retrain = bridge != NULL" if you prefer this style), and then we 
don't have to repeatedly check two variables iff (pcie && !bridge) in the 
loop below:

> @@ -1201,9 +1190,9 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>  		}
>  
>  		if (delay > PCI_RESET_WAIT) {
> -			if (retrain) {
> +			if (retrain && bridge) {

-- i.e. code can stay then as:

			if (retrain) {

here.  I hope you find this observation rather obvious, so will you amend 
your tree, or shall I send an incremental update?

 Otherwise I don't find anything suspicious with the interdiff itself 
(thanks for posting it, that's really useful indeed!), but as I say I'll 
yet double-check how things look and work with your tree.  Hopefully 
tomorrow (Thu), as I have other stuff yet to complete tonight.

  Maciej
