Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC3860D705
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 00:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbiJYW0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 18:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbiJYWZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 18:25:22 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04C57D1E2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 15:25:20 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ez6so12245137pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 15:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVyOXaIPwUu5vIxKTkFwgvGCOhZvoDwYK5zKXQji1rw=;
        b=FXN94XTHI8WO7GeSzT3nSCHe9nGZqe2ZmzGLnUOqPa93icziFIl7n+9AfXwT3f2+y0
         8QSjBta7eXcMJndiixYUZaYrIr/ALR4UMqjUyF0XwH2DvIQU9E69PpcWNPC0sAnOd+X6
         fVZP3RQlmJQyVICheUyWF2dKDm4CAztuMUGoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fVyOXaIPwUu5vIxKTkFwgvGCOhZvoDwYK5zKXQji1rw=;
        b=yZbRFXylTomh4VcRTRXTWt7iKQBGgfm2Q7ztIRnPwPbrTMCSBT9lXgABRF6crQplaD
         fKXvpOiX7aySY6UZU4834dda2ZuJwMmE6HYTeRa3NUXM8FNJO+HfoW3+q5bT8WtPxXvl
         FBJGUgXtiEAmwpKOesaNRKTVyvWA5yO4NbEXblHr4iowgp8SU9T6t5H+zrkCtH138taM
         eMbwkzG5zobH/sNf9WuHy7uU16qNGD32CRiMD9HVLqkc55WddcCNBOBjr2hJaK8XkmSw
         UtxcpGItua3FpcM+8ESX3rMfNzGNJ0nLBbTt0lLBIpsm+ZNFNsFOStkyGUBqwj9IC6ib
         wMEA==
X-Gm-Message-State: ACrzQf00A4AIXNvRuXmsSpS3b2G73M3JT325Y6p44RAZZcvtSnM53QkV
        IoC/WMfWiWNBuc8dPKxG1sf453/0DdHe2g==
X-Google-Smtp-Source: AMsMyM4ED1R3VmA5cIJauau3fO0RwdvVSUL/RQb5KUEJx9boipxAayQvCEMLL5iMFYJ0zskyLrXX7g==
X-Received: by 2002:a17:90b:4c52:b0:20d:489b:5607 with SMTP id np18-20020a17090b4c5200b0020d489b5607mr597178pjb.40.1666736719535;
        Tue, 25 Oct 2022 15:25:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b78-20020a621b51000000b0056b4c5dde61sm1898977pfb.98.2022.10.25.15.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:25:18 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, ebiederm@xmission.com,
        eb@emlix.com
Cc:     Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/exec.c: simplify initial stack size expansion
Date:   Tue, 25 Oct 2022 15:24:39 -0700
Message-Id: <166673667324.2128117.14471012472344174206.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2017429.gqNitNVd0C@mobilepool36.emlix.com>
References: <2017429.gqNitNVd0C@mobilepool36.emlix.com>
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

On Wed, 19 Oct 2022 09:32:35 +0200, Rolf Eike Beer wrote:
> I had a hard time trying to understand completely why it is using vm_end in
> one side of the expression and vm_start in the other one, and using
> something in the "if" clause that is not an exact copy of what is used
> below. The whole point is that the stack_size variable that was used in the
> "if" clause is the difference between vm_start and vm_end, which is not far
> away but makes this thing harder to read than it must be.
> 
> [...]

Applied to for-next/execve, thanks!

[1/1] fs/exec.c: simplify initial stack size expansion
      https://git.kernel.org/kees/c/bfb4a2b95875

-- 
Kees Cook

