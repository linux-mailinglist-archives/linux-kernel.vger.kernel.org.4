Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F941664326
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjAJOVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238385AbjAJOVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:21:21 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24FF54738
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:21:18 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id g19-20020a05600c4ed300b003d9eb1dbc0aso7112550wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=liyTD8kZN+VJiroRLr8l9K3r5/CB+eOjRyoY0GEnNto=;
        b=Es3Z1g+oh8f+c06foHQ1GV+ZKr97m8fGyY0/oPZpjfwDZQrLcUp0vyNSMLxjekUuej
         T3bgHP+pM/83eBnqgMUR/PtbGhXWm7rHW/KJ0vEtEOtnG7C/cglsv3d/QNIuYkgEjm7i
         evHiyk0pYU/RSuLDP2DZ29SM2JwWGTKzgN6fGyuIgViqeJB0dGwoX+KWu7sDFnVvEmtb
         jcpTOXerKhAZBWG92EccZBbshvXP1Ch7fGPcRb1WksetqOLl0aIa6wBbceaqiFZSG4GD
         jrygSV+g5ggEEot9jbCbgcJxyfTyJUhzSMfo+h44AN/y3+R0cxa6pdUGVgozEuxqY4Q4
         BtOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=liyTD8kZN+VJiroRLr8l9K3r5/CB+eOjRyoY0GEnNto=;
        b=1wk0Gj1JdM6qh/LSSPtH1H3Q5v/jb7nE3zqj0nfS5eaXIrD+ao77XmfuO+3/2ujPVV
         MaxUIynKzMdazkrTA8nBN+OHUVVFyH/oyVUufyVj5wYhBHYkRU4jKcPRHdJX9yld86ZI
         dtwKe7uKIQ/QRJon1hA2/+xjDssWN5giM2K6RGJGUlBnb5LwVBYAfNSXN8WUecg1UxeJ
         s8sVC1R+aSzZZRadWNIgNYdnW3qdU16tbLkp7tjfCS6WRWD2IAz3+3MQ+teTkziqXJFQ
         E6UIzh6YSyJjOiq7Sc3czTpWVXiZ7Idos+VBjHvKOiyBlVnemxD0nP+3DRn790bPbTTV
         acjQ==
X-Gm-Message-State: AFqh2kqBeoZ3OB+M1n3WlZ3Rw0n1ypwC12BNyWej2benScox4HUZi49I
        MpUwqb7vYKIvAKEb8rUM+WCgYg==
X-Google-Smtp-Source: AMrXdXuNjH+i9dFOXqBb7TEvhlDjx16HuNabSp7vHXWViPs7mGvrXmbrr8HmiRDwYR0s3uQkiCY93Q==
X-Received: by 2002:a05:600c:2844:b0:3da:4e:8dfe with SMTP id r4-20020a05600c284400b003da004e8dfemr183826wmb.38.1673360477384;
        Tue, 10 Jan 2023 06:21:17 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id f15-20020a7bcd0f000000b003d9a71ee54dsm14640561wmj.36.2023.01.10.06.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 06:21:16 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miles Chen <miles.chen@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org
In-Reply-To: <20230110031242.4917-1-miles.chen@mediatek.com>
References: <20230110031242.4917-1-miles.chen@mediatek.com>
Subject: Re: [PATCH] firmware: meson_sm: stop using 0 as NULL pointer
Message-Id: <167336047652.1961574.14299477052580291272.b4-ty@linaro.org>
Date:   Tue, 10 Jan 2023 15:21:16 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 10 Jan 2023 11:12:42 +0800, Miles Chen wrote:
> Use NULL for NULL pointer to fix the following sparse warning:
> drivers/firmware/meson/meson_sm.c:85:24: sparse: warning: Using plain integer as NULL pointer
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.3/drivers)

[1/1] firmware: meson_sm: stop using 0 as NULL pointer
      https://git.kernel.org/amlogic/c/fcdc53aceed413dce3ef1d0166a8e9348d5a9c94

These changes has been applied on the intermediate git tree [1].

The v6.3/drivers branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil
