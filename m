Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F516B8055
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjCMSWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjCMSVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:21:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4ABEA80E2E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:21:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E56444B3;
        Mon, 13 Mar 2023 11:21:04 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 080EF3F67D;
        Mon, 13 Mar 2023 11:20:19 -0700 (PDT)
Date:   Mon, 13 Mar 2023 18:20:13 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Marc Zyngier <maz@misterjones.org>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: Circular lockdep in kvm_reset_vcpu() ?
Message-ID: <ZA9pUNZPyFtLDfxC@e120937-lin>
References: <f6452cdd-65ff-34b8-bab0-5c06416da5f6@arm.com>
 <Y+bnybGEkMpZzm/y@linux.dev>
 <ZA72c+TT9epTcvX4@e120937-lin>
 <3496a6a10b2d8693825e733b871938f5@misterjones.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3496a6a10b2d8693825e733b871938f5@misterjones.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 02:09:55PM +0000, Marc Zyngier wrote:
> On 2023-03-13 10:09, Cristian Marussi wrote:
> > On Sat, Feb 11, 2023 at 12:56:41AM +0000, Oliver Upton wrote:
> > > Hi Jeremy,
> > > 
> > 
> > Hi,
> > 
> > > On Fri, Feb 10, 2023 at 11:46:36AM -0600, Jeremy Linton wrote:
> > > > Hi,
> > > >
> > > > I saw this pop yesterday:
> > > 
> > > You and me both actually! Shame on me, I spoke off-list about this
> > > with
> > > Marc in passing. Thanks for sending along the report.
> > > 
> > > > [   78.333360] ======================================================
> > > > [   78.339541] WARNING: possible circular locking dependency detected
> > > > [   78.345721] 6.2.0-rc7+ #19 Not tainted
> > > > [   78.349470] ------------------------------------------------------
> > > > [   78.355647] qemu-system-aar/859 is trying to acquire lock:
> > > > [   78.361130] ffff5aa69269eba0 (&host_kvm->lock){+.+.}-{3:3}, at:
> > > > kvm_reset_vcpu+0x34/0x274
> > > > [   78.369344]
> > > > [   78.369344] but task is already holding lock:
> > > > [   78.375182] ffff5aa68768c0b8 (&vcpu->mutex){+.+.}-{3:3}, at:
> > > > kvm_vcpu_ioctl+0x8c/0xba0
> > > 
> > > [...]
> > > 
> > > > It appears to be triggered by the new commit 42a90008f890a ('KVM: Ensure
> > > > lockdep knows about kvm->lock vs. vcpu->mutex ordering rule') which is
> > > > detecting the vcpu lock grabbed by kvm_vcpu_ioctl() and then the kvm mutext
> > > > grabbed by kvm_reset_vcpu().
> > > 
> > > Right, this commit gave lockdep what it needed to smack us on the head
> > > for getting the locking wrong in the arm64 side.
> > > 
> > > As gross as it might be, the right direction is likely to have our own
> > > lock in kvm_arch that we can acquire while holding the vcpu mutex.
> > > I'll
> > > throw a patch at the list once I get done testing it.
> > > 
> > 
> > I just hit this using a v6.3-rc2 and a mainline kvmtool.
> > 
> > In my case, though, the guest does not even boot if I use more than 1
> > vcpu, which
> > I suppose triggers effectively the reported possible deadlock, i.e.:
> > 
> > root/lkvm_master run -c 4 -m 4096 -k /root/Image_guest -d
> > /root/disk_debian_buster_guest.img -p "loglevel=8"
> >   # lkvm run -k /root/Image_guest -m 4096 -c 4 --name guest-288
> > ....<HANGS FOREVER>
> 
> Pass earlycon to the guest for a start.
> 
> I seriously doubt someone has actually seen a deadlock, because
> the issue has been there for at least the past 7 years...
> 
> And -rc2 works just fine here.

Thanks, I'll dig deeper what's going on un my setup.
Cristian
