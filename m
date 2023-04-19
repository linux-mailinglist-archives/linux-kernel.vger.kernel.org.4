Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB976E7A5E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjDSNNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbjDSNNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:13:54 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0B1118F7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 06:13:52 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-5e5b5da22b8so5846616d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 06:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681910032; x=1684502032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRldcBVidDTHSdySyAJIkaPyXZDLrSYOn69E5Iym9mk=;
        b=bAbKIJTuPkk+qi/lN+WYch1K0c0RIuMw+qdV3TwUk/FfgMlrEOZXAcdY0ahZ5jGXuX
         T+E2yXekGP1/mtq0OiG5Ltc1eL14hJujvM5RQjLL8kzTCpRfNDEIC2DrIXd83war+CCX
         00Ss/pvGHb0UNIaz2ow4OfH3kEg8DR2fFjTyeDs98cPTijkxezravEiArPeJmWjCQLcA
         qvP2YHvcCozI8zkECl4Ne6ClOb/DSRKQ6aEm28/jZZ7zwIFjxBSDEhPN8pZcDgJsbz7Q
         d9l0+wGTC1g2blCw2IdWA675k+mPUr1ZZPbjISEfB/6RFERK8Hj/5HdtruEHJXsNfM4k
         C9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681910032; x=1684502032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRldcBVidDTHSdySyAJIkaPyXZDLrSYOn69E5Iym9mk=;
        b=AtEi8ZFeKJ6uHQwf4HgRJSXnwKFv4Ql3/p1Gj8ctZq9/MgWLFAnqUa7GoFrWMycyIE
         qJQkvDnlyXMx7Ubq63l4LXFRigOTeJEj1AaBq+RUji4q7lITAJU8rQSV3deYJQLb2L0g
         Hbcw3NC/VObzj2jR5Izkv3a07xtL3ZYGb4jaIcwbtuGaBeWdCQ054L4LBYJKx+6Gf1Z4
         itprRvv+8Sqmd/RzlfxfknmadnJ/9L0OUv+AkdbBS1u3qJF4wjSGhembDuRofmazYEzA
         Wh3ZoJYh8ZPajSN3sQcVjZpTYMyZXg4O7/H7H1vZoZG2zlYsBbDGJ+KeufkPFsIqnLDE
         PoqQ==
X-Gm-Message-State: AAQBX9dIC1L8YCBKFlnNXkkp/zjwTkDJ/IJxSCOsZ1ZliFYVBJVJS4EL
        e9SeP2KVO/UhOEge97ifzUbwFr3lQg3qNd9tE0A=
X-Google-Smtp-Source: AKy350Yb9EsEtVq4PNdlbLUqMmSHVv9A3Gx1fizcLz6axORlMx/dyNwjRt1zy+OUWREoLi0ZlXA2Ng9muqzj3+a4MuU=
X-Received: by 2002:a05:6214:d6c:b0:5da:b965:1efd with SMTP id
 12-20020a0562140d6c00b005dab9651efdmr27969461qvs.2.1681910031616; Wed, 19 Apr
 2023 06:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsPZxgpFzAVN=eFXu0WV+Jk0vB4rv4p+Jt31C841LcqV=A@mail.gmail.com>
 <CABXGCsO0sST8+MvQs=T1JP49ogRsaHPT9gMQZGJ3dY7v3m0H8g@mail.gmail.com>
 <CABXGCsOTEpJG_0NWdGXRvcXQ4iTav6AUJm-U4SQb-vVzjoL6rA@mail.gmail.com> <10b2570f-a297-d236-fa7b-2e001a4dff12@gmail.com>
In-Reply-To: <10b2570f-a297-d236-fa7b-2e001a4dff12@gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Wed, 19 Apr 2023 18:13:40 +0500
Message-ID: <CABXGCsPcPY8dqZm0aF4c1p0ZvMYHy+NksMrZi9xK0=WdE5_osA@mail.gmail.com>
Subject: Re: BUG: KASAN: null-ptr-deref in drm_sched_job_cleanup+0x96/0x290 [gpu_sched]
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <Christian.Koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
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

On Wed, Apr 19, 2023 at 1:12=E2=80=AFPM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> I'm already looking into this, but can't figure out why we run into
> problems here.
>
> What happens is that a CS is aborted without sending the job to the
> scheduler and in this case the cleanup function doesn't seem to work.
>
> Christian.

I can easily reproduce it on any AMD GPU hardware.
You can add more logs to debug and I return with new logs which explains th=
is.
Thanks.

--=20
Best Regards,
Mike Gavrilov.
