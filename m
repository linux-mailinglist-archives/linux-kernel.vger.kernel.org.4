Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED2864AAAE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 23:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbiLLW4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 17:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbiLLW4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 17:56:19 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F481580B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:56:18 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id i12so9245041qvs.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cQgXhVL7yHUkmUtLcX9xfhfdarH50CN/0oZPWJALOk=;
        b=PMeAZdowkcrqUymRp8AJKP1j4g8mdX32cAYhCk3vieyhYUozIpSgExU8d6t/A2m3D5
         +xNl4ihsZCq+5w5z95IShx3X+oRvNWvVfHyCHL0BIs9GlZ8UxpFhyTqLy85iRNu6PzE4
         MYRvjy2UOZ7ef1xKj9Ht9NyXYg+rCKhyAECkS1TPPopqq+0cwV+oOSM+RbxuXSs6Sqf0
         w8ddD3GxEK9zDOXdxt+oV/SX5nnbn4RRHhxYSNsGQyeMY7SZTXQi4H75AxX3XvbSvX+y
         rZ2+bmwU6Mcpn3soYiV8tXcDFAmszV87eZpuHUousuxlFtyuAFWQnAT/wqMdnrOjtE3k
         I9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3cQgXhVL7yHUkmUtLcX9xfhfdarH50CN/0oZPWJALOk=;
        b=joedMUT0ZW5lXCMR8QIU/WpTyJ7NQ+T3tUpfd1ZGRZo08dtfWBkFFNcCGLGz3dXYKc
         vy748D/6OOPACK/wiUzWidKxi7P6p43YNhv1wjtAlGsSrlFEJ7ahBrLIhxBJQk4ri9al
         wP1tQZFXwtd13WElIsb15s/N2xwuNrQtO9J4Quu+ENiTKZkufL3DeGjH2i537/7XHB8d
         r53kNUX8mb1ojqydbhzfzONonagQx0r2Y65uZ0KGz3JXBB6saZNaLbz4PltrIQZ1nVyD
         WgggJjS4GviNT2bNPoJLlHj+fsvBaF940ADCBPBWCN7ZpG1NsaQ9lXItibDXD6ZeXW1O
         +xYw==
X-Gm-Message-State: ANoB5pkafd/jQn0lgQpjDgF3bAiLcmW5c75gFFeqD2zsrrYzYG9A6dWX
        XGQyKiPWrPKqsowSn42DQXrb/FNXldl7Jw==
X-Google-Smtp-Source: AA0mqf7KZLl6UxQvjcD59h9U+bgxRWlS7kPdk6x/UeMkL7oYTMiZGBCIihYZzx+5BMtKJ6Y2dXFstw==
X-Received: by 2002:ad4:5908:0:b0:4c7:971e:3bfd with SMTP id ez8-20020ad45908000000b004c7971e3bfdmr24608382qvb.48.1670885777468;
        Mon, 12 Dec 2022 14:56:17 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l9-20020a05620a28c900b006cfc1d827cbsm6908888qkp.9.2022.12.12.14.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 14:56:16 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/3] soc: bcm: bcm2835-power: Drop empty platform remove function
Date:   Mon, 12 Dec 2022 14:56:14 -0800
Message-Id: <20221212225614.1647812-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221212222549.3779846-2-u.kleine-koenig@pengutronix.de>
References: <20221212222549.3779846-1-u.kleine-koenig@pengutronix.de> <20221212222549.3779846-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Dec 2022 23:25:47 +0100, Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
> A remove callback just returning 0 is equivalent to no remove callback
> at all. So drop the useless function.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/drivers/next, thanks!
--
Florian
