Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AF9690E75
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 17:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjBIQjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 11:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjBIQjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:39:04 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102855D1ED
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 08:39:03 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id a5so1056759ilk.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 08:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4uXFLudCXK7C83Silz2odK5j98HOY4Dq7T/WA9bw5M=;
        b=HoRdJeK5sN7GFDv8wEVbw+d6CEM95J8tc43GxgbTprthhHtotMaqB8/Twfo1BxWtfw
         zReDXESEisZsWJYicS55+W2TmsmiEwZCr+Gnrn227943/FMms8ciH5OPBtUdj4Zt/QRr
         ZvOk+sg7BUXX4Iu0X7M1EEBB8DPl+w64c7XD+7PjIdXs5DAogPkspC1BcPeh3AWWi1ZO
         TrAhEEGOClaashUbpOAwJ5ELdPp1i/PeI04C/L6PLeUTw2TmIJDMsvPXT2EXTifFie/L
         SUOs9nS5Sc70nTrOyHY2Kwe3UIUalqz+tMjlZUGU1mNlQvNChHi9bioONDDmqXA4JNaq
         wyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4uXFLudCXK7C83Silz2odK5j98HOY4Dq7T/WA9bw5M=;
        b=onQgBVbYGggBS8C3b7s/9kQT9oFhHy17JgU63ugAebTqKQYkDm2qRABaluR51Ou9eO
         iARpE2BI2hl1Z8+C9Lvvo8/hVhLIWNfsed63zp48nZOFiJhV5iSvVcWEnOkK8wbT7R1+
         SuYpYGkt2o00ZLV76oxVKUJB20LKHJyIF9hUUDeIGfmu32qKNVZz3JGggb37grjJHoWo
         pAnWdw9amnzNvdsgKJHlWzzVRf1FqoIGB4G/p1tk3yhEueAjYPsCds6QOeWio/VqcAec
         bq/O8r0DgH/SAWj51j7tFAWBculdSIwZ/BODL2C7mEITdZ9ii4yUc2g4oJG0jHvFCwZ3
         /fXA==
X-Gm-Message-State: AO0yUKUw5YStS5/7TU8QUjCbDOlCBOwAw3xw3wV7eMpxlkjTiSMiEcjY
        HgMb06+qpwwCD74tuvd3SqSUhAH/F1qTMgp8
X-Google-Smtp-Source: AK7set/PpaCBvpqzAGe5GZPxAD3bxg9ZiVka+e9eDCRuGuf8vxnA9H6o3KHW4CbnEQWWjIsN+8jNcQ==
X-Received: by 2002:a05:6e02:1b88:b0:313:c5a4:9888 with SMTP id h8-20020a056e021b8800b00313c5a49888mr10935544ili.0.1675960742109;
        Thu, 09 Feb 2023 08:39:02 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id d7-20020a056e02214700b00313fd0afb40sm573207ilv.58.2023.02.09.08.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 08:39:01 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230208-kobj_type-block-v1-1-0b3eafd7d983@weissschuh.net>
References: <20230208-kobj_type-block-v1-1-0b3eafd7d983@weissschuh.net>
Subject: Re: [PATCH] block: make kobj_type structures constant
Message-Id: <167596074152.332757.13679917606663797604.b4-ty@kernel.dk>
Date:   Thu, 09 Feb 2023 09:39:01 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 08 Feb 2023 04:01:22 +0000, Thomas Weißschuh wrote:
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
> 
> Take advantage of this to constify the structure definitions to prevent
> modification at runtime.
> 
> 
> [...]

Applied, thanks!

[1/1] block: make kobj_type structures constant
      commit: 5f6224175fbe4c2b91e303c17af4d4eb5e3a60a7

Best regards,
-- 
Jens Axboe



