Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C81C7238F2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbjFFHZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbjFFHZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:25:42 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA057118
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 00:25:40 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-516500163b2so3919a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 00:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686036339; x=1688628339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPF+WpuL/xMCwBBFd9KfvVcmMNsxJhns9XIqBZO560E=;
        b=vLCNinj2bEM3FiVvrF/+x6nnhxhsO2BexYOlk0TYTqVU1pdo6ehqugnwMzm+flncxE
         Xgivpff83CkWgjw5Yr4E+3sOZS9dOXm9kTAcNulD4GFFGABE2Ja1DPECchnPfua19lWE
         cJAipQrKli7eKLYQfk0+Wq6ZfWeJ9LfU1icWC+BDyzRkB65gqFcr68OpTSGWwOTb8pwn
         HhEtSqBxvkOmPk+SnIdzDRfOXFUCYYvd934pGHrHbY8+njJdtqqaFH86MTraC4imLDAo
         pOSsDUSSlcBDnJshzC8h494xp5XgEMHBiW4XpcZFMxOU+0WMXIgNGQekjFrsrPwdbMCB
         II+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686036339; x=1688628339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPF+WpuL/xMCwBBFd9KfvVcmMNsxJhns9XIqBZO560E=;
        b=khtD08v+f8oRfEzwIIT0atFwhkAlQwgIuf+XBkl/6HR3RyHuCQ53kyAdwF5/MBB7zH
         HjrkWP4jmkKajWHksMzUZ5dQSk1Cv1owIn1CJNctnwziXPWErcHaoCGG7YfsDTf0KFDP
         28ju72EMakmX10VRt5i89mxf8pnYQmng6ErurxbgKI7GWD6sEinl/gaTrRUBZicSCb7C
         8HAI2xQ1JiU6lq3kp8RgoBUcu+ZYypxsOunT3oia1bvkzWjD4KRXm2K4HzZdLv227rl5
         b2VJHs5AmYK4xXLKPygLWyVV2T8uKMFjqniQylvjG/oWsQz3SEVqZUhLWqkqLQ2oVwqB
         3HJg==
X-Gm-Message-State: AC+VfDyay2uW4bYVYOSP2+tE6saO5Va8crDcr7JmKkU+gboDb+mKDfFa
        kPKKBqJt3cTrLhBREEo+FFmYZh6NVENjxl3TAMFeWQ==
X-Google-Smtp-Source: ACHHUZ5cNWPcjfKtNsWJhyYQNP1iFI2GeXmicW0H038wrAq8eY23NWpbpreszixWFZT3nZYRnOXHRyz7ztoUdKIqRsA=
X-Received: by 2002:a50:9f05:0:b0:50b:c48c:8a25 with SMTP id
 b5-20020a509f05000000b0050bc48c8a25mr108937edf.6.1686036338998; Tue, 06 Jun
 2023 00:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230601160924.GA9194@debian> <20230601161407.GA9253@debian>
In-Reply-To: <20230601161407.GA9253@debian>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 6 Jun 2023 09:25:27 +0200
Message-ID: <CANn89iLA0Wo4nHKHWatGKAoRXktG64HWbkDACuoFGYw3KHPhew@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] gro: decrease size of CB
To:     Richard Gobert <richardbgobert@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        aleksander.lobakin@intel.com, lixiaoyan@google.com,
        lucien.xin@gmail.com, alexanderduyck@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 1, 2023 at 6:14=E2=80=AFPM Richard Gobert <richardbgobert@gmail=
.com> wrote:
>
> The GRO control block (NAPI_GRO_CB) is currently at its maximum size.
> This commit reduces its size by putting two groups of fields that are
> used only at different times into a union.
>
> Specifically, the fields frag0 and frag0_len are the fields that make up
> the frag0 optimisation mechanism, which is used during the initial
> parsing of the SKB.
>
> The fields last and age are used after the initial parsing, while the
> SKB is stored in the GRO list, waiting for other packets to arrive.
>
> There was one location in dev_gro_receive that modified the frag0 fields
> after setting last and age. I changed this accordingly without altering
> the code behaviour.
>
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
