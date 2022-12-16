Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14A564EEA1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbiLPQJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiLPQJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:09:16 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A5D3890
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:08:48 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id c13-20020adfa70d000000b0024853fb8766so599256wrd.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IGoF+2jeK3IkIsvFOiLtqC8rk3aTOnFvuluK6bOOS/s=;
        b=V4uY+vWc/RMYG7pA2bA3dSUek6jo2HTpzw5kpwwq+9/ZdVNEH0gQvYNW5Or+TWCRky
         f7Y6/9Khiv+DoWa+oGa9504FjuzAI92zMsjPS/QFrXPTYs0St3aidPUdVqKijA3MwxGm
         smBZ3ZsJThu78ZkErPyhH5oUXvp8EvszZj2Czz6sYjakiEk8hBNLXgxpaypl9nppX52i
         qeKqRqG00MJ0oEX97SxQPzmlSeG+JJPzr3w32COM053OLO9ECwgeYq1V6zmkOIJ2MSCp
         bYyfMtxQdxIdSzuzl+oltMftHHci/r5R9LFEYrmoTyyDTPsgdhb6Sw8QIQAiTv43zm+P
         qrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IGoF+2jeK3IkIsvFOiLtqC8rk3aTOnFvuluK6bOOS/s=;
        b=3AyRNNHHc+BdufjO/cZkinLz70higGl9z64qFefTL84EIfix4qzgUmluJAXB3F08E+
         2XGSwfbeSgjyrj3YHDeBLnOw5Cf/9Ml7wl12l3otvDKnWVSpXODFEVhxd56dArsR2e0V
         To3NtzwhePP3i+GGZB/2/npDv3DnaE8eYu6ZCRMZVybPHfwoFGlORCx2wfH6DrSr2ZIR
         ahuTp5SMESwhPiA5WQJcko8SB5OI5m5zDIOJDHUppTufXMbEPMRAUwjoUuMcCjITu3Hn
         eZb8uHKvTFAZiPJcrf5uF49MXJp52vGAKVZ2SQpxItzd64OE0D+RS6P2GN6KZ5Xviof0
         1qrw==
X-Gm-Message-State: ANoB5pmkoVsbDnTscIJPfZ2zmboeM1Jr2kfmzj2nyNzxQsr71bVNsf5X
        bG47sgxz4BcylNohhzMj/hE9hOkZFf0=
X-Google-Smtp-Source: AA0mqf4hi3NoV2PPOPWSopZoCqtyNF/jAEb1brUqVVbG1TOeXQ0CqV0qCkQD1Dw23x5Qwh/tX8kvMwTXbDs=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:ad2c:4edf:bcb3:f7ae])
 (user=glider job=sendgmr) by 2002:a05:6000:146:b0:242:9e3:87ba with SMTP id
 r6-20020a056000014600b0024209e387bamr33632358wrx.580.1671206926247; Fri, 16
 Dec 2022 08:08:46 -0800 (PST)
Date:   Fri, 16 Dec 2022 17:08:41 +0100
In-Reply-To: <20221215162956.4037570-1-arnd@kernel.org>
Mime-Version: 1.0
References: <20221215162956.4037570-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221216160841.2061759-1-glider@google.com>
Subject: Re: [PATCH] crypto: wp512: disable kmsan checks in wp512_process_buffer()
From:   Alexander Potapenko <glider@google.com>
To:     arnd@kernel.org
Cc:     arnd@arndb.de, davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The memory sanitizer causes excessive register spills in this function:

> crypto/wp512.c:782:13: error: stack frame size (2104) exceeds limit (2048) in 'wp512_process_buffer' [-Werror,-Wframe-larger-than]

> Assume that this one is safe, and mark it as needing no checks to
> get the stack usage back down to the normal level.

KMSAN indeed bloats the stack frames heavily.
Wouldn't it be more preferable to further increase KMSAN's -Wframe-larger-than limit instead?
It is not intended for production anyway, and detecting a runtime stack overflow in the debug mode should not be a problem.
