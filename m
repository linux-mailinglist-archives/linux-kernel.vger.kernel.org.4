Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3F36DE76A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 00:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjDKWmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 18:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDKWm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 18:42:29 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D010810D5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 15:42:25 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id e18-20020a17090ac21200b00246952d917fso8056883pjt.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 15:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681252945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0xO9Bx9i5tldfd7adzq3NuOgykDM+T3WB8seKN/9fM=;
        b=uKwy/ailVcOdYbsnJvdxytCFTrv0n9YS+0ARjJFB00iUjwbkqRfGDfF4iYzZ1iG9Kv
         82FGZ/RpThSY7QFxdhSjPl4N6pfaAYAQMd9Ex1gbWk6CB/OpsWHbkyHE5HbkBtCln6AE
         CCetfIcGqIF201lBE0Y2PEFqvyxG/rYdrihtSshNnCdmy+JT1Jp8YKvBWU+bzR94zy3Y
         gb0f4CVOuc7NI5ZIKEg3JU+1EpjqKZ28E3JxVlDdNU6OSXDzHwfO/rXmhyT3vdqjpb9S
         lWZdb+Ngq9YKJhhVvmPUq+K8pUbhytxE29NwfYYWpcUSUjgY+3DZpEWJQCeBrv1S5tuK
         3KDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681252945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0xO9Bx9i5tldfd7adzq3NuOgykDM+T3WB8seKN/9fM=;
        b=HCJqmtGLNIcwAdP8sejeLv+6VoWtYQFQTt6fd8nuULDT+TtmLxeobwlsOTcEwkULWV
         P0EHbo/BT8uDnnF8WN3kLqoRR0qyq0PEUvfuFRBJj+Fw4QON4Z2E0+UgB+5isprqXFPV
         hNrvzjYRgak8yxXQEfJMyjJMke+PNDTYrcodQo3Dn/oVhaTcpw9mNJI3aWEOnGj+tvss
         wUX8mv1pZK/lGgSGt9sF5Y5uFvR3wDuZ+m1vJFCjSspZcvGWX6HZ48O1AdfvHLiWmwiK
         kLbEp/yhO9LpFPYdInGkjqqOrae8UMMzAQS1nH3aE99y5bn3Lpbb/t/p8i9tPlXQw6tZ
         +Jow==
X-Gm-Message-State: AAQBX9dRT97wnr9CJsLmg+vwnkYoB+zE0FdHvBYkU0HYkWfHtW1oof+7
        83oxceuWxccMN0Khg1ouhDAlA9Mk4V0d+4wcILWScw==
X-Google-Smtp-Source: AKy350Yke3xHvPIcVDrfJDNbsXAC8S4tRog/pB48r6EGnMKgP8FWKKWc/STPyg9eHg7eVsBk44WhbqLGoyLPXsVzwRk=
X-Received: by 2002:a17:90a:6bc3:b0:23b:36cc:f347 with SMTP id
 w61-20020a17090a6bc300b0023b36ccf347mr3906797pjj.9.1681252945157; Tue, 11 Apr
 2023 15:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <168098183268.96582.7852359418481981062.stgit@firesoul> <168098188134.96582.7870014252568928901.stgit@firesoul>
In-Reply-To: <168098188134.96582.7870014252568928901.stgit@firesoul>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 11 Apr 2023 15:42:13 -0700
Message-ID: <CAKH8qBu2ieR+puSkF30-df3YikOvDZErxc2qjjVXPPAvCecihA@mail.gmail.com>
Subject: Re: [PATCH bpf V7 1/7] selftests/bpf: xdp_hw_metadata default disable bpf_printk
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     bpf@vger.kernel.org,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        alexandr.lobakin@intel.com, larysa.zaremba@intel.com,
        xdp-hints@xdp-project.net, anthony.l.nguyen@intel.com,
        yoong.siang.song@intel.com, boon.leong.ong@intel.com,
        intel-wired-lan@lists.osuosl.org, pabeni@redhat.com,
        jesse.brandeburg@intel.com, kuba@kernel.org, edumazet@google.com,
        john.fastabend@gmail.com, hawk@kernel.org, davem@davemloft.net,
        tariqt@nvidia.com, saeedm@nvidia.com, leon@kernel.org,
        linux-rdma@vger.kernel.org
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

On Sat, Apr 8, 2023 at 12:24=E2=80=AFPM Jesper Dangaard Brouer
<brouer@redhat.com> wrote:
>
> The tool xdp_hw_metadata can be used by driver developers
> implementing XDP-hints kfuncs.  The tool transfers the
> XDP-hints via metadata information to an AF_XDP userspace
> process. When everything works the bpf_printk calls are
> unncesssary.  Thus, disable bpf_printk by default, but
> make it easy to reenable for driver developers to use
> when debugging their driver implementation.
>
> This also converts bpf_printk "forwarding UDP:9091 to AF_XDP"
> into a code comment.  The bpf_printk's that are important
> to the driver developers is when bpf_xdp_adjust_meta fails.
> The likely mistake from driver developers is expected to
> be that they didn't implement XDP metadata adjust support.
>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> ---
>  .../testing/selftests/bpf/progs/xdp_hw_metadata.c  |   16 ++++++++++++++=
--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/=
testing/selftests/bpf/progs/xdp_hw_metadata.c
> index 4c55b4d79d3d..980eb60d8e5b 100644
> --- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> @@ -5,6 +5,19 @@
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_endian.h>
>
> +/* Per default below bpf_printk() calls are disabled.  Can be
> + * reenabled manually for convenience by XDP-hints driver developer,
> + * when troublshooting the drivers kfuncs implementation details.
> + *
> + * Remember BPF-prog bpf_printk info output can be access via:
> + *  /sys/kernel/debug/tracing/trace_pipe
> + */
> +//#define DEBUG        1
> +#ifndef DEBUG
> +#undef  bpf_printk
> +#define bpf_printk(fmt, ...) ({})
> +#endif

Are you planning to eventually do somethike similar to what I've
mentioned in [0]? If not, should I try to send a patch?

0: https://lore.kernel.org/netdev/CAKH8qBupRYEg+SPMTMb4h532GESG7P1QdaFJ-+zr=
bARVN9xrdA@mail.gmail.com/

> +
>  struct {
>         __uint(type, BPF_MAP_TYPE_XSKMAP);
>         __uint(max_entries, 256);
> @@ -49,11 +62,10 @@ int rx(struct xdp_md *ctx)
>         if (!udp)
>                 return XDP_PASS;
>
> +       /* Forwarding UDP:9091 to AF_XDP */
>         if (udp->dest !=3D bpf_htons(9091))
>                 return XDP_PASS;
>
> -       bpf_printk("forwarding UDP:9091 to AF_XDP");
> -
>         ret =3D bpf_xdp_adjust_meta(ctx, -(int)sizeof(struct xdp_meta));
>         if (ret !=3D 0) {
>                 bpf_printk("bpf_xdp_adjust_meta returned %d", ret);
>
>
