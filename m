Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DA66130EA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 08:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiJaHDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 03:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiJaHDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 03:03:02 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54909BE25
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 00:03:01 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 128so9959269pga.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 00:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBwMgX4cqDJqKT2x7OMcJxt8S6CoPEZ4r5fmW2QVYPc=;
        b=nYmyB1+ilBReCNrQyBybAAiE7MP2pvTwvOy8wHuf+a1v0rmgrm/LpZrOIXXcAqTdwq
         /BwCDya3/OlNhSAp6lpt70nmOCKtxUJ87wfuTurPdqd+VwcDUVTMwCZFcJq9UEGWKWwD
         BxsDO9EtJvqA95aCGodJhB9hs6k9QhK6ffhctxWaZb1+ZwQBUH0TzEp1wl2XNuMerxyQ
         g/IUCaaSV3MPPEsIFT10k1hbio7jFejX51Jf4TvRjrXR8F/HrPmiqLjfEQhotgTfwhdd
         wpo8u4go5gESMdGkuzRe209k1VajEUudJ8hedk5lUb2PvzKVxfYf7+1761ceLcM/MVzn
         wZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBwMgX4cqDJqKT2x7OMcJxt8S6CoPEZ4r5fmW2QVYPc=;
        b=wBAOLjzYmY6dNNUn4gwlUNQkAG8uUhdhOoHFzUzmXDDdtMpSeJ5pvLzZHz0L5zDK/i
         sr/L+adsfPuP7OyotmnqoJAP+vtEfPKKLo8TuzrEfneCxQgshjOw910lU5LwyrMXdfqm
         0RYmGRFLSKcgwXQQ5JfYZLSEkjdOYGg2bg0EBDilYWvf6vU4sxI/s3wblGv9+eeaRQvN
         /hzZOhXbxHtlZGVOjw2MTa62Zfuq+EScxwu5Vd7mdWrsY8IxKv5SM1mrZabSoUniHmIb
         rUp/2m2ffdhXFwGzukcO4gXQDykRarbsLDu9JVr7orhk5T3SBqG3wMcKxBXPDFmbjYOp
         MwKg==
X-Gm-Message-State: ACrzQf1EoRwl3eEgr0d++FFxMmhJONdz9XXRDzbUKR/n/G97Bmg9Hczl
        r530bqCjkyohl3euXC58/BBn46cYOQV8IQ==
X-Google-Smtp-Source: AMsMyM7RYV5AM87Y+XNdX3tJ78sl9bjrFJ5Yipol1jSEng9dhl5WItqLeDJqS/rJPFvJiB1geF/NUQ==
X-Received: by 2002:a05:6a00:a94:b0:56d:5c36:7eb8 with SMTP id b20-20020a056a000a9400b0056d5c367eb8mr5445916pfl.38.1667199780755;
        Mon, 31 Oct 2022 00:03:00 -0700 (PDT)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id d62-20020a623641000000b005627ddbc7a4sm3759758pfa.191.2022.10.31.00.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 00:02:59 -0700 (PDT)
From:   Song Shuai <suagrfillet@gmail.com>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        suagrfillet@gmail.com
Subject: Re: [PATCH] ftrace: fix static function tracer not working
Date:   Mon, 31 Oct 2022 15:02:56 +0800
Message-Id: <20221031070256.2478832-1-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221027092444.3702378c@gandalf.local.home>
References: <20221027092444.3702378c@gandalf.local.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Steve:

Thank you for your time and attention.

The static ftrace is exactly overridden by dynamic ftrace in most architectures
when selecting Kconfig. I'll throw this patch to trash.

BTW, can you help me review this [thread][1] which hasn't been checked for about a week.

[1]: https://lore.kernel.org/linux-kernel/20221026132039.2236233-1-suagrfillet@gmail.com/

--
Song Shuai  
