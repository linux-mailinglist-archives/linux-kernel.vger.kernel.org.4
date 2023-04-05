Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9176D81EE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238501AbjDEPa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238568AbjDEPal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:30:41 -0400
Received: from valentin-vidic.from.hr (valentin-vidic.from.hr [IPv6:2001:470:1f0b:3b7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F96F5251;
        Wed,  5 Apr 2023 08:30:38 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id B2DA3297E1; Wed,  5 Apr 2023 17:30:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=valentin-vidic.from.hr; s=2020; t=1680708631;
        bh=r5XRUYKahCaALtmf0y8l5u58U9M52WuvSYB8cnVeaGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kpSBJQZDMNFSfUp0iuSjiYe3wVqsp4eyfgX3Rit0OHu5iWbg+JRv5dOtbsAlu2jhy
         Rml+Qm2VPCkxxb+MF6o1D7ZzYTRM4Axa6BDobl4pHAyyxgF+ZrZ6Dt8JDkrflwKMC+
         AuZZ7lFIW9C2AJJr1M85w2b4ipSJxC5inaTber4+xO0xQR7zsuDgO+0MNHQDzcyTkm
         oXevpf6mTqWara1X72yzKPPoIzVwRuSNhHj1lF7M1NwAsZORYjQL7Y05vVu8ZTT4Ut
         qqEvn8q+pr0Zx8te3iKDo8v2aduPF2tY8CanqWl/sbeBVuPQg+EpVpdkJtXNCcG1qJ
         AGtSdh5r5L5MFJQF6Ow6hposZQlDI2iJCmnohXfSVqn0FRb+3wMiMZe7b7s0RqLpF6
         EY1Q05j9QvsNEJVF+P3to2A3Ro8eJudRD5hdsDppSZ3ywjsNAZoYGexaE8wYkPofRn
         1p4+jE+i4U6PQAKctlaW6EmvcxMvmp9czuGLLGi90TGuZdNR5UxJ0ugQeMxvNwznGE
         FxhykonvAJXBvmTSfdGIJ+SPrFKm+4H9VWY+J/XOHD0c6iHHcPnqzKDcAxBtER91Sj
         JlBKuky8CuFt5iq1kCUIdEDtlotnwbAFz0QUWa0RBSATVWrxaRIX/0HgF5UNYkOC2F
         nsyF258bc1PLuRYmE/YfqU7A=
Date:   Wed, 5 Apr 2023 17:30:31 +0200
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
Message-ID: <ZC2UF7FfJ1XDEu67@valentin-vidic.from.hr>
References: <20230401214151.1243189-1-vvidic@valentin-vidic.from.hr>
 <CAHC9VhT6VXwybScqsnYHHtbHNPoWMVQJzQ7VAccm2MWZEz+5Dw@mail.gmail.com>
 <ZCnff6gUjU89zfAb@valentin-vidic.from.hr>
 <CAHC9VhTCafjmo7k=qGnOMDm4s4UHL9g=o5KgRfg9_xwWCzUhcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTCafjmo7k=qGnOMDm4s4UHL9g=o5KgRfg9_xwWCzUhcw@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 03:28:11PM -0400, Paul Moore wrote:
> I think backporting it to the stable kernels would be okay, but I'd
> prefer to let it get some more testing in linux-next first if that's
> okay with you.  Since we are currently at v6.3-rc5 and this patch is
> scheduled to go up to Linus during the next merge window, it might
> make the most sense to give this two more weeks in -next, let it land
> in Linus' tree, and they ask the stable team for a backport ("Option
> 2" in the stable kernel docs):
> 
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> 
> Thoughts?

No problem for me, as long as it gets included in the LTS at some point :)

-- 
Valentin
