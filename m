Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB845F4905
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 20:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJDSG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 14:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiJDSG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 14:06:56 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992341EED6
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 11:06:55 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id h19so504287iof.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 11:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=c+iMt+Zmn4W4daL1eQ1jMpY6swlWjzwhrCtpT283CF8=;
        b=a3+1CLfIPasemBNKqEoPpR0kvPISBFHqo/qxpHW2TdSRRKNY9Tk6aQscfPUWS1U8s3
         B+64cP05oBJQcUIpMvNJEg4n8nc9GPRA6mY1Mrs7N2ZAUq0QqBGT3WfMOajzEucbKTno
         74lpkJf9UkGQbgfLbzwu9ptCsj6q/fsE/JdW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=c+iMt+Zmn4W4daL1eQ1jMpY6swlWjzwhrCtpT283CF8=;
        b=M8sz27M5aKrVvDVsfx03jKGIvE3md0NYxxGL8EykY4PngE5TeHo41ps0ZrtGIGIX8A
         xcF3hLY4H3syAJI1fnvTtp1F8ZRpo09iUrR4Ibv/8GPzW1n7zTRxABmmRfvkF9D3GKBv
         vZtjWds/AQZ82koC/aWZEVaBRmK4V0sBe6g91UYD30qqvUSztaV85C2zwz6SRXrtczYL
         wntWkXMOZ2Gnoq4GyzaGQY9DKE0OQLoJlzUYsZYi02ZkFnt22VI7emZi/xqnmzp9SLPC
         efTNbRcQvIEmZYW1F2HJPJY5wF3IK4RPYeLV3h7yH/GLsUlfahF5KHHP1SpC/uGD+MTA
         UJRQ==
X-Gm-Message-State: ACrzQf2D5MnZuwV4ISc+MQaQm85a7oMvlH1354rufpcMo7m8kdMRN2Jk
        Y+m2t5Bm93exAztMz5AAmNguy7MtNDKE4rDq9Al+2Q==
X-Google-Smtp-Source: AMsMyM7gV1ewQXslE6I25iElynSxAh00oyGlWhU+MXH3mNaqlBEII0fyGTlTSLcSQ9O7JopAG3ebceDqV4sQEMJvHrA=
X-Received: by 2002:a05:6638:1606:b0:35a:5472:fa1b with SMTP id
 x6-20020a056638160600b0035a5472fa1bmr13091186jas.241.1664906815032; Tue, 04
 Oct 2022 11:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <3F5B20A5-6E48-4603-ACBA-0A7947A9C457@joelfernandes.org>
 <9E3CFF3C-8956-4C44-8072-1CCD5E84CC4C@joelfernandes.org> <YzcVGN8v1yhgIlF6@pc636>
 <YzwafYASrgKZ24uq@pc636>
In-Reply-To: <YzwafYASrgKZ24uq@pc636>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 4 Oct 2022 14:06:45 -0400
Message-ID: <CAEXW_YT9qMJFW0sD-_shDd1PSeY4TefZ4HdbKtm_rqDXZcj-5w@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     paulmck@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vlad,

On Tue, Oct 4, 2022 at 7:35 AM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> > > >>
> > > >> OK. Found the boot up issue. In my case i had 120 seconds delay:
> > > >
> > > > Wow, nice work.
> > > >
> > > >> <snip>
> > > >> diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> > > >> index 448748e3fba5..a56cfd612e3a 100644
> > > >> --- a/drivers/scsi/scsi_error.c
> > > >> +++ b/drivers/scsi/scsi_error.c
> > > >> @@ -312,7 +312,7 @@ void scsi_eh_scmd_add(struct scsi_cmnd *scmd)
> > > >>        * Ensure that all tasks observe the host state change befor=
e the
> > > >>        * host_failed change.
> > > >>        */
> > > >> -       call_rcu(&scmd->rcu, scsi_eh_inc_host_failed);
> > > >> +       call_rcu_flush(&scmd->rcu, scsi_eh_inc_host_failed);
> > > >
> > > > Great! Thanks. I=E2=80=99ll include this and the other one you conv=
erted in the next revision.
> > >
> > > By the way, any chance you could check android as well, just to rule =
out any trouble markers? ChromeOS and your Linux distro are doing well on b=
oot so that=E2=80=99s a good sign.
> > >
> > I will check v6 on Android. I will get back shortly.
> >
> OK. Works and boots well. I do not see any issues with Android so far.
>

That's great news and thank you so much for testing Android and all
your efforts on this work!

 - Joel
