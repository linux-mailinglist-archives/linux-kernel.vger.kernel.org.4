Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8112A6C941C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 14:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjCZMLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 08:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCZML3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 08:11:29 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21697ED7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 05:11:26 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32QCBIaD026451
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Mar 2023 08:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1679832680; bh=o3K+LK7qFJm44sDDKFv4Azm+mpVYba1dEvG19ttEHH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=MTY7Yn9B+5VUKvd2XEaxnEOtp6sypW+jp4PUwa9VBoF0G5h7nfbeiNV7tc0nrtvUX
         c1OgY1VvkFF1pgZfvEXVhp2i6Wg/OLch9kr8O63NFAutrPCDyHAJMhlym6A599J10d
         IzN+NawnjOHRbtgfMjPAU1ZQWZ/sPzqFaj8atb0mV6QDUcsLKvm9KBwfZCHYmXQ++6
         qmYTF4MCm2qoCl42ivFdPuNinxwCr9QScMMCKvve8m/irBXkHgRlJPTjdqRliEjlVf
         IQZuVBWGCUtL/NwtenjTbKVlRJMHRRavozOidDc7+TTso0VBYHR3drbzgqE62hWkcC
         7UZ/r4NN1R06A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8F1E115C46FF; Sun, 26 Mar 2023 08:11:18 -0400 (EDT)
Date:   Sun, 26 Mar 2023 08:11:18 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Change in kernel debian packages between -rc2 and -rc3
Message-ID: <20230326121118.GB323408@mit.edu>
References: <20230325143122.GA409315@mit.edu>
 <CAK7LNARndpbtzRAW1kEiqyNBmAxdqJKiTquvY9bW08LYTTMiOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARndpbtzRAW1kEiqyNBmAxdqJKiTquvY9bW08LYTTMiOg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 12:39:44PM +0900, Masahiro Yamada wrote:
> 
> I am afraid you are completely misunderstanding the two versions,
> the ABI version and the package version.
> 
> They do not need to match. Actually, they do not match.
> 
> See real Debian (or Ubuntu) systems.
> 
> `uname -r` returns '5.10.0-21-amd64'.
> This is what they call the ABI version, and
> this is contained as a part of the package name,
> 'linux-image-5.10.0-21-amd64'

That may be a convention that Debian uses, but I'll point out that
trying to use this as an ABI version when people are using different
.config's is not going to end well.  That's because many different
Kernel configurations will end up making incompatible changes to the
ABI.  and only works if you are ***super*** careful about not making
any kind of changes (e.g., the number of CPU's, adding or changing
various cgroup controllers, all of which will make incompatible kernel
ABI changes.)

This is "Stable ABI nonsense" is well, nonsense.

> It was _not_ reflected in the package version.
> This is also correct since the package version
> is not meant to reflect such user configuration
> as CONFIG_LOCALVERSION.

Citation, please?  Does the Debian system work in that particular way?

In any case, it's an incompatible regression made during rc2 and rc3,
which I think is at the very least, unfortunate.

      	      	    	     	    - Ted
