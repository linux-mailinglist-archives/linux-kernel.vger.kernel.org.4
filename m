Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4849263F8B8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 21:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiLAUAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 15:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiLAUAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 15:00:46 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A170B496
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 12:00:45 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so3168464pjm.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 12:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p2tI5HdhCwiN69OAnPTmJeg0B+xd577KH88UEmawIS0=;
        b=ROEeyDLQ0/2mGltxq6Nzk8X5cwWVDcLB2O14n9c4pKZE7r8OXSDufnakDsaeKilEu6
         V4RDXN2fwEzJFF7OVkqXTC1yR40bGt39Jg6nXVQnCUFO+M98GiQjbCac8lG+irfgfPAx
         uYLxMMTxL6TBhCzgFD2uz8dpnoRG7vM9OfIE80iOgBgkc5K51BblbrMGxMlykjhlpTD0
         uUZq8j8FFLTZ6MKkwgSmLhFcVKDs8hJOU9jNrZx2+AxKLgNLUEnspStctVvC+7qfNXed
         b7vEa2ltBRj9czNUBan0MUWjizJe6g2P0/Dzoc4Won8BiRibRfTMTe6En45m4xJnUEwX
         kNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2tI5HdhCwiN69OAnPTmJeg0B+xd577KH88UEmawIS0=;
        b=Wc3RSUZaQm9/qqZRWQ2ossKjczv4b7TJtjrS5Db5aRoi/ARGjtDF41ikxIsD+AZD2W
         QaJWUC1DrNnU0Pi1vdC2+NboF3AHk0KGVEn5edH8fE/akULwL0gdTUocEaIUJCPD4J3b
         IEkfG9LmVHG6Pq/b28ZajKtdNv8paia2qKM0uGo3hFBeFCai2zQWrMQdUL83YGPn9YCp
         BW07wJKCFEbupMQxEvkSx6oaQx7gL1vew0ZXccFgPSj+m4foq3azqRfbPqTAUOc4fPB5
         MzuzGQQNewULL3vR9nwhCQf5S0nXrdg4wNSpWkrriS1sR5AmT41q3KaS7kfwnT/TK2sp
         2AsA==
X-Gm-Message-State: ANoB5pkL1P4fEutjlQJCpDO7cWAtzjLCOh5G3ljtxR5S7qE9+2jOnIVG
        qfWCwqLFDIKJtVW12BDQ+QQ9tQ==
X-Google-Smtp-Source: AA0mqf63UnXMDCarclEpJATkO7Xj2jd5Vk+Mt/6A9rtUCNb7aKrYa4QY4W8An4qOxazR+hukawrAMg==
X-Received: by 2002:a17:902:6904:b0:185:3f7a:50cc with SMTP id j4-20020a170902690400b001853f7a50ccmr48245010plk.99.1669924844446;
        Thu, 01 Dec 2022 12:00:44 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id v8-20020a17090abb8800b00218daa55e5fsm3422640pjr.12.2022.12.01.12.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 12:00:43 -0800 (PST)
Date:   Thu, 01 Dec 2022 12:00:43 -0800 (PST)
X-Google-Original-Date: Thu, 01 Dec 2022 12:00:19 PST (-0800)
Subject:     Re: [PATCH v4] riscv: fix race when vmap stack overflow
In-Reply-To: <Y4gSJnVh1/lUSnWo@andrea>
CC:     jrtc27@jrtc27.com, guoren@kernel.org, jszhang@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Andrea Parri <andrea@rivosinc.com>
Message-ID: <mhng-e1799ed5-c012-40a1-b730-c20627cdb3f9@palmer-ri-x1c9a>
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

On Wed, 30 Nov 2022 18:43:32 PST (-0800), Andrea Parri wrote:
>> >>> @@ -23,6 +23,7 @@
>> >>> #define REG_L          __REG_SEL(ld, lw)
>> >>> #define REG_S          __REG_SEL(sd, sw)
>> >>> #define REG_SC         __REG_SEL(sc.d, sc.w)
>> >>> +#define REG_AMOSWAP_AQ __REG_SEL(amoswap.d.aq, amoswap.w.aq)
>> >> Below is the reason why I use the relax version here:
>> >> https://lore.kernel.org/all/CAJF2gTRAEX_jQ_w5H05dyafZzHq+P5j05TJ=C+v+OL__GQam4A@mail.gmail.com/T/#u
>> >
>> > Sorry, I hadn't seen that one.  Adding Andrea.  IMO the acquire/release pair is necessary here, with just relaxed the stack stores inside the lock could show up on the next hart trying to use the stack.
>>
>> I think what you really want is a *consume* barrier, and since you have
>> the data dependency between the amoswap and the memory accesses (and
>> this isn’t Alpha) you’re technically fine without the acquire, since
>> you’re writing assembly and have the data dependency as syntactic.
>> Though you may still want (need?) the acquire so loads/stores unrelated
>> to the stack pointer that happen later in program order get ordered
>> after the load of the new stack pointer in case there could be weird
>> issues *there*.
>
> Agreed.
>
> Just the fact that this is the 4th iteration of this discussion strongly
> suggests to stick to the acquire and these inline comments to me.  ;)

I spent a little time last night trying to reason about the no-AQ 
version and I think it might actually be correct: the AMOSWAP is on the 
lock and SP is overwritten when loading up the actual stack so I don't 
think that's enough alone, but the no-speculative-accesses rule might be 
enough here.  Also I think mabye none of that even matters, because the 
same-address rules might bail us out due to the nature of stack 
accesses.

That said, this is some complicated and subtle reasoning.  The 
performance here doesn't matter so I'm just going to err on the side of 
caution, but if someone cares enough to come up with concrete reasoning 
as to why the barrier isn't necessary I'll at least look at the patch 
(though I'll probably gnumble the whole time, as I hate being tricked 
into thinking).

That'd be for-next material anyway, so the yes-AQ verison is on fixes 
beacuse there's a concrete breakage being fixed.
