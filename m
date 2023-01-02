Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C95065ACDA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 03:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjABCap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 21:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABCao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 21:30:44 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8692191
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 18:30:40 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d3so28265056plr.10
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 18:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:content-id:mime-version:references:in-reply-to:cc
         :to:subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GyLV+1S1hAjg0o7h3QJ5Zb1ssDmernO4L9KtQwhF2cE=;
        b=mHQ6dH+D8MLQCPAoTapLxM0IdIIDSaJQrEy3Bl+V33GfgFeYYWEaqmx9OSDGLyvlEi
         UUs0IfKUqVVXPi/sffKo0LXIb60J9WtNj+K97D3+XIQOqXFWDkqwBke38vmKi5xm0B7u
         JLNe6TzBSh5Eddpv1aN2NnFHCoCUfOCplSkgYqiAnkxDQBEsldhArIZAh08KBPwIQK3t
         lhY11fx/sQ3KnLNNdisQIIsyTowhOZkGdS5iEfhha0xPX8tLi7eZyGkWNhz1uFS0WA+9
         Xcf3Xa0A7dJZeLSF1kWjPDd5t0s4ly7qHJUMxe5kA6bZDvP6BH73z/fgCforVRL7TngY
         bN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:content-id:mime-version:references:in-reply-to:cc
         :to:subject:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyLV+1S1hAjg0o7h3QJ5Zb1ssDmernO4L9KtQwhF2cE=;
        b=nhVDBHcJiOY/Fr/E4ci/khxSUYdT/WhX4eSumuTLn4KEW3exqQ5RhUsqpUT/eNqV5H
         p81+yMIm/pqr4rNWbSCxQGzp/+kwoE2MNNmK9hwh/TlmJWAR/rPmbe95nIOeI32XLq2n
         jkKRXaMsE5s3qzz4EMibPSveLShw/467lgXZWh/JwaF2aM6loYCTiCVCbCdQeNmfgIK0
         kiPJydJnc6oxD2HIxFWUcsQTR/wu4KGygNzppq9F3g8lSNutyUX0k+6K9SqtP8NvwXtI
         wS04EYqvSkwnMPdWyhkIzllj+7FbHiRqwPGPyiuXwBaA2yOs4ub5B984OrdRBKD+/LpM
         o9kQ==
X-Gm-Message-State: AFqh2kotidV8u2yK5QQS7yCad/RFVfwco8G7OS4FYcCEVISbRLEi4ijQ
        2hdQ1QeKB/lVwoQ7VVBbMhkLzQ5Kmhc=
X-Google-Smtp-Source: AMrXdXtxDFusFCZ6j/X0CvkKFQaTyBbBaZ9J1VAnNmXXHr+0Ohpep8SSnGTBFmeO/6u/lMb4oR7wsw==
X-Received: by 2002:a17:902:c94b:b0:189:76ef:e112 with SMTP id i11-20020a170902c94b00b0018976efe112mr53520951pla.41.1672626639893;
        Sun, 01 Jan 2023 18:30:39 -0800 (PST)
Received: from jromail.nowhere (h219-110-108-104.catv02.itscom.jp. [219.110.108.104])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902dac900b00190fb8f9e0asm18811730plx.249.2023.01.01.18.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 18:30:39 -0800 (PST)
Received: from localhost ([127.0.0.1] helo=jrobl) by jrobl id 1pCAaz-0007Nu-QS ; Mon, 02 Jan 2023 11:30:37 +0900
From:   "J. R. Okajima" <hooanon05g@gmail.com>
Subject: Re: how to build a single module
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     masahiroy@kernel.org, mcgrof@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <cddcae6d-41d2-1b71-4785-b9c454e54c0b@infradead.org>
References: <25966.1672603613@jrobl> <cddcae6d-41d2-1b71-4785-b9c454e54c0b@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28388.1672626637.1@jrobl>
Date:   Mon, 02 Jan 2023 11:30:37 +0900
Message-ID: <28389.1672626637@jrobl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap:
> Please see
>   https://lore.kernel.org/linux-kbuild/CA+icZUW9MewkPJKwd4gA+pKADypseiCT0uYyVvFDTura7CzHog@mail.gmail.com/T/#t
>
> Does that fix the problem?

Yes, it does.
Thanx a lot. I didn't know there is kbuild ML.

J. R. Okajima
