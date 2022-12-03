Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B182064120D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 01:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbiLCAcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 19:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbiLCAcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 19:32:12 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB97F2C7E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 16:32:12 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id f3so5688082pgc.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 16:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZRChpZav5IUrRCCfNMjwsJ5gE9vU0npcYHbSte7ykZQ=;
        b=UMZ0kD3ro2ZGDE+e9W16wQdmAPwhKaJvzuPQieVDlZ/p6T3Yd/L1hZ7feEdLmzsD28
         aZmDXrkZtQYwATKeKIPMgHhwg+xWAsWIwjwCdwT621lfUMwTdBSGRRG9W6kNpOfTgNR/
         eBC4K2BnUz248QiQLid9uNafWRvKFDyyDjWtGSmRbJcbIftPl8kYToj9uKACwOa5+0SG
         i/9EgR3Vq6WxhK7tMK+MY64ecK6t1kB+3Og958L076S0ExASqn4ftQHI5akFAsgQdXz8
         ZpwbcxZAN3JlaE1ZcWUNmVx7xSzzcFehYCxVe77BLtdtw4AROurt5soR9Jb9z94eWuDZ
         WE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZRChpZav5IUrRCCfNMjwsJ5gE9vU0npcYHbSte7ykZQ=;
        b=Yt34FXQ7XMacqQpaupSi+vAkidqTfkWnrzyGUgXmdapikbJfTxjk6XmI1DIGQxiada
         qRX75O6XSnEjwo4YLYyJN7jKXiEy1G3V+hrBS+3S7sRaLvxS+r2u17UaSrg3Yyv9WWil
         tw1X1HYnK+S+VjvZUlSiKOQfYonsapxOhwfBaeiDdcH070PrINlLMAsql0kHb+PrJb08
         ftPPVlOXR2/92Zd/651rQx7FA7WCpogrRp7Y+fMTUAEqKw6D84BfhFihS+g5zjnZID53
         lV97+esFaXin6pzre6+11GhQOCX5lK8+jEQumPf0+s6pbR/vGbtJbXpcvoszSM7fjc1y
         OPTQ==
X-Gm-Message-State: ANoB5pnVQTxFG+Drqh9AWgkUasRDuoMP0e6FQz4xBw0MA4R0iFw0LNEm
        bGESsKL7FOn/MDx0qA7RgUwf4w==
X-Google-Smtp-Source: AA0mqf7uaiW9KUWwAqUqSe0UQVeO4qsy7A6HdKkJOVvJ+/TBdv5/aPmr2UcMgA37azQM7d8VmMiDWA==
X-Received: by 2002:a63:f5a:0:b0:470:18d4:f18d with SMTP id 26-20020a630f5a000000b0047018d4f18dmr47532513pgp.295.1670027531410;
        Fri, 02 Dec 2022 16:32:11 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id q14-20020aa7842e000000b00575cc2f74ffsm5665749pfn.35.2022.12.02.16.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 16:32:11 -0800 (PST)
In-Reply-To: <20221025151831.1097417-1-conor@kernel.org>
References: <20221025151831.1097417-1-conor@kernel.org>
Subject: Re: [PATCH RESEND v9] riscv: add riscv rethook implementation
Message-Id: <167002752044.1717.9764530676447697647.b4-ty@rivosinc.com>
Date:   Fri, 02 Dec 2022 16:32:00 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-e660e
Cc:     l3b2w1@gmail.com, Conor Dooley <conor.dooley@microchip.com>,
        davem@davemloft.net, mhiramat@kernel.org,
        anil.s.keshavamurthy@intel.com, linux-kernel@vger.kernel.org,
        naveen.n.rao@linux.ibm.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>,
        aou@eecs.berkeley.edu, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2022 16:18:32 +0100, Conor Dooley wrote:
> From: Binglei Wang <l3b2w1@gmail.com>
> 
> Implement the kretprobes on riscv arch by using rethook machenism
> which abstracts general kretprobe info into a struct rethook_node
> to be embedded in the struct kretprobe_instance.
> 
> 
> [...]

Applied, thanks!

[1/1] riscv: add riscv rethook implementation
      https://git.kernel.org/palmer/c/b57c2f124098

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>
