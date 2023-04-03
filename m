Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FD76D52BF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 22:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbjDCUnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 16:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbjDCUm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 16:42:58 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1F1139
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 13:42:51 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r11so30656659wrr.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 13:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680554570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsXZOUmTIvuqTGRRSXLCxsQtjq6NOtSPfGUe7/3UZ4U=;
        b=SCjfQ0wynXd/hEqjm5VLa5dKgx5CYR3zFbfTC4wZpXBq/eli5xIqtZU2jwQgBKIMIW
         gQNGtYoN1cSl9NermspKi5hw2mOaIu9xO7knhugSTLEK39qiB3BZXJcoGqFO5zJCMzJy
         DQa8nXgOPl5XdyyvqWcP3mSmGwwm89v+slTQAv6Exx7UU+zFSYFXHwiUgL6eHFyugVdd
         Tp2yEmAddamwWhkukNXg/sN4vjpcdtImzR+ADRIlZzXLfP+OrQyvMuDcKMccpndiPR4c
         xHkBBBmBymipKMnm+DSlOK9gaOFdwoaPMJe2u6tKuhdjQskn8ye3iywT7odBXgp6TWOY
         F+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680554570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsXZOUmTIvuqTGRRSXLCxsQtjq6NOtSPfGUe7/3UZ4U=;
        b=vQYf3bzCQlrFqR3zL2q2wJ4LFHru/wF4um0/g9GI2akwX/Y2NcQMBh7VnGm8HBZZT8
         EfTc+CaAB78VMjzlUwqeY+0HdoPgIbpW5UBQUeF6CXdgr9fLfnXulji53CSe6t76O0ga
         AXKc7++JIer04g24ai9CfkE48hq2WMF6HhCoox7XxgCbVm5X5pKs0VU+uKqoL0c1wGeJ
         Xl6RjG7+c79EyBDKjM52wS25omph890xo2tmLnQBhIHzlUxootPMo49Yo3MmuXGdDc0m
         Nc1x5d0qEJ/pJsKXa3vb2G7lGmQyGJUJhAVKV4e4DP3I/UYuXjb30w2zShxNu/taZqal
         YzxA==
X-Gm-Message-State: AAQBX9fkHYf5NZV1yS+GTHoJ2wBmDyq9Y0uVbQTvU358w3adQa/eZrlH
        YDo9fQSbv9J3hE/Oh1M5ZFROkg==
X-Google-Smtp-Source: AKy350bRnMTIJx7ByEQuSeqfOccO7KEea5y8X9Kxm2W+PX0m4hanzgsekcPwBv/6NsA1PGEqYV1XVQ==
X-Received: by 2002:adf:decb:0:b0:2d2:471f:cf6e with SMTP id i11-20020adfdecb000000b002d2471fcf6emr27653446wrn.5.1680554570109;
        Mon, 03 Apr 2023 13:42:50 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id y16-20020adfe6d0000000b002df7c38dc3esm10564165wrm.87.2023.04.03.13.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 13:42:43 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     sboyd@kernel.org, abelvesa@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, shawnguo@kernel.org, mturquette@baylibre.com,
        kernel@pengutronix.de, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx: drop duplicated macro
Date:   Mon,  3 Apr 2023 23:41:53 +0300
Message-Id: <168055445901.2178600.3873641347083873753.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230403082728.3199849-1-peng.fan@oss.nxp.com>
References: <20230403082728.3199849-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Apr 2023 16:27:28 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Drop duplicated macro definition
> 
> 

Applied, thanks!

[1/1] clk: imx: drop duplicated macro
      commit: 79ef82c55a37b9c3605602c4909db84481c9fb2f

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>
