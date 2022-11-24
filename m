Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534216372F9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 08:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiKXHkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 02:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKXHkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 02:40:13 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8784093CD7;
        Wed, 23 Nov 2022 23:40:13 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id y4so780307plb.2;
        Wed, 23 Nov 2022 23:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohiAa0C2lBySitC5TtKG/yXfWFC5n9qkGB3jrwFe/G8=;
        b=ey/P+XFjNpu0XAsuMZJHJhS4TeIidxuF7IypQRwUgUz7oIabCQ00YkJqm/bZ9nla+I
         jlzYboTVKtKRMlymqCgExRdHLYs7Z3EPJFnvsRe9sMjCJbnyphvzadYUOPwEST2cOcqz
         +CjOYI9qvh/PHtGjk7kaFXhMCbaqOLx8vutEXzy6G4toqfyz7658sraT2yK8ENdOiBpL
         V7BfOVQrPeCMsJoqhKNGWCw4ULMB0y6H+O3ce7JnXa8Y743qMWiiQ7bi4goQxPrUpipW
         VnZziWY2NC0rFetwFwnKJFQGWIWWMXVZz7VAGcwwVVPIzk6hZpVBxg/O3siKvIW4+Y3B
         hePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohiAa0C2lBySitC5TtKG/yXfWFC5n9qkGB3jrwFe/G8=;
        b=qlMZvk8xTIw5lUbhrPaq1s92noLw1PLKW5wbaex+Sr84y/rtYsXrFep0tTKf9hgO6g
         bK87TumHIsBuBFCo4Jz/gI+VQvRLiNrsjYKbPZ8rqRBQ0X0cvsKpZ8wezl7TDrZ8xKqo
         tuTIEbUZTwttmQp/bVjRZJNcIoR6Q6J37nOPLbz3ST1gp38t+f+Xyyzg4da/E7lOmeTu
         l+p9nnct7zAanwPhkM8nsFcJzY8fBQI64MLR0HVsXGOHojXkgBUZQGkgrC4mxyRQkcwq
         KQoQR9YdldAKyZm8sMB+hpwOVkLsZXwasqFp05fU9GY6Lfyetg/9O29FBGSn8wgd8TQ6
         goLg==
X-Gm-Message-State: ANoB5pmQ36FdDhCLuyIJoVNCsd69xUZIvxWqCI2ZiJbOLC/O/gW7bki7
        c3ADG89VW2+hiGu0+MzI83Y=
X-Google-Smtp-Source: AA0mqf7gXtfqZLY5/zeJNuxP1qLbi3jT2uvLpk3T04qx4c3oiTp6drX/w1vgs+g0Tz8jsx4gt2EsSg==
X-Received: by 2002:a17:902:f68a:b0:189:b07:10fd with SMTP id l10-20020a170902f68a00b001890b0710fdmr12319943plg.151.1669275612936;
        Wed, 23 Nov 2022 23:40:12 -0800 (PST)
Received: from localhost.localdomain ([123.51.145.88])
        by smtp.gmail.com with ESMTPSA id s5-20020a632c05000000b0047781f8ac17sm503143pgs.77.2022.11.23.23.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 23:40:12 -0800 (PST)
From:   JaimeLiao <jaimeliao.tw@gmail.com>
To:     broonie@kernel.org, krzysztof.kozlowski@linaro.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jaimeliao@mxic.com.tw, JaimeLiao <jaimeliao.tw@gmail.com>
Subject: [PATCH v1 0/2] Add Octal DTR support on RPC driver
Date:   Thu, 24 Nov 2022 15:39:55 +0800
Message-Id: <20221124073957.22471-1-jaimeliao.tw@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Octal DTR support both on spi-rpc-if.c and renesas-rpc-if.c

JaimeLiao (2):
  spi: spi-rpc-if: Add support for Octal DTR mode
  memory: renesas-rpc-if: Add Octal DTR mode support

 drivers/memory/renesas-rpc-if.c | 56 +++++++++++++++++++++++++++++++++
 drivers/spi/spi-rpc-if.c        | 19 +++++++++--
 2 files changed, 72 insertions(+), 3 deletions(-)

-- 
2.17.1

