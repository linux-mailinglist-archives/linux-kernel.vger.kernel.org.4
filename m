Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFE36CDC8C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjC2O2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjC2O2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:28:31 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DC0B474
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:21:51 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id i7so19545614ybt.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1680099565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4/N2vrJxKSPGNOo4Sdxe+Hpfi1jERAyjrq6Q8qDfAk=;
        b=E+Xv3lvbzYSO6w0sxubf8tFqaPhuhL0DT/DtwdsUELKN0hN/L0LFwwN91nkb4xMgGE
         QWrSyk2SZJ0638qc+KCN26yHQaipDrBAA9Dc01zPYIV3sY/5juz+8QCRNNiM+sHS3qGp
         t/h+yPhXPjqZhPcpbGWbgMXRsFhl3EkQHCp5AK0WeewpRa81XEzgjRZSDBAmUsIjlzZl
         1NqGnRfyuzMWzQCsBnnFrwsxJTp9kDPZq1TjvjicFGh0ZucARB5wt/SEZzQxLI8pBtGt
         fKkPXeB83uxyRCoMdKUOF3vcF0E2iVY9nPolxBp7M4x5QpjSyTSBbuPh8tUwAE6srx3m
         AO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680099565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4/N2vrJxKSPGNOo4Sdxe+Hpfi1jERAyjrq6Q8qDfAk=;
        b=mgDQbM6s3w9MsLGoX7wGfEJE14PPOlIsn3HxEisZBkZ8UmSfmnAfcJDPu+fBzBVvae
         tN5UqmadtqogRM7CBgovEs9NiAHNavRnoQqMjZYaMAIQSAMgbMzQ3alZrqrepKq7kh1I
         CiOLgOvw/zXuU5kIQZYdyxWQUmYru5sGuaIosouDDRQ8ONsUxlDtVrCwzQhWJg9mog4D
         bHuxMdAnIYvzXnV6rwgwhJ/01omL5RN2mbrywHT8jfzM+aOvh4lY/+o2BFucZkjDtFx/
         sRSA6U2V5PHLhKl4JGm0PbWeoX0RJxRiPfHcvOOqU/O9JvPWzQUKTtK7vbbyiXNlbqIA
         eo4A==
X-Gm-Message-State: AAQBX9dub9+8IYciWCNgh2IB1x7VHDEMBmmGL/8B5TUvuASgy772hoXq
        oNv3xy7gzUK6JEMAymdvq8I5nKfSSv/PZcL5Be4U
X-Google-Smtp-Source: AKy350ZXG/6vdtiRwb14rFlkSfYbi/rQ7HyN95sz22NFfzMEzzIVcrSq4Yj28sNoDp2O5+duQn4747E2fbAWADJ+YJg=
X-Received: by 2002:a05:6902:18c2:b0:b78:5662:d5bb with SMTP id
 ck2-20020a05690218c200b00b785662d5bbmr9370969ybb.3.1680099565020; Wed, 29 Mar
 2023 07:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de> <83763b78-453d-de21-9b48-1c226afa13a0@web.de>
 <57a97109-7a67-245b-8072-54aec3b5021d@web.de> <CAHC9VhR=yK72JXW3hJR+gUQtGCNpF0Bzk5RDzPZR0MunC84AUQ@mail.gmail.com>
 <CAHC9VhREfdgiCji=uEeCrc4w1kPGfnWGKnJuUYKXwTApdneSjQ@mail.gmail.com>
 <9e8bb69f-99e8-f204-6435-cc6e52816ebf@web.de> <CAHC9VhQfiNd_4uWBmKCC81UnOJb7Y=UFCDMXuqz3=UPr8QtqNw@mail.gmail.com>
 <382bc6d8-7f75-822a-6c36-088b1d2f427a@web.de>
In-Reply-To: <382bc6d8-7f75-822a-6c36-088b1d2f427a@web.de>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 29 Mar 2023 10:19:14 -0400
Message-ID: <CAHC9VhRxjJ3WMNc=vwkLKGDjSN8G=P9ykMkYg9dAJs3SaxVYYA@mail.gmail.com>
Subject: Re: selinux: Adjust implementation of security_get_bools()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org, selinux@vger.kernel.org,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Eric Paris <eparis@parisplace.org>,
        Michal Orzel <michalorzel.eng@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Ruiqi Gong <gongruiqi1@huawei.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, cocci@inria.fr,
        LKML <linux-kernel@vger.kernel.org>,
        Ruiqi Gong <ruiqi.gong@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 1:20=E2=80=AFAM Markus Elfring <Markus.Elfring@web.=
de> wrote:
> >> Would you like to take advice from another information source
> >> better into account?
> >
> > In this case, I prefer what I suggested.
>
> What does hinder you to work with more jump labels for improved exception=
 handling?

I'm the one who has the responsibility to fix bugs in the code when no
one else has the time or the desire, I'm also the one who shepherds
these changes up to Linus and argues for contentious changes which are
not popular outside the Linux Kernel security community.  Having to do
this with patches that I find bothersome hinders me in ways which are
sometimes difficult to explain, but easy to understand if you've ever
been responsible for maintaining a significant code base.

--=20
paul-moore.com
