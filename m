Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88686C7EA8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjCXNVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjCXNVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:21:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76B520550
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:20:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8AC75B82432
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 13:20:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12166C433A0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 13:20:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Y819CmiO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1679664050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vh+MpBmDcTqJR8bkipH3xoGChH7Ag1enS9/gWacPJ1k=;
        b=Y819CmiOB2QzKfEGqot++gniwklDA9lmONMoDNbR1fYtOU3MLjI/bRsmsKWGaQ2hKHHZ2o
        B34jBHIirKaE7awkVyBR7ZV5ppfR62b46lR4tzv8U8m0MT+ZDlQwISahTEdFObXBtLyczW
        SEYcpi8CnwQTbErC84kQr8brlOBu2S8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cac92e5f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 24 Mar 2023 13:20:50 +0000 (UTC)
Received: by mail-ua1-f49.google.com with SMTP id g9so1357401uam.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:20:50 -0700 (PDT)
X-Gm-Message-State: AAQBX9dab9y8x+nSY/N+4o8wKFAQTMtifqFi1H/XgFJDf7LyMa4XB3YS
        /LEIrxXJ/vB9ohuufoWFO+gIrzbKufSK+f1LdmA=
X-Google-Smtp-Source: AKy350b1md9rigPAnpbhwmFCMweNJSrwFYI/hWGjwWc5fHcz5EcX48KZGgbC9py4QNmzptwva3DmNM5WCw5Be/H0FIM=
X-Received: by 2002:a1f:2997:0:b0:432:8b30:81b7 with SMTP id
 p145-20020a1f2997000000b004328b3081b7mr1695217vkp.2.1679664049753; Fri, 24
 Mar 2023 06:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230324100538.3514663-1-conor.dooley@microchip.com>
In-Reply-To: <20230324100538.3514663-1-conor.dooley@microchip.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 24 Mar 2023 14:20:38 +0100
X-Gmail-Original-Message-ID: <CAHmME9p4LAY5XLLU+A6qtnHHDT_sZ4=D=VJCj6qs5_kmx61Tcg@mail.gmail.com>
Message-ID: <CAHmME9p4LAY5XLLU+A6qtnHHDT_sZ4=D=VJCj6qs5_kmx61Tcg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] RISC-V: Fixes for riscv_has_extension[un]likely()'s
 alternative dependency
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     palmer@dabbelt.com, conor@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seems like a good approach to me. I'm not a RISC-V maintainer or
reviewer, but in case it helps,

Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>
