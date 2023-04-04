Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCE26D600F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbjDDMT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbjDDMTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:19:25 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFE43C2A;
        Tue,  4 Apr 2023 05:14:53 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id ew6so129627489edb.7;
        Tue, 04 Apr 2023 05:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680610492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqDwgiSEHXYcctc2ir4e/JOQcuBACd3Y+m4voyUVZdI=;
        b=PdbEHNY4MaJL2QK86ou5R9wBF04TH2u2t/C4OGX6xErvzcS4SKsJSKwsFzfZMNgejk
         sERjEwvJ5PmDrDRikHSjluohq6E9AbtZrcGsThGhufTxtEKmdwrt5f1ngeX3m2dRg9UB
         R7MM4fyazeWvNxb8wAG392oNBi87WKq8VYAlnRA9K9slTfOZBS6H/DjsiV4/Cbh6JjKr
         kX8YcXgNmRBQRIZ9tUFeCJ8KAJ25/xtBwtSryf5QFL265QV1sr7jQ5zlQ9Zbru5bx3tu
         XyDV6RnGiV2RXJrKUJqg6V38T5nTLzN6NotJ9On7MvhHa+uXM+1biWrxOOZZFqSQB7sT
         3K8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680610492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AqDwgiSEHXYcctc2ir4e/JOQcuBACd3Y+m4voyUVZdI=;
        b=4PGHdRgLClVRNQoOaF8bWFf6E1Cr+3IAI3vcGRONOk/7z6CGIA+xyRcTHHIULW8/Xw
         IvEtF6mUH7asZEwwJDQjyV6OL7PnYjb/XVZO4RdEVoSLWvrVclMqUxVhSV4iKPRdpcAB
         x4+cgNpMtU7T0E4bkKtfBw6wFEbrTwm4U1Wi5oEH8/rBnInckW9bo0wYIngCJjv54hTi
         6nq3S1M3qiWWjPWfWtI+KfFWc8i8XVzRKCeObJVsZTbn+aDE9bbl/FAuvCuB6KSjTqYn
         TUx3/Q9IStDjTKQSJI0pDUPeY9gf4P3HfMibB61Vu30XtVvKbxRZwe3FI+GgbxydHEdY
         cOrg==
X-Gm-Message-State: AAQBX9eZvAVojXsBR+IqMFhYfKzXfAVBPBaK8GxvFr/6Va9ga7d4ceXn
        OSYBQHn2Gsw5W7qvwkLPzI0=
X-Google-Smtp-Source: AKy350ZA5sgGwgL3vMVo5Ny1rRfi1xq5vWXKPdWqstTtkyS1o1E8fWWWqrsgwBFlAzhuAlspbdoFCw==
X-Received: by 2002:a17:906:b10f:b0:93b:752:d2a9 with SMTP id u15-20020a170906b10f00b0093b0752d2a9mr1905729ejy.31.1680610491802;
        Tue, 04 Apr 2023 05:14:51 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id qo26-20020a170907213a00b00930aa50372csm5843631ejb.43.2023.04.04.05.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 05:14:51 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tegra: dsi: Make use of the helper function dev_err_probe()
Date:   Tue,  4 Apr 2023 14:14:42 +0200
Message-Id: <168061024450.2054665.3431873528237731595.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20210916105641.12215-1-caihuoqing@baidu.com>
References: <20210916105641.12215-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

On Thu, 16 Sep 2021 18:56:40 +0800, Cai Huoqing wrote:
> When possible use dev_err_probe help to properly deal with the
> PROBE_DEFER error, the benefit is that DEFER issue will be logged
> in the devices_deferred debugfs file.
> And using dev_err_probe() can reduce code size, the error value
> gets printed.
> 
> 
> [...]

Applied, thanks!

[1/1] drm/tegra: dsi: Make use of the helper function dev_err_probe()
      commit: 6fae3bc81e679961cfd198622f2aed2d720ee631

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
