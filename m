Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF0973C3D6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 00:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjFWWNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 18:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjFWWNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 18:13:07 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B6D26B9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:13:06 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-66c0a45f7b5so181244b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687558386; x=1690150386;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KSMItz4s9WYcwyQLoRm56nsz7aYFAcT5yhPDIqN2h4=;
        b=QYQ89xb9XChKpxU9JSZkkaS5Y63f1djkgfdG9Kk1scid9PU2NqIt+x2BR1KiWvpEQh
         r+YrCJP4f3OEFcny8B3b202NCh3jWxJlnbYtzVycWr5uXhqsNU9OuvnE0btLYOM1rAZi
         BC123itQV6iFJ58GXa+o4iTQhC/gZK7Heb79p2rTcIwY3EZFK6OHkj6XiLOxGLDHoAW0
         2U9b2mgWa9wg8xmL/l05ORSKRkfBm/gf0OnfBzTNrL/hpGzVXsDWLDDwLnTFqRB/oX1j
         Xn5dQIcHQskr1t/8rZht6muPpabBgouyRNCoHJEGWQpGubSlLcsWz/AQG753/Kk4xz8y
         aqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687558386; x=1690150386;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/KSMItz4s9WYcwyQLoRm56nsz7aYFAcT5yhPDIqN2h4=;
        b=kGssIUN3v0/QGWkgQOE5bmpTMprNxV+sw3vTjwF0KS1jGyTCo0041F5s5YKYANEX/N
         bz8OJW6i7Owq/2YujtlcMl8JjWgKVxhBV7wC+fYFXQKbq/P30vBbOg8J+mB9AR5ehAjX
         Y4nudd9z4U2KFh6qw9ElqG8aoE0TNk+YytlzIT+YUPKs4SUzvitL7nKHTLcfXlxTNZYl
         3755pYvbLd2uNcCmiZTbZi0IZH7uyfP/QZn4L7wNeyRLjX/4U4MnZoQD6hiGM14YdBVc
         WidYlNDMP0uvSzF70dADUy+QG0mzry4KBZWpyHdcEQJe8u3gugr9leYbkMnK99ybmAKe
         VSeg==
X-Gm-Message-State: AC+VfDx2C8n+n4t/w34bgFKqzv4D0h5R/t2VmahBrY0RaKLDrQxCzyeo
        ulduOHCqQwiXqmYpONRzQC03HQ==
X-Google-Smtp-Source: ACHHUZ5/93LE1VmylYBiFVVVXUAVOZG25bizHpUFZuyUm13I50qZygghxodx2zbOlLMnnHaJtRkxUA==
X-Received: by 2002:a05:6a00:1daa:b0:668:7351:ca8d with SMTP id z42-20020a056a001daa00b006687351ca8dmr17399390pfw.3.1687558386174;
        Fri, 23 Jun 2023 15:13:06 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u1-20020aa78381000000b00662c4ca18ebsm21998pfm.128.2023.06.23.15.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 15:13:05 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Guillem Jover <guillem@hadrons.org>,
        Jeff Moyer <jmoyer@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Michael William Jonathan <moe@gnuweeb.org>,
        Matthew Patrick <ThePhoenix576@gnuweeb.org>,
        io-uring Mailing List <io-uring@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
In-Reply-To: <20230622172029.726710-1-ammarfaizi2@gnuweeb.org>
References: <20230622172029.726710-1-ammarfaizi2@gnuweeb.org>
Subject: Re: [RFC PATCH liburing v1 0/3] Introduce '--use-libc' option
Message-Id: <168755838465.749394.1580343149214117660.b4-ty@kernel.dk>
Date:   Fri, 23 Jun 2023 16:13:04 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 23 Jun 2023 00:20:26 +0700, Ammar Faizi wrote:
> Hi Stefan and Guillem,
> 
> This is an RFC patch series to introduce the '--use-libc' option to the
> configure script.
> 
> Currently, when compiling liburing on x86, x86-64, and aarch64
> architectures, the resulting binary lacks the linkage with the standard
> C library (libc).
> 
> [...]

Applied, thanks!

[1/3] configure: Remove --nolibc option
      commit: 7eba81f6eb2d62d7835622267b483b95bdf0bcd5
[2/3] configure: Introduce '--use-libc' option
      commit: 151f80504d8cba262f0950b76953dd7441342163
[3/3] src/Makefile: Allow using stack protector with libc
      commit: 449ebc5a425f3a8b14c78357cbe9ab1011a797eb

Best regards,
-- 
Jens Axboe



