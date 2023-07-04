Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A69746C47
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjGDIri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 04:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjGDIrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:47:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764BBBE;
        Tue,  4 Jul 2023 01:47:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F314A6119A;
        Tue,  4 Jul 2023 08:47:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE57C433C7;
        Tue,  4 Jul 2023 08:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688460454;
        bh=wiLQWpeMEZfyCX4MGG4bJcnARIlh8hWwkPNEE7EarQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tPz82UdPJgvetK4jncfKD47WubHVyDAtVFjZihD8R9ysb98kaW8cNRnYxAS4Ft5Z0
         xAsIaea9Y59yOZWYuBJjn55pKYlcCKCu4m9vjLk0S4pZuwasaL8bOUU8ABv48cOcSL
         RAh4f12MKnsq1gSSEZ6UQQ1qa1Wsh7agtjLYthYk=
Date:   Tue, 4 Jul 2023 09:47:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH 6.3 00/13] 6.3.12-rc1 review
Message-ID: <2023070444-untimed-clerical-565a@gregkh>
References: <20230703184519.206275653@linuxfoundation.org>
 <CA+G9fYvf-sw8tCHjxhoMvHrtzzdE69EwvB2PmypUkGDdCFFASA@mail.gmail.com>
 <2023070411-steadfast-overtly-02a3@gregkh>
 <2023070416-wow-phrasing-b92c@gregkh>
 <37f9e884-6535-1ed7-8675-d98d0a6d8b36@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37f9e884-6535-1ed7-8675-d98d0a6d8b36@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 02:13:03PM +0530, Harshit Mogalapalli wrote:
> Hi Greg,
> 
> On 04/07/23 1:54 pm, Greg Kroah-Hartman wrote:
> 
> > > > 
> > > > 
> > > > While running LTP hugetlb testing on x86 the following kernel BUG noticed
> > > > on running stable-rc 6.3.12-rc1.
> > > > 
> > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > > 
> > > > Crash log:
> > > > =========
> > > > [   54.386939] hugefallocate01 (410): drop_caches: 3
> > > > g tests.......
> > > 
> > > And this worked on 6.3.11 just fine?
> > > 
> > > Trying to narrow down what would have caused this...
> > > 
> > > Any chance you can run Linus's tree with thie LTP test as well?
> > 
> > Ah, I can hit this here locally too!  Let me bisect...
> 
> 
> Have you looked at Patch 9 of this series:
> 
> https://lore.kernel.org/stable/2023070416-wow-phrasing-b92c@gregkh/T/#m12068530e846ac8b9668bd83941d82ec3f22ac15
> 
> Looks very much related, it also has a note on Backporting.
> As I think it could be related, I am sharing this.(But haven't tested
> anything)

Yes, that's the offending patch.  I should have read over the full
changelogs before doing bisection, but bisection/test proved that this
was not correct for 6.3.y at this point in time.

thanks,

greg k-h
