Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E67E6E1099
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjDMPGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjDMPGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:06:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAB48A74
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:06:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68CF863F65
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 15:06:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1F6C433D2;
        Thu, 13 Apr 2023 15:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681398363;
        bh=BgPD03K8VDv3X6el3A2XpsePodKHLI7seCgCr9oEcRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AXMOMN5421vR+3lakIaI6HLBf4kR6ExrBiIxQRG2NyEwC77BFSDP/tRWlIInUQO1J
         hHY2PHJBlhTSM2eNhvTVAiBMzuUc4MqdOAFpXoAbL9wDOqTKoM26i7LO1FV/OpR4Ip
         td63zCFfTgPkcq0tHDKJZzpV/ELL/1aIov4ulDt8=
Date:   Thu, 13 Apr 2023 17:06:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chuang Zhang <zhangchuang3@xiaomi.corp-partner.google.com>
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, brauner@kernel.org, cmllamas@google.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        Chuang Zhang <zhangchuang3@xiaomi.com>
Subject: Re: [PATCH] Binder: Add timestamp and async from pid/tid to
 transaction record
Message-ID: <2023041324-molecule-clad-b580@gregkh>
References: <20230413104047.388861-1-zhangchuang3@xiaomi.corp-partner.google.com>
 <2023041302-uncut-tutor-0e6e@gregkh>
 <CAO+dPF9KFJe5h4wO47ypL2-__3+1mnzurdRcj6OCQ1wdku_7cA@mail.gmail.com>
 <2023041359-marine-uninsured-bae9@gregkh>
 <CAO+dPF-YNtaZvVax8Z1QD9VtG36uc2C=uus4eR4H_vipEzu8Dw@mail.gmail.com>
 <2023041347-abdominal-bronze-34be@gregkh>
 <CAO+dPF8inueprEXeNMBWZtiqDzcjFQLbKLVq+qL0gGq3gRBu3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO+dPF8inueprEXeNMBWZtiqDzcjFQLbKLVq+qL0gGq3gRBu3w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 09:03:08PM +0800, Chuang Zhang wrote:
> On Thu, Apr 13, 2023 at 8:36 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Thu, Apr 13, 2023 at 08:34:06PM +0800, Chuang Zhang wrote:
> > > On Thu, Apr 13, 2023 at 8:17 PM Greg KH <gregkh@linuxfoundation.org>
> > wrote:
> > > > And how are pid namespaces being handled here?  I know it's just
> > > > debugging data but showing a pid from the wrong namespace probably
> > would
> > > > not be a good idea as it might get confusing quickly.
> > > >
> > > [chuang] Do you have any good suggestions? thanks
> >
> > I do not know what you are using this debug information for, nor how or
> > if Android uses pid namespaces (I think it does?)
> >
> [chuang]
> So can I use (struct binder_thread *async_from) instead ?
> and get the corresponding pid and tid through the following way:
> async_from->proc->pid
> async_from->pid

I don't know, try it and see!

I'm not quite sure what debugging information you can get here with the
pid, nor what you intend to do with it, so I can't answer this very
well, sorry.

thanks,

greg k-h
