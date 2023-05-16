Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C8470504C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbjEPOOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbjEPOOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:14:36 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA051FFB
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:14:35 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-645cfeead3cso1927640b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684246475; x=1686838475;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cCxvGJajOXCMUGeHJZr6/Oyl9zRWStp7x7yawhzT6QU=;
        b=sGkGwfptGEfX2TcFtw52PNDHgWfDqqPwNnOO9EEvpAplpLrpJ/642P6u8YXz71N5q5
         DwroumVlR3PxNl8Mo4zdeQfBBNiH9ZSg7PsbsGuqcgr8kqOLOcqPFl2lizhN1SR8EYmM
         bgBn5oMM5EdQgeRhOMC1HMYZ/L5IZNZfReYWEc2cq9k2cIIwquLPL3XHW4ciC+r+7Cgm
         ACRR/4pavdBT0MptSdhryYBpiNuVbBZqUbuCIe1MqAN2R8nvca34wvqt4FuMU0o93tgv
         /JAcsxNZyA0WHMWt2pGZkOrLAmFlJlqnBNN9U0rZObO91KUemCJmz9x9Fo2mQemdT/XR
         kCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684246475; x=1686838475;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCxvGJajOXCMUGeHJZr6/Oyl9zRWStp7x7yawhzT6QU=;
        b=LHB6U8JTomLSXhLs8Ebs8gWtfwxE6AIXUmqAgxwazzk0c7eaF5ZluUaRnldPmwpe0l
         IGKoEVR6uGpG+l0mSrzMD9t11yl8UzIUCgzcWVZU/6PxZuixS7dVnNjVZQ+mxZ+qSPly
         Rx5BfnHvZpusIuolodH5X2IA/4Rio3azz3ravMHijh8BD0jmGfBbaaATE400sF03duJo
         GKNb0OBu6jpMymy0l/0VEeTe5dRuP8ZuEb4IlyzviPCyy5wPTSbdq9mR+hduB5Vkz2cl
         XmW/OPNXS3jeLYqScbdSHBNfRJSkPCmIoV8nHIbJ7MLV7A4KQrvfjbMic7SeVfS1BgWQ
         A1+Q==
X-Gm-Message-State: AC+VfDzbhLWMDgZWuC6Gczyo63cHCU1rEWskSV7C64ZIXwd87TB3ivBG
        ujvaHMo9Hj643WoqKasToaZG3XEAqIpYygPU3Go=
X-Google-Smtp-Source: ACHHUZ4ArrQmcdldMUd/RhtEp98ANEbUxDowKAOxeDQn1K+i8+lUFT7CVOAvpGIl+9mbI6ehtzH9Lw==
X-Received: by 2002:a05:6a21:99a2:b0:103:9d9b:1ebb with SMTP id ve34-20020a056a2199a200b001039d9b1ebbmr4696510pzb.0.1684246475143;
        Tue, 16 May 2023 07:14:35 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id r15-20020a170903020f00b001a1a8e98e93sm15592351plh.287.2023.05.16.07.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 07:14:34 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>
In-Reply-To: <bc8f431bada371c183b95a83399628b605e978a3.1682699803.git.josh@joshtriplett.org>
References: <bc8f431bada371c183b95a83399628b605e978a3.1682699803.git.josh@joshtriplett.org>
Subject: Re: [RFC PATCH] io_uring: Add io_uring_setup flag to pre-register
 ring fd and never install it
Message-Id: <168424647374.1741575.7066874860468744586.b4-ty@kernel.dk>
Date:   Tue, 16 May 2023 08:14:33 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 29 Apr 2023 01:40:30 +0900, Josh Triplett wrote:
> With IORING_REGISTER_USE_REGISTERED_RING, an application can register
> the ring fd and use it via registered index rather than installed fd.
> This allows using a registered ring for everything *except* the initial
> mmap.
> 
> With IORING_SETUP_NO_MMAP, io_uring_setup uses buffers allocated by the
> user, rather than requiring a subsequent mmap.
> 
> [...]

Applied, thanks!

[1/1] io_uring: Add io_uring_setup flag to pre-register ring fd and never install it
      commit: 6e76ac595855db27bbdaef337173294a6fd6eb2c

Best regards,
-- 
Jens Axboe



