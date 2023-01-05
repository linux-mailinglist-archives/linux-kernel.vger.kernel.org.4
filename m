Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5D365F087
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbjAEPvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjAEPuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:50:39 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC23D5E0BA
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 07:50:38 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id d123so19685144iof.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 07:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5N+tQSXR3a1Z2OXWXkb2lYzYjkzFSaH5GpFM4+ANT4=;
        b=cIYPykcI4c0tm0JrP8L5kXUAhZiIVY6Aiw2+PLkjAwaIysgc8bjoVZFY0RE1LJLRVr
         oSYfQ9BkvxF/72S5ZH/KyrqHqtbI8oURpC/F/SefBNrQvfzu679lNUx9Yz8TsNjrOBi3
         ru7vsqzBZaG0Jg5DMEbQxOFlduZBSdhwFzmTJBIfdIssycK2KSGG9LIN+LGyLv2zfwQ5
         N8WBLsmWxZ2p+Bi5WNS1LZWHXjzQjsX8oB8ZpO73KTRI4H9dyJf/9+VebWZO3raUqchA
         3047OPkhL7I+UYpMu0q8PCkN0CxUcEvn6gxCEGblEKYXANzfvQL1OKLH9ohRBg5p/uaa
         Vafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5N+tQSXR3a1Z2OXWXkb2lYzYjkzFSaH5GpFM4+ANT4=;
        b=E9PgCsVP8666RudFK8GNtvqDIwyR7OcSgeNTPDHaPHGajp9YNcPCWXPvL7N8oMcqTj
         G85MVdgjFGxibq7hGrgIBBt9GgiV+GXIaJWP2KqvENFogHQfpokGDYCMwVh0ahSey4di
         R8WTTGzkoDMX7EK79JhAwtPQbt1bApVvvaE4fTiQNUqk/8VnCL0ivBVQ3aNgkEICxpkL
         RRqGlVwkZBJhMEvccfBDESU/u205AQn9+nVz53BNjwhLKB81QRAJu644+Nua5Po98mPc
         vMQqOmLi4v8G9ztlWeNA3FK4yMfcWpsvrwJE8GJLEnNKYB8dJQp1oRjXXlwHxiH/zwTx
         +iIQ==
X-Gm-Message-State: AFqh2kq48gJntSawZ6PAnvkRZqMlss4asER3G2y4DN1XxLMUcj/QeMre
        3v4JULIaKjJ9zo4O3MUF2n8hSQ==
X-Google-Smtp-Source: AMrXdXsjnlZwcoNllvJnOHFnPUEI0F8/jX8TyxLtYEQ4cLiggavuVDXW8VLsDOF9BWnHpzILm8ROpA==
X-Received: by 2002:a5d:990e:0:b0:6df:128f:ca12 with SMTP id x14-20020a5d990e000000b006df128fca12mr6265742iol.1.1672933838201;
        Thu, 05 Jan 2023 07:50:38 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id j2-20020a02cc62000000b00363362cd476sm12180995jaq.101.2023.01.05.07.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 07:50:37 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
In-Reply-To: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
Subject: Re: (subset) [PATCH rcu 0/27] Unconditionally enable SRCU
Message-Id: <167293383749.9409.12809142428621928168.b4-ty@kernel.dk>
Date:   Thu, 05 Jan 2023 08:50:37 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-7ab1d
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 04 Jan 2023 16:37:59 -0800, Paul E. McKenney wrote:
> This series removes Kconfig "select" clauses and #ifdef directives that
> are no longer necessary give that SRCU is now unconditionally enabled,
> courtesy of new-age printk() requirements.  Finally, the SRCU Kconfig
> option is removed entirely.
> 
> 1.	arch/x86: Remove "select SRCU".
> 
> [...]

Applied, thanks!

[07/27] block: Remove "select SRCU"
        commit: b2b50d572135c5c6e10c2ff79cd828d5a8141ef6

Best regards,
-- 
Jens Axboe


