Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA2860258E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiJRHVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiJRHVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:21:38 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9A0AA35F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:21:24 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q1so12550262pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHkzj4kw1PI7WIoQnIPAYoIPTSQVIxc3IhT+lSvVULQ=;
        b=YXFvKUROLbAcSMkQ8uN87Rd2wN/VVfxZTKYIlKGArSfGX6hCxTu5RSMDhDaJwsXXV6
         ZlI+Pot58CkyWFqF/N4gEfumimSf6KY6j5eiF6KstkxcuysSW/pbF4CJetoBzWQN2SAP
         wJF9grZugBgGn9EaoxJcNV+EnyI9G9u8zBKkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHkzj4kw1PI7WIoQnIPAYoIPTSQVIxc3IhT+lSvVULQ=;
        b=4mYF+fPXIIwGq+Jo63eR+dlrt5q8qmVqM/nxwS4mwYS1dZj0hs/9xZ3NSq+YCIyQOh
         V3kEi1UnMEAUvdqGN8Gbld6Op4KWvlkoquwyX7ZxA02Vg4V6zeZ85E/VWG9OifEMczWM
         99Cjb++JmrrFfmjjt9iMt+99t5ibnWaF41D6PbHXC3JizmjEEz8IJDivn/iUESWCcHpB
         +vpmRysCYiSAzT+Q3LwC8fY8O/AeZ6TyHOx+ab5wc2bVwUUzRvygm0MeG5Qzb/wc3a9o
         mW3NNQ54gj+n+34nDSs3TuCavIcr1W0SynTvdVrNNgzJU/wZsMKaFi2cpSOBWik7C6QB
         SHhA==
X-Gm-Message-State: ACrzQf14YZOxhOVnr35lGCKqzmU3vHcF0WHGyVfi/Gk9rOSIHm6aTmsD
        uT/S/R3Wb4JrxaGUHdc52cZfpA==
X-Google-Smtp-Source: AMsMyM5cYVw9IQX60rbtqzHwCK5oUdU/bt2cv/tUPffENA+gzMMWky4kgtUFKAi88QQDwf4HwHzU6w==
X-Received: by 2002:a65:408b:0:b0:42a:55fb:60b0 with SMTP id t11-20020a65408b000000b0042a55fb60b0mr1533373pgp.431.1666077683914;
        Tue, 18 Oct 2022 00:21:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902a38700b0017bb38e4591sm7850809pla.41.2022.10.18.00.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 00:21:22 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     avagin@google.com
Cc:     Kees Cook <keescook@chromium.org>, fweimer@redhat.com,
        linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        izbyshev@ispras.ru, avagin@gmail.com, 0x7f454c46@gmail.com,
        brauner@kernel.org
Subject: Re: [PATCH 1/2] fs/exec: switch timens when a task gets a new mm
Date:   Tue, 18 Oct 2022 00:21:08 -0700
Message-Id: <166607766447.3775011.11893363509592656217.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220921003120.209637-1-avagin@google.com>
References: <20220921003120.209637-1-avagin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2022 17:31:19 -0700, Andrei Vagin wrote:
> From: Andrei Vagin <avagin@gmail.com>
> 
> Changing a time namespace requires remapping a vvar page, so we don't want
> to allow doing that if any other tasks can use the same mm.
> 
> Currently, we install a time namespace when a task is created with a new
> vm. exec() is another case when a task gets a new mm and so it can switch
> a time namespace safely, but it isn't handled now.
> 
> [...]

Applied to for-next/execve, thanks!

[1/2] fs/exec: switch timens when a task gets a new mm
      https://git.kernel.org/kees/c/f8e06046dd69
[2/2] selftests/timens: add a test for vfork+exit
      https://git.kernel.org/kees/c/de8517320d01

-- 
Kees Cook

