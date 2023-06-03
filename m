Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126B872107B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 16:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbjFCOgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 10:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjFCOgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 10:36:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B79E185;
        Sat,  3 Jun 2023 07:36:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BE70617E4;
        Sat,  3 Jun 2023 14:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778D6C433EF;
        Sat,  3 Jun 2023 14:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685803002;
        bh=1UvUJK5AQ9jaoB/c8WAMLmYLCpboFrSXmGutlJI39kQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hJrAKzk2oXlITq1jg496diVgL5iODWkbeV+dfsnpcWZzUQDUTJMyEwlKB04HTc72l
         WzV3Gi1DI3TPvCZ3RjzXIEP6GK06nEovHHkDnKU33v2mM8RzNFGyxH0y3ipOd/G/UZ
         GCahtyl2rKVCq8KdY4zJAzDF7sx6nCpJtRA/gfG4=
Date:   Sat, 3 Jun 2023 16:36:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.15 00/37] 5.15.115-rc2 review
Message-ID: <2023060316-everyone-stir-f2c7@gregkh>
References: <20230601143331.405588582@linuxfoundation.org>
 <CADVatmPDwobeqntQ5+LQibMSHK86FmwUpN+E3JUd+GMs3bWpDQ@mail.gmail.com>
 <779687e0-7e21-77fb-8559-49e2100853ed@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <779687e0-7e21-77fb-8559-49e2100853ed@roeck-us.net>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 05:33:12AM -0700, Guenter Roeck wrote:
> On 6/2/23 05:07, Sudip Mukherjee wrote:
> > Hi Greg,
> > 
> > On Thu, 1 Jun 2023 at 15:36, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > 
> > > This is the start of the stable review cycle for the 5.15.115 release.
> > > There are 37 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > 
> > s390 allmodconfig build fails with the error:
> > 
> > arch/s390/kernel/uv.c: In function 'should_export_before_import':
> > arch/s390/kernel/uv.c:204:40: error: 'mm_context_t' has no member
> > named 'protected_count'
> >    204 |         return atomic_read(&mm->context.protected_count) > 1;
> >        |                                        ^
> > arch/s390/kernel/uv.c:205:1: error: control reaches end of non-void
> > function [-Werror=return-type]
> >    205 | }
> >        | ^
> > 
> 
> Missing commit 07fbdf7f93479 ("KVM: s390: pv: usage counter
> instead of flag"), but I don't know if that alone is sufficient
> (there have been other commits adding to its use).

I've just dropped the offending patches from now, and will wait for
proper backported ones if the s390 people want these added.

greg k-h
