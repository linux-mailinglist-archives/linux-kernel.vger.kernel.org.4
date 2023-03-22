Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DCF6C4846
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjCVKxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCVKxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:53:04 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C7E24C80
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:53:02 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v25so13060702wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679482380;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzWdOETeKkfj0OjRM+C7rh/5LlaXa2JRYFRBahnbMUE=;
        b=wmDrTIFohkUG8pxLgNrsqVVqKFLE4nfuGcK4Af7uKUCQmD2NT3xA7ub9BUp5jqYgtE
         aQrQdvWorAfxrjZAvqjv7SvTfWg4YR1KnhDtgX9Tnu36Objyt4kMS1jdHwhTPQAXn2ef
         SDQlOgqxnzksE3bVaMrii+lLFHYWKP7JMp6IXePGrldVqeOw8ot2SZPNyHGhIMZ2JKuX
         DepmNMGJHveaY0a1G5V1UAQ/iWiAsJfzF4MViz9yUGnYk/ujKTv7yAj+lefBtP6eszxQ
         GfzRboP4/DTZ7tOPhDaXB0blq/y0YaT0GthkKVPy+sJxO9sF+dE6XKD0TMJe7ZlVZvfa
         TKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679482380;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzWdOETeKkfj0OjRM+C7rh/5LlaXa2JRYFRBahnbMUE=;
        b=2H/faFZaTdcr2q7YXe6wyAVx7drz83JlzdDfR7qjDxiV0nhMErLk4oB7O96KMAQzrU
         ENIiskL4B6Q+GZGtM8iRNfFsPvmjsSBaJfZS/hqgkCosseRCo278G94AdqNpBaHBI0Px
         4DGxVhoTAYh5FKVhRLcWU/kODzEYZZArW+2nOLeVS3WL5hcKpQH+797IMQ1uCu8EzHOj
         KGiiKfiWAwyTI+adezYMfJ1OR8ur0ltydo1bxAO96C5rM3weyRw+oDllUASHoHMCM8J2
         mtZ7PPPD1erSJP2jmclMfZU3FyPxdNaai469M7eBCi2mTpxhWcLkXYUJKyRMmHJp8CpG
         THwA==
X-Gm-Message-State: AO0yUKXIUWT39mseD1VbiaCpvJNU++6G9gjKJTlQVY6NfJIKS/kIYdkT
        0dFZP27jfchBAjdn+xAYSzYrqA==
X-Google-Smtp-Source: AK7set9MJI5Uw+Netidw+IiEGOmh4is+8m96rUXxAiW8nBCSWWmBCMEeEQ4D53DFFAczickRyV2ACA==
X-Received: by 2002:adf:f688:0:b0:2d7:998c:5aee with SMTP id v8-20020adff688000000b002d7998c5aeemr4821335wrp.17.1679482380462;
        Wed, 22 Mar 2023 03:53:00 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id j10-20020adff00a000000b002d1bfe3269esm13555049wro.59.2023.03.22.03.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 03:53:00 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     laurent.pinchart@ideasonboard.com, ye.xingchen@zte.com.cn
Cc:     andrzej.hajda@intel.com, rfoss@kernel.org, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <202303221621336645576@zte.com.cn>
References: <202303221621336645576@zte.com.cn>
Subject: Re: [PATCH] drm/bridge: display-connector: Use dev_err_probe()
Message-Id: <167948237963.3845492.14392683700321737363.b4-ty@linaro.org>
Date:   Wed, 22 Mar 2023 11:52:59 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 22 Mar 2023 16:21:33 +0800, ye.xingchen@zte.com.cn wrote:
> Replace the open-code with dev_err_probe() to simplify the code.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/bridge: display-connector: Use dev_err_probe()
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=ed8f4e1002781c47813e4e2b37ad15b927fd8b67

-- 
Neil

