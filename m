Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5B46B9A90
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjCNQDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjCNQDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:03:13 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7933AB371C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:03:09 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5416b0ab0ecso184449317b3.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678809788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6YTlXkTcSY/lOWk5MFxXiktxYqqn/77NC3wi3iPQ7o=;
        b=iwOEnLdh8l5o8+zMmWNefw2TcVAWJdZwkuXbSuGVsf6Yii3dnuiV+X/BUGk4yIB73g
         UCMiJclXfbUq97SAbV71ro6OTPniDZDDz8GCCXe/P9iaQsbI/KUvlVWQ+fCJ7hnDAEcM
         ja/TuBSmFn+I4YHGxz93yxzaII9HiotlYnZRmatsGYbrO0xtuIYwiszim7pIDZIumQF6
         cNc/PjvKorq6a3zJyqK0oJI+F/cEGsdk9KyTgt9JJ7t/8Uca/vj3oA3JW9o/XUxRFOw9
         yAj6w39bk9lTPPUFbd3st6rm+ZyjJJgSBYYZ663+eNAPiJFQ0vCXzhYMyHm13RB06/C1
         +Arg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678809788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6YTlXkTcSY/lOWk5MFxXiktxYqqn/77NC3wi3iPQ7o=;
        b=UDKMsgDug6mGBbH3cSoagVcv/TEmeaD6IibQKhwVUZ/XmpJ7GRzljaE4cCtO6qXbbd
         AGNbGGT/WSwBVWov00aBjtnZIEsaTb5l4Y+m57/GntYx8LgTYnTMClaIpGjdezLF9/uY
         bIk2WC9lSbkNS2V4L1lvKskX9AriSorIbSyRkqlbrkkdWuf+W6dndrRluFbSdJmzSdbK
         8KnXqRk7j9hiZA0CTUKeofn+xpaLesz/M3b5AOXfKrf3CnKyuzwMpVJv8qylsZIU0rQF
         /PSv0M0wzkyPCfWHrh1cXDRbwkjFKAqNzWiTZISc/dSPQi07xvJ+19C+p1H5c7dkDhgi
         uqHw==
X-Gm-Message-State: AO0yUKUVnm29wh0ZL+f7OtrdMKDwhuc/rU66nHtBkI+MOyCMUsfypTU+
        iXt1r4MiuB+z19rVc7MXb81hMe8rLhpJZBqeyOvlPg==
X-Google-Smtp-Source: AK7set/FG4sRkcaSN3cSyLA5qL/1YpZ76JsEPYBQAEKJ5H0umEU4hT1QCqnSbDDR6G0qYWJzGbGYrMexvBc3G0S3MxQ=
X-Received: by 2002:a81:a946:0:b0:52b:fd10:4809 with SMTP id
 g67-20020a81a946000000b0052bfd104809mr26140095ywh.0.1678809788468; Tue, 14
 Mar 2023 09:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <a0734a6b-9491-b43a-6dff-4d3498faee2e@alu.unizg.hr>
 <d7a64812-73db-feb2-e6d6-e1d8c09a6fed@alu.unizg.hr> <27769d34-521c-f0ef-b6c2-6bd452e4f9bf@alu.unizg.hr>
In-Reply-To: <27769d34-521c-f0ef-b6c2-6bd452e4f9bf@alu.unizg.hr>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 14 Mar 2023 09:02:56 -0700
Message-ID: <CANn89iKi67YScgt5R0nHNAobjnSubBK6KsR9Ryoqu5ai4Opyrw@mail.gmail.com>
Subject: Re: BUG: selftest/net/tun: Hang in unregister_netdevice
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 9:01=E2=80=AFAM Mirsad Todorovac
<mirsad.todorovac@alu.unizg.hr> wrote:

> After a while, kernel message start looping:
>
>   kernel:unregister_netdevice: waiting for tap0 to become free. Usage cou=
nt =3D 3
>
> Message from syslogd@pc-mtodorov at Mar 14 16:57:15 ...
>   kernel:unregister_netdevice: waiting for tap0 to become free. Usage cou=
nt =3D 3
>
> Message from syslogd@pc-mtodorov at Mar 14 16:57:24 ...
>   kernel:unregister_netdevice: waiting for tap0 to become free. Usage cou=
nt =3D 3
>
> Message from syslogd@pc-mtodorov at Mar 14 16:57:26 ...
>   kernel:unregister_netdevice: waiting for tap0 to become free. Usage cou=
nt =3D 3
>
> This hangs processes until very late stage of shutdown.
>
> I can confirm that CONFIG_DEBUG_{KOBJECT,KOBJECT_RELEASE}=3Dy were the on=
ly changes
> to .config in between builds.
>
> Best regards,
> Mirsad
>

Try adding in your config

CONFIG_NET_DEV_REFCNT_TRACKER=3Dy
CONFIG_NET_NS_REFCNT_TRACKER=3Dy

Thanks.
