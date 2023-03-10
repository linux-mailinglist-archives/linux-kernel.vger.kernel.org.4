Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13A46B5487
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjCJWfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbjCJWfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:35:32 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C89412C0D5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:34:11 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id i6so6786434ybu.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678487632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEqMrbXf4+0rUojKZeV+/yCgoA9VPbTp19zx2WV07vA=;
        b=VN0pAvf6sUR96XBRDOxcDOZzkuEPTsnPMpkOyW6+8hPj8X4JptdaE1YRuDIt0EMzfD
         2gCGWpVzyOrFNtwUNTQ5sBb7vTQChtr6KBWLPMTfxRmQnZw6Ig1o/0SgoSSg+diKNYqA
         ZeKx75DxgneqlCWpeFSYarvBkULxvZvafnsaqMftPasaarzi31PUcFrxWsr8UKqN1qRW
         q2NocXpN1ipmKP39HLfVP12e7Lzjl+uoNTnxf0zsmV+YQk6iOp8dspJM3L6MhOKWkAtX
         ATmgiB9o/H6LBE4Nq2Ddm4ESKPwwIcCvrPVV25Q1sW47raVXVzW6RAdSpcfYmvjB8FFO
         hTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678487632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEqMrbXf4+0rUojKZeV+/yCgoA9VPbTp19zx2WV07vA=;
        b=nSWVrVx3g3H2PqMEIU0YdDCqgFQ5pbrsgSTl0deifTBjpZi8KBnp0ek226aaHEagm4
         60s5siRD+yEAioR2mz3WIzD/LYGjlU2zNVsKyQkRBX+0KZegsFbgviIqOPcriem8I2be
         Etc8/o2JCZsm3dMGI3zAWElVv1R3FKtF0lKWvLSzFyoucdg34hsMqVWJpvnEowWy/n3N
         /nrLVTR+Jfal7o/qpdVwlXa2gh1K75LR0qAXQOx3WtJS97QK7lOKKDaA//R4oj2+UwAK
         nEA6lGTug7cB1bLKJcdQPjBgh5cLzQFtBmRhssZSCWKH+/vR3WY/ldH2oeDFuNc+WbDH
         dVkw==
X-Gm-Message-State: AO0yUKWJ24vaXMRTxGQkTGb4eHu2wj/kRq5ifR9d7w6VtJHVVFepd8zy
        iZy72y29Jju0T7Afh8ALjEqdkwIK23r1INAet6N/
X-Google-Smtp-Source: AK7set+T1Mnofqh3OrYW6OYLxLKBqekqP7LDRV8/1bf8W8w0FxiAqHqDBOusMIPzCxxXySZQ/lR8YBEQgQYMfvo/8UM=
X-Received: by 2002:a5b:f87:0:b0:b30:8d4b:230e with SMTP id
 q7-20020a5b0f87000000b00b308d4b230emr1663841ybh.7.1678487632489; Fri, 10 Mar
 2023 14:33:52 -0800 (PST)
MIME-Version: 1.0
References: <20230310192614.GA528@domac.alu.hr>
In-Reply-To: <20230310192614.GA528@domac.alu.hr>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Mar 2023 17:33:41 -0500
Message-ID: <CAHC9VhSzppHevG_Td+hKU4KRSDgV_NYf2RSeKA06PR-rD+dJLw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add destructor hook to LSM modules
To:     Mirsad Goran Todorovac <mirsad.goran.todorovac@alu.hr>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Frederick Lawler <fred@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 2:26=E2=80=AFPM Mirsad Goran Todorovac
<mirsad.goran.todorovac@alu.hr> wrote:
>
> LSM security/integrity/iint.c had the case of kmem_cache_create() w/o a p=
roper
> kmem_cache_destroy() destructor.
>
> Introducing the release() hook would enable LSMs to release allocated res=
ources
> on exit, and in proper order, rather than dying all together with kernel =
shutdown
> in an undefined order.
>
> Thanks,
>         Mirsad
>
> ---
>  include/linux/lsm_hooks.h | 1 +
>  security/integrity/iint.c | 7 +++++++
>  2 files changed, 8 insertions(+)

I only see the 1/2 patch, did you send the 2/2 patch to the LSM list?
If not, you need to do that.

--=20
paul-moore.com
