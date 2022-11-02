Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2AE616550
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 15:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiKBOpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 10:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiKBOpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:45:15 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAEB29CA0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 07:45:14 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id y6so12210437iof.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 07:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GN/nbg0NqP+NEJxaNuJMBwfso2nkMgjJidOrNm8QtFU=;
        b=bQBxfhiwJB0A4fnRM2tR0zguyn2rI99KjpRcf0nQeq/QIVCJGTuiYvCHKuBlLL0NNj
         /mANaogE5KnAetT3XRwoZSlT7BR8O4rLYKBjefVL4hXzv0tGCMZIpBk0qFzkbBB22gCl
         It7iC828jxpzx6GVOb2AmbCsW0xvONfcUTX2LdpBqdzIhRjfL3uxdWLq4PCD13KKNAgx
         /rRrGLJLXOMTNQcyF/cmUMs6c6Ci+CsLysZKYxxyco5j0gejhEXRRaZMiteuroGkZu+e
         y75GXKMoexi6OXL36K/R+V0+9aV4EJj8NnsuG1eV9E2LCX1vCE/OUrOrQTUWDTzMyQdX
         4CjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GN/nbg0NqP+NEJxaNuJMBwfso2nkMgjJidOrNm8QtFU=;
        b=pOQVZf6tjwAB3rf/88TxRunwHjjg7mGNajW9jg1dv0xbnyqVruLXr31WUpTngijU1A
         xMiQTLvxWHTmNkh5O+neR/T8ABVFFAZ3Xdg1oJUwALPABd5/Fv/NZ9WLDCJGWhyQhkj3
         VLueO2O+3o3rSI7Bv7/Tdj0XMrr1A1XWbxIiYCmZ8sJrigki8ExSdylGu9+8BvXyuiA6
         ViWbPjXAKcHQtvXVwmEfJuPHV8Nx7ELkomfnTz5IQ4TNcvw94uuC0V7Sv+2FZKnfxZpu
         cvwVORrsc8zv0mq6gafhbobVAKZrjuCjop/OeRYpvzMbTZPL34vi4bfVr6M02FH8cYVQ
         GNGw==
X-Gm-Message-State: ACrzQf3d0vyCkdKt9SwjcTu02X+ToAdiF8e/9+sbj+96M22o0bkz48Vc
        owNEReUKwHHcGRfA5a+LEwFvVw==
X-Google-Smtp-Source: AMsMyM7yWb1iHppp84a2Y0gyk1Y2/6pYyWpNY0suhiLLKynG3JDkyOIyPAPGHLSUj31cTL6X3dEb9g==
X-Received: by 2002:a05:6602:2d82:b0:6d4:cc5d:b980 with SMTP id k2-20020a0566022d8200b006d4cc5db980mr1891378iow.80.1667400313218;
        Wed, 02 Nov 2022 07:45:13 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t4-20020a92b104000000b002ff32b2ab1esm4615692ilh.1.2022.11.02.07.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 07:45:12 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        chaitanyak@nvidia.com, hch@lst.de
In-Reply-To: <cover.1667356813.git.nickyc975@zju.edu.cn>
References: <cover.1667356813.git.nickyc975@zju.edu.cn>
Subject: Re: [PATCH v2 0/2] some random cleanups for blk-mq.c
Message-Id: <166740031203.45892.11870428706627551730.b4-ty@kernel.dk>
Date:   Wed, 02 Nov 2022 08:45:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2022 10:52:28 +0800, Jinlong Chen wrote:
> Patch 1 improves the error handling blk_mq_alloc_rq_map(). Patch 2
> improves readability of blk_mq_alloc_cached_request().
> 
> Changes in v2:
> - drop wrong and worthless patches, suggested by Christoph, Jens and
>   Chaitanya
> - remove silly goto-return-NULL in patch 1 (patch 2 originally), suggested
>   by Christoph and Jens
> 
> [...]

Applied, thanks!

[1/2] blk-mq: improve error handling in blk_mq_alloc_rq_map()
      commit: 7edfd68165b8dab8cde231728ff092a625469eb7
[2/2] blk-mq: use if-else instead of goto in blk_mq_alloc_cached_request()
      commit: 4046728253751adb41b05e85ebd686210efde1ad

Best regards,
-- 
Jens Axboe


