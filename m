Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B55B673264
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjASHZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 02:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjASHYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:24:43 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C97C677A0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 23:24:22 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id q10so934857wrs.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 23:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuvvxU5SQjrPNh/tsenI3bDuTK1r+L/h3C2FusTkVJM=;
        b=naPlxqGjiqVsWt05MsYVWdzKkcBus4Gbs4pbt/tn1HcDoe3V89aXmti61qphNonjLY
         7xcsJSm+V2e1WNwIb52SN9OF/FOzQibPCPORVLt3So/RfhORVa/769EFquj2bA23dujL
         fcyu3Q2k3Anr+CMEbYiReJa5vfqn/H1rrcHY1GwVNrsy9x3smdC9hntNrgDAxQkNAfba
         0mxuG6Jv0Q9cFhrhwhkHKKsrc+AJzFFNi8VMxBvfmOTUDmlejKtaiwxCFpbKCRZZRUl4
         AQt0wGDkiaYSvHkdNxB9lNvGFAYv9OlQH7nzkyqKfGUg+0Ic4bqF7dbZ7RHXGkg4QRAH
         zlyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BuvvxU5SQjrPNh/tsenI3bDuTK1r+L/h3C2FusTkVJM=;
        b=pAsXEWVsRWBH4/M0lMOBLupoUCH0aCkyYJOYXJiFzPtDmHYBoW2kKwq6Cd7QT9oAhL
         AvhyWVIYo+oSBE+FOllo2a2LyKmrNgcsr9hbyFk/l0bpk4bdGumpuRFljNemZ4xHIuzu
         o/HRyecjxlsXqKLG1/b2U1QhyR7i0wpVtMhrqLGxJnZ7FPJJPxtp/uqsHfKVa4v2c5ZF
         VsEwwa+Iha63PboCkPhJ2WJYnEjb5X0uiiO9DWzu6QknycNAVWAXZ7llY2t0qTq+hDeS
         SufnAXNp7qHuFPuMxOMw5mmIZa+xEiwHU2uwlM5b61NpIoYu30bU8Ssgg4ZSSgbwBfJ/
         +pTA==
X-Gm-Message-State: AFqh2kqjg8sxE3N7poR3cKkH8yPD6ZIN/Z2B1gZ3EsOuEvclYgpQgADj
        wJd3XTleOPOrjVK9qylcvVsghA==
X-Google-Smtp-Source: AMrXdXs2UyDs6MMmSx1HD83ql/F8H3MVkRcUOF5XNTPpk8+TtFKjPT9nGENMak1zYW6i+qrg+2qEKQ==
X-Received: by 2002:adf:dd01:0:b0:289:773c:59ee with SMTP id a1-20020adfdd01000000b00289773c59eemr8341444wrm.6.1674113060803;
        Wed, 18 Jan 2023 23:24:20 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id r11-20020adff70b000000b002bdf290efdasm10397537wrp.58.2023.01.18.23.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 23:24:20 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Vinay Simha BN <simhavcs@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>
Cc:     Daniel Mentz <danielmentz@google.com>,
        Caleb Connolly <caleb@connolly.tech>
In-Reply-To: <20230116224909.23884-1-mailingradian@gmail.com>
References: <20230116224909.23884-1-mailingradian@gmail.com>
Subject: Re: [RFC PATCH v3 0/3] drm/mipi-dsi: 16-bit Brightness Endianness Fix
Message-Id: <167411305980.243807.4478206402643640808.b4-ty@linaro.org>
Date:   Thu, 19 Jan 2023 08:24:19 +0100
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

On Mon, 16 Jan 2023 17:49:06 -0500, Richard Acayan wrote:
> Changes since v2 (20230114010006.50471-1-mailingradian@gmail.com):
>  - patch vtdr6130 to use _large (3/3)
>  - remove Change-Id again (1/3)
>  - change patch subject (1-2/3)
>  - correct function name in patch description (2/3)
>  - add Tested-by tags (1-2/3)
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/3] drm/mipi-dsi: Fix byte order of 16-bit DCS set/get brightness
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=c9d27c6be518b4ef2966d9564654ef99292ea1b3
[2/3] drm/panel: sofef00: Use 16-bit brightness function
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=fd40749a4f62a03d0aebe6eb446ea84a9901795a
[3/3] drm/panel: vtdr6130: Use 16-bit brightness function
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=9402cde9347eca050e14ea9e47270e84a6899162

-- 
Neil
