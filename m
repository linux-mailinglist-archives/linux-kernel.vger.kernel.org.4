Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB06E702004
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 23:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbjENVt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 17:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjENVtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 17:49:24 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A8290;
        Sun, 14 May 2023 14:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zygIhDyV8ht+xJs1lmqnA3sy7ZHDhj2x5W8U9MyDTpM=; b=AtfoJ+yRkuDm9gCWovg7bgbFzv
        zvtG8omqD3Ee2e5vtlK1211bbhN7KzcG9ZOV/p9gXghTUS1HF9EaelwoM4SQo/b4sWNMb2wsJsVAh
        ryLGjfB/dL5jQW5LWnI6h4gq4lKj2LKWt1eQxsKNKi4CYTHPi2D+7G5csc6so1Mr3IZqjzYXfvDre
        Wa2IYRFjoBiG9xBoaM3MR/ceTkMFFWkX6SNnbTUn4IT7Xv2Ef1OD3QTBmf65tsdUdiBBhGBc7WMfJ
        YjLmEKzf9bN3ap+iE91yCmvTRvaupsrf+ACH5S2PsgkJyDm/ZJKotc9YiiD6FM6FqFSv7z1nQGLn3
        n3J6H6Qw==;
Received: from [177.189.3.227] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1pyJaT-009SDU-MC; Sun, 14 May 2023 23:49:06 +0200
Message-ID: <b4733705-7014-49c6-57ab-a67459954f28@igalia.com>
Date:   Sun, 14 May 2023 18:48:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [patch V4 00/37] cpu/hotplug, x86: Reworked parallel CPU bringup
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Ross Philipson <ross.philipson@oracle.com>
References: <20230512203426.452963764@linutronix.de>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230512203426.452963764@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 18:06, Thomas Gleixner wrote:
> Hi!
> 
> This is version 4 of the reworked parallel bringup series. Version 3 can be
> found here:
> 
>    https://lore.kernel.org/lkml/20230508181633.089804905@linutronix.de


Hi Thomas, thanks for series! I was able to test it on the Steam Deck
(on top of 6.4-rc2), and everything is working fine; also tested S3
suspend/resume, working as expected.

Some logs from boot time:


Parallel boot
[    0.239764] smp: Bringing up secondary CPUs ...
[...]
[    0.253130] smp: Brought up 1 node, 8 CPUs


Regular boot (with cpuhp.parallel=0)
[    0.240093] smp: Bringing up secondary CPUs ...
[...]
[    0.253475] smp: Brought up 1 node, 8 CPUs


Feel free to add (to the series):

Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck

Cheers,


Guilherme
