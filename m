Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB5E728077
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236326AbjFHMvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235773AbjFHMvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:51:20 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371C526B0
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 05:51:19 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-30e412a852dso404158f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 05:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686228677; x=1688820677;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQMTg2asd6/z1TQc0GwCD1tU1OXhoBS7NtC63V59A9o=;
        b=dU5IQj4BJptT5+1iMV4cWGdd+DqQmnjGSnkU31rDAIkiGaV91UFUSc4AEpKZroSnKy
         TkJO8TruUgMuk9MMwX54oIdSr3In++wZulIBTtPPpeOe+1r4/nHcF67mhN7QAHHxolK7
         QVgXByYCQG4P57Ng924N8la/d2HPmvp04+2bRYpcCVKmYoHVeQVt8dmffWqmxNsP0sB8
         +P+XltdgkLnUA2W1zznqZcw+5wYWkgDhYKRXzLv51Wjv6ehUrZzH3gDcAQU6xPRw7ZU7
         JMEytqeH0r+5QKfg0fQZjUl2M5NNSaisdvrQxUUfwQHDH7sH38U1KV3b20KCTKxLrVBW
         exQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686228677; x=1688820677;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQMTg2asd6/z1TQc0GwCD1tU1OXhoBS7NtC63V59A9o=;
        b=d13Lfi3SSPZTVrwVAu6NC5j+TKKA3g15pxtNoP656ijIDiMEawlPEugGCAzlej5ACa
         K5IbiIdJ4dp+cn+fIBpIga5J3Tcw2vI1RzG0RAjPt331TrgcZ3KxK+uObTtX4T3g+5k2
         egT6NOXLvgpmV6J5zKHgjp5d/T9v56ZBI2B4GYKhz29VZimtS5KKoRdIsbZA0H5SlqSY
         soHoCCm0fhEUlupDKNmVjIBkmhJW2uxo9y0fc0mjbYbHBhA97jfBr2hHxX4oKdu+dMBL
         HlCmfG5ijjWfwikmk8fS1f8d9CwYnmaHi+GbDuzFLith+BMfFy/4Pn8E6YQP/KMkoEAZ
         6aNg==
X-Gm-Message-State: AC+VfDzIg13OoooKUqFfq+MVxrHB2N1vEG8mMqkDmyKJ9LT6qE55tUcJ
        gv/HshOXTuSnSpCB/1nSiGQeCg==
X-Google-Smtp-Source: ACHHUZ4fddPWAXwB7Ei2gnzuTtFtKvFSYafaL+nGQniuAjfX2uouva1tLaCbYWA97I8kJkOUexFXKA==
X-Received: by 2002:adf:dcc4:0:b0:30a:e66d:25b7 with SMTP id x4-20020adfdcc4000000b0030ae66d25b7mr6867184wrm.13.1686228677644;
        Thu, 08 Jun 2023 05:51:17 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id x15-20020a5d650f000000b0030adfa48e1esm1523143wru.29.2023.06.08.05.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 05:51:17 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Artur Weber <aweber.kernel@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Wang Jianzheng <wangjianzheng@vivo.com>
Cc:     opensource.kernel@vivo.com
In-Reply-To: <20230608033446.18412-1-wangjianzheng@vivo.com>
References: <20230608033446.18412-1-wangjianzheng@vivo.com>
Subject: Re: [PATCH] drm/panel: s6d7aa0: remove the unneeded variable in
 s6d7aa0_lock
Message-Id: <168622867695.567381.16167502106642001528.b4-ty@linaro.org>
Date:   Thu, 08 Jun 2023 14:51:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 08 Jun 2023 11:34:46 +0800, Wang Jianzheng wrote:
> Remove unneeded variable and directly return 0.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/panel: s6d7aa0: remove the unneeded variable in s6d7aa0_lock
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=c5dacfe2e6c1251276e29b4cdac771f504593523

-- 
Neil

