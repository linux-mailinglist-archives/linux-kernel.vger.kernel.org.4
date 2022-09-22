Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6EF5E64A7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiIVOFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiIVOFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:05:34 -0400
Received: from smtp-out.xnet.cz (smtp-out.xnet.cz [178.217.244.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BABE8DBB
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 07:05:30 -0700 (PDT)
Received: from meh.true.cz (meh.true.cz [108.61.167.218])
        (Authenticated sender: petr@true.cz)
        by smtp-out.xnet.cz (Postfix) with ESMTPSA id 080EC18DC6;
        Thu, 22 Sep 2022 16:05:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=true.cz; s=xnet;
        t=1663855528; bh=I0J6ujNLVhhMLRh/6e6Aj/CNH22tQ5rFeLmRIK00Kp8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
        b=TSASf9fEl1CgAJeERTp/DNaIBCk97+0BRDyqQq2TfrEvepbGwEDMMGaCfrUxQ1wuo
         8J9QkYRspRtOtzdIdj+lW/AFQId2FbYyFnOdmpRasCvODVsRe9ujeWA7a9u6ZV8vAL
         yv6sDAmRvaPPX56nflhhPGByMHqt8SrZEeXwNN2I=
Received: from localhost (meh.true.cz [local])
        by meh.true.cz (OpenSMTPD) with ESMTPA id 7761a6f8;
        Thu, 22 Sep 2022 16:05:04 +0200 (CEST)
Date:   Thu, 22 Sep 2022 16:05:04 +0200
From:   Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
To:     Phil Auld <pauld@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, yury.norov@gmail.com,
        rafael@kernel.org
Subject: Re: aarch64 5.15.68 regression in topology/thread_siblings (huge
 file size and no content)
Message-ID: <20220922140504.GA58265@meh.true.cz>
Reply-To: Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
References: <20220922113217.GA90426@meh.true.cz>
 <YyxVytqQDbGWPa+6@lorien.usersys.redhat.com>
 <YyxXoPmtTZHCr5pR@kroah.com>
 <Yyxgtx/Vr6Ar1xEe@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yyxgtx/Vr6Ar1xEe@lorien.usersys.redhat.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Auld <pauld@redhat.com> [2022-09-22 09:18:47]:

Hi,

> I've seen the size cause problems for tools. Are we sure that it's the empty file and not
> the size causing issues?  Maybe something is treating that as signed again for a count of
> -1 bytes (which seems like it would be a bug anyway)?

  root@OpenWrt:/# strace cat /sys/devices/system/cpu/cpu1/topology/thread_siblings
  ...snip...
  openat(AT_FDCWD, "/sys/devices/system/cpu/cpu1/topology/thread_siblings", O_RDONLY|O_LARGEFILE) = 3
  sendfile(1, 3, NULL, 16777216)          = 0

  root@OpenWrt:/# strace md5sum /sys/devices/system/cpu/cpu1/topology/thread_sibli
  ...snip...
  openat(AT_FDCWD, "/sys/devices/system/cpu/cpu1/topology/thread_siblings", O_RDONLY|O_LARGEFILE) = 3
  read(3, "", 4096)                       = 0

  root@OpenWrt:/# strace head /sys/devices/system/cpu/cpu1/topology/thread_siblings
  ...snip...
  openat(AT_FDCWD, "/sys/devices/system/cpu/cpu1/topology/thread_siblings", O_RDONLY|O_LARGEFILE) = 3
  read(3, "", 1024)                       = 0

Cheers,

Petr
