Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87956731947
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239306AbjFOMzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238426AbjFOMzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:55:48 -0400
X-Greylist: delayed 2087 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Jun 2023 05:55:47 PDT
Received: from mx.treblig.org (unknown [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A3C1BC9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=GE+Tl63UN/bjw5brENYW6CUw4m+KlAeFUuic6M+A4KQ=; b=Zzqm9rAYDbhknznnSjOJWcljLf
        wp2WwiWtx9bk+Pe1ezTsZgJy8ZRdllWKm+6uR1DVrF1/fVzBk3EQPQsRL0x75BaBSKx72TVR+kcwz
        Tjh90buA+Y2Z60lDJBQSnGEp3pnLQMqwP1be4CG6zfZvpcnqsk/k+gfXPCcqit0NPfLIeU1p2QaGq
        +7AdP0x+Y3Gb9KkXs4buEyQijNQ2cWxZxZf0zVKZ9hNAY3b80Jtyk2x9bsZWg9ZSgqdAvq72ArhqQ
        Nk+tuzJa87jDtF7bef8E6eGMAx0zZJvXG8beVYJHbG/UNLK9pxSAlsaZ0s6wDOZp2UmT9N+Q3UX0d
        3H8z2+5A==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1q9ly6-00EGxW-9x; Thu, 15 Jun 2023 12:20:50 +0000
Date:   Thu, 15 Jun 2023 12:20:50 +0000
From:   "Dr. David Alan Gilbert" <linux@treblig.org>
To:     "Richard W.M. Jones" <rjones@redhat.com>
Cc:     YiFei Zhu <zhuyifei@google.com>, dev@aaront.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        zhuyifei1999@gmail.com
Subject: Re: printk.time causes rare kernel boot hangs
Message-ID: <ZIsCIp7Vq735hfxl@gallifrey>
References: <20230614112625.GN7912@redhat.com>
 <20230615110429.2839058-1-zhuyifei@google.com>
 <20230615113108.GN7636@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20230615113108.GN7636@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-21-amd64 (x86_64)
X-Uptime: 12:05:57 up 87 days, 22:40,  1 user,  load average: 0.10, 0.04, 0.01
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Richard W.M. Jones (rjones@redhat.com) wrote:
> On Thu, Jun 15, 2023 at 11:04:29AM +0000, YiFei Zhu wrote:
> > see if you can send a alt-sysrq-w to show stacks of
> > blocked tasks.
> 
> I guess this is a virtual console thing?  I have to boot this hundreds
> of times with a serial console to even get to the bug, so it's tricky.

If you open a monitor device you should be able to do things to the qemu
after you detect the hang; and then I think a :

   sendkey alt-sysrq-w

   on HMP should do it.

However, some other thoughts:
  a) You could try taking a dump and then importing it into crash rather
  than using gdb; both ways are touchy, but that does mean you could
  give the dump to someone else who can't trigger the bug.

  b) You could try giving your kernel to someone who can't trigger it;
  if they can trigger it on their host with your kernel that would
  suggest something is different in your build environment of your
  kernel (e.g. compiler version or flags) rather than the host kernel.

Dave

> Rich.
> 
> -- 
> Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
> Read my programming and virtualization blog: http://rwmj.wordpress.com
> virt-builder quickly builds VMs from scratch
> http://libguestfs.org/virt-builder.1.html
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
