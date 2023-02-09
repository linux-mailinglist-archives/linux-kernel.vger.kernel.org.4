Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933556914E3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 00:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjBIXsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 18:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBIXsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 18:48:20 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9FE3803C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 15:48:18 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id s89-20020a17090a2f6200b0023125ebb4b1so3884328pjd.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 15:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TbWYdqHwSto9YO7YB+6UGbw5fXLIzmmd65qc7lLKVWc=;
        b=voxfkaqKTjidecOv8HFOLzIviY9xDjRoVvioBFOWhSdCEJOPDorptBWE98l/Qd4mLF
         5vb87gMNXo95OnE3zYO9LqzZ//zrzdTxBnd7pHEJCuNxmmy5MDz0bYYvdcOpYBUNNRQe
         8jIuQAMrYIKrq2M09Z3cI4ZqAVE5CAO8p+TXFjFJtiUfB3xV6oDdJWuya3nJLH538xh+
         W2MuiRB1BrrgXit7boq1g4vjJZuh5XfcZwu2ggOqHoUBi03nbhbV+5cxSAJAG7KwlwJZ
         ubmNAqOnh9KwwbUw4tkgDQqbhdJVboD6t/EG8wNCfQm48Q/fJeleZhuR0I/qaoLKruFR
         MVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbWYdqHwSto9YO7YB+6UGbw5fXLIzmmd65qc7lLKVWc=;
        b=rR7He8pJNhwB8wSYEG6f5eIU65ykPQqAdEzyog1h5HdX7Neq3OVjg7yTICu07uQoYz
         KBsLzvqICOyL715MJwyE46OOSkLqagOayQBxVyNEcht59KWGlXFJGpq3baNtywICUnoY
         fs2vqe07hB5zw9rfJLBHUMKFWGM09srDqzGkZCAyp9NN5Az7WfxIjw+B9AHwjq+5kyUh
         k1+KI6Lr1ZndXm5kMYFovrSZEFxAF9fNQ6lvfsEsvrL0ql9fZfk4LnfDEc+sHhCrYZpq
         zkqGW1iIX788SCN4aTApd6TH+eLUv0ktbsX3WZvzpzgCY/9Y5/vTSW8uxdDrSa7Q6Dlw
         OR7w==
X-Gm-Message-State: AO0yUKXxHyNS/BehD+eq+wOfA2Cl7OULnW6WP+wmtM6HiN7cCEF8SZ44
        u1IfqlsYrsHb5BeAbogeiTDqiw==
X-Google-Smtp-Source: AK7set8BpY5cU5Bd5cEH6MQ9aM5cGH2OqoALs0sQq+FyHtNt11Dq6OnthUY0jZwTvEmqw/3PHOqajA==
X-Received: by 2002:a17:902:da8b:b0:199:bd4:9fbb with SMTP id j11-20020a170902da8b00b001990bd49fbbmr15173197plx.43.1675986498356;
        Thu, 09 Feb 2023 15:48:18 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id jd2-20020a170903260200b001946a3f4d9csm2097465plb.38.2023.02.09.15.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 15:48:17 -0800 (PST)
Date:   Thu, 09 Feb 2023 15:48:17 -0800 (PST)
X-Google-Original-Date: Thu, 09 Feb 2023 15:47:34 PST (-0800)
Subject:     Re: [PATCH] clocksource/drivers/riscv: Refuse to probe on T-Head
In-Reply-To: <Y+WEfc2fYd3qJmUe@spud>
CC:     linux-riscv@lists.infradead.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-c66f0475-5f2c-4aab-a532-7ce026fd5413@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Feb 2023 15:40:45 PST (-0800), Conor Dooley wrote:
> Hey Palmer,
>
> On Thu, Feb 09, 2023 at 03:23:02PM -0800, Palmer Dabbelt wrote:
>> From: Palmer Dabbelt <palmer@rivosinc.com>
>> 
>> As of d9f15a9de44a ("Revert "clocksource/drivers/riscv: Events are
>> stopped during CPU suspend"") this driver no longer functions correctly
>> for the T-Head firmware.  That shouldn't impact any users, as we've got
>> a functioning driver that's higher priority, but let's just be safe and
>> ban it from probing at all.
>> 
>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>> ---
>> This feel super ugly to me, but I'm not sure how to do this more
>> cleanly.  I'm not even sure if it's necessary, but I just ran back into
>> the driver reviewing some other patches so I figured I'd say something.
>
> I'm not super sure what you're trying to fix here. That revert went
> through to restore behaviour for the SiFive stuff that do deliver events
> in suspend.

My worry was that we'd end up probing the SBI driver on T-Head systems, 
where it doesn't work (as the combination of SBI timer and SBI suspend 
depends on unspecified behavior).  So we'd be better off just failing 
early and obviously in the case, rather than letting users think they 
could get away with only the SBI drivers.

> Subsequently, we added a DT property (probably the wrong one tbh, but
> that's all said and done now) that communicates that a timer is
> incapable of waking the cpus. See commit 98ce3981716c ("dt-bindings:
> timer: Add bindings for the RISC-V timer device") & the full patchset is
> at:
> https://lore.kernel.org/linux-riscv/20230103141102.772228-1-apatel@ventanamicro.com/
>
> AFAIU, the binding for the T-HEAD clint was only accepted in the last
> week & there's nothing actually using this timer. IIRC, when I wanted to
> test the timer, Samuel cooked me up a WIP openSBI etc to enable it.

That makes sense.  I'd assumed these DTs just had the SBI timer in there 
(as a bunch of other stuff requires it), but from Samuel's reply it 
sounds like I was just wrong here.  I guess we're sort of in a grey area 
for DTs that aren't in the kernel source tree, but this code is ugly 
enough I'm OK just ignoring those.

> So ye, I don't think this is needed fortunately!

Ya, I think so too.

>
> Cheers,
> Conor.
