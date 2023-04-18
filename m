Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF2C6E6517
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjDRM4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjDRM4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:56:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8076A275
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:56:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6169563482
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5741C433EF;
        Tue, 18 Apr 2023 12:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681822603;
        bh=bfiHJMtui8taHNlLbuqMhpjAZdV45d/VaQDs8aQUkk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sHH3P1X2laX/3Z5A9k4BzmLW+A6HOivA2dLhW18Di0VOWELJf+0eomVW7ATy2CGKH
         Pp/jbAaRhYLGf4+83Ktlv8ARJF8WWGrEvyhgYupLgGkrOcpW+q/1aCAeoLQ7LSnY/v
         zAjwHWJuACsJVNinG1ev0PFGUSGhVgMzs8OBmn7q6lyIXanusI3nYu0y33CVKNUVUP
         5MHRfoPgLzlz5MxhceyR+CtrO+4M0QoF2pMXmXlTwzlGC0AkkW3MeHdZIIUcEQl9fc
         QlLF0u4gtSk6T8PlxNjAxX3e9uxD4GlOVes4OaTjdNfacges6br5hmLvPz/rV/wOn5
         t3JECJ6Gg2MyA==
Date:   Tue, 18 Apr 2023 14:56:38 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Arnd Bergmann <arnd@kernel.org>,
        akpm <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
        ocfs2-devel <ocfs2-devel@oss.oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ocfs2: reduce ioctl stack usage
Message-ID: <20230418-vielmehr-nominieren-7f2adb0f6703@brauner>
References: <20230417205631.1956027-1-arnd@kernel.org>
 <20230418-fortgehen-inkubationszeit-5d3db3f0c2b1@brauner>
 <7555eaf9-b195-5189-3928-c7292e4a0ba5@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7555eaf9-b195-5189-3928-c7292e4a0ba5@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 05:37:06PM +0800, Joseph Qi wrote:
> Andrew picked ocfs2 patches into -mm tree before.

Yup and that's fine obviously, but this belongs to fs/ and we're aiming
to take fs/ stuff through the dedicated fs trees going forward.

Thanks!
Christian

> 
> Thanks,
> Joseph
> 
> On 4/18/23 5:17 PM, Christian Brauner wrote:
> > 
> > On Mon, 17 Apr 2023 22:56:24 +0200, Arnd Bergmann wrote:
> >> On 32-bit architectures with KASAN_STACK enabled, the total stack usage
> >> of the ocfs2_ioctl function grows beyond the warning limit:
> >>
> >> fs/ocfs2/ioctl.c: In function 'ocfs2_ioctl':
> >> fs/ocfs2/ioctl.c:934:1: error: the frame size of 1448 bytes is larger than 1400 bytes [-Werror=frame-larger-than=]
> >>
> >> Move each of the variables into a basic block, and mark ocfs2_info_handle()
> >> as noinline_for_stack, in order to have the variable share stack slots.
> >>
> >> [...]
> > 
> > Going by git log, ocfs2 patches don't go through a separate tree.
> > So unless there are objections I'm taking this through fs.misc,
> > 
> > tree: git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git
> > branch: fs.misc
> > [1/1] ocfs2: reduce ioctl stack usage
> >       commit: 85ef56bc2d65215f43ceb7377ca14a779468928d
> > 
> > Christian
