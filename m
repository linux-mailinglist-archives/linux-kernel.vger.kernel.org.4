Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62620750C49
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbjGLPUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjGLPUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:20:05 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52371BFF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:19:39 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31297125334so603495f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689175174; x=1691767174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r2jUmgPJMl8rNeDpH2GLcq5ImDgq36YmUU+/0NveM+c=;
        b=UCdooMkEYlmcH+/GKIRSljMulWWBGH63TzM/BqZq9bgBjr1sGdLtosqgSUbGCEEzjo
         m7W1rk+X2V7pObvBjCST9USZDZ5VZF/1RBl6O41iXhaR275YmFfzJ7OtCj9+nRp6HPpB
         lQKhDg1TWTYDRWOHVa4pcjQipoboO9GFErVfWepMof3s3AdkSb4H2ijilhUpquOCL/j8
         MaAri8u5ZsVQ/TDcX2sBvarXUp79ENwuv8db663JxWVAKpMFUmOSzeTPvTMknpoePoN8
         dDBfTTtozC5DV89B74cZ4PLVjzfWWLaW2gHahea6422LmC6nGJCjgvwjuqRrEtJ/ghj5
         kDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689175174; x=1691767174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2jUmgPJMl8rNeDpH2GLcq5ImDgq36YmUU+/0NveM+c=;
        b=HHS6xMEDn+OR9cZN22N9DvPpNOEZWj3cFC59Elb6gLdKmjz5g6LoWGkJasA0Muh0nl
         p68MmvwWncqcOR4RnUEJomaYINkNXa6l9qyW2rksvqeCojVqSpcZrkRdupCvLvSFkgWo
         s2Xfb+AV0v0J2lVYuE76DZtgjALIq04MckxNuZLvhR830WQp95tngcxjerIvT70ax/Ml
         JLEykJnY6gmGhs+R3NLIBnRu/7+InMVGhopEzRCnK8pzw+MHEbJxCdd9T4dwkUXhFEtH
         uK3wuTVZGbM7KgQTT/4224xuUelc3u4H2O9cd7P1zbWLveqQG+OvwPQc4gKd5e191NcE
         FySg==
X-Gm-Message-State: ABy/qLbjszVD7d0sH3U8d+zUUrmbDEMoZPhl47mkx3npT5ZvnPWU6DpD
        ZOonK7OJmmaNZCK3RcNt2/hNFQ==
X-Google-Smtp-Source: APBJJlHdwL2zKIVCmmL3/riZO45YQ7rzeJE80NsRv8hjeV/nAECA/Gt5BHfQ4Nv94ah2m4kod3Me7A==
X-Received: by 2002:a05:6000:4c3:b0:314:1d6:8aa7 with SMTP id h3-20020a05600004c300b0031401d68aa7mr1972887wri.29.1689175174315;
        Wed, 12 Jul 2023 08:19:34 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id r8-20020a056000014800b0030fa3567541sm5349531wrx.48.2023.07.12.08.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 08:19:33 -0700 (PDT)
Date:   Wed, 12 Jul 2023 16:19:31 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH 02/10] tty: sysrq: switch sysrq handlers from int to u8
Message-ID: <20230712151931.GA458038@aspen.lan>
References: <20230712081811.29004-1-jirislaby@kernel.org>
 <20230712081811.29004-3-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712081811.29004-3-jirislaby@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 10:18:03AM +0200, Jiri Slaby (SUSE) wrote:
> The passed parameter to sysrq handlers is a key (a character). So change
> the type from 'int' to 'u8'. Let it specifically be 'u8' for two
> reasons:
> * unsigned: unsigned values come from the upper layers (devices) and the
>   tty layer assumes unsigned on most places, and
> * 8-bit: as that what's supposed to be one day in all the layers built
>   on the top of tty. (Currently, we use mostly 'unsigned char' and
>   somewhere still only 'char'. (But that also translates to the former
>   thanks to -funsigned-char.))
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> <snip>
> Cc: Jason Wessel <jason.wessel@windriver.com>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Douglas Anderson <dianders@chromium.org>

For kgdb:
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
