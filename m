Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11CA747157
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjGDM2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGDM2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:28:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F3010F9;
        Tue,  4 Jul 2023 05:28:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 217F861230;
        Tue,  4 Jul 2023 12:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9CEC433C7;
        Tue,  4 Jul 2023 12:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688473715;
        bh=eAnnv+dDV9eU46cnv4COWRKpmReSFfmKhoejTXImYPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z6fjDnuvhzCBPiy5g7CnAG0oRDmwrNtho1EjwGTU7aXf5ppGM0U1rPd/I9QuIA1M0
         a3/kHKq0qRClXiTUhmbxqcRkaO36/IhWDU4Ncjz02x+pUmbe4dZEGUtdzL2fcjCh8Z
         TerM7Vs29xllT5hqiZfzAGmXEa5Y652sqUJHnUI4=
Date:   Tue, 4 Jul 2023 13:28:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH 6.3 00/13] 6.3.12-rc1 review
Message-ID: <2023070446-sublevel-humid-7b01@gregkh>
References: <20230703184519.206275653@linuxfoundation.org>
 <CA+G9fYvf-sw8tCHjxhoMvHrtzzdE69EwvB2PmypUkGDdCFFASA@mail.gmail.com>
 <2023070411-steadfast-overtly-02a3@gregkh>
 <2023070416-wow-phrasing-b92c@gregkh>
 <37f9e884-6535-1ed7-8675-d98d0a6d8b36@oracle.com>
 <2023070444-untimed-clerical-565a@gregkh>
 <db4bf839-df6a-c2b9-a03c-3b9d1680c2a9@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db4bf839-df6a-c2b9-a03c-3b9d1680c2a9@leemhuis.info>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 11:56:11AM +0200, Thorsten Leemhuis wrote:
> On 04.07.23 10:47, Greg Kroah-Hartman wrote:
> > On Tue, Jul 04, 2023 at 02:13:03PM +0530, Harshit Mogalapalli wrote:
> >> On 04/07/23 1:54 pm, Greg Kroah-Hartman wrote:
> >>>>> While running LTP hugetlb testing on x86 the following kernel BUG noticed
> >>>>> on running stable-rc 6.3.12-rc1.
> >>
> >> Have you looked at Patch 9 of this series:
> >>
> >> https://lore.kernel.org/stable/2023070416-wow-phrasing-b92c@gregkh/T/#m12068530e846ac8b9668bd83941d82ec3f22ac15
> >>
> >> Looks very much related, it also has a note on Backporting.
> >> As I think it could be related, I am sharing this.(But haven't tested
> >> anything)
> > 
> > Yes, that's the offending patch.  I should have read over the full
> > changelogs before doing bisection, but bisection/test proved that this
> > was not correct for 6.3.y at this point in time.
> 
> FWIW, I'm preparing a few small tweaks for
> Documentation/process/stable-kernel-rules.rst (to be submitted after the
> merge window). I among others consider adding something like this that
> might help avoiding this situation:
> 
> ```
> To delay pick up of patches submitted via :ref:`option_1`, use the
> following format:
> 
> .. code-block:: none
> 
>      Cc: <stable@vger.kernel.org> # after 4 weeks in mainline
> 
> For any other requests related to patches submitted via :ref:`option_1`,
> just add a note to the stable tag. This for example can be used to point
> out known problems:
> 
> .. code-block:: none
> 
>      Cc: <stable@vger.kernel.org> # see patch description, needs
> adjustments for 6.3 and earlier
> 
> ```
> 
> Greg, if this is stupid or in case you want it to say something else,
> just say so.

That looks great, hopefully people notice this.  We still have a huge
number of people refusing to even put cc: stable in a patch, let alone
these extra hints :)

thanks,

greg k-h
