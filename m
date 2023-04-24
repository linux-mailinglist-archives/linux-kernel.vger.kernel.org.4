Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44CC6D42D6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 13:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjDCLDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 07:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbjDCLCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 07:02:53 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA2D12BC1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 04:02:19 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id i5so115866819eda.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 04:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1680519737;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0A9cBUe1CIhDzuQx2yGzHPxbDSN2uhcwM/gtEXwXGpQ=;
        b=MJ1S6YAr0p1+c2LTdnZvvwoMbkTpnzogcae4lkhzx2gf8L3f56zzQQwG1QWrzpcoRq
         FW1JQJF+XtT0V6/RzptZHqmbcMJa0PUc+eJg+SxYDoLb4cG8KIMhhFrX3msHleRkdH0/
         O23Cgt2jZJD5kZRvLh0hQYfM60GpTxxxqaS/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680519737;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0A9cBUe1CIhDzuQx2yGzHPxbDSN2uhcwM/gtEXwXGpQ=;
        b=zpjeKOz/m0YLAB4dSj24Ire2z0eEAUbAakbfr2CSwCOWnLCTzMUSCbI3Ktvqc3tU8S
         uC1YbpAean4lIB0C7ylXQ/5qtMXvFiFQfTSKNLd9Zno/A746jo0+cvulZFs6pBTkXzjU
         d9Z3vn3V1eBdcQ0vuk4JzuuNvpTNGickiEsLfRpWl966a4sKBiB/68KrEuDTRyO2oBvy
         5cnEMz3hbr/We1CXjAW5lOABXui8n3QaaJu2UnxyeHa4IAZlzpkOfZb8eYZt5UaVG2dF
         09r9M39cQuwP+GOE0CApDZbbXjhjinXoJKtujZDPq0OJ3+mteyrNJyNhyFswy4OG3HcC
         RAVQ==
X-Gm-Message-State: AAQBX9e3NSmt6C3gLHtx6CEdzHUs87ycInagVWgn+SVBltfZQZ8RZQDx
        RaePDJqPSr8INUPd8W/tYETJoJC9fxDEM0uEfr95aQ==
X-Google-Smtp-Source: AKy350a3CTDjvcE2j8ryyIGM7DAKEbV0Sa+8uvmTWhEPaKIjaoFbiqMUyLp4ecWNx1G7nx8HHCZ3848IOEne7HHt71o=
X-Received: by 2002:a50:f692:0:b0:4fc:fc86:5f76 with SMTP id
 d18-20020a50f692000000b004fcfc865f76mr17913135edn.6.1680519737334; Mon, 03
 Apr 2023 04:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230329180502.1884307-1-kal.conley@dectris.com>
 <20230329180502.1884307-5-kal.conley@dectris.com> <CAJ8uoz1cGV1_3HQQddbkExVnm=wngP3ECJZNS5gOtQtfi=mPnA@mail.gmail.com>
In-Reply-To: <CAJ8uoz1cGV1_3HQQddbkExVnm=wngP3ECJZNS5gOtQtfi=mPnA@mail.gmail.com>
From:   Kal Cutter Conley <kal.conley@dectris.com>
Date:   Mon, 3 Apr 2023 13:06:57 +0200
Message-ID: <CAHApi-kV_c-z1zf9M_XyR_Wa=4xi-Cpk1FZT7BFTYQHgU1Bdqg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 04/10] selftests: xsk: Deflakify
 STATS_RX_DROPPED test
To:     Magnus Karlsson <magnus.karlsson@gmail.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This has been bugging me for a while so thanks for fixing this. Please
> break this commit out of this patch set and send it as a separate bug
> fix.
>
> Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
>

Can I send patches 01-05 all together as one patchset?

Kal
