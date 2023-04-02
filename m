Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C285F6D3989
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 19:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjDBRt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 13:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDBRt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 13:49:57 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532EFCDD3
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 10:49:55 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id t10so108587744edd.12
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 10:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680457793; x=1683049793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twCPC0pauRSrcDGPcatZZnRn4es+o8hDMAtgf21b8Ls=;
        b=V1xjAwxIQpU+AKtTAqNqQTXZ5XTfQpwo4FJqpSfOxuxfMAijag35GXzem9qcwW2Grl
         137BTU5gvXiBbzDSEmPfs7+3Rl+4BFwl48XsV6MD8xvTpWZQeuvewmUgOrk/4OvhGu7h
         9gtsaSAf1ocKhC28eHJD8r8M9nHMnnaA6JnUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680457793; x=1683049793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twCPC0pauRSrcDGPcatZZnRn4es+o8hDMAtgf21b8Ls=;
        b=OlO2bYnFiYcihCrm5Uh1oKpJjg5CEbhrhESKOmKhlmZGaA/FE6BTkGXB0yZIgF8VsI
         TyTNbOLCd7b+HLHWmQK2N6e8NiMibAo/RYsp/qn/lSVK+u7koU3ZRErYZrGp5/WI4oUd
         Uy9dWmOZkNJhKSi/AgqEPOyff0W6dbEazg+1K/2FwUBGHnCWeWNUrzucTf7junfDh/ck
         VpPopp3Uz34shFHc6E8oolPl89DclrZ9B4EVQdJH9mxrs1M6AwnfbvWorjoQVMq7Qu50
         +SbuWDQGi5jgnp/fTq1aiK17Z3u/YDzKbWJqR+1F3Zf6Z/cDeWvPv4Z4XsRSvPcQSLaa
         CyuA==
X-Gm-Message-State: AAQBX9ekDnVCVgZlplUTRKlYyT796tHvIvNhQrXjsEwM4aUj3Xh4+s84
        lCPqHjn84uGOqaBD+hwx04UX7vq5w5CLgH5ZBSY=
X-Google-Smtp-Source: AKy350b2+3hF87s79kIJ9GoLgJWWsX4Ccqmn3V2yyFmuR9NWgkR8PGIhZUr/EDLwbCV6dLTbMF5sfQ==
X-Received: by 2002:a17:906:4787:b0:933:89a1:57e6 with SMTP id cw7-20020a170906478700b0093389a157e6mr42473101ejc.26.1680457793522;
        Sun, 02 Apr 2023 10:49:53 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id x3-20020a50d603000000b004c06f786602sm3483284edi.85.2023.04.02.10.49.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Apr 2023 10:49:52 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id r11so108770121edd.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 10:49:52 -0700 (PDT)
X-Received: by 2002:a05:6402:e93:b0:502:a4ec:a225 with SMTP id
 h19-20020a0564020e9300b00502a4eca225mr436161eda.4.1680457792538; Sun, 02 Apr
 2023 10:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <168045676522.992122.1074253542608037015@leemhuis.info>
In-Reply-To: <168045676522.992122.1074253542608037015@leemhuis.info>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 2 Apr 2023 10:49:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=whRs_MavKCqtV3=K31dq9Z6HzbaG8Uxo-EV=uRxdsXduA@mail.gmail.com>
Message-ID: <CAHk-=whRs_MavKCqtV3=K31dq9Z6HzbaG8Uxo-EV=uRxdsXduA@mail.gmail.com>
Subject: Re: Linux regressions report for mainline [2023-04-02]
To:     "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 2, 2023 at 10:34=E2=80=AFAM Regzbot (on behalf of Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> But there is a 6.2 regression that annoys me. It's one of the two in the
> media driver venus I mentioned a few times already in earlier reports.

Ok, something is rotten in the state of Denmark^Hmedia.

I've taken that revert directly, the same way I had to take Arnd's
build fix. Both patches from way back on February 7.

Oh well.

                   Linus
