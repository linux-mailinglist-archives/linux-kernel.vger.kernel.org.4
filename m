Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBEB6BD09B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjCPNRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjCPNRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:17:45 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43874CC33A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:17:15 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so1546939pjg.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678972634; x=1681564634;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pezwyd0vG7hsp540g7EcpBHXx5rGXUfKuMnF2JXzgn0=;
        b=7LI9ZrcjEBJ7Dpe1Dzd1B0GhrxafrAL0WykRXyy+cuE0d4ls/g0MjMa+TzfxyAPjma
         RsDui0lKGQM/z7YphJaI7xtJ2iRraoYDBSYu9w56HVQTO7QPR2+uFfxRB4eUoum9UCnC
         fNtrCktJc8k7+iPqdFTUykj0kZFC/PhLLh2tHgyc4oCf/m5xg0HUqsgqhwemxSBjTpbT
         8vUbuS53RS9mIqsL9gs0YoCncsQhaPFk7hx0jm8x20T8ThX1FMK1JG8xP+n8UtKx4w6b
         mEvEAhyhQ9sI6yphrpz2Iukg4KlBvZ7b/Sor83C/jDpBo32FAQVpk4KOAbqRR61Dls9o
         PrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678972634; x=1681564634;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pezwyd0vG7hsp540g7EcpBHXx5rGXUfKuMnF2JXzgn0=;
        b=46o50208m634N0e2SwvRFr7C3l2pnvbbsOtGlP5oS39QsyrhYlsEfRpNxrGUbbfnz4
         J20jlzPARs+NcBSfJ2FWXrIxrR8XbYLjhHHdOH56pGE2uh565wle8HkwPepm6P1HNh1z
         PKVMfj0yJSnjxBO6BQp4ehnxnvi5+Ndo3DZSItPZfSxXVENPlHonv+1l4AJWSxqnB4gI
         YOZSyIy/pLg5lLCNJ+xlCRNu0QxWmVPBezWy3VcUsKsso47tiW/Xc5Bh2E7yOBYvcY01
         PQ+LWPLzr/df+C0omeWKZWxGPOlkidzHd+407XiONaHPJy4L8Xj5uUQmgHUyPB9RVe/O
         ENXQ==
X-Gm-Message-State: AO0yUKXKr0GjQdotNlFbej8wFdkvU0HC8zvQmIHzjPK196bwyyKnJLqj
        JAbiJ/l6oZtOXziAfy9MJnL8pKvUzUnSGIFJcg8QDQ==
X-Google-Smtp-Source: AK7set8wFP0FQmVwFthXtW8wW12GYUG1LiO5prgOre7P4z+VfiGC49CCZ55ul61g9R0AxGtDsRiMqA==
X-Received: by 2002:a05:6a20:7fa3:b0:cd:345e:5b10 with SMTP id d35-20020a056a207fa300b000cd345e5b10mr7745142pzj.5.1678972634488;
        Thu, 16 Mar 2023 06:17:14 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j9-20020aa78dc9000000b00571f66721aesm5456108pfr.42.2023.03.16.06.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 06:17:14 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     asml.silence@gmail.com, Li zeming <zeming@nfschina.com>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230317182538.3027-1-zeming@nfschina.com>
References: <20230317182538.3027-1-zeming@nfschina.com>
Subject: Re: [v2 PATCH] io_uring: rsrc: Optimize return value variable
 'ret'
Message-Id: <167897263379.230509.14067894771761277084.b4-ty@kernel.dk>
Date:   Thu, 16 Mar 2023 07:17:13 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 18 Mar 2023 02:25:38 +0800, Li zeming wrote:
> The initialization assignment of the variable ret is changed to 0, only
> in 'goto fail;' Use the ret variable as the function return value.
> 
> 

Applied, thanks!

[1/1] io_uring: rsrc: Optimize return value variable 'ret'
      commit: 6acd352dfee558194643adbed7e849fe80fd1b93

Best regards,
-- 
Jens Axboe



