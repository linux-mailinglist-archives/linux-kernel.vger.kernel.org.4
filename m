Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8334473FB52
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjF0Lq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjF0Lqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:46:55 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C30C120
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 04:46:49 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3128fcd58f3so5224474f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 04:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687866408; x=1690458408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=93ix1PFwMGcYNWGV6IVWE0KIXtRQfJZmFaSipqA6+E0=;
        b=knLhWB3B+Xvns39e03ZtlStEtYlzyXWGSq9r+d8G+edWTvVdD6Q6ov+pClnJ49668e
         FJ72HKXTWQfDhfCg8OyP7AGd9zSozHaUFxEPvmg0eaiJbJ/3wVw0Sg/VjRZ6APS1ZH4l
         IVPX6Gpc6oDUZTOxU+6Ly+iAwlcN8NYyS4owJF1b7Iqgk5Oc71ZspouBY01BW3fF80hn
         RtMSccfIuhHoX5sTc9hvTWKtc9YvdV4mthtb/px8nAZMlTJV8z6qtmjkbbhSd0Su4KFg
         sxC8KJaoJD0z7jPXCbVzK4I2CM8kWHF6kGFpQe1o3P12DMNE7hI6Hsz2P3+OqPcJUAz3
         ZUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687866408; x=1690458408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93ix1PFwMGcYNWGV6IVWE0KIXtRQfJZmFaSipqA6+E0=;
        b=lYmgusddvwvLYw7uBW1prewRk5E+VpYzmtPfD7oZvhL1507hrUPxzYkb4gIQizbJmu
         OY13XkfKT6ah8Kiy3N5lM7ctKTKcX2ufvA1dwTpAMXI6zVSfGsugdr7c3YPL2oaok1rE
         guzlxOBLAu/VOYDXcN1Mvwoj/5eZsR651c1NwDBhaYfd+/KgS+neQ5dgdobXKM3clHUk
         j269Wa3Q/jk1l2nHAiP1WqBkN61a6kcHPTYVN7/rrXrRX4BNcdvAM+WE3Dub5paC3R7g
         6atrKal9ZbJShOH64f3GV9dIKQ/ATtiuEo0OwYp9peT0z1stxs+oR58zIct6L78AWMaH
         u67w==
X-Gm-Message-State: AC+VfDyiV1M1nv/T8gBIz/oOX5HjKffoUGZFB6EHx9HKDW0+JqZQF3MU
        Pm3FVepQbM/gp0BtUQeH2Co=
X-Google-Smtp-Source: ACHHUZ7CyvZzAJr6uBq6De/Xba+6rOZ+iq+1IZHD5Wl0NIxxIwDKi3dF5dD3WZCivlMEJaZIfBNCZA==
X-Received: by 2002:a05:6000:1370:b0:311:1a45:3606 with SMTP id q16-20020a056000137000b003111a453606mr25243539wrz.30.1687866407799;
        Tue, 27 Jun 2023 04:46:47 -0700 (PDT)
Received: from gmail.com (1F2EF7E2.nat.pool.telekom.hu. [31.46.247.226])
        by smtp.gmail.com with ESMTPSA id j4-20020adfea44000000b0030fa3567541sm10253726wrn.48.2023.06.27.04.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 04:46:47 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 27 Jun 2023 13:46:45 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] objtool changes for v6.5
Message-ID: <ZJrMJYz285GLB881@gmail.com>
References: <ZJrGGfFl4MHEeftI@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJrGGfFl4MHEeftI@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> Linus,
> 
> Please pull the latest objtool/core git tree from:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2023-06-27
> 
>    # HEAD: 301cf77e21317b3465c5e2bb0188df24bbf1c2e2 x86/orc: Make the is_callthunk() definition depend on CONFIG_BPF_JIT=y

I forgot to mention that there's a new conflict when you merge this, in 
tools/objtool/check.c, plus a semantic conflict in the new 
tools/objtool/noreturns.h file - to remove the 'btrfs_assertfail' entry 
from the new tools/objtool/noreturns.h file.

Our -tip CI conflict resolution can be double checked here:

    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/merge

Thanks,

	Ingo
