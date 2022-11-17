Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C1162DC50
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239531AbiKQNK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbiKQNKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:10:24 -0500
X-Greylist: delayed 907 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Nov 2022 05:10:24 PST
Received: from queue02b.mail.zen.net.uk (queue02b.mail.zen.net.uk [212.23.3.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09540686AE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:10:23 -0800 (PST)
Received: from [212.23.1.3] (helo=smarthost01b.sbp.mail.zen.net.uk)
        by queue02b.mail.zen.net.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <dvrabel@cantab.net>)
        id 1oveQF-00052j-5S
        for linux-kernel@vger.kernel.org; Thu, 17 Nov 2022 12:55:15 +0000
Received: from [82.70.146.41] (helo=pear.davidvrabel.org.uk)
        by smarthost01b.sbp.mail.zen.net.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <dvrabel@cantab.net>)
        id 1oveQ0-0003J5-PK; Thu, 17 Nov 2022 12:55:00 +0000
Received: from apple.davidvrabel.org.uk ([82.70.146.43])
        by pear.davidvrabel.org.uk with esmtp (Exim 4.94.2)
        (envelope-from <dvrabel@cantab.net>)
        id 1ovePr-001FlP-Bo; Thu, 17 Nov 2022 12:55:00 +0000
Message-ID: <0afe3f35-1b25-d1c6-89bb-8dae7a4070e9@cantab.net>
Date:   Thu, 17 Nov 2022 12:54:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-GB
To:     =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jan Beulich <jbeulich@suse.com>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>
References: <20221117114122.1588338-1-marmarek@invisiblethingslab.com>
From:   David Vrabel <dvrabel@cantab.net>
In-Reply-To: <20221117114122.1588338-1-marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 82.70.146.43
X-SA-Exim-Mail-From: dvrabel@cantab.net
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
Subject: Re: [PATCH] xen-pciback: Consider MSI-X enabled only when MASKALL bit
 is cleared
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on pear.davidvrabel.org.uk)
X-Originating-smarthost01b-IP: [82.70.146.41]
Feedback-ID: 82.70.146.41
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2022 11:41, Marek Marczykowski-Górecki wrote:
> Linux enables MSI-X before disabling INTx, but keeps MSI-X masked until
> the table is filled. Then it disables INTx just before clearing MASKALL
> bit. Currently this approach is rejected by xen-pciback.
> Allow setting PCI_MSIX_FLAGS_ENABLE while INTx is still enabled as long
> as PCI_MSIX_FLAGS_MASKALL is set too.

The use of MSI-X interrupts is conditional on only the MSI-X Enable bit. 
Setting MSI-X Enable effectively overrides the Interrupt Disable bit in 
the Command register.

PCIe 6.0.1 section 7.7.2.2. "MSI-X Enable ... is prohibited from using 
INTx interrupts (if implemented)." And there is similar wording for MSI 
Enable.

I think you need to shuffle the checks for MSI/MSI-X in 
xen_pcibk_get_interrupt_type() so they are _before_ the check of the 
Interrupt Disable bit in the Command register.

David
