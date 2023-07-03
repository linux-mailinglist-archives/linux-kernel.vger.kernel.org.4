Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222FE7462B4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjGCSrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjGCSru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:47:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A972AE73
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 11:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688410017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zg54bx4XEvunLiZj82LGfi5c5+FX4BrGVPRNU463J4Y=;
        b=QY1EzV1UI0Mf3efJg1ipf7deMNKfF5aMCqGzzXhMY/T93VxEyLvs14ODN41nK2IZRludSp
        yN2hzMW7IbHv3u5yzWMpN/1eZLzbZP7JMjQ3vXZmIbnYDYC4lYtCzuyWgwLZ0ENgAq4efB
        02aDb9dXdx325yx1MZTOEvW+xVe/lkM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-7KEoV_mnOLGMPv7VQQ_V4g-1; Mon, 03 Jul 2023 14:46:56 -0400
X-MC-Unique: 7KEoV_mnOLGMPv7VQQ_V4g-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-26304c2e178so6617487a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 11:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688410015; x=1691002015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zg54bx4XEvunLiZj82LGfi5c5+FX4BrGVPRNU463J4Y=;
        b=Ie2T9MZr2ToBkhg89uRtsDI8j/AsB+iNnAMmGzJBGGQDsMuZw2Q2NO2l4iyETAVOsz
         +GVXPtCzuFnOPDimMOKWi0Cv3aZgarrwgUVCQjThsfSDy904GtpelTS519hz3rygngtG
         ptXlpVPtq1O4JmiZngR/7S9C6icl3fOo0GrTzl0iZjkpZpkmwMZ4c0Uu6uSDzSKi4gvN
         GEOUEpeniMHSTXQkGa54EDvWEvxexiGxtYLm2PLCAFstJjOAo2yZCs0UYTdx34kPSawF
         aJRJBJRuZ/NMttFsHWoCZ2z2DmUUorSsCc+F68Io2sp5Wzz3+DbaqL+vVadsB0zvWP6j
         H3sQ==
X-Gm-Message-State: ABy/qLbwuiDNMVhwBrfQqh8xJnbb51emplQbGMdYaqz49bfcst6W1c8P
        ZpxudKlSDZkADACOTD+IflUjxJqnSSmLJXrXpwNbMkmRvBiY6pRJogVm8bc5wYffFCiwU582STm
        7AX5r+lgyXMucrePx6RwF5mIVyR3adm3SrpG5uRhx
X-Received: by 2002:a17:90a:db87:b0:262:d1b5:3390 with SMTP id h7-20020a17090adb8700b00262d1b53390mr11049013pjv.3.1688410015740;
        Mon, 03 Jul 2023 11:46:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGkc7rjCplwSajX8n+mv7eIvy6ajxMAqm10BJXg05B67wq4TvO2dQTP3QjhlYDW1iQ/aH659Ky0fDnNH9hy36M=
X-Received: by 2002:a17:90a:db87:b0:262:d1b5:3390 with SMTP id
 h7-20020a17090adb8700b00262d1b53390mr11049002pjv.3.1688410015479; Mon, 03 Jul
 2023 11:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230703114318.1576ea24@rorschach.local.home> <CAHk-=wg4J3XjdakYiK6yC-QuBuCDn1g4XGNkuaAzByUM4KCCog@mail.gmail.com>
In-Reply-To: <CAHk-=wg4J3XjdakYiK6yC-QuBuCDn1g4XGNkuaAzByUM4KCCog@mail.gmail.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Mon, 3 Jul 2023 14:46:19 -0400
Message-ID: <CALF+zO=r8sV3nOOKSEmC_k5iFML-e_H9dUnKoK3fx7Z6DLz9Ag@mail.gmail.com>
Subject: Re: Buggy rwsem locking code in fs/smb/client/file.c
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Pavel Shilovsky <pshilov@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ajay Kaher <akaher@vmware.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 3, 2023 at 1:00=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 3 Jul 2023 at 08:43, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > And hides the bug by wrapping the down_write() with:
> >
> > +void
> > +cifs_down_write(struct rw_semaphore *sem)
> > +{
> > +       while (!down_write_trylock(sem))
> > +               msleep(10);
> > +}
>
> That is indeed disgusting.
>
> It may *work* - because as the commit message says, it means that
> writers are now never queued up and thus never block recursive
> readers.
>
> And in the process it now becomes absolutely horribly unfair to
> writers, who will easily get starved by readers.
>
> This is absolutely not acceptable in any sane situation. Are writers
> *so* rare and special that starving them is ok?
>
> Because starvation can be just as deadly as a deadlock. You're just
> hiding the problem from lockdep and yourself.
>
> This is very much a "head in the sand" solution.
>
>             Linus
>

Steve and Linus,

Thank you for pointing this out.  I'll have to get with Ronnie on this
and come up with something better.

