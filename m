Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A155C7261AE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbjFGNwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbjFGNwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:52:35 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F911BD9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 06:52:34 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-75d4f06b302so62378285a.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 06:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686145953; x=1688737953;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ATelbEey9YqITdBNEhlVknT1NxjwiMcqCvYxHbd4Ko=;
        b=wMhwr1xfNlbDE70oKXzzLiEU+1vVgxU1IosZYD9QCdsLJketjJpcw9/+2UEVNdbyhO
         mjez+vxtn4nOpS+3qUCAiq7PgJW2fPPpx0+Uv0XQJqBoN4yMoLrt2Rl9awgnH2XqQjk6
         gNQvqEXTryqWlAW49owoodgWmsql0YrHRxj+uanNJEXDFgifyusJrBgJtLYkPQRbMUb9
         w59Y6jF2jeUf9QkVGQbGcCqtc5V00MFJ5rnpgZcUoJnD9raRZz+B59Nui/QFnOFvSgIT
         2jim8ft8cz+Ki/3p817pH8t6WP9TlHlZltm5bZ3z84CoSsBpvhorG9WvVW53z5wLoO1D
         Pb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686145953; x=1688737953;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ATelbEey9YqITdBNEhlVknT1NxjwiMcqCvYxHbd4Ko=;
        b=e9E53zcfVtcpP/wVkQ/8c/VksbuZmO0HgKWuf1TJzV+jnB5wDd8iJECwnXN1w1b9AF
         AevBrDJrhv5QVJGfLSUMjnt5Iro6/gwJ89ANcgea7aYqslmKEsCsHc2Xpnl7iLjom1jx
         5BZX9i9H9V1apcLZzzrK5/ptITTzvHLDeaFrpmWL+zFjZGDOERkRUUhMUfMPf/h8oebI
         KclIU3iz4s45hKej4iMKD+rmeqVR2qHG0O7C2RF4UWiJaFdwkK7Vx9vRhOoiKBkuPFSd
         O6eN1RGac2BxgNuHHAme+gvef27sfu+XSXxkiGu31SoIRSMWJx0y1Jf1yNxNakVf6yw8
         sAKA==
X-Gm-Message-State: AC+VfDw2DEkQKWmCbBn3Pv5Xzu5V+qOArk/cUPGXND+AcX3SA9LDlp3G
        qIVc1GbkxwZIil4xq/jKaJGgoQ==
X-Google-Smtp-Source: ACHHUZ49Oh3b7Y6iFWQKYu5DqKnGXEfj1mjRUktdPRfW2jeikSvwGrTUsu6pWhn2aXJbSK88m7oQzQ==
X-Received: by 2002:a05:620a:1a89:b0:75e:da20:a10e with SMTP id bl9-20020a05620a1a8900b0075eda20a10emr2222379qkb.3.1686145953723;
        Wed, 07 Jun 2023 06:52:33 -0700 (PDT)
Received: from [127.0.0.1] ([50.234.116.5])
        by smtp.gmail.com with ESMTPSA id s5-20020a05621412c500b0062119a7a7a3sm6141611qvv.4.2023.06.07.06.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 06:52:33 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     hch@lst.de, yukuai3@huawei.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20230606011438.3743440-1-yukuai1@huaweicloud.com>
References: <20230606011438.3743440-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH -next] blk-ioc: fix recursive spin_lock/unlock_irq() in
 ioc_clear_queue()
Message-Id: <168614595209.134969.6798849940705397930.b4-ty@kernel.dk>
Date:   Wed, 07 Jun 2023 07:52:32 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 06 Jun 2023 09:14:38 +0800, Yu Kuai wrote:
> Recursive spin_lock/unlock_irq() is not safe, because spin_unlock_irq()
> will enable irq unconditionally:
> 
> spin_lock_irq	queue_lock	-> disable irq
> spin_lock_irq	ioc->lock
> spin_unlock_irq ioc->lock	-> enable irq
> /*
>  * AA dead lock will be triggered if current context is preempted by irq,
>  * and irq try to hold queue_lock again.
>  */
> spin_unlock_irq queue_lock
> 
> [...]

Applied, thanks!

[1/1] blk-ioc: fix recursive spin_lock/unlock_irq() in ioc_clear_queue()
      commit: a7cfa0af0c88353b4eb59db5a2a0fbe35329b3f9

Best regards,
-- 
Jens Axboe



