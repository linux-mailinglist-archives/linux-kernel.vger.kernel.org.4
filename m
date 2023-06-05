Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F94722E5C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 20:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjFESJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 14:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjFESJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 14:09:04 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA90ED2
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 11:09:02 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-25945de43c3so323961a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 11:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1685988542; x=1688580542;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbhZgeRfrMzo8RZUjiv5Kr8KvV2/iK/o9SdLtbvSVL4=;
        b=M12TBi/qdCVHqFYGFxUaq8Xsf9tqgm2Saa+5o3o1AI1a3KbqNFyMgmbcVKqIov05Ci
         uMu1xJio3U6fVN1G/jl2PUsd6FfTM2VoZDOwX7lR25xQYp21IAoM8ZUY/ZFgfbyD0/sV
         1KfXLD/Y35e9+smYan7Kr0Rem30tgZYv9c1pkZmEhNS3G64FQ4tbzn+Z96fOlAH7oCKE
         70Mug7V/5btfozq7bpQdOHu/l9UdwCtFocNQzW7AxzrKfoRhhwBlyuGyqmjY35AoVCsP
         1bBlhI363MBzD9H2yKJRzFRGAoewe0XkRBxhBpjKASyBecCg93NxosUIBRL4RHua0PUg
         e6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685988542; x=1688580542;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SbhZgeRfrMzo8RZUjiv5Kr8KvV2/iK/o9SdLtbvSVL4=;
        b=La7zioeqeDvHs5P1+v+pGnES8m7oaxQD/+dYVK9UplexF4g325h8J9gRwtnkW9xbeb
         1Dl7JwL/MVJn3reIHopi9GjzW5B/Oy5qCTUP3qP5EWdCPuJGnm+39hnallRNm5He1pt+
         X/rxP4xIxnwdaYhOUN8JCVBcvpm4MoKc6Khgo3E5N87iCu8TCNg0tkvt0qmURZUadfIH
         n4ty7Of8nJ2Zp4lqN9oLRIgA/yO/M5Jw3PGJ0svl2IAOfFjyvf65kwYIuEtoLL3y+JSD
         T2a90tENQnq6J9YMJtFCPRWCbI6DZg49AlEcRrfDhe2hu5r4fDZgP8NQeDvYNYqVhbCn
         93iw==
X-Gm-Message-State: AC+VfDxXdSxaAlosrpBD7CSnceUE1O8uZ+0RSawfiF4S0Q9qzABwvmHn
        AB/me2LzqYaOxaFO2sxP8ud5Gw==
X-Google-Smtp-Source: ACHHUZ5x1VhEu0cbk+F9o60l7ZlBAYq207KYwhSkbPgBXjs/jRHW4y+9It3zndPrTP6WOfYfW5+i8g==
X-Received: by 2002:a17:90a:e7d0:b0:256:4bc:6bc8 with SMTP id kb16-20020a17090ae7d000b0025604bc6bc8mr23198257pjb.2.1685988542338;
        Mon, 05 Jun 2023 11:09:02 -0700 (PDT)
Received: from [127.0.0.1] ([2620:10d:c090:400::5:a83f])
        by smtp.gmail.com with ESMTPSA id i9-20020a17090a2ac900b0025645d118adsm6656422pjg.14.2023.06.05.11.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 11:09:01 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, josef@toxicpanda.com, linan666@huaweicloud.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linan122@huawei.com,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
In-Reply-To: <20230527091904.3001833-1-linan666@huaweicloud.com>
References: <20230527091904.3001833-1-linan666@huaweicloud.com>
Subject: Re: [PATCH] blk-iocost: use spin_lock_irqsave in
 adjust_inuse_and_calc_cost
Message-Id: <168598854044.127564.8532399641861277056.b4-ty@kernel.dk>
Date:   Mon, 05 Jun 2023 12:09:00 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 27 May 2023 17:19:04 +0800, linan666@huaweicloud.com wrote:
> adjust_inuse_and_calc_cost() use spin_lock_irq() and IRQ will be enabled
> when unlock. DEADLOCK might happen if we have held other locks and disabled
> IRQ before invoking it.
> 
> Fix it by using spin_lock_irqsave() instead, which can keep IRQ state
> consistent with before when unlock.
> 
> [...]

Applied, thanks!

[1/1] blk-iocost: use spin_lock_irqsave in adjust_inuse_and_calc_cost
      commit: 8d211554679d0b23702bd32ba04aeac0c1c4f660

Best regards,
-- 
Jens Axboe



