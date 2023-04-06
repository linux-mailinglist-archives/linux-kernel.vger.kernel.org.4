Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148AD6DA1F4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238542AbjDFTuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237736AbjDFTtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:49:52 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A462C7;
        Thu,  6 Apr 2023 12:49:50 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 2873992009C; Thu,  6 Apr 2023 21:49:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 197BA92009B;
        Thu,  6 Apr 2023 20:49:50 +0100 (BST)
Date:   Thu, 6 Apr 2023 20:49:50 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        linux-parport@lists.infradead.org
Subject: Re: [PATCH] parport_pc: don't allow driver for SPARC32
In-Reply-To: <20230406160548.25721-1-rdunlap@infradead.org>
Message-ID: <alpine.DEB.2.21.2304062039260.44308@angie.orcam.me.uk>
References: <20230406160548.25721-1-rdunlap@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Apr 2023, Randy Dunlap wrote:

> arch/sparc/kernel/ebus.o is only built for SPARC64.
> ns87303_lock is only built for SPARC64.
> arch/sparc/include/asm/parport.h says that it is for sparc64.
> Various documentation on the internet says that ebus is for UltraSPARC
> systems (64-bit).
> 
> Therefore don't allow PARPORT_PC to be built for SPARC32.

 This looks completely wrong to me, any ordinary PCI parallel port card 
ought just to work as long as you have PCI (S390 is special I'm told).  
What needs to be done is AFAICT just making `parport_pc_find_nonpci_ports' 
in arch/sparc/include/asm/parport.h SPARC64-specific, i.e.:

static int parport_pc_find_nonpci_ports(int autoirq, int autodma)
{
	return (IS_ENABLED(CONFIG_SPARC64) &&
		platform_driver_register(&ecpp_driver));
}

or suchlike and let the optimiser get rid of all the unwanted unsupported 
stuff.

  Maciej
