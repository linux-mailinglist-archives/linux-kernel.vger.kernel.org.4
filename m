Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEE76602B0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 16:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbjAFPDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 10:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbjAFPDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 10:03:50 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6225645646
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 07:03:49 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m3so1255933wmq.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 07:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+OwdKfXK+SNVrPvVK8uWPY9jI3lOu8t40smt1t6yZrc=;
        b=Z/gQJZss/OE/GRRyOiHB4/SFRKQvqNos1nrrpmF/NfzoZ/5zVb+pTRHQ0wnXi0IMV7
         qMLVKBtUWcR4THNiaBTMjFUS1P+UGbTHYyF8d4LFly/TwSdPnotCTdDqZUEUQLPLlDqf
         4jxQ4xK0Ssv28TozR02aKtZ97p1nV33r0iJzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+OwdKfXK+SNVrPvVK8uWPY9jI3lOu8t40smt1t6yZrc=;
        b=lcRsB5Y4PhveoodJUnT8DoSNniZ7ismr2rs4nYQKBai5QonyUuAEXCoGqFonm3uHyR
         YrtRltdUENaHp0nZlB45f8bEhg2W1dihyrzmxj+nQdRWKa01JOq/PQjiXs2CwLfH9jE5
         AE7NDNv797Y9tBK0T7igdfSXI3/VNM2hYC0BFAq6o6WGlfFQC1DSsvpZnHSMQZ9eFPct
         qpMAzZsR8B5ePp7+gYVhrPhJso+MdnIMrjv8yYi7iYTcD6oH0QJerYMWMc2j7n3K0s/c
         Yxz/yPicQR4j4sNzj3PcLzipV5ecRjJIJAiUHEA1rRYL709QXgXojKnIZOP1ED3D878L
         EqvQ==
X-Gm-Message-State: AFqh2koRFnBwEdqUqyzxn3SypX+LL4QK/R7LKcmd0eSBfYA4A2ASrNGc
        j1Qw3OBUtB77TBGKqNovzMXD6CAPkxFCoBPhEu1D3Q==
X-Google-Smtp-Source: AMrXdXvsNwItCisvp7fzc6VLVmnUJvtQuVploPMux0GmwOPd7GZX7XpZtI7ovjzBP3i8v0d4UaGM3MYZAlmvih2v0tU=
X-Received: by 2002:a05:600c:26d5:b0:3d2:1e7d:f9ea with SMTP id
 21-20020a05600c26d500b003d21e7df9eamr3395201wmv.62.1673017427753; Fri, 06 Jan
 2023 07:03:47 -0800 (PST)
MIME-Version: 1.0
References: <20230106045327.never.413-kees@kernel.org>
In-Reply-To: <20230106045327.never.413-kees@kernel.org>
From:   Julius Werner <jwerner@chromium.org>
Date:   Fri, 6 Jan 2023 16:03:35 +0100
Message-ID: <CAODwPW8kXZ107kMuVGya9Y=i+8QwQzQHokXCpybzMBjd_w_83w@mail.gmail.com>
Subject: Re: [PATCH] firmware: coreboot: Check size of table entry and split memcpy
To:     Kees Cook <keescook@chromium.org>
Cc:     Jack Rosenthal <jrosenth@chromium.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Have you considered adding the flexible array member directly to the
union in struct coreboot_device instead? I think that would make this
a bit simpler by not having to copy header and data portion
separately.
