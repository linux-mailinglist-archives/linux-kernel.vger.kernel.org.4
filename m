Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419CB70FDE4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 20:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237343AbjEXS3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 14:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbjEXS3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 14:29:02 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0841C98
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 11:29:01 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-96fd3a658eeso184561866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 11:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684952939; x=1687544939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5lgPY1OhSwXtRY0LRAeuO9w0cAYukxFSoQE2BhbX5Y=;
        b=doTct/umbGJ2NGSZfavFJNaiYz8FxhaAljg6NSt6hs8auwjLpc/TxrPJioDpEdbWBx
         aXgmHEME3QkebZ0nmTGnXfR+gHhJlk9NoLlSkefmoipWILRsvUxicr4lfEQv9ry1RMgu
         JpAaVHi6V2YtulRO+hGtCPpcl1AaITS8SCXsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684952939; x=1687544939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5lgPY1OhSwXtRY0LRAeuO9w0cAYukxFSoQE2BhbX5Y=;
        b=VhjPjuh/vcMIN9FUJ1niNGnMVxmhBWwxesdUGpZxvkSeFr7YIaOFZqvWyRUb0NWgVp
         IHH5n378h3y331lBrII4uznQ3pQqfVtyzK8Y+uV3R8QNCkw392F3s8zlNxQ2/DK2vyTu
         PD64ICClLBvn6p9l4yFL5/5Fn5/IJBB1Zrup+SUis/G+AtaTj56nxg4QjrTq0tmy8HXo
         z8A5YzsuP8SAfHc3yLr+u+JwoIn1Iqqq3ZNSN8iHCZpQsN87XDAh6g7qsbluw+X/SAzN
         uHi9jxbtv5DWCFd+5tJfL9n+DOyeWhM1RIehWyCghL2vz4tSFsEjRm2ZAYgMK0mP0/Rb
         TJNA==
X-Gm-Message-State: AC+VfDwB6l47CNmPkR/uQk9cK1jTJ/7oqdGmDkENJEVqHPrZHXTdA/oq
        qssZmgQzgmtcwF6Fpu4H/b745ybRIHAw/1lZbtNzMVuv
X-Google-Smtp-Source: ACHHUZ5fKSiygDLIueGMjF/bl7hIjsYvMgr6eJTNilIwyIhzbucev5ZWe4IJTqtTBi5aP+RjdkTaAg==
X-Received: by 2002:a17:907:86a2:b0:96f:a39c:86d6 with SMTP id qa34-20020a17090786a200b0096fa39c86d6mr15106884ejc.8.1684952939342;
        Wed, 24 May 2023 11:28:59 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id qx15-20020a170906fccf00b00965f98eefc1sm6126279ejb.116.2023.05.24.11.28.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 11:28:58 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-969f90d71d4so183524366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 11:28:58 -0700 (PDT)
X-Received: by 2002:a17:907:7b8d:b0:92b:3c78:91fa with SMTP id
 ne13-20020a1709077b8d00b0092b3c7891famr20565714ejc.28.1684952938255; Wed, 24
 May 2023 11:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230524131200.0f6fb318@rorschach.local.home>
In-Reply-To: <20230524131200.0f6fb318@rorschach.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 May 2023 11:28:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNagW7exChQ4YuiRpCDN=kxmUdY5u7ebFux1jgEoL2tg@mail.gmail.com>
Message-ID: <CAHk-=wiNagW7exChQ4YuiRpCDN=kxmUdY5u7ebFux1jgEoL2tg@mail.gmail.com>
Subject: Re: [BUG 6.4-rc3] BUG: kernel NULL pointer dereference in __dev_fwnode
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 10:12=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> I started adding fixes to my urgent branch rebased on top of v6.4-rc3
> and ran my tests. Unfortunately they crashed on unrelated code.
>
> Here's the dump:
>
>  BUG: kernel NULL pointer dereference, address: 00000000000003e8
>  RIP: 0010:__dev_fwnode+0x9/0x2a
>  Code: ff 85 c0 78 16 48 8b 3c 24 89 c6 59 e9 e0 f7 ff ff b8 ea ff ff ff =
c3 cc cc cc cc 5a c3 cc cc cc cc f3 0f 1e fa 0f 1f 44 00 00 <48> 8b 87 e8 0=
3 00 00 48
>  83 c0 18 c3 cc cc cc cc 48

That disassembles to

    endbr64
    nopl   0x0(%rax,%rax,1)
    mov    0x3e8(%rdi),%rax
    add    $0x18,%rax
    ret

which looks like it must be the

    return dev->fwnode;

with a NULL 'dev'. Which makes sense for __dev_fwnode with CONFIG_OF
not enabled.

Except I have no idea what that odd 'add $0x18" is all about. Strange.

Anyway, the caller seems to be this code in power_supply_get_battery_info()=
:

        if (psy->of_node) {
            .. presumably not this ..
        } else {
                err =3D fwnode_property_get_reference_args(
                                        dev_fwnode(psy->dev.parent),
                                        "monitored-battery", NULL, 0, 0, &a=
rgs);
                ...

so I suspect we have psy->dev.parent being NULL.

>  I ran a bisect and it found it to be this commit:
>
> 27a2195efa8d2 ("power: supply: core: auto-exposure of simple-battery data=
")
>
> I checked out that commit and tested it, and it crashed. I then
> reverted that commit, and the crash goes away.

At a guess, it's

 (a) the new code to expose battery info at registration time:

+       /*
+        * Expose constant battery info, if it is available. While there ar=
e
+        * some chargers accessing constant battery data, we only want to
+        * expose battery data to userspace for battery devices.
+        */
+       if (desc->type =3D=3D POWER_SUPPLY_TYPE_BATTERY) {
+               rc =3D power_supply_get_battery_info(psy, &psy->battery_inf=
o);
+               if (rc && rc !=3D -ENODEV && rc !=3D -ENOENT)
+                       goto check_supplies_failed;
+       }

interacting with

 (b) the test_power_init() that does that

                test_power_supplies[i] =3D power_supply_register(NULL,
                                                &test_power_desc[i],
                                                &test_power_configs[i]);

which passes in NULL for the "parent" pointer.

So it looks like a dodgy test that was a bit lazy. But maybe a NULL
parent is supposed to work.

                Linus
