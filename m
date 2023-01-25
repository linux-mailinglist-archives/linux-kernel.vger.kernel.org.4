Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A6667B907
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 19:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbjAYSLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 13:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbjAYSLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:11:08 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5FA22DF1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 10:11:02 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id x2-20020a17090a46c200b002295ca9855aso2900302pjg.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 10:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pQD0shi11rZTj5LNtv6GYSFD9d2uw2BA5/okkdV1qGc=;
        b=IC+bFBcFvn2PSd7vnbhTc6y+Ojmi8ByU5GrzrtzXea91y9WNsgbZnCgwGTZLH9F6Qm
         rI3GIA9XnXPmDV8tktseWWQ7prZFJKKor3tDTVbQ94JVgssUmgcK9sXRi4FxmlTvPiWh
         WSKMlPbjrGUxIqQs6zFHH30mS+zaNyBjd/rLHkChryFiF6HNUo0XVuAAGnvW5mY+Ew0a
         TvpKv2ZIYGNQPqAW1QeD4x8vokQiJN7nBiB/Nw39WfHKVzH7fDOpIbVRWJHXDZdEOsSV
         f76xbzkPgl3U3r9G5c1H5yD4zK8gDqNZY2tkvEc9zWSRqJpnm+/AfcuXHwo10il1282Z
         1p+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQD0shi11rZTj5LNtv6GYSFD9d2uw2BA5/okkdV1qGc=;
        b=TqeerE+NOEVZuFONrlhzKmD7e7rswWKkPeHGyl4tSLAGzqqpyYoD528tbnOKRq8kta
         6/FXKQeZuF2oCcoLXw4btjpr06gYkQAArR95j91lMaYfVT9Tu8J3gJHwfQDIv8M5VvMv
         LFPAj/dQxvlaDERoaqxl2GGNaGPsjK465fbmhJH33Rd6ToEi+y181nVRvufmEiRFn04E
         o7yEcpxB1Z7VPSnlQdVlqz1j5Jbq6ZIIKNYI8az5ddwIYTlXeE52BdYIXIYGfJzpSqsV
         7GPMvFzaDhPKhFwwljguOe48iic/+4pZzib7OySmVoW/BWU68bUrf9TeVqWDsNYMfTsT
         ttOQ==
X-Gm-Message-State: AFqh2krgFzXT85qu98YNN7I6Aja22+yXnY/OB7S2lavW765P/02L20X3
        /qJvGd8HEyuy8Tx1cboliJJN5g==
X-Google-Smtp-Source: AMrXdXu7+jQL329BQiKXN9pflTqeYS1ZPGEtU3VDiQ90DOui+Z/FxU2rxULGW4luUM1uoFHBYTlJMg==
X-Received: by 2002:a17:903:210d:b0:193:3a92:f4bd with SMTP id o13-20020a170903210d00b001933a92f4bdmr29203740ple.47.1674670262165;
        Wed, 25 Jan 2023 10:11:02 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c20600b00188fadb71ecsm3961963pll.16.2023.01.25.10.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 10:11:01 -0800 (PST)
In-Reply-To: <20230105033705.3946130-1-leyfoon.tan@starfivetech.com>
References: <20230105033705.3946130-1-leyfoon.tan@starfivetech.com>
Subject: Re: [PATCH v2] riscv: Move call to init_cpu_topology() to later initialization stage
Message-Id: <167467025508.9605.6900641961195110953.b4-ty@rivosinc.com>
Date:   Wed, 25 Jan 2023 10:10:55 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-e660e
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>,
        Ley Foon Tan <lftan.linux@gmail.com>,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2023 11:37:05 +0800, Ley Foon Tan wrote:
> If "capacity-dmips-mhz" is present in a CPU DT node,
> topology_parse_cpu_capacity() will fail to allocate memory.
> ARM64, with which this code path is shared, does not call
> topology_parse_cpu_capacity() until later in boot where memory allocation
> is available.
> 
> Move init_cpu_topology(), which calls topology_parse_cpu_capacity(), to a
> later initialization stage, to match ARM64.
> 
> [...]

Applied, thanks!

[1/1] riscv: Move call to init_cpu_topology() to later initialization stage
      https://git.kernel.org/palmer/c/c1d610586946

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>
