Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4335F0180
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 01:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiI2XmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 19:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiI2XmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 19:42:08 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15071C5CB9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 16:42:07 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id c6-20020a17090a4d0600b0020958fcd9acso1488852pjg.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 16:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=8szeZwXnwvU54gfCkC5Z4AK0EYqrldkwFcobGjKRWDI=;
        b=ANtFD3OTQsg2c8m3Ro/9Dz4eM7tfGxKLTZAErtPS2+nsjSTM5U9kovZSA1PVjmhG/8
         r6R1jHEugt2j+c4eQIN/XY4E86zHz5sKtLVsEbaOxjqUkKiKgTQwJ+2Oj7jilECYsLtt
         F9kHojDT1YCVAYwrqnUO55izH4MsHMPLZO8Vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8szeZwXnwvU54gfCkC5Z4AK0EYqrldkwFcobGjKRWDI=;
        b=vw4OqbV5tyOposv9HsTkzWZCh4m4+q/vx1133pWmZucrsdhZ+Tzb/bGoR2AqDULfir
         pBUVJZO3uJnxhy1I1X2+iLM2WLIV70iSZ8pumS/2uP3B7ucZFO1fs11JIojLMnVWmW/4
         NFb5oIiBPzR8FWiuDlJZVxOYo9aAkyIgSsZmxx63QoyBdhJhXHj39XF4SYxhyuQp15P0
         wtnCEAgOv7pLCNa+OI//iqcLzzMRV5OUKtzWusCcePr5QkMysL6uPENXi+NMZSyT3AIY
         ujVgA9lVlGH/l82sw4CZJ9ScVrCjv/PKb61Fs4VNb0faSrBZjQbOHeP3BL2l1wEjLvq0
         V2Hw==
X-Gm-Message-State: ACrzQf3zLTN+SCQ4VZU9t+OWDfUPPiDmztwcegVC5UiUGlYbVLLf5i9k
        tzt/Jgo7A0Eq+OJpcuMkDj90M5Uj5GSYKQ==
X-Google-Smtp-Source: AMsMyM6vvkm+NacBp95u2wlgHRzWT87v6ptVwcsQgsU0eQEb0yV7DNWUdrQv6o4MJUfkOCVLcl0Fwg==
X-Received: by 2002:a17:90b:1e45:b0:202:fbc9:3df1 with SMTP id pi5-20020a17090b1e4500b00202fbc93df1mr19511488pjb.72.1664494927215;
        Thu, 29 Sep 2022 16:42:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a193-20020a621aca000000b00528bd940390sm241675pfa.153.2022.09.29.16.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 16:42:06 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-mm@kvack.org, lukas.bulwahn@gmail.com, ebiederm@xmission.com
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] binfmt: remove taso from linux_binprm struct
Date:   Thu, 29 Sep 2022 16:42:00 -0700
Message-Id: <166449491824.2140283.16877979347941550616.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220929203903.9475-1-lukas.bulwahn@gmail.com>
References: <20220929203903.9475-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2022 22:39:03 +0200, Lukas Bulwahn wrote:
> With commit 987f20a9dcce ("a.out: Remove the a.out implementation"), the
> use of the special taso flag for alpha architectures in the linux_binprm
> struct is gone.
> 
> Remove the definition of taso in the linux_binprm struct.
> 
> No functional change.
> 
> [...]

Applied to for-next/execve, thanks!

[1/1] binfmt: remove taso from linux_binprm struct
      https://git.kernel.org/kees/c/9f4beead610c

-- 
Kees Cook

