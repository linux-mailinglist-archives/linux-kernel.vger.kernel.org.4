Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192846EF668
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240854AbjDZO2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240813AbjDZO2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:28:14 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4147E76BE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 07:28:10 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b5ce4f069so8782424b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 07:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682519289; x=1685111289;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJcqfi4NEDS/gG1hv5lKgN6zMX9n9uOcWUQlYRE2NO8=;
        b=rmWmWMhl46pNMCYl02KJfjZB2Bzr5P68tnYvKy3PGjqscKP68boWgdEFvw6DY9HiVE
         9BFW9M9r1Hwz5bLLYRt8GAb/l9K0gWAlKlTabXGUR/7+qLwfxCIOb89ex3wmtlzBxh8L
         ITz4i86w6I3VPZGrD4HK4c34ABTEBn1tUzH3GWiyHaEPfNWHAKQmUQP2k4IbNggEwd+X
         u/xlD8qx6MTUdeJvcr0+sUM6UEybaQLNqZex4eN5G1jAw95GeJCOz1NlY1etPwyvg1K6
         hB9vrmiDWVYAV6iACdZHmll/rKJVua8MheojhlbGrofoUC1kB0dCf6q3EF3Di+GdmCET
         eoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682519289; x=1685111289;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJcqfi4NEDS/gG1hv5lKgN6zMX9n9uOcWUQlYRE2NO8=;
        b=O/NiEIJ9NzMumPC4s3PqRnXQMg/g4g43aSN7qQwZeTzp5dWChC6sNPxO2rDwEH7iG9
         O2WahWF0dL1LoaaRMpnle+iTkz9jyAj4jUb20HXRSOUs6MpIMMMP4c7LOBd7rGOo24AL
         lBigiDEj+DhDjPhyllK6Md2KzFMzy2WaMu9V/VU+14lKDcgLGMrJ/yDt7hJjYlxeM4x7
         XhO8+ZAk0vlUGSpYotfIwCO8Uix6B99jgTC0b0XG9iXPVmwZ2WWeOnVSXwQLtKUDItSS
         10G+iPq1M9WJss1sIXpnVPWONhspzyFqNZpiEUUlaBWTugyT+Ar4YWhi966c2MntZdR7
         T+Vg==
X-Gm-Message-State: AAQBX9drXut6O7aeOFHhLCXixqfsyhhlZPtGaHERyL/8hkvF5tDmxnBq
        IrlqcfPVrfZrAdfyX/L4NqQdDA==
X-Google-Smtp-Source: AKy350akRxCs7TonP1gzP9WOV/BgVNsnnKVETfliEzntID5BRaDew/MoU+piyD+55ef6PEXgcJC3Og==
X-Received: by 2002:a05:6a20:3d93:b0:f3:6746:ba37 with SMTP id s19-20020a056a203d9300b000f36746ba37mr17752988pzi.13.1682519289486;
        Wed, 26 Apr 2023 07:28:09 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id v16-20020a17090a459000b0024b822e6644sm7059005pjg.54.2023.04.26.07.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 07:28:08 -0700 (PDT)
In-Reply-To: <20230420194934.1871356-1-evan@rivosinc.com>
References: <20230420194934.1871356-1-evan@rivosinc.com>
Subject: Re: [PATCH] RISC-V: hwprobe: Remove __init on
 probe_vendor_features()
Message-Id: <168251927960.19663.8319628708059117867.b4-ty@rivosinc.com>
Date:   Wed, 26 Apr 2023 07:27:59 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Evan Green <evan@rivosinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Apr 2023 12:49:34 -0700, Evan Green wrote:
> probe_vendor_features() is now called from smp_callin(), which is not
> __init code and runs during cpu hotplug events. Remove the
> __init_or_module decoration from it and the functions it calls to avoid
> walking into outer space.
> 
> Fixes: 62a31d6e38bd ("RISC-V: hwprobe: Support probing of misaligned access performance")
> 
> [...]

Applied, thanks!

[1/1] RISC-V: hwprobe: Remove __init on probe_vendor_features()
      https://git.kernel.org/palmer/c/bb3f89487fd9

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

