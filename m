Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72946C1A13
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjCTPoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjCTPoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:44:13 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5204A21972
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:34:55 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x3so48303599edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1679326489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gev+lmTSygz71wO6A6cNgtj4LSfVrLddOXwraPWxX2c=;
        b=EgUCBDYYrWJ5uO3T3dPxpCLgj6ldA9iqzSVSSnyLEPMFRBGzlbSwKaNXuLT1kwwMDD
         WYsOYVmlR3FknZMj+rIWX/vZ7lkujwgz3kV3O1G++PNMj+H24ZqMjSO269ShhpoiD9pH
         Ime1XpUSigSDSAbS/eH2zQ4WfbpCVDKjA83jOw3+YcOzcfIJwNDqcd+GzhURUgmFsdRZ
         IjyKkNSVtViPm/1xdRhRss1rW3drQMuh4hQ1+eWYNtXzbg2hR7pRJexI7OXIlyOLTo/O
         6CMa1Tio0W2f+U8KSTx36GZd2zyueusC6uuwVeEE5xI5xyoDmAV3XzhfhNvsdwvUVQfH
         GugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679326489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gev+lmTSygz71wO6A6cNgtj4LSfVrLddOXwraPWxX2c=;
        b=g05PBQOeWda5zNKQQ/HyZeL71zkXDTtVUejBSM7eJQUzsq+cDm5eWAx/nUKzh8PzOJ
         +75RQYd6uG+SQryIrvw/1a5b0OIUq251VLtfiYK5YDFB0UmI/UGLYdA0sy/tEV9VvC23
         ScfE3zCqOBuzIO6/KZDaK5MLLgIR+YowNVIghZIkPNufT1U1VFEZHnzBib2KYdVt37aw
         Vo5AIWaz/XIze2UegZEmf5tiz6kar6WaKItzUN6k9Gb8uM91u1wfOBWeCqu2iHvAWejC
         GyeAB9g+QDvzVRBHwHgkoOnYHlKFmLDp6Zkn2DXhfZe3+Yvb+vQzgAevgNPWSdhScs/z
         KVJQ==
X-Gm-Message-State: AO0yUKXtoFnamsuv0SxueaGUNku7ckUcP5+bLtwC/hCF3JTgk6EUQ1ql
        TsIgCIea/BE7GmIE6DXk6gJJwwUXQCw2N8yBJMacwQ==
X-Google-Smtp-Source: AK7set9t1GSZQvLjwHP75VPWyy4c6sXRoX5WbHLyQmpI3SxhTwuy82upwft7ydf/sZudpjbyLo4B7u6+zU0Qc1Y/V0g=
X-Received: by 2002:a50:d594:0:b0:4fb:7ccf:337a with SMTP id
 v20-20020a50d594000000b004fb7ccf337amr6576541edi.3.1679326489177; Mon, 20 Mar
 2023 08:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <af0a1f2194fc9a6f8a95cf6c82277b8b0377d029.1679311226.git.geert@linux-m68k.org>
In-Reply-To: <af0a1f2194fc9a6f8a95cf6c82277b8b0377d029.1679311226.git.geert@linux-m68k.org>
From:   Caleb Sander <csander@purestorage.com>
Date:   Mon, 20 Mar 2023 08:34:38 -0700
Message-ID: <CADUfDZocrTZq2MPKFFNuJc5yBabG48EiEURwn7-t2UBuVZxCWg@mail.gmail.com>
Subject: Re: [PATCH] nvme-tcp: Fix implicit padding in struct nvme_tcp_term_pdu
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Arnd Bergmann <arnd@arndb.de>, linux-nvme@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nvme_tcp_term_pdu definition needs to be updated anyways to match
the spec. FEI is at offset 10, so it isn't 4-byte-aligned. I think we
have gotten away with this so far because the NVMe/TCP driver never
sends H2CTermReq and doesn't interpret C2HTermReq.
Mirroring numdl/numdu in nvme_get_log_page_command, the definition
should look something like:
struct nvme_tcp_term_pdu {
        struct nvme_tcp_hdr hdr;
        __le16 fes;
        __le16 feil;
        __le16 feiu;
        __u8 rsvd[10];
};

Best,
Caleb

On Mon, Mar 20, 2023 at 4:29=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> On m68k:
>
>     drivers/nvme/host/tcp.c: In function =E2=80=98nvme_tcp_init_module=E2=
=80=99:
>     include/linux/compiler_types.h:397:38: error: call to =E2=80=98__comp=
iletime_assert_723=E2=80=99 declared with attribute error: BUILD_BUG_ON fai=
led: sizeof(struct nvme_tcp_term_pdu) !=3D 24
>
> Indeed, on m68k the minimum alignment is 2 bytes, not 4 bytes, thus
> triggering the check added in commit 7e87965d3807ab1f ("nvme-tcp: add
> nvme-tcp pdu size build protection"), and indicating that NVMe over
> Fabrics TCP on m68k must be incompatible with other platforms.
>
> Fix this by adding explicit padding.
>
> Fixes: fc221d05447aa6db ("nvme-tcp: Add protocol header")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  include/linux/nvme-tcp.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/nvme-tcp.h b/include/linux/nvme-tcp.h
> index 75470159a194d97f..ba8f82672e39730f 100644
> --- a/include/linux/nvme-tcp.h
> +++ b/include/linux/nvme-tcp.h
> @@ -115,6 +115,7 @@ struct nvme_tcp_icresp_pdu {
>  struct nvme_tcp_term_pdu {
>         struct nvme_tcp_hdr     hdr;
>         __le16                  fes;
> +       __u8                    rsvd2[2];
>         __le32                  fei;
>         __u8                    rsvd[8];
>  };
> --
> 2.34.1
>
>
