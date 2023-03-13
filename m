Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628016B7A90
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjCMOkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjCMOks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:40:48 -0400
X-Greylist: delayed 1829 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Mar 2023 07:40:44 PDT
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077E412CD2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=misterjones.org; s=dkim20211231; h=Content-Transfer-Encoding:Content-Type:
        Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Qr9EmARbpnWVBZVDOnt8Yn6YBbvuxLqxnG9mDigVdc4=; b=DTLP+2GXw5z/4G76KmEtd1Gja3
        D5qgsxG3QaFv3ll2zrN/8ibitIq82Ue+1nuq1WNt3GD11m2/MW7qW1kiXf/JyWy43RRoIxHKz0xOA
        WsHxrOaM3ubxLJz5npfX6Z/GvyW+qIE4yYKlyaBdbM+P7PMjBUNuc9c9714gUgZnGy4BQpqLn3vhL
        Fcve9tCh3qL7SAAOB5vD/Prka0F/aDQH9WRR3+Q+O6TAJRpU0NPc7AYhzDOddQkFf7cGUJyZ5bTRK
        IDMwgKy/Jbsw5clKXTLuIorr7bDppYDquAJ+uCn7RG0e/tgPbMsLoeYzdtVwZLFcVpFMqeNS3ZmkV
        wMCP5x/w==;
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@misterjones.org>)
        id 1pbis8-00HGIo-9F;
        Mon, 13 Mar 2023 14:09:56 +0000
MIME-Version: 1.0
Date:   Mon, 13 Mar 2023 14:09:55 +0000
From:   Marc Zyngier <maz@misterjones.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: Circular lockdep in kvm_reset_vcpu() ?
In-Reply-To: <ZA72c+TT9epTcvX4@e120937-lin>
References: <f6452cdd-65ff-34b8-bab0-5c06416da5f6@arm.com>
 <Y+bnybGEkMpZzm/y@linux.dev> <ZA72c+TT9epTcvX4@e120937-lin>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <3496a6a10b2d8693825e733b871938f5@misterjones.org>
X-Sender: maz@misterjones.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: cristian.marussi@arm.com, oliver.upton@linux.dev, jeremy.linton@arm.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, dwmw@amazon.co.uk, marc.zyngier@arm.com
X-SA-Exim-Mail-From: maz@misterjones.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-13 10:09, Cristian Marussi wrote:
> On Sat, Feb 11, 2023 at 12:56:41AM +0000, Oliver Upton wrote:
>> Hi Jeremy,
>> 
> 
> Hi,
> 
>> On Fri, Feb 10, 2023 at 11:46:36AM -0600, Jeremy Linton wrote:
>> > Hi,
>> >
>> > I saw this pop yesterday:
>> 
>> You and me both actually! Shame on me, I spoke off-list about this 
>> with
>> Marc in passing. Thanks for sending along the report.
>> 
>> > [   78.333360] ======================================================
>> > [   78.339541] WARNING: possible circular locking dependency detected
>> > [   78.345721] 6.2.0-rc7+ #19 Not tainted
>> > [   78.349470] ------------------------------------------------------
>> > [   78.355647] qemu-system-aar/859 is trying to acquire lock:
>> > [   78.361130] ffff5aa69269eba0 (&host_kvm->lock){+.+.}-{3:3}, at:
>> > kvm_reset_vcpu+0x34/0x274
>> > [   78.369344]
>> > [   78.369344] but task is already holding lock:
>> > [   78.375182] ffff5aa68768c0b8 (&vcpu->mutex){+.+.}-{3:3}, at:
>> > kvm_vcpu_ioctl+0x8c/0xba0
>> 
>> [...]
>> 
>> > It appears to be triggered by the new commit 42a90008f890a ('KVM: Ensure
>> > lockdep knows about kvm->lock vs. vcpu->mutex ordering rule') which is
>> > detecting the vcpu lock grabbed by kvm_vcpu_ioctl() and then the kvm mutext
>> > grabbed by kvm_reset_vcpu().
>> 
>> Right, this commit gave lockdep what it needed to smack us on the head
>> for getting the locking wrong in the arm64 side.
>> 
>> As gross as it might be, the right direction is likely to have our own
>> lock in kvm_arch that we can acquire while holding the vcpu mutex. 
>> I'll
>> throw a patch at the list once I get done testing it.
>> 
> 
> I just hit this using a v6.3-rc2 and a mainline kvmtool.
> 
> In my case, though, the guest does not even boot if I use more than 1
> vcpu, which
> I suppose triggers effectively the reported possible deadlock, i.e.:
> 
> root/lkvm_master run -c 4 -m 4096 -k /root/Image_guest -d
> /root/disk_debian_buster_guest.img -p "loglevel=8"
>   # lkvm run -k /root/Image_guest -m 4096 -c 4 --name guest-288
> ....<HANGS FOREVER>

Pass earlycon to the guest for a start.

I seriously doubt someone has actually seen a deadlock, because
the issue has been there for at least the past 7 years...

And -rc2 works just fine here.

         M.
-- 
Who you jivin' with that Cosmik Debris?
