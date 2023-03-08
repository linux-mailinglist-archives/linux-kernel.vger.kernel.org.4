Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF756B045F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjCHKbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjCHKbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:31:12 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E269B95F5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:30:35 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id ff4so10796526qvb.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678271432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIIXmoaoZ2cbg5syPX+iagmSH5eLIxghMqLgfdresrM=;
        b=GkdzxzBuvM11CVaZf+28wtzXhwqDTZMtiU+AQxw8EGHiKa5frXUqsvzL0Cmy7NzC9s
         VylIWDwYtJpFWKxIJxXqpC02AWb4cKC6q6Mlh4lEujJ+IjSlzkSmCVySG/qbO3mpXrS5
         PhUPio0xQpbmJXWNNvK42EaWF06TvZersDk2HXoJVzOfWF8F9sJff9PJbbfKF0RPUvgk
         rSZifiQOomQJTmJ0lyZmU2ZI5jt+cjUBPXhiKOxYyzRxAP5IbM/GdGIYqWlXWfELh7bx
         pK0coGjFj+FQWvVd+yZzUh8IcsMGIXZrIUMYlpxRoBoj0JahqqHCRg8/jqZ3JgYSbG7F
         5gUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678271432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIIXmoaoZ2cbg5syPX+iagmSH5eLIxghMqLgfdresrM=;
        b=BDLKGHzb4wUZkUn+d9niHi+4UOw8qOu9vNVuqWHKhrU0KRfZKzaYnhf5FKtv4W112R
         fToqjazou5+nU2SuCuOG22JZJPrlWhEyzqTaqcz4ZExFz46Dd4VrxPDL072UUiNtB4V5
         bFp9leDXzuFiMQ+GA/g8ScqQXEcJTyz6Qa/lDiAgRjnKAwfH7LMzQ5tJnwM1S8IF7rZL
         SuyzK6nxrC466Xp/P1zZ95oUE4DzfNdal2E5Ec5YAi898xAl5uvSc9zI20kZZPvL/pdK
         Tme2om2wJdnusfliOvMp0PMiqJjf7QufnxIUEKVegErGamBvUJrOwd0ZqoIUPLZMUH8g
         wtNw==
X-Gm-Message-State: AO0yUKXHeSQcYNLPiSbIvndWBUdir6RBlmXm3U35lIBAO69/rXPMo6tq
        Erg1XmbeqVL0vfexrnuTsDIHbismD2P7dmosfH5OnA==
X-Google-Smtp-Source: AK7set/TsUg9QUZT5R1x5V3XpvnjRnxQEc0Dg8JHiwwFzQtnB4XsQdffeMF2xgS19+5dFw1vAJw0BNGhuu/L9TZIVdw=
X-Received: by 2002:ad4:58c1:0:b0:56e:a066:5016 with SMTP id
 dh1-20020ad458c1000000b0056ea0665016mr4476607qvb.5.1678271431834; Wed, 08 Mar
 2023 02:30:31 -0800 (PST)
MIME-Version: 1.0
References: <20230113175459.14825-1-james.morse@arm.com> <20230113175459.14825-8-james.morse@arm.com>
 <678c5d45-eb91-c000-76d6-7ed9341e52c3@intel.com> <4002faaa-d93a-0d9b-0234-05bfae3d7b93@arm.com>
In-Reply-To: <4002faaa-d93a-0d9b-0234-05bfae3d7b93@arm.com>
From:   Peter Newman <peternewman@google.com>
Date:   Wed, 8 Mar 2023 11:30:21 +0100
Message-ID: <CALPaoCjP4Zx9-QUOJwZEQ_5acFhgkr+9TND3mqUvefQmgkbqCw@mail.gmail.com>
Subject: Re: [PATCH v2 07/18] x86/resctrl: Move CLOSID/RMID matching and
 setting to use helpers
To:     James Morse <james.morse@arm.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Mon, Mar 6, 2023 at 12:32=E2=80=AFPM James Morse <james.morse@arm.com> w=
rote:
> On 02/02/2023 23:47, Reinette Chatre wrote:
> > On 1/13/2023 9:54 AM, James Morse wrote:
> >> +    resctrl_arch_set_closid_rmid(tsk, rdtgrp->closid, rdtgrp->mon.rmi=
d);
> >
> > This does not use the intended closid when rdtgrp->type =3D=3D RDTMON_G=
ROUP.
>
> Yes, it should be rdtgrp->mon.parent->closid.
>
> rdtgroup_mkdir_mon() initialises them to be the same, I guess its Peter's=
 monitor-group
> rename that means this could get the wrong value?

I noticed this earlier. The next revision of my MON group rename patch
series updates rdtgrp->closid to that of the new parent so that for
MON groups, rdtgrp->closid =3D=3D rdtgrp->mon.parent->closid continues to
hold.

It looks like rdt_move_group_tasks() assumes this, as it always sets
t->closid to rdtgrp->closid.

-Peter
