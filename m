Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA3273B5EF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 13:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjFWLPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 07:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjFWLPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 07:15:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5B8273A;
        Fri, 23 Jun 2023 04:15:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01C1D61A2B;
        Fri, 23 Jun 2023 11:14:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCAFC433C0;
        Fri, 23 Jun 2023 11:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687518885;
        bh=xbvC3kjWq1hfL5aAh9tuCG2kEzE43wCvi8FpuV11tSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fOCpUqB2aSnCuKP8QBkQDlQjh7NtXPhJNVyP9vYqz+j32WRaQvMBK7mEYpM1xKYmU
         sfe+PSR9DueffCx5tZiN+XPYoHVR81o2tXWCgOn65XdSQpbaGXpQbUT85MisWHCmMZ
         DKDfUv5CguUE5yS1Nh9CWgq7jTpDjVdVwD6hm12w=
Date:   Fri, 23 Jun 2023 13:14:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyle Tso <kyletso@google.com>
Cc:     heikki.krogerus@linux.intel.com, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] usb: typec: Use sysfs_emit_at when concatenating the
 string
Message-ID: <2023062327-bucked-backrest-c20d@gregkh>
References: <20230622150423.3726894-1-kyletso@google.com>
 <20230622150423.3726894-4-kyletso@google.com>
 <2023062345-hassle-septic-b8b4@gregkh>
 <CAGZ6i=3BP4ssx31roJoGL_VT=o3mq9Lj_VfZ_HSywzPOEt3v7g@mail.gmail.com>
 <CAGZ6i=1uD-baR+Tht4+D1oC7O04K4L-RDBdDLSo6gZhNqN=2rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGZ6i=1uD-baR+Tht4+D1oC7O04K4L-RDBdDLSo6gZhNqN=2rg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 06:11:00PM +0800, Kyle Tso wrote:
> On Fri, Jun 23, 2023 at 6:06 PM Kyle Tso <kyletso@google.com> wrote:
> >
> > On Fri, Jun 23, 2023 at 3:51 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Jun 22, 2023 at 11:04:23PM +0800, Kyle Tso wrote:
> > > > The buffer address used in sysfs_emit should be aligned to PAGE_SIZE.
> > >
> > > Why?  Are you getting warnings about this?
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Yes, here is the warning.
> >
> > [  223.243123] invalid sysfs_emit: buf:00000000eda2d647
> > [  223.243197] WARNING: CPU: 4 PID: 8860 at fs/sysfs/file.c:735
> > sysfs_emit+0xb0/0xc0
> > [  223.244335] CPU: 4 PID: 8860 Comm: cat
> > [  223.244363] pstate: 62400005 (nZCv daif +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
> > [  223.244378] pc : sysfs_emit+0xb0/0xc0
> > [  223.244394] lr : sysfs_emit+0xac/0xc0
> > ...
> > [  223.244560] Call trace:
> > [  223.244568] sysfs_emit+0xb0/0xc0
> > [  223.244582] select_usb_power_delivery_show+0x134/0x18c
> > [  223.244626] dev_attr_show+0x38/0x74
> > [  223.244654] sysfs_kf_seq_show+0xb4/0x130
> > [  223.244668] kernfs_seq_show+0x44/0x54
> > [  223.244683] seq_read_iter+0x158/0x4ec
> > [  223.244727] kernfs_fop_read_iter+0x68/0x1b0
> > [  223.244739] vfs_read+0x1d8/0x2b0
> > [  223.244775] ksys_read+0x78/0xe8
> >
> > The warning comes from
> > https://elixir.bootlin.com/linux/v6.3.9/source/fs/sysfs/file.c#L734
> >
> > if (WARN(!buf || offset_in_page(buf), "invalid sysfs_emit: buf:%p\n", buf))
> >         return 0;
> >
> > Kyle
> 
> BTW, to print the buf address, it should use %pK ...

Patches accepted :)
