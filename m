Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCF372ACA2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 17:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbjFJPho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 11:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjFJPhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 11:37:42 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C734A270B;
        Sat, 10 Jun 2023 08:37:41 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b1fe3a1a73so30588881fa.1;
        Sat, 10 Jun 2023 08:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686411460; x=1689003460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhK25wDVWu4aqu+48JlvJ7y91Ju+qS3b/ze2qAoWuAY=;
        b=NwOa64ru20yDlvD/Rf+X5uGDMHzdtXmWZzJR6U1TTGMkZF+yu1BMWrf7IaLi6JkIMo
         +bcRalU0ODH62O/wU/C69ExznFm7Xkn/9cJKdxDbwc+uTKjludHSrqW3dKRyzcQjvQvS
         v1fL27NT8M7lex5O5RTGaGtt1MZ/u7eG7DkKKT1HhV09R7hU/j48qQiti+LLIKhvXcZJ
         uAa2T//I0ESuwqKyxv7DZlTTTmte8zMFwoada1RKfNUVoIaO8JwlcEA3G3gKV62qgGrj
         fadNmcvpWlcnqxE/xc9cYt3zWVJlPiO0US56BuJT9Xs6nOWOgrhT2TAXUrh9HceXnXrG
         76iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686411460; x=1689003460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhK25wDVWu4aqu+48JlvJ7y91Ju+qS3b/ze2qAoWuAY=;
        b=Y0Xhvr/EXpfts/5IGwzsiJopunFDaX1pvZSDo3MEtxtSNW6mhj4vtnHKZCSmRgSnEy
         jgofrDLpGVyYp7OHBr8us9Sq7VVNjRvpvXIdzxTtc3mbLwg83jtpVVo5DOoewSXP1j0a
         D2Onmo73kqntUEmAeISTKz0+LAnFzdjXWoJ9HjddLDzUA8ZzaE35hj6xNiFAFK+tEeZZ
         puYhlu4rigIjNDX0bFf9rPk/oBEExwAlNeTaAjR/+b9jJ/2WBcqt2un8UNlXztHia+nT
         +EL6S6K4u3zg0IUw3MOZ8y284GTahlOeqHJOK9TjtzJiFvQKfVFuVpgk7Et+f8ijmVKe
         Yseg==
X-Gm-Message-State: AC+VfDziOfbf1VA3IgFVZ6Hj7U563pwv2/ARNHVF2GM867bUWIBN+zyM
        XMzxX8T1248frZOnBliR4Xi4qgC+dmXIJIgDWeCUDXy9xOs=
X-Google-Smtp-Source: ACHHUZ7CoYgOiJDpVDgrHqK0Xjx8aaTwpwH0V+Xh4d2mCJ+axjf7vfEejO7uIwiY6O5jp/aPWBEHrmngS6KAFALPD+k=
X-Received: by 2002:a2e:b163:0:b0:2b0:573a:3c69 with SMTP id
 a3-20020a2eb163000000b002b0573a3c69mr599762ljm.23.1686411459699; Sat, 10 Jun
 2023 08:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230610110518.123183-1-clangllvm@126.com>
In-Reply-To: <20230610110518.123183-1-clangllvm@126.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 10 Jun 2023 08:37:28 -0700
Message-ID: <CAADnVQLoDnBAhi+vOVL6+9KtLr30BLXptn0jtr3Sek2NmBTDww@mail.gmail.com>
Subject: Re: [PATCH] Add a sysctl option to disable bpf offensive helpers.
To:     Yi He <clangllvm@126.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
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

On Sat, Jun 10, 2023 at 4:21=E2=80=AFAM Yi He <clangllvm@126.com> wrote:
>
> Some eBPF helper functions have been long regarded as problematic[1].
> More than just used for powerful rootkit, these features can also be
> exploited to harm the containers by perform various attacks to the
> processes outside the container in the enrtire VM, such as process
> DoS, information theft, and container escape.
>
> When a container is granted to run eBPF tracing programs (which
> need CAP_SYS_ADMIN), it can use the eBPF KProbe programs to hijack the
> process outside the contianer and to escape the containers. This kind
> of risks is limited as privieleged containers are warned and can hardly
>  be accessed by the attackers.
>
> Even without CAP_SYS_ADMIN, since Linux 5.6, programs with with CAP_BPF +
> CAP_PERFMON can use dangerous eBPF helpers such as bpf_read_user to steal
> sensitive data (e.g., sshd/nginx private key) in other containers.

You can do the same completely without BPF and with just CAP_PERFMON.
I'm not going to share how, because you'll write a "security paper"
about insecure linux just like last time:
https://lore.kernel.org/bpf/20230117151256.605977-1-clangllvm@126.com/
Note, our answers didn't change. Look for security glory somewhere else.
