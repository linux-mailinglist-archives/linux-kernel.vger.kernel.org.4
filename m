Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEC05E8DAB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 17:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbiIXPDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 11:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiIXPDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 11:03:32 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D103C33E15
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 08:03:31 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso2868683pjm.5
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 08:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=qYvrAhig9F+unAPbd1/716L+dnUCLnsOlccNkw3UIUE=;
        b=6sjPQqTHqh7TGwi+KhrasovGQqG7CjZ0zXuHfDLtmqEv/w9/By8iRWQA3HuTVh0rbo
         KkWaTY5mlB69ECJA1ZUr5HtH1Z5LS6U24HxJ/7WXnD47J9uAHa7fDDzOwbFfIKB6Nxju
         mT8bYVXg4xhEc+GUMiQk7wicaBjUt4nNeyzsvtLuU73suBz34sGRutkufdjT/g6wRqta
         X9SZH6oMKVrYjX5o4idOfKK+uh5+vqQqEIs+9/lm9BmV3CecbBqNCIxVwFsSYP7/bohr
         WyFLI0zho83xlrJsREkNCy/3wPC2K3iBZTOLN2rQpczFUe4CcYNXIRyMAVOBIV4HZc6G
         CChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=qYvrAhig9F+unAPbd1/716L+dnUCLnsOlccNkw3UIUE=;
        b=Y3vc/svwdJD0DVMFXCeOG3qTO9Kt+uZuXzyDMi2/D62puI/ywHx/v55ZeEGAVQuU8K
         OeuKmtfbnW5DF2+kNdJcFHcDRcCJzV2k/EQssHmA9MjvxN8R8vSOnca+mK7kFS7+T+TX
         287937mNVOArdGbvWVSAsl+pb7UDhGvwgVoy3F4JBtKon6nK68VX+RK4l9LGIyjkxAvP
         7JCv5dw+Ks2Komtg6aQbGzLqc0pqCwKduP6bCdY6FkOM6pL3m087OhCloH5rpCo+Mdg7
         VsDLUBqLRAAWFXODqXfxmw2CD+iVFfetUhsd3BZqKM4BfsPdw1FqYpztsA5rUPq/l3fI
         p/2g==
X-Gm-Message-State: ACrzQf23frcFKn7Q1C3PqgpjcTzckcTqmHaSjC4Kwze9LjgFIgJu15Nv
        3GAS39LQlVbIfGKc4CFV7LzuWQ==
X-Google-Smtp-Source: AMsMyM77oFWrzITHf0GXE3CUYxCjbosxOWcz9VPKexh2E83ai54BK/cGR4Crh9dFP6BT+CnPGPp3Yw==
X-Received: by 2002:a17:90a:e60d:b0:201:6b28:5406 with SMTP id j13-20020a17090ae60d00b002016b285406mr26532669pjy.228.1664031811263;
        Sat, 24 Sep 2022 08:03:31 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902650f00b00174f7d107c8sm141790plk.293.2022.09.24.08.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 08:03:30 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Liu Song <liusong@linux.alibaba.com>
Cc:     hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, kbusch@kernel.org
In-Reply-To: <1663731123-81536-1-git-send-email-liusong@linux.alibaba.com>
References: <894e18a4-4504-df48-6429-a04c222ca064@kernel.dk> <1663731123-81536-1-git-send-email-liusong@linux.alibaba.com>
Subject: Re: [RFC PATCH] blk-mq: hctx has only one ctx mapping is no need to redirect the completion
Message-Id: <166403181034.5940.4446452471783801931.b4-ty@kernel.dk>
Date:   Sat, 24 Sep 2022 09:03:30 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-355bd
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2022 11:32:03 +0800, Liu Song wrote:
> From: Liu Song <liusong@linux.alibaba.com>
> 
> High-performance NVMe devices usually support a large hw queue, which
> ensures a 1:1 mapping of hctx and ctx. In this case there will be no
> remote request, so we don't need to care about it.
> 
> 
> [...]

Applied, thanks!

[1/1] blk-mq: hctx has only one ctx mapping is no need to redirect the completion
      commit: f168420c62e7a106961f2489a89f6ade84fe3f27

Best regards,
-- 
Jens Axboe


