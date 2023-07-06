Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA3D749E34
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbjGFNxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjGFNxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:53:04 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE711BC2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 06:53:03 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-401f4408955so247731cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 06:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688651582; x=1691243582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qXU7DJbvjvp8NOnfG/RtU8czB/tGMFzNKlo2sF77yk=;
        b=nkmLRa2pG3dc3VLFpHILMirKPgPoNY54hkVz8PeM2OoGejIvRWxpwCptjKTq4O0dTc
         Z08GqFf4YHbLuk4dVrCBmJjJ/1gIt+3hgBmmVd5bY0THo+Sv+F54hp68Uut0lusV4GJk
         nncuaqjV/mMdCpBmZSAmnPTECnwJQlAlBv8IyouM8Cw/Qo8g4wTRY/+MWYGA/LEi06fH
         j2XgvciunqOPOWcdHS20kC2P14BEuTlAeJov9u4QyBujIknokgyTANi73exvzQseF8VV
         IdQK1NaF9ijSCGleRo5pLVWeQj32eohJRe7w0ipkYCMVK9H1bDflBGf5ShY5F9RbqyED
         9MvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688651582; x=1691243582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qXU7DJbvjvp8NOnfG/RtU8czB/tGMFzNKlo2sF77yk=;
        b=Mc+dKHc60dur/ZYorMId/FFpK0vr3mbOHosDM/DflWUVZiXpaPzl3Yo5AiPzyAIAfB
         5tdAjKBP4hETOy71Pfk5eSVjoFD6b6ZPtcOVzKQNSR+KA3zCTm1CbNgONCgvpZBvQT9j
         eIn7BOITWuN0xTbb8GG7E6rpGzNaH/VB6ubhZBonvQ42WLpu1Tzdzvkz0NwAt4fE0ytS
         NWmWzPlHEOXMuBHfgk6tMjA2GRf2m9qT50Ldsjlzqm2GAbnJ39cp3LasmvGbZ8a13bGb
         fWoMbE19Iav8k2WdGQD7va6wIJVl3vEDpdm3NwQWhmnlXONEf/FGnLGj/Yi5YO1OE2oQ
         2PNg==
X-Gm-Message-State: ABy/qLbmub8zPCmJhF7sSCogg6Rvki0MDAEEG69KyYQtSHrGTMjv3Bcb
        FlEGOqtQ849Hu12pKjk3y2S/03WDUtI9FshlvWzmjQ==
X-Google-Smtp-Source: APBJJlFALeU9HSen3KdmHCQrxo9kEwHDHomQmFVFUZWi0ZAX+HQA+FZala5YK6bqPhBOMR+kOF2CDd4kL0r6xVne0pE=
X-Received: by 2002:a05:622a:1789:b0:3e0:c2dd:fd29 with SMTP id
 s9-20020a05622a178900b003e0c2ddfd29mr212250qtk.4.1688651581998; Thu, 06 Jul
 2023 06:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230706130800.85963-1-squirrel.prog@gmail.com>
In-Reply-To: <20230706130800.85963-1-squirrel.prog@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 6 Jul 2023 15:52:50 +0200
Message-ID: <CANn89iKxGVDQba1UCbpYKhNo=rZXuN2j=610DbJx0z=kWa7N3w@mail.gmail.com>
Subject: Re: [PATCH] gro: check returned skb of napi_frags_skb() against NULL
To:     Kaiyu Zhang <squirrel.prog@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 6, 2023 at 3:08=E2=80=AFPM Kaiyu Zhang <squirrel.prog@gmail.com=
> wrote:
>
> Some rogue network adapter and their driver pass bad skbs to GRO.
> napi_frags_skb() detects this, drops these bad skbs, and return NULL
> to napi_gro_frags(), which does not check returned skb against NULL
> and access it. This results in a kernel crash.
>
> A better approach to address these bad skbs would be to issue some
> warnings and drop them, which napi_frags_skb() already does, and
> move on without crashing the kernel.
>

Certainly not.

We are not going to try to be nice to buggy drivers.

Please fix the "rogue network adapter" instead.
