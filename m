Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E3360DDA4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 11:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiJZJCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 05:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiJZJCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 05:02:06 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340D1923EE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 02:02:03 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id fy4so19464729ejc.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 02:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2AiRgJoL/WQguaTORVj2RUdC+41fuiOA89svDNGAFm0=;
        b=fyp3rZs8LYK2nDycQqmsGkDkEe73cLXOI+E59kxTn23leCm0FDPivgGJ01akWf8bS0
         bcU27SWYNz6/f01vubMz9ANCa/MYf2oRiK+ocQSdGzNFo1XHRK5RfalvYAdDBJFZP3RK
         SXBLuN9hfI7ygC52xkxYtc9RBFbey95BDf0aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2AiRgJoL/WQguaTORVj2RUdC+41fuiOA89svDNGAFm0=;
        b=2cpK5oz6tTzveeAjy8HblqC3lnzHeBqECtnci58StY25slAx8aPZTQgKFpXtup75gA
         Q13kP0igAx9GBi3ux4irxYTmZxTxmqLu5EV3uwrBhtyXAZy7zo7tDG28Y+bAZzQBJP0P
         4J6Spt72T+bkYN+4cgjzX5+2O1wd1gLEJrhE3nXfZ6z4tP0AVdzplB3yz6DbApNtpMC9
         8umXZngv8b5iMhJ926yvHDdyB8B9a57o15ItbL+rG6TiTsUSxXH32Qygwk8CkkUrqoTh
         B8JxUta+zvqyynraJgLkhjItrYvM2WTB66rPA//qkCg9QTAErkT8cBVupVuSn8H53sPa
         soqg==
X-Gm-Message-State: ACrzQf15recEduEVwRkWwkZDheUmvvJQ4x2o+IK45rI75BljTMLN+Tzj
        YqthXRGuyDMTLl2Y4oEuH18VRajmkh1bFM8wtclCWg==
X-Google-Smtp-Source: AMsMyM7MACRplKV101kFt3pYqGwFpCDUHyDOAvHWrixNDP6N4LNCXc7xjiKav7fflMtMchZZAMBUGdXgY0TXgUIAreo=
X-Received: by 2002:a17:907:62a1:b0:781:b320:90c0 with SMTP id
 nd33-20020a17090762a100b00781b32090c0mr34457876ejc.255.1666774921655; Wed, 26
 Oct 2022 02:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegswSAeUdxHR1Z8jC_nQtUm7_mD=ZZC_LyQczaoJWTPe3g@mail.gmail.com>
 <20220929163944.195913-1-tycho@tycho.pizza> <CAJfpegtcHW8AwjfjDSm8Y7OXbesrw=ZpX-CMujJ=1Zz_Ly2FdQ@mail.gmail.com>
 <Yzb20Y4wHrqUZ93Z@tycho.pizza> <CAJfpegsZk+R2wmXo_358J6YrxLaWN7=VAUEUaGjF1Jveb+qKJQ@mail.gmail.com>
 <YzcU1IhHEa2oV0vo@tycho.pizza>
In-Reply-To: <YzcU1IhHEa2oV0vo@tycho.pizza>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 26 Oct 2022 11:01:50 +0200
Message-ID: <CAJfpegvrd2nsydG26stcmeEkdO1JLyeu69KrZs4dvVxXtoz42Q@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: In fuse_flush only wait if someone wants the
 return code
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
        fuse-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sept 2022 at 18:10, Tycho Andersen <tycho@tycho.pizza> wrote:
>
> On Fri, Sep 30, 2022 at 04:41:37PM +0200, Miklos Szeredi wrote:
> > On Fri, 30 Sept 2022 at 16:01, Tycho Andersen <tycho@tycho.pizza> wrote:
> > >
> > > On Fri, Sep 30, 2022 at 03:35:16PM +0200, Miklos Szeredi wrote:
> > > > On Thu, 29 Sept 2022 at 18:40, Tycho Andersen <tycho@tycho.pizza> wrote:
> > > > >
> > > > > If a fuse filesystem is mounted inside a container, there is a problem
> > > > > during pid namespace destruction. The scenario is:
> > > > >
> > > > > 1. task (a thread in the fuse server, with a fuse file open) starts
> > > > >    exiting, does exit_signals(), goes into fuse_flush() -> wait
> > > >
> > > > Can't the same happen through
> > > >
> > > >   fuse_flush -> fuse_sync_writes -> fuse_set_nowrite -> wait
> > > >
> > > > ?
> > >
> > > Looks like yes, though I haven't seen this in the wild, I guess
> > > because there aren't multiple writers most of the time the user code
> > > that causes this.
> > >
> > > I'm not exactly sure how to fix this. Reading through 3be5a52b30aa
> > > ("fuse: support writable mmap"), we don't want to allow multiple
> > > writes since that may do allocations, which could cause deadlocks. But
> > > in this case we have no reliable way to wait (besides a busy loop, I
> > > suppose).
> > >
> > > Maybe just a check for PF_EXITING and a pr_warn() with "echo 1 >
> > > /sys/fs/fuse/connections/$N/abort" or something?
> >
> > AFAICS it should be perfectly normal (and trivial to trigger) for an
> > exiting process to have its dirty pages flushed through fuse_flush().
>
> Agreed.
>
> > We could do that asynchronously as well, generally there are no
> > promises about dirty pages being synced as part of the process exiting
> > .  But ordering between dirty page flushing and sending the FUSE_FLUSH
> > request should be kept.  Which needs more complexity, unfortunately.
>
> How can we wait in fuse_set_nowrite()? Or are you suggesting we just
> do a fuse_flush_writepages() in the async part and hope for the best?

I was thinking along the lines of calling schedule_work() in the
exiting case to do the flush.

Thanks,
Miklos
