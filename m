Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411B96BD273
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjCPOek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjCPOei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:34:38 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3EC26CC4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:34:36 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id r4so1099924ila.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678977275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAXWkVDijxnw2BDTwVeUZ4B+Od1pD8xCW/YRafFMsJU=;
        b=nafsOBQrgAeDjmhzAa3RWIu67XeXwovRzAk7PkcUeHJpxz0XJLAeW8a4UDtlKpmPN1
         EhtqVsoWOZqA58hPAgG1StYx/Mbn08riarzBIp88ANPXhvicUjD+o2fWY08SIdYUMqOL
         vuEbd7H8piGSI5use8wYvfrSH/Ns9vHXjyNCNXRU7V4yAA49Py1LHxXptbFNKs93Kplk
         UOhWYxfwzdbfMZUv5l44N3wOq86YD4U34gldlV9MEk7RQE+QSh0ptNidpz7SUJx+ivpw
         7nxx3IpCs0tsaiZ8u6pDWrUDSApZsMpC2fYsM0U8bMNWSAEZ0jnSQBDYTp4slosNHJOV
         WQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678977275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZAXWkVDijxnw2BDTwVeUZ4B+Od1pD8xCW/YRafFMsJU=;
        b=gAdzuU3FfJ6ajaV1UrJroB0nHmu7qOsXxQMje2mWWDisakpNmrNXnIr6FNWFSmbIpo
         WtM6W0ESmeO/9yX8geOkUHN3vXYZ08NzDa7wg7bi0g+qcS8mICMXxEAstYXjH+/ejRHl
         DrK0KFeRhTbKk9B6kU69yGEklClu/PgRgasmOZclTFc0auz5SzVm7Yb3hS/7mIXvrWYs
         clHYi0sHSphEpiDl5weNyYFKq9Fk4+M6+Ps9HxhZPhh8DbBo12xaLON2NAP206cmO9QW
         5yN15Iqf7bnpqG380FHPy3tfjENhrJSuqX9B4XN14MNmGzJir2nJFaZ99iEBC4qicCkU
         2gjA==
X-Gm-Message-State: AO0yUKWxFZyGSA+lkeeDeJhf4OZrr4h5XDCbfWLMiaUhVTBXQHUvF7bc
        g4PKKwCxtY9E+/LNNFsn23A2HLOSaW4md7s8DWO25g==
X-Google-Smtp-Source: AK7set+ZRIT9jTyEnUmdriZuyK50X2UU90r0LFKB4vGV21A7kWzGKFjMUSV742r7pSxpfK3az2/G+z57mnfWfLNZTMk=
X-Received: by 2002:a92:c542:0:b0:314:b2cd:b265 with SMTP id
 a2-20020a92c542000000b00314b2cdb265mr5097853ilj.1.1678977275331; Thu, 16 Mar
 2023 07:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230316131526.283569-1-aleksandr.mikhalitsyn@canonical.com> <20230316131526.283569-2-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20230316131526.283569-2-aleksandr.mikhalitsyn@canonical.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 16 Mar 2023 07:34:24 -0700
Message-ID: <CANn89i+s7TG4jqC1qanboKff=-DRmDjB-vEkoLKbEDwv195ytg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] scm: add SO_PASSPIDFD and SCM_PIDFD
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-arch@vger.kernel.org
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

On Thu, Mar 16, 2023 at 6:16=E2=80=AFAM Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> Implement SCM_PIDFD, a new type of CMSG type analogical to SCM_CREDENTIAL=
S,
> but it contains pidfd instead of plain pid, which allows programmers not
> to care about PID reuse problem.

Hi Alexander

This would add yet another conditional in af_unix fast path.

It seems that we already can use pidfd_open() (since linux-5.3), and
pass the resulting fd in af_unix SCM_RIGHTS message ?

If you think this is not suitable, it should at least be mentioned in
the changelog.

Thanks.
