Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8796CCCCE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 00:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjC1WIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 18:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjC1WIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 18:08:51 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB291BFE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:08:49 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 582E1C01F; Wed, 29 Mar 2023 00:08:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1680041328; bh=lIAxBZX8Ok9MLTzD8LQPfEMHK5pZ4ioFrz+9hrOO4h4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K21RGKXCuiDcpFs4KNSlwq2+RDm091FpHB7hmVjdY67N4tan3/AqTwuO8eqv881+m
         SX9NSFIaYEbRHrv6wwVxwHKgcJR3HbPiNF4Abgz6sytjK0vYPjt/kVN9DWDv2ujF30
         2jmXwRrGuP+td8/Jpela255I5utBcqy6h1EN/yj+B1G2euC03aowW1ezfEEaOiqkVw
         jv78c5uOUKWyUbmqFwW/5VUgpkHGIvePa6GJCHchOoJCGkr49th5Wqs5QgtN96qWUW
         DvMKlhYjruSU69Sac8jHCkeJHN1bPsVP5Fnfx+NxV5VLTfW02tyGUoUuYhThwzIMBj
         yNiN7CIx02fug==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 70BD5C009;
        Wed, 29 Mar 2023 00:08:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1680041327; bh=lIAxBZX8Ok9MLTzD8LQPfEMHK5pZ4ioFrz+9hrOO4h4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=20HcFiyuj80bZO9Ai5zvaFWJDqwmczJDYJUdYJw7bay1mp7M902oPe3QbdjAy3ELL
         T6HAGE5O92Ep70tctj4M6R82CrRofD7VLqVW1uGJUA1EUCFioNTMuZu1ftPS9YPg1i
         Eh6xzCfz7BNuE14GLpJ3X4WHZxS3Oq+npszRnLVLEHY7Jt6TciupADjmnh92UgM/gY
         9Gyq8quPvzpHPBc03VXn0IXszRBOsa1xJg0rXir3aQshTW4EwBUi/+j+j/IB/A5F9P
         uuZjhi+uplqfGFOuD1kytrK8qzGrtYaEVcAAssVaJGSN4UL72VO8Jt11qS0Mfome63
         MdoOkY07B6EjA==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 5723ce5b;
        Tue, 28 Mar 2023 22:08:41 +0000 (UTC)
Date:   Wed, 29 Mar 2023 07:08:26 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jeff Layton <jlayton@kernel.org>, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: 9p caching with cache=loose and cache=fscache
Message-ID: <ZCNlWnQTbWoBBPd2@codewreck.org>
References: <ZA0FEyOtRBvpIXbi@bombadil.infradead.org>
 <ZCHU6k56nF5849xj@bombadil.infradead.org>
 <ZCJRlqc/epbRhm93@codewreck.org>
 <2391219.DQnbcWml7j@silver>
 <ZCMmrnmZFcH65Orp@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZCMmrnmZFcH65Orp@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luis Chamberlain wrote on Tue, Mar 28, 2023 at 10:41:02AM -0700:
> >   "To speedup things you can also consider to use e.g. cache=loose instead.
> 
> My experience is that cache=loose is totally useless.

If the fs you mount isn't accessed by the host while the VM is up, and
isn't shared with another guest (e.g. "exclusive share"), you'll get
what you expect.

I have no idea what people use qemu's virtfs for but this is apparently
common enough that it was recommended before without anyone complaining
since that started being recommended in 2011[1] until now?

[1] https://wiki.qemu.org/index.php?title=Documentation/9psetup&diff=2178&oldid=2177

(now I'm not arguing it should be recommended, my stance as a 9p
maintainer is that the default should be used unless you know what
you're doing, so the new code should just remove the 'cache=none'
altogether as that's the default.
With the new cache models Eric is preparing comes, we'll get a new safe
default that will likely be better than cache=none, there is no reason
to explicitly recommend the historic safe model as the default has
always been on the safe side and we have no plan of changing that.)

> >    That will deploy a filesystem cache on guest side and reduces the amount of
> >    9p requests to hosts. As a consequence however guest might not see file
> >    changes performed on host side *at* *all*
> 
> I think that makes it pretty useless, aren't most setups on the guest read-only?
> 
> It is not about "may not see", just won't. For example I modified the
> Makefile and compiled a full kernel and even with those series of
> changes, the guest *minutes later* never saw any updates.

read-only on the guest has nothing to do with it, nor has time.

If the directory is never accessed on the guest before the kernel has
been built, you'll be able to make install on the guest -- once, even if
the build was done after the VM booted and fs mounted.

After it's been read once, it'll stay in cache until memory pressure (or
an admin action like umount/mount or sysctl vm.drop_caches=3) clears it.


I believe that's why it appeared to work until you noticed the issue and
had to change the mount option -- I'd expect in most case you'll run
make install once and reboot/kexec into the new kernel.

It's not safe for your usecase and cache=none definitely sounds better
to me, but people should use defaults make their own informed decision.


>>   In the above example the folder /home/guest/9p_setup/ shared of the
>>   host is shared with the folder /tmp/shared on the guest. We use no
>>   cache because current caching mechanisms need more work and the
>>   results are not what you would expect."
>
> I got a wiki account now and I was the one who had clarified this.

Thanks for helping making this clearer.

-- 
Dominique
