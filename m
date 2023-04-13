Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750A36E0D58
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 14:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjDMMSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 08:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjDMMRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 08:17:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B163584
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 05:17:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC0C363AD1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 12:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79FFC433EF;
        Thu, 13 Apr 2023 12:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681388266;
        bh=n5nOoo2W9g0u+tk13LjYJcEYuamfw6LN0szQR/FuK2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sWizl+bwmAmIkW6Bv/FAJIKZumpVPjhixarTV6F+dfe+gosK5FvDS4dKlOaxDOFUi
         4uSLPKSMhXeRWZr69HyKjuZZO36++KuriRQXK1Ob72ZW0aDHdPAVu8O+wVoD0KBKBS
         GC+QfgwcKpybsPhKaiw22bIsjBtCDu2G0zFgq9Ho=
Date:   Thu, 13 Apr 2023 14:17:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chuang Zhang <zhangchuang3@xiaomi.corp-partner.google.com>
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, brauner@kernel.org, cmllamas@google.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        Chuang Zhang <zhangchuang3@xiaomi.com>
Subject: Re: [PATCH] Binder: Add timestamp and async from pid/tid to
 transaction record
Message-ID: <2023041359-marine-uninsured-bae9@gregkh>
References: <20230413104047.388861-1-zhangchuang3@xiaomi.corp-partner.google.com>
 <2023041302-uncut-tutor-0e6e@gregkh>
 <CAO+dPF9KFJe5h4wO47ypL2-__3+1mnzurdRcj6OCQ1wdku_7cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO+dPF9KFJe5h4wO47ypL2-__3+1mnzurdRcj6OCQ1wdku_7cA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 07:33:26PM +0800, Chuang Zhang wrote:
> On Thu, Apr 13, 2023 at 6:51 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >       spin_lock(&t->lock);
> > >       to_proc = t->to_proc;
> > >       seq_printf(m,
> > > -                "%s %d: %pK from %d:%d to %d:%d code %x flags %x pri
> > %ld r%d",
> > > +                "%s %d: %pK from %d:%d to %d:%d code %x elapsed %lldms
> > flags %x pri %ld r%d",
> >
> > Why not add this at the end of the line instead of in the middle?  That
> > way any existing code that looks at this line isn't as broken as it
> > might be with your change :)
> >
> >> [chuang] Ok, so move it after t->need_reply or buffer->user_data?

After need_reply?

> > > --- a/drivers/android/binder_internal.h
> > > +++ b/drivers/android/binder_internal.h
> > > @@ -528,6 +528,9 @@ struct binder_transaction {
> > >       long    priority;
> > >       long    saved_priority;
> > >       kuid_t  sender_euid;
> > > +     int async_from_pid;
> > > +     int async_from_tid;
> >
> > As you are just using 0/1 for these variables, why not add them to the
> > bitfield location in this structure instead of wasting a whole int for
> > both of them?
> >
> >> [chuang] They are used to store the caller's process ID and thread ID,
> not just 1 or 0, so I understand that integers are still needed to save
> them. thanks!

Ah, I missed that these really were the pid itself.  Then an int will
not work at all, it has to be pid_t, right?

And how are pid namespaces being handled here?  I know it's just
debugging data but showing a pid from the wrong namespace probably would
not be a good idea as it might get confusing quickly.

thanks,

greg k-h
