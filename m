Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7645C7491FA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 01:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjGEXk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 19:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjGEXkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 19:40:45 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F35B1989
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 16:40:44 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-666eec46206so174393b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 16:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688600444; x=1691192444;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0lf3uaq5f8gZLbnMSHirHb1QHfBK88CvzowXxr+xlUY=;
        b=iN2XA1D40K7Rv6za5RLTMq3D/4qMkJNWQc3jJiNY5I7m3zXzITaeu8Zt6b8s0EEj/9
         Go15cBMYOHjPPSyMk3a18XTnV7UYIBeWc+HkaOomugkZI8wCPPyUtZw/omLjUDx9TBPi
         /DDBofPDOfWJo7Dt0+bTGU/C7QI7ugCGF7ZWHAnMv8g4eel8+shrX9GDX9ZuOsCbmO/1
         E+l3V4luTtJDP/P6SpP9LUdNTZTMicLGUJii4SE3au2zfIJYfXtUzDAfjem3fl3AdHwa
         qkFI7gkA/Z2JGXgTSESIY0YfHW+r4f1+0zQISX/r5eJO2dbcwMWvcre/KHnkT8xlgWXX
         Q/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688600444; x=1691192444;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lf3uaq5f8gZLbnMSHirHb1QHfBK88CvzowXxr+xlUY=;
        b=KZf8/59s/6SBm/z+uvDNb6ubLR1l+n36t78NYK7cg/2IjASKrys4gtoGwogPsZ4WjH
         ol4sZNNZBdcIK0IryvgyaqJ9ig7efPM7XJz9vPsDMCPYydOd0+TJijhAgExUout+I738
         hDupc/9MqtzktesqwqOXsB/yAer+wqX6R7Evx88bnC7nw7RZpNvaRU0sOCxJ/9JyAUCO
         iPqyZ6+Zsj+5TPxGHwBrQlXl9cuM0bTi1tzh42dkO4WS1+SaAWC5sEDdyKrrMy9kNXhH
         h2F6tV+3ruNRz8c+V1ZKfWkfXJtFUMep3mLM+yJ6FNvnqEco0JIFxlc5gVYdZ20tPJ7R
         jZ0Q==
X-Gm-Message-State: ABy/qLaACSgHnj3eF/HHZgXAND0V/8p9tE3u0yosZaLlHMDWRL4saFjh
        kujUeBLfHCMa7spSN84Zmnmc4A==
X-Google-Smtp-Source: APBJJlFugFhUfL+xhDQ490oTvlE8ZcTbbYqp+QcQ7LR991rHK6hivTUyZ6G/f6GvuH+/tR+4x0sakA==
X-Received: by 2002:a05:6a20:3219:b0:12c:30f4:bd0b with SMTP id hl25-20020a056a20321900b0012c30f4bd0bmr358767pzc.11.1688600443658;
        Wed, 05 Jul 2023 16:40:43 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id jh5-20020a170903328500b001b872c17535sm47771plb.13.2023.07.05.16.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 16:40:43 -0700 (PDT)
In-Reply-To: <20230703183126.1567625-1-maz@kernel.org>
References: <20230703183126.1567625-1-maz@kernel.org>
Subject: Re: [PATCH] risc-v: Fix order of IPI enablement vs RCU startup
Message-Id: <168860030768.22647.6698047675033569268.b4-ty@rivosinc.com>
Date:   Wed, 05 Jul 2023 16:38:27 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     Conor Dooley <conor@kernel.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 03 Jul 2023 19:31:26 +0100, Marc Zyngier wrote:
> Conor reports that risc-v tries to enable IPIs before telling the
> core code to enable RCU. With the introduction of the mapple tree
> as a backing store for the irq descriptors, this results in
> a very shouty boot sequence, as RCU is legitimately upset.
> 
> Restore some sanity by moving the risc_ipi_enable() call after
> notify_cpu_starting(), which explicitly enables RCU on the calling
> CPU.
> 
> [...]

Applied, thanks!

[1/1] risc-v: Fix order of IPI enablement vs RCU startup
      https://git.kernel.org/palmer/c/6259f3443c6a

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

