Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8886B115B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 19:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjCHSuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 13:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjCHStr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 13:49:47 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96888BF8C7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 10:49:41 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id j11so50104465edq.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 10:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1678301380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBpRHgewt5MiGF66U0DT4BDVvT3+VXwPETbuarc5Zwg=;
        b=Sjxfr/ej//kTgJGRMe/M3L/gLgNtBP4o/m5i6MqR7sxC1C3k+CpEpLKMBm6vz/BTxE
         Ma98xQ9Tkiuq5oXzb3TCN2xTyTe+WnKOtphoszKuh6qdD5+J5FJROE56DrRb59xM7t4A
         jdjArJr2ZhajSDNWba82B+X6o4tHgh/ndvsHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678301380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZBpRHgewt5MiGF66U0DT4BDVvT3+VXwPETbuarc5Zwg=;
        b=wZyIKTD0FRHgGvrPJLOI3h+XfTzJo+bkX9drXS77Dsga6/TNTT4edAwdsadLlZJUgM
         8IfayFIa8egj6IyfLY03U+cgTEshxlNmXb84OqxG17N3XrGh0TSIs6/nGAGXvtGDk6Dy
         wVTuAaRTWFkyV7nn5e2OmiWSqARRiX3f2v4xF7pz8+iwLxNfQVpDpeRhwHzPwCCq0Z/7
         cHo/bNmPIZettMs1x4kfUcWs78oV4bM190EgZ+voQSjXPB5vrfN3yy1Gx1ifl9O2mQmL
         jN4jcfbsRogpV8C6Qr0FXhFb3ua99W93t0v46yGrkrNM3G0XI06bEo0QSn1zGwXnCjfi
         +Fcg==
X-Gm-Message-State: AO0yUKUFaHCLT5SLHHh08fRq1t9yX9jx47+MwuatJZRgzA+qp53AYdNx
        Y0SsSUXdfKpwHW7VJwlLIGf1BS7uAsniYmc7rdTdgQ==
X-Google-Smtp-Source: AK7set/qyO7vtNLdMRPF6aLaljYqHnMHV091vjuGk3W/YxMAjtRnUTvnqpz62SKCAK+Tbplr0yxdoqOETLcMoeEwBRU=
X-Received: by 2002:a50:d60d:0:b0:4bc:edde:14ff with SMTP id
 x13-20020a50d60d000000b004bcedde14ffmr10259842edi.0.1678301380094; Wed, 08
 Mar 2023 10:49:40 -0800 (PST)
MIME-Version: 1.0
References: <20230307172306.786657-1-kal.conley@dectris.com>
 <20230308105130.1113833-1-kal.conley@dectris.com> <4ddd3fe4-ed3c-495e-077c-1ac737488084@intel.com>
In-Reply-To: <4ddd3fe4-ed3c-495e-077c-1ac737488084@intel.com>
From:   Kal Cutter Conley <kal.conley@dectris.com>
Date:   Wed, 8 Mar 2023 19:49:29 +0100
Message-ID: <CAHApi-=C3ym23bBQ2h8BOyOfUtYXs9eZNG0Z8G2zfPeaEQWeRg@mail.gmail.com>
Subject: Re: [PATCH] xsk: Add missing overflow check in xdp_umem_reg
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The code is fine to me.
> Please resubmit with the fixed subject and expanded commit message.
> I'd also prefer that you sent v3 as a separate mail, *not* as a reply to
> this thread.

Done. I used "bpf" in the subject as you suggested, however I am a bit
confused by this. Should changes under net/xdp generally use "bpf" in
the subject?

Thanks,
Kal
