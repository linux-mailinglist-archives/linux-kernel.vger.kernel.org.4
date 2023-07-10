Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4F674CC55
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjGJFn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjGJFnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:43:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B873E3;
        Sun,  9 Jul 2023 22:43:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD07360BC1;
        Mon, 10 Jul 2023 05:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B81C433C8;
        Mon, 10 Jul 2023 05:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688967834;
        bh=+80BagJxUJyQJ3IMWMojMWDAgzi0xlAYAibhFrk/X9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z5/oMyt4b5wjIz5uqrUGDb+tesqrwL8xoViSIwXapcNAwEvzd6vWrCSaKoxWHvUni
         gR6hZwVXqM6437xyqprAnfhVKcV2TW3b6TVp8O1nQKbYxxSVFpLfrWy4XQxpu4A5XM
         ZHTFp6K0I/jW9/FR9q8M1piqkPZWw9rNp3TW5NCk=
Date:   Mon, 10 Jul 2023 07:43:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.3 000/425] 6.3.13-rc2 review
Message-ID: <2023071039-puppet-wieldable-6db2@gregkh>
References: <20230709202353.266998088@linuxfoundation.org>
 <CAEUSe7_KV_+jLJzE4u4_DHUPbi8Z=ASh-=aKB_JQr4+pz_8GVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEUSe7_KV_+jLJzE4u4_DHUPbi8Z=ASh-=aKB_JQr4+pz_8GVw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2023 at 04:55:55PM -0600, Daniel Díaz wrote:
> Hello!
> 
> On Sun, 9 Jul 2023 at 14:24, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > This is the start of the stable review cycle for the 6.3.13 release.
> > There are 425 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Tue, 11 Jul 2023 20:22:29 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.13-rc2.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> This introduces a warning:
> -----8<-----
>   In file included from /builds/linux/block/genhd.c:28:
>   /builds/linux/block/genhd.c: In function 'disk_release':
>   /builds/linux/include/linux/blktrace_api.h:88:33: warning: statement
> with no effect [-Wunused-value]
>    # define blk_trace_remove(q)    (-ENOTTY)
>                                    ^
>   /builds/linux/block/genhd.c:1187:2: note: in expansion of macro
> 'blk_trace_remove'
>     blk_trace_remove(disk->queue);
>     ^~~~~~~~~~~~~~~~
> ----->8-----
> 
> This is again with Arm 32-bits on omap1_defconfig.
> 
> Bisection points to "block: fix blktrace debugfs entries leakage"
> (d8c9d0067dbd here, dd7de3704af9 upstream). Reverting this commit
> makes the warning go away.

Thanks, I've queued up a fix for this and will push out a -rc3.

greg k-h
