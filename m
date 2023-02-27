Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6EF6A428B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjB0NWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjB0NW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:22:29 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AB11F4BD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:22:19 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id d7so6424837qtr.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFR902szqybDFYZJoGK/JTKzMDtqfbypiZEZKZrJDLI=;
        b=GiRwuLspWw3ue+nBpguBSx+w4mxqKsGFo8jI3hvC+F0h39RFd889WmMoxZOJ5796Vp
         lFuZp+0ZlZujerH2fCWfOW6pAAEJcRukUmn03j4d6shjrVdLbl4mfYqjK3fdWHQnjfFX
         K2vM6wAyRDKtZ62VXt4uSbZZqxZPUnhKs5MgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFR902szqybDFYZJoGK/JTKzMDtqfbypiZEZKZrJDLI=;
        b=3IRgFCjsEAHrvIySi+5I6R6RG4AZ1zfy8GRmYNn47u+Ab05ilF6xtJPnAMdIZvzGvc
         DxMZ67I0cFHF3CMDrPANUdXjsYq+UVDXKgSUgYEHJIJA367NbXTfQSr+4XjL6cbk4wJI
         ppLuJ8RsdSJglpYbCmmlsjvLdu6hcBZc6Um1zey1EfdwkTjBBL+D7q2ga3RkOnjGjPaW
         +T3OZCj84Xs9JPp6jCVeJavJh8qjjG5cZNoFezZ2QGY0E6KeCEzYMf7vG94O5rZI6fT+
         b+fX8KrjojewOEtj85/e17PNHPz9Fcfghu7ZF1mM9Ab6AwBZVFkHMBRwowdcQ8djtLuf
         1d0Q==
X-Gm-Message-State: AO0yUKVHTsrCXJqEb0w9YcbihZBh4kvyVIxv60Ikal3urJba8Q9tvY3E
        wGXGFSdmdX3siRco4m62Qlim9Q==
X-Google-Smtp-Source: AK7set9x4SPLdiku5B6h0BkDzShNm1D/AK6nvLy5oS0IQCDDMkqk7ZxuU1S3gCtGOFZnbMmpiScz4Q==
X-Received: by 2002:a05:622a:1a90:b0:3b6:33c6:c5ac with SMTP id s16-20020a05622a1a9000b003b633c6c5acmr27180254qtc.4.1677504138413;
        Mon, 27 Feb 2023 05:22:18 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id v3-20020a379303000000b007429722e620sm3875184qkd.10.2023.02.27.05.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 05:22:17 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC v2] rcu: Add a minimum time for marking boot as completed
Date:   Mon, 27 Feb 2023 08:22:06 -0500
Message-Id: <764CA486-6FB2-4667-B8CB-56E3AC31FD58@joelfernandes.org>
References: <IA1PR11MB617175CA398D425B7489CE4889AF9@IA1PR11MB6171.namprd11.prod.outlook.com>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org
In-Reply-To: <IA1PR11MB617175CA398D425B7489CE4889AF9@IA1PR11MB6171.namprd11.prod.outlook.com>
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 27, 2023, at 2:53 AM, Zhuo, Qiuxu <qiuxu.zhuo@intel.com> wrote:
>=20
> =EF=BB=BF
>>=20
>> From: Joel Fernandes (Google) <joel@joelfernandes.org>
>> Sent: Saturday, February 25, 2023 11:34 AM
>> To: linux-kernel@vger.kernel.org
>> Cc: Joel Fernandes (Google) <joel@joelfernandes.org>; Frederic Weisbecker=

>> <frederic@kernel.org>; Lai Jiangshan <jiangshanlai@gmail.com>; linux-
>> doc@vger.kernel.org; Paul E. McKenney <paulmck@kernel.org>;
>> rcu@vger.kernel.org
>> Subject: [PATCH RFC v2] rcu: Add a minimum time for marking boot as
>> completed
>>=20
>> On many systems, a great deal of boot happens after the kernel thinks the=

>> boot has completed. It is difficult to determine if the system has really=

>> booted from the kernel side. Some features like lazy-RCU can risk slowing=

>> down boot time if, say, a callback has been added that the boot
>> synchronously depends on.
>>=20
>> Further, it is better to boot systems which pass 'rcu_normal_after_boot' t=
o
>> stay expedited for as long as the system is still booting.
>>=20
>> For these reasons, this commit adds a config option
>> 'CONFIG_RCU_BOOT_END_DELAY' and a boot parameter
>> rcupdate.boot_end_delay.
>>=20
>> By default, this value is 20s. A system designer can choose to specify a v=
alue
>> here to keep RCU from marking boot completion.  The boot sequence will no=
t
>> be marked ended until at least boot_end_delay milliseconds have passed.
>=20
> Hi Joel,
>=20
> Just some thoughts on the default value of 20s, correct me if I'm wrong :-=
).
>=20
> Does the OS with CONFIG_PREEMPT_RT=3Dy kernel concern more about the=20
> real-time latency than the overall OS boot time?

But every system has to boot, even an RT system.

>=20
> If so, we might make rcupdate.boot_end_delay =3D 0 as the default value=20=

> (NOT the default 20s) for CONFIG_PREEMPT_RT=3Dy kernels?=20

Could you measure how much time your RT system takes to boot before the appl=
ication runs?

I can change it to default 0 essentially NOOPing it, but I would rather have=
 a saner default (10 seconds even), than having someone forget to tune this f=
or their system.

Thanks,

 - Joel


>=20
> -Qiuxu
>=20
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> ---
>> v1->v2:
>>    Update some comments and description.
>> ...
>=20
