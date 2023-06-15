Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1301E73135B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245376AbjFOJPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240593AbjFOJPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:15:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BA4270D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 02:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686820464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tb5nOqyG703NV7P4uB0/SJ9ITcPAetTKogsQW8Hmr8c=;
        b=Nn/vsimP+zKnZTJY+gBIepKTAn6Exwx0lhXi35mZ0JbsBbsl/A41OdDdjFmOdrQgym6WDq
        EWjq+JrJV/O9JDSX/55YLZxryH8mBic2HwXPmwVTqi9j1NRilCy4N9XlwNYRO1AgzATWVZ
        GD3En5yRI9szvyLKrNWX5p8KkMleASE=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-7eYpGz0ePeaRmHPYdmUxww-1; Thu, 15 Jun 2023 05:14:22 -0400
X-MC-Unique: 7eYpGz0ePeaRmHPYdmUxww-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-39cd7689d15so3644009b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 02:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686820462; x=1689412462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tb5nOqyG703NV7P4uB0/SJ9ITcPAetTKogsQW8Hmr8c=;
        b=MPUhh0uSe6Q8KesuBTgQVznlSx/1AI9AJ9Ac0qZVXfnvVWTcqs+dOGEuw2b2xXqSVI
         p8WlcLwH8WfF7SbhGndq2fpMQimxc6XPHPY8EUTYP5Q7C1pVjSzls3p28hqqbivU7gNi
         ItP7XrkLCdDDgqLelfpEN93OTocdz515ZHJdf4bhm8mPrmRFicVlt59tYKTC957Rxgvn
         QRFaTo4HuwAv/TBr26A8nO1Y609gK1SkpeABDTA0Okv+eBHAUi8EH8ao5UsDFSFnoM3k
         DvN7DnVX3CGQrFkP8KDHJwUGTn38hqWMm1j6zg3F85AnRJ4cWc0spl47guY9oZZkMZPM
         J/0g==
X-Gm-Message-State: AC+VfDyBpGFUYupyUt7SJh80Po6tbuO3HejshCW+B5sTziNaCFaWHBfQ
        BS+vZ6YlRDf6gKSGIprz6k2uRGd0vJdMDCym26YYly8WaMgwmbc2khUxZ7Owmdexf13+83UGJQp
        /svG2OxLwUT6pFHWwKmESNhxOnxh86mpSKX9fBPh1
X-Received: by 2002:a05:6808:2121:b0:39a:af56:4dda with SMTP id r33-20020a056808212100b0039aaf564ddamr14782864oiw.17.1686820462141;
        Thu, 15 Jun 2023 02:14:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4I7cNI9F+cpY9YvJXebxjurS8POfuPraOH0yb1xS/M4OIsOvyYRDgu99uKmRspg+mMauITXYpyLTqFqlV35Xw=
X-Received: by 2002:a05:6808:2121:b0:39a:af56:4dda with SMTP id
 r33-20020a056808212100b0039aaf564ddamr14782854oiw.17.1686820461923; Thu, 15
 Jun 2023 02:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230529132037.2124527-1-yukuai1@huaweicloud.com>
 <20230529132037.2124527-5-yukuai1@huaweicloud.com> <05aa3b09-7bb9-a65a-6231-4707b4b078a0@redhat.com>
 <74b404c4-4fdb-6eb3-93f1-0e640793bba6@huaweicloud.com> <6e738d9b-6e92-20b7-f9d9-e1cf71d26d73@huaweicloud.com>
 <CALTww292gwOe-WEjuBwJn0AXvJC4AbfMZXC43EvVt3GCeBoHfw@mail.gmail.com>
 <5bf97ec5-0cb4-1163-6917-2bc98d912c2b@huaweicloud.com> <CALTww28UapJnK+Xfx7O9uEd5ZH2E7ufPT_7pKY6YYuzTZ0Fbdw@mail.gmail.com>
 <b96ec15b-6102-17bb-2c18-a487f224865b@huaweicloud.com> <CALTww2-knHOoX35NB73X-sMn1u8EJHLA=0aOnoVqVm83+fdG5Q@mail.gmail.com>
 <04700f85-62a2-1dbd-f330-80f9a13b7d2e@huaweicloud.com> <CALTww2-Wr8UbNFaLOyYv5Syh5q4J+hzRuo8Eakj_nOW+P4Cx7A@mail.gmail.com>
 <CALTww2_V=KVLqVVXpXZvGyrmT0N-WG1tFC+HaSEGNfHagaLHug@mail.gmail.com> <bacb3159-514c-76e2-ef2e-353cb1a0e30b@huaweicloud.com>
In-Reply-To: <bacb3159-514c-76e2-ef2e-353cb1a0e30b@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Thu, 15 Jun 2023 17:14:10 +0800
Message-ID: <CALTww2-C6vjiSZqd=gko84mbf3tN3UjX7izPFE2vr3VgNdaQ7g@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH -next v2 4/6] md: refactor idle/frozen_sync_thread()
 to fix deadlock
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     yi.zhang@huawei.com, yangerkun@huawei.com, snitzer@kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        song@kernel.org, dm-devel@redhat.com, guoqing.jiang@linux.dev,
        agk@redhat.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 5:05=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2023/06/15 16:17, Xiao Ni =E5=86=99=E9=81=93:
> >> Thanks for the example. I can understand the usage of it. It's the
> >> side effect that removes the mutex protection for idle_sync_thread.
> >>
> >> There is a problem. New sync thread is started in md_check_recovery.
> >> After your patch, md_reap_sync_thread is called in md_check_recovery
> >> too. So it looks like they can't happen at the same time?
>
> Of course they can't. md_check_recovery() can only do one thing at a
> time.
>
> >
> > After thinking a while, there is still a race possibility.
> >
> > md_reap_sync_thread is called in pers deamon (e.g. raid10d ->
> > md_check_recovery) and md_check_recovery returns. Before
> > idle_sync_thread is woken, the new sync thread can be started in
> > md_check_recovery again.
> >
> > But it's really strange, when one people echo idle to sync_action.
> > It's better to add some messages to notify the users that they need to
> > echo idle to sync_action again to have a try. Is there a way that
> > md_reap_sync_thread can wait idle_sync_thread?
>
> I don't think this is a problem, echo idle only make sure to interupt
> current sync_thread, there is no gurantee that sync_thread is not
> running after "echo idle" is done with or without this patchset, before
> this patchset, new sync thread can still start after the mutex is
> released.
>
> User shoud "echo forzen" instead of "echo idle" if they really what to
> avoid new sync_thread to start.

Thanks for all the explanations and patience.

Regards
Xiao
>
> Thanks,
> Kuai
> >
> > Regards
> > Xiao
> >>
> >> Regards
> >> Xiao
> >>
> >>>
> >>> Thanks,
> >>> Kuai
> >>>
> >>> --
> >>> dm-devel mailing list
> >>> dm-devel@redhat.com
> >>> https://listman.redhat.com/mailman/listinfo/dm-devel
> >
> > .
> >
>

