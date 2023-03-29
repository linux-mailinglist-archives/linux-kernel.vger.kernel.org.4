Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517496CF573
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 23:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjC2VhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 17:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjC2VhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 17:37:05 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D70211C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 14:37:04 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-544f7c176easo318603677b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 14:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680125824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9ieYNoj+s4aioetQxdSPMNHlC0f9mki2XJo28L5hbo=;
        b=BvHjW9Q/QWBTu2WKZOgFt1EeOjUGJf2P8QxJC6SWsYehD6qCAYPAMpVVEYsEdMkD/T
         HXgoacCXoK/N9BHQaQxUn/hvScnQPvajat+7ZihYPl9LgCk8o8PBkqF2YeN2K7GrS1/j
         H7iOpNGm3MeXucUwRmgaekbsAexmgjAzzYy3xkAgANj9c6YheEeLenJOvljqIzcKFVhp
         hbv1pkwvf5S+c2fTAkjsvX+fd9xF5LpXem1J3qtAa6ivjGrDR/p4bQAUEu+bB13Ifepe
         kaHquDAoCDd+NVsvJH0Xv4aC2NtGLG/Sapaldta62wOtTJm7L3BIi4ejijMWr6S62deG
         5NLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680125824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9ieYNoj+s4aioetQxdSPMNHlC0f9mki2XJo28L5hbo=;
        b=i+0zExRmoqmBAO0+TqiZghqlNsyugVD9jwzKq6cX0djTt6L3LezTPhFnhQZu7fmTPg
         TT/YYTRnUjSr/Aj1lsXKW5JJ4GQgrSgCC/6WbdMz3urK2HibOEkjw+kvwZFyPGfT9SWk
         dQ/rda/DhTG/s++FoUYr6YjAILrMJRtdfemo0UEDt32Nok6kR5iCdHAGcjOdyhTIiI9W
         brRW4BACZV2nKupEppzsab4F7KdtsU9rfVWziahYn1RA5kMWt4yuXPoIeU0LQ/MVvWAl
         KBAEncUnt9qiTAovNppZdSaS0I4J1sTFR+/cySQZwlFM2P3hV/mNHCzCOSFFd3fkyajR
         Om4w==
X-Gm-Message-State: AAQBX9dbt9LeQADELi7maDspu4yhSI5asT1ruJNblQeoV+q/RKBjbDuz
        bJPcUj2kvNQKLn5vIw3XX+wAqGhTnxrPN12rVBwvBQ==
X-Google-Smtp-Source: AKy350agdcSTlFPrX/zTWuBoJnDIGbjdL9TN+EIyeX7VNcmr6kT1/zeADYCZ/97dP0e4+0wS31kBNVA8n4iPoqL/YK4=
X-Received: by 2002:a81:b645:0:b0:545:7164:49aa with SMTP id
 h5-20020a81b645000000b00545716449aamr10324744ywk.1.1680125823734; Wed, 29 Mar
 2023 14:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1676378702.git.quic_charante@quicinc.com> <20230328155027.f0f7571bd430e7525481c6ca@linux-foundation.org>
In-Reply-To: <20230328155027.f0f7571bd430e7525481c6ca@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 29 Mar 2023 14:36:52 -0700
Message-ID: <CAJuCfpEznM+R6uG+-qYGy=CG=8OR2EthEjNObrWVRirRba2p+g@mail.gmail.com>
Subject: Re: [PATCH V7 0/2] mm: shmem: support POSIX_FADV_[WILL|DONT]NEED for
 shmem files
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Charan Teja Kalla <quic_charante@quicinc.com>, hughd@google.com,
        willy@infradead.org, markhemm@googlemail.com, rientjes@google.com,
        shakeelb@google.com, quic_pkondeti@quicinc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 3:50=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 14 Feb 2023 18:21:48 +0530 Charan Teja Kalla <quic_charante@quici=
nc.com> wrote:
>
> > This patch aims to implement POSIX_FADV_WILLNEED and POSIX_FADV_DONTNEE=
D
> > advices to shmem files which can be helpful for the drivers who may wan=
t
> > to manage the pages of shmem files on their own, like, that are created
> > through shmem_file_setup[_with_mnt]().
>
> Could we please have some additional review of this series?

The series LGTM but unfortunately I'm not a shmem expert. I asked
Minchan to take a look as well.
Thanks!

>
> Thanks.
