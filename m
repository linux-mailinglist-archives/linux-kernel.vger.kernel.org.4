Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6637F68C346
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjBFQ3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjBFQ3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:29:47 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA5027495
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 08:29:46 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id j4so4637495iog.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 08:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0wSgKUacGM7xvS2cBdhx6arq2ihGPco/pYthVvg21s=;
        b=Ou0qdNl+W/3pD5Mbs69QEZlUJxBjbP/Ce2eJ6WniAHlvyInm8n3xyoJdQ7XiDRXg0b
         xzZ92HBKHjYYbeYiJJJj4s5iSyPy5+Mfg4cQJPYD9Tl60e4vs5/Dr9XKIcToo1npe2QS
         foTxzyzukpuC6bz1ZWMoN/FfogeZMd0u7BbuOIoGYuCzrCg44AfTaIznrEdvwkfOsZaY
         j6Ao57G3NoDmclo2trDIPF1bKhSpWRy6tk/PCurQgUlTXEJYkFjOO7s2dxMIFA3gz7gK
         XLIZplBWMHRpG1maWxefNiqFF6YN7iH5r25xPkNabqNbX+yCZDk4dbs1UITOUgenXHqd
         +Zww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0wSgKUacGM7xvS2cBdhx6arq2ihGPco/pYthVvg21s=;
        b=zYITlDGCResADZgsYEou3ljR9ugK/0wvR7cmf/NMHnggQM1VyWerI9dg/n6cgvczD3
         /8RleTv7DJfpE+UqWdKQgt/yud+GspD8WO8YWEH58V3C/gF9G4CapZoYkNMsovzUOgFB
         jr4es7VJsT/mQfolz1QMkOw83W4xrJmZfbCqWM4jNTlGB7/syiMaS/zlTVZ0cts9jymu
         L/HdMO9eeB7lUSLovlLudeXOookRY0Altg7k+Ql7j3PpmxVu2ODU8iJZnZutV8gxWWAg
         2K3wYLRL86RSjGRmt2Vh6f0jLQ/6ZAg65Yeoq2MpOFMYpSaVSnVZ/64F0qqvJaMDbSGC
         g5bQ==
X-Gm-Message-State: AO0yUKVYcw5zc0hpMj7zjmRy+COTt5BC22YkE8FF8dxX0l1wHQHvUJF+
        15jk28Sg7enc0W9h2HsiTb7rgA==
X-Google-Smtp-Source: AK7set9bUNSjke79Got4lwtiThY2fA3KOJf/RNpPFWIB2xPST2fTtzAuMaafu5jj49Tkp0IAgPgvyQ==
X-Received: by 2002:a6b:7808:0:b0:71d:63e5:7b5f with SMTP id j8-20020a6b7808000000b0071d63e57b5fmr13132135iom.2.1675700985321;
        Mon, 06 Feb 2023 08:29:45 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id dl6-20020a056638278600b003a60b0b09d1sm3575949jab.5.2023.02.06.08.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 08:29:44 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-trace-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230202141956.2299521-1-gregkh@linuxfoundation.org>
References: <20230202141956.2299521-1-gregkh@linuxfoundation.org>
Subject: Re: [PATCH] trace/blktrace: fix memory leak with using
 debugfs_lookup()
Message-Id: <167570098443.24242.14188383758966607556.b4-ty@kernel.dk>
Date:   Mon, 06 Feb 2023 09:29:44 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 02 Feb 2023 15:19:56 +0100, Greg Kroah-Hartman wrote:
> When calling debugfs_lookup() the result must have dput() called on it,
> otherwise the memory will leak over time.  To make things simpler, just
> call debugfs_lookup_and_remove() instead which handles all of the logic
> at once.
> 
> 

Applied, thanks!

[1/1] trace/blktrace: fix memory leak with using debugfs_lookup()
      commit: 83e8864fee26f63a7435e941b7c36a20fd6fe93e

Best regards,
-- 
Jens Axboe



