Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F327960D703
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 00:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiJYWZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 18:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbiJYWZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 18:25:14 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53D160E97
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 15:25:10 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id f140so13392020pfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 15:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/IHWp5axKcNbS4CK0rdqluH2L9n6cyXddp8mwZdAWk=;
        b=M+QTTQuJYEiA9TQ/SaVp6cRfUf5PJqP7uvCnPdF4C/K5AcaCpZ3dnqjCsBVxZf26u6
         YN9NAK30TVZha17vuUpG9TRFJxK01wJ+Nfnk4rLf5/5/+YaqBOOmkJotmZ4GGZH8u2g1
         5f+OTY0f1+7kwGO9LaWXRPRZ0n8wX7GVMty+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/IHWp5axKcNbS4CK0rdqluH2L9n6cyXddp8mwZdAWk=;
        b=z9RHg5cVIHbn9we4v3+4EiVXtvnXcPPSPM+stksle1dEvBdZeXM9cSGSTvYwkAxGni
         B4hdX7rTvLuIBhG/MtI12ubCmZmVtt9YrpuAiaJdnI7oIQjcNxvUwj/kflb0xXIsX8uf
         e9q8fdu+ja23ri4+JAmE6saJNST6vyZ1BPW0XrhOGx5hr3hUkj7dXWi3Y3MwX09xAGA7
         ffZ7YYnn1EVOsQ4LEM0pFzOzys8hVKJG9z35WN4Ftu6RgcQbvu5r/Nk0kxJKm02rG0v/
         GPBBnsCdkb++Or1Y6tCnhcPj3L9bRb98veW0DsAGbDh/9EHI9SY7miq324h+GwX8/lfz
         ce3A==
X-Gm-Message-State: ACrzQf2SNee0V7bZXuMYTxFOTN2IfiJ5b4r8muDk/m6FeJFggtaJBFP1
        yc54fkZj6+Gj1tc7oPJ6UD/rPg==
X-Google-Smtp-Source: AMsMyM66lXBBZiCQgf6FJkUodLvLKJHXn2RfG7lIzuw8OWJbBF9QFZXfjigg53YexUkU8JIZdanoxA==
X-Received: by 2002:a63:d314:0:b0:452:598a:cc5a with SMTP id b20-20020a63d314000000b00452598acc5amr35619334pgg.299.1666736710427;
        Tue, 25 Oct 2022 15:25:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y17-20020aa79e11000000b0056be4dbd4besm1848936pfq.111.2022.10.25.15.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:25:09 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, ebiederm@xmission.com,
        eb@emlix.com
Cc:     Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] binfmt_elf: simplify error handling in load_elf_phdrs()
Date:   Tue, 25 Oct 2022 15:24:37 -0700
Message-Id: <166673667324.2128117.9264012790851667013.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <4137126.7Qn9TF0dmF@mobilepool36.emlix.com>
References: <4137126.7Qn9TF0dmF@mobilepool36.emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2022 09:52:16 +0200, Rolf Eike Beer wrote:
> The err variable was the same like retval, but capped to <= 0. This is the
> same as retval as elf_read() never returns positive values.

Applied to for-next/execve, thanks!

[1/1] binfmt_elf: simplify error handling in load_elf_phdrs()
      https://git.kernel.org/kees/c/ef20c5139c31

-- 
Kees Cook

