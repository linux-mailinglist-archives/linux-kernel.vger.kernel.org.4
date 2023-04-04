Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D116D6010
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbjDDMT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbjDDMTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:19:25 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1FD3C3E;
        Tue,  4 Apr 2023 05:14:55 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id eg48so129605038edb.13;
        Tue, 04 Apr 2023 05:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680610494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcckzg95zpKeurnjtan7E8VP+EYwCJoi2cRFH+SxLY4=;
        b=MaAjRRFugUvjadZGGJRXWMxFGP3C+fpBJg9N4EY47OixBVN6M7Ff/CxGNwnhPZSMjg
         Rmu9tS6icUukt3KVYABNtD6RK58Y5tsb55mTyDDku7bDiccsYlKFIAeDDbqIVJdBUhHD
         ykqEsCTrmretXQnYjLSuH+fo9x+eSVbvUOkOvpxaHR6FFqA5mO0010AD3ux8OchBB59Z
         CP7vGg4mWcMjzfUXxh8lqF5cVH+eA2dn72TNMl+roMKrvOUczkRcOoyJIIxqzk6KOp7N
         9a4M+DQWdzHiCtovTGKs8BrxzqSA85IY5QOKlS+a40YRr69imrL2KZhLSKnAbfBQbk6l
         Snpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680610494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcckzg95zpKeurnjtan7E8VP+EYwCJoi2cRFH+SxLY4=;
        b=adyJ+/j6GAuycsVjGXx1ZSQU3sGtvN6GWNINjFEDw4TFy61uTmom/uxEeDfPopFQKi
         JR6XUBw3aB9XuPPuvbD39g9/3Qm3R1fXNlCZyGBoWx3D5wIWg7lwJ2BtakFOS+YXvEmE
         Cka0RiZwoI/dLAFabHJ+G77UohaivyeDhoI3XtmYRMgiWXP5GHy+7lSq127oszslnxc9
         r5CpGc26Lxxp5Td9t6Pu44/go1s5yvu8eRgFQqGQK9mNPvCY7EtnrpbyhR/pgNyoX3bc
         geqwuEkwqiYotcR1SXPAt2N/eAjbiZgNQT9LPe0SKLVIj/NBaO+1vN+/omSLQXsH/4Ab
         GFRg==
X-Gm-Message-State: AAQBX9dLFcN+PJaTFd41KnSOf9zcimVZF1FD9bgyjH027mnEgVbWzvKc
        J/N8Y5Z1okzaaav41uzqPCY=
X-Google-Smtp-Source: AKy350ZAccl7ypQjeajCpBxjnbYrGDamuVDbdEk5hzFtzr6jmcUkKbPu7ycNguia4WaGj1vfQpk0CA==
X-Received: by 2002:aa7:d598:0:b0:501:cde5:4cc9 with SMTP id r24-20020aa7d598000000b00501cde54cc9mr2212071edq.39.1680610493757;
        Tue, 04 Apr 2023 05:14:53 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id v23-20020a056402175700b004c5d1a15bd5sm5724789edx.69.2023.04.04.05.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 05:14:53 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/tegra: sor: Make use of the helper function dev_err_probe()
Date:   Tue,  4 Apr 2023 14:14:44 +0200
Message-Id: <168061024450.2054665.8080259648129396992.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20210917020741.17525-1-caihuoqing@baidu.com>
References: <20210917020741.17525-1-caihuoqing@baidu.com>
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

On Fri, 17 Sep 2021 10:07:41 +0800, Cai Huoqing wrote:
> When possible use dev_err_probe help to properly deal with the
> PROBE_DEFER error, the benefit is that DEFER issue will be logged
> in the devices_deferred debugfs file.
> And using dev_err_probe() can reduce code size, the error value
> gets printed.
> 
> 
> [...]

Applied, thanks!

[1/1] drm/tegra: sor: Make use of the helper function dev_err_probe()
      commit: a4c56f2f8ce0e242eb51e5309a743361e2348a64

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
