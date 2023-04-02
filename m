Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8FE6D3A20
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 22:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjDBUDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 16:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjDBUDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 16:03:18 -0400
Received: from valentin-vidic.from.hr (valentin-vidic.from.hr [IPv6:2001:470:1f0b:3b7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2015A8A49;
        Sun,  2 Apr 2023 13:03:16 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id 32CA1295B5; Sun,  2 Apr 2023 22:03:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=valentin-vidic.from.hr; s=2020; t=1680465791;
        bh=9VdTdi38B+ohBYB7mtje7rl53RM9eLoGTNFkms+HzbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P3zQOheTkGXjBNtEJf5A2qf6YkJ32PjA29Prfa5xseW4hrwSq+qEWFXeEQGezBDMT
         wx7w2YEcMjz3l6q4YAgjhzTtWpvrj5kRaTHtGtwuBAZtBCZMqoEVkXicDQ2bUy/wcG
         DYDq907W2MlUjmlG7P/r2z3RCLksqMFOS8LTlsQ10evFhefimbOTDxcNRenbL+qcwl
         IFvL/42Zr+1zNHxXqb69AtyBV3/LS6jNj2sjtz4eXaUXjRkp6eXM2w8058Sn8UTTJD
         xKS09CY8bSBCn9eUn9QdVtQz/lcpa6zzjGMb6fNaUSgDm3Aa7QzBreyteCTwBWsxY8
         FN33R5V0GD4k1F4oZTEB46ivyUXxuk9Sme8sNHd9bIGAZxKBQnVz+ODd1PgeLaFwGC
         b3LSXJvxepn7mjloawdID81IE5sr8IM5E07aQYd1xWzmqxYxCAeiJHLBxYpjdZmxLh
         7BlZApm3Q32CFVmSSbuao4qR0KJaVMD4YY+aG/lx6Qf+NIKmRLn+TQJTbhyTkVNhD7
         6gFb2ae2hCawUWYF9ZZBrq6SVPwWGqWAMFctkaWKSoA2IYMUlpbHtVdPIlQV6rH/r5
         BIhireO219++LWC26DWQrKp9g94j83911I2FGhu/CHp+X7qXma4AqyAol+XIHDfvzi
         /DzeNmGZkh5j8tWZhqR+Cf9Y=
Date:   Sun, 2 Apr 2023 22:03:11 +0200
From:   Valentin =?utf-8?B?VmlkacSH?= <vvidic@valentin-vidic.from.hr>
To:     Paul Moore <paul@paul-moore.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Micah Morton <mortonm@chromium.org>,
        =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] security, lsm: security_old_inode_init_security() Handle
 multi LSM registration
Message-ID: <ZCnff6gUjU89zfAb@valentin-vidic.from.hr>
References: <20230401214151.1243189-1-vvidic@valentin-vidic.from.hr>
 <CAHC9VhT6VXwybScqsnYHHtbHNPoWMVQJzQ7VAccm2MWZEz+5Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhT6VXwybScqsnYHHtbHNPoWMVQJzQ7VAccm2MWZEz+5Dw@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2023 at 11:14:33AM -0400, Paul Moore wrote:
> If you have the time, could you try a patch we have queued up in the
> lsm/next branch?  We are in the process of removing
> security_old_inode_init_security() and transitioning all the callers
> over to security_inode_init_security(), and I believe the ocfs2 patch
> for this should solve the problem you are seeing, can you test it on
> your system and let us know?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git/patch/?id=de3004c874e740304cc4f4a83d6200acb511bbda

Great, thanks for the pointer. This patch also works for me as I don't
see the crash anymore. Can it also be included in the 6.1 LTS kernel
since this is were I first noticed the problem?

-- 
Valentin
