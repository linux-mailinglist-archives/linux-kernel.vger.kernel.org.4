Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83586F5990
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 16:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjECOLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 10:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjECOLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 10:11:21 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F6F44BE
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 07:11:19 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bcb00a4c2so4736930a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 07:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683123077; x=1685715077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5LxvsPjOYAe3iUvm6GoNOplQUzGwHhxqPoIECxKyo0=;
        b=MlI0yIfbI0bE1J4sKC+POMzM+vqeNwr3y01aaXeiE1eRtOo8aRf+9D78mjMyeq9RGP
         3BZiyWaV4hWy2lrCHmCrUNqVY1JZmKI/q8YyfFPV7IOCJJCDLIlzqvmxK7eGkQt0L13f
         2uDPHfJkhp7XDl4hDYybia/JUdTBVhZBbxnk+9O0+9/TTXjjW1rs7l9CMgu4PvL5M0dx
         iE/G9HtGARY4p8GKlgBfYSkfnGpSBgOSZnD80okL/wt2vCQTRGLusaps4XBn57/8LbfQ
         aj7fGnwM1LnOO7Ssv00LqMQCv5OAq/efjACNJCgUwSeQViJDZSfkLEcBE5KFB4Or99EW
         4hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683123077; x=1685715077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5LxvsPjOYAe3iUvm6GoNOplQUzGwHhxqPoIECxKyo0=;
        b=UH8zO14yZqr9NI5TnWqt962trRPYZXPuR0AjZsua+ILeQrlUIHYLiEcC9MB+KC8BK7
         ft5MYqJNGE8qJdlYnPpvUzjzz66yQWIIvGKNDqT7Qb/17s3G462jBbJOclJor/oAhyZu
         KKtxtSfHt6P/W8n/4GEuGGHit6zMS+PyWEesf0NDLjklzXNUBUdqEjFrb99glnvHlHob
         dO3IkkveHPbV5gZ6iIc0APbcEsZ1x179zzAsaExmyddCTK42qzIIPyP5uM6Fd4qhLm7n
         fWNGI3py43TjwaszngPkaz4mEIcgHbaQVDcEsAC2wlg0ZTDNDXn9yPuavnxcbR4v5AU9
         JykA==
X-Gm-Message-State: AC+VfDx/kZ8BKFHmJjt5MbQu0Utf1B/axSLv0OoAlQdTcUfBgdgfFLzI
        iDwX6y9nD6lDimuSeJnLNxtMKCxSQYqSP/uvlgA=
X-Google-Smtp-Source: ACHHUZ4ycd+6VumABdUuT3gG4UU3LoMW7fnsENTwKrMH+DfWXVkBR4bfgazOBqtq/y6Ot8Yh0BXJK0SvQJoL41aSzUk=
X-Received: by 2002:a17:907:a08a:b0:94f:3b07:a708 with SMTP id
 hu10-20020a170907a08a00b0094f3b07a708mr3652466ejc.29.1683123077123; Wed, 03
 May 2023 07:11:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230501190602.86281-1-jandryuk@gmail.com> <ZFAWaQbDR1_r5jf-@codewreck.org>
 <CAKf6xptMDRVet-C_1H7txPb_J_xq+XnNxwrQVbNWL_2JGnbHgw@mail.gmail.com> <ZFGdTDrPa1LD899y@codewreck.org>
In-Reply-To: <ZFGdTDrPa1LD899y@codewreck.org>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Wed, 3 May 2023 10:11:05 -0400
Message-ID: <CAKf6xps8Z8GJZV6SJDmh7cM6v8EDuE6=V8+h1adjivaB70wLsA@mail.gmail.com>
Subject: Re: [PATCH] fs/9p: Remove INET dependency
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 2, 2023 at 7:31=E2=80=AFPM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Jason Andryuk wrote on Tue, May 02, 2023 at 08:03:15AM -0400:
> > > Good catch.
> > > Could you add depends on INET to NET_9P_FD in net/9p/Kconfig?
> >
> > trans_fd.o builds without INET and without UNIX.  Looks like trying to
> > use either TCP or UNIX sockets would lead to runtime errors, but it
> > also supports generic file descriptors.  That could be useful for
> > someone.   Since it builds, would it be okay to leave this patch
> > unchanged, or do you still want the depends added?  Leaving the patch
> > unchanged provides more flexibility, though the runtime errors may
> > surprise users.  While I built a Xen kernel without INET or UNIX, that
> > is an unusual scenario.  Typically INET and UNIX sockets will be built
> > in anyway even without a depends.
>
> Hmm, good point; the socket interface is common between INET and
> UNIX.. And you're right about the ability to use plain fd as well.
>
> How about 'imply INET'? That will automatically select INET when
> enabled, but allow someone to disable it explicitly.

This sounds good.

Thanks,
Jason
