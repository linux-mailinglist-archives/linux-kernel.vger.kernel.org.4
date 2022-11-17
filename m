Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7830662E11C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240200AbiKQQJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240123AbiKQQIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:08:42 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BC17DEE2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:07:50 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-141ca09c2fbso2664698fac.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IfbrclEAp02esXRgMf8hzV0FzaiwXcfG62c3P4EwgX8=;
        b=UxHb4bJ//EU5zUhNXovBeJy4qD5iIdUsIyQ6yLuY8MZWZcff0PUAtFRT14kWCYS7gd
         9xuSPojPdwLHgRtO7goU7i1sFRH9liTF0s9wQ0DaICrY0L/K4CUQcgsfEbnR2pugt9Nt
         unrjlagX+fskga5pdUM50zgvK3fsexdggS0D4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IfbrclEAp02esXRgMf8hzV0FzaiwXcfG62c3P4EwgX8=;
        b=pRY7oS2HW7/my9cdk4CKYHr4l3fE/cW8mS1vkcOmZF/CTcYtg7eWqqvOSvnz7rJpe+
         w/EFmvXboDcs9FfGaXpNmQZOzYrsu76GE76obXSexLvq1v2KetVommvSgY+3t4kc/JXI
         7EKdTPGbpV2fpdbOiT7VHgSlK/QrBdnFhsDQTyq9VsulpJUgxUua65tWRD9CRmEV1m2P
         uxvtSC7UEJQJXnRDQichks4UuT4PEt2HlKvHmv1P4RzOy6QUxKrpVb+iVIyhg39ZpQUJ
         EXXk8MLNFJLEHeMI2sVCQ5OvKtO5m1XNC33vnySC2a1E6mSoG7+aHXE29ysHMcFRxrRN
         aLKQ==
X-Gm-Message-State: ANoB5plDpUx4K5K9hehZ48A4BBujrIyXN2rTxTBBeCYJiD05RXmKq1bL
        B+RZFuJPjGAZ0PBMvJTXv/lsVquJJpAGY0CaHe5btQ==
X-Google-Smtp-Source: AA0mqf5S3LgZfCLc4YtVrcbwVLzwn4/DKEsp6EZSD6SjAfrWNkOloiskr4sgD9Kt4Ed41+Y7uFRmCGgJzGWcEMkK/T8=
X-Received: by 2002:a05:6870:bacb:b0:13a:dd16:9b83 with SMTP id
 js11-20020a056870bacb00b0013add169b83mr4660609oab.15.1668701270248; Thu, 17
 Nov 2022 08:07:50 -0800 (PST)
MIME-Version: 1.0
References: <20221116195624.124092-1-joel@joelfernandes.org>
 <20221116151610.7294a9e8@gandalf.local.home> <20221117164612.65832e37@rotkaeppchen>
In-Reply-To: <20221117164612.65832e37@rotkaeppchen>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 17 Nov 2022 16:07:39 +0000
Message-ID: <CAEXW_YSQsc96XZJ3Ht0DHx5TUANUDjStiYMOB0GgQ0jO66uynQ@mail.gmail.com>
Subject: Re: [PATCH RFC] kexec: Freeze processes before kexec
To:     Philipp Rudo <prudo@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        ribalda@google.com, zwisler@google.com, robdclark@gmail.com,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 3:46 PM Philipp Rudo <prudo@redhat.com> wrote:

> On Wed, 16 Nov 2022 15:16:10 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > On Wed, 16 Nov 2022 19:56:24 +0000
> > "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
> >
> > > --- a/kernel/kexec_core.c
> > > +++ b/kernel/kexec_core.c
> > > @@ -1175,6 +1175,12 @@ int kernel_kexec(void)
> > >     } else
> > >  #endif
> > >     {
> > > +           error = freeze_processes();
> > > +           if (error) {
> > > +                   error = -EBUSY;
> > > +                   goto Unlock;
> > > +           }
> >
> > If this is the path of a kernel panic, do we really want to check the
> > return error of freeze_processes()? We are panicing, there's not much more
> > we can do.
>
> kernel_kexec isn't called during panic. We don't need to worry about it
> here.

Indeed, sorry for my hasty comment and for misleading Steve. This is
seen to happen when doing manual kexec from the reboot(2) system call.
During a regular panic, machine_shutdown() is not called so this would
not happen. However, for testing, the crash is a hurdle.

> Having that said I think this is a problem in the device driver _not_
> in kexec. In my opinion it's the job of the driver to prevent such
> races during shutdown.

Thanks a lot for your input. Rob, what do you think?

thanks,

 - Joel
