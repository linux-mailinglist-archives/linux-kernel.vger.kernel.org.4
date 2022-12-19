Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647556510D7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 18:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiLSRAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 12:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbiLSRAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 12:00:32 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5E212D1E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 09:00:31 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id y3so5053667ilq.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 09:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPb9xZNC4Ug7Zu21pqpW67sFxSgvib6Tb7cv4NS0Xjg=;
        b=Q/L0f0AFtZeDvINQJCTuCSb1fAUC3zDP2s7psk2oDGS54r2Gv6LfxEHfj3tKarhpoW
         5W1DWHlFWcIuXp2Cnjs55V3Y/MoaRYAfhNFY6feqFszfWZT2KYXg+XVE7mcV+/1e/jH5
         aKbOfS92ZYxxFV+u33F4uTHzlWD5l86znHLhd5k1/AV6J1ge7MY+Xpdgiz1pZwCkU0tv
         KM07vtZ5A6jbVQ9lKIHRP53aMHEdFCrIqDgRCMnIHX7msC+igGIDb10g91CRn7m4Efyi
         SO0fxZ694gsnA6QoJtldIUdhA6SOvXGUedQWz+vVV6jIBwkqjr3lftpTkeExZn/NcmcN
         h5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPb9xZNC4Ug7Zu21pqpW67sFxSgvib6Tb7cv4NS0Xjg=;
        b=IL3egJsBdo+0nU/2utzoSwAG5VP3zBS5qB0jTFlGePX59V3OAkHsoscbVR1AH7C0ct
         oiIlYfQl8ZxQssUp9PjTWElkv0pT9m/OolhpciUIc9dhm+zR1BKVrOYYyWaYb1u1lzwi
         9eZ4dma2VwoePW/MiZv/RaLiyHsSIX9DUP0NHept2O611Fmc7Jt52kyva6RlnSjaZ8C2
         WHcmLfqlFjXcHt97xiR4EMfWX57RsDnF+mCAjCghibaf4JzGoL2zwiTaiIx93KU3UrR7
         Ft03gesllcM5vnSzGb2K/J/FkwxDcl0UIqh3+sPwZHMnC/H6VCyU0rtW1hKYduJqikAr
         Nw8g==
X-Gm-Message-State: ANoB5plodF+bRNz+ZzZ43x0pGgCnB4AZD50/FUjR4AVNmztFO7P6t71B
        QwTfBZglN+lH0V4uCnELyZmtJJOuSkHnwBF6QFk=
X-Google-Smtp-Source: AA0mqf6qIahEITeZXrNeAmjqIWwiU08yFnFSORJYAJk31HqgXn9103oLRkvFKvK4nSA9MIRu64Ri5g==
X-Received: by 2002:a05:6e02:4c4:b0:303:814:5698 with SMTP id f4-20020a056e0204c400b0030308145698mr4788481ils.1.1671469230931;
        Mon, 19 Dec 2022 09:00:30 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id o13-20020a92c04d000000b00302bb083c2bsm3417874ilf.21.2022.12.19.09.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 09:00:30 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Muhammad Rizki <kiizuha@gnuweeb.org>,
        io-uring Mailing List <io-uring@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20221219164521.2481728-1-ammar.faizi@intel.com>
References: <20221219164521.2481728-1-ammar.faizi@intel.com>
Subject: Re: [PATCH] MAINTAINERS: io_uring: Add include/trace/events/io_uring.h
Message-Id: <167146923021.38039.12965457783921580572.b4-ty@kernel.dk>
Date:   Mon, 19 Dec 2022 10:00:30 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-50ba3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Dec 2022 23:45:21 +0700, Ammar Faizi wrote:
> This header file was introduced in commit c826bd7a743f ("io_uring: add
> set of tracing events"). It didn't get added to the io_uring
> maintainers section. Add this header file to the io_uring maintainers
> section.
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: io_uring: Add include/trace/events/io_uring.h
      commit: 5ad70eb27d2b87ec722fedd23638354be37ea0b0

Best regards,
-- 
Jens Axboe


