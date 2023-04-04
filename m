Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53006D600C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbjDDMTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbjDDMTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:19:25 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460FF3C3C;
        Tue,  4 Apr 2023 05:14:54 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id er13so88719884edb.9;
        Tue, 04 Apr 2023 05:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680610493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0o7Z7K9+zrlNWZtJcWxuL9uISamg1eDlEvrGhyuFPQ=;
        b=j8aGR4529Q/B7L4FFuUUpKd+oOGe7+MvJQicsEc3iRB0Y+Ci/+aJzCvW9lC12qHkjQ
         sLEDkBnhECal797TjMIs8owp/9eRyIDsXIcK2uUJT2XOiLsqj4Ip1VvHoGxDMExHSSgL
         pKUGPTmoAResXnsnOEzQgH9kJpmRwQSkrlfBG3kL5zN/ASl3HKBOk9TKl4917gj97DuI
         VzC7ybHo2XchlVoAOaxlF8i+YnFk1qR+4QXumsC3RHrwvGaMPTl+NJ3a4HGiEAfZzxfi
         fuQRXqMWmGLnyP7QzNmwwGJl1XxI3ZnQJv19OLwK9eZahlvnIdZ5NAtW4LXsOMLnLY8N
         qOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680610493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0o7Z7K9+zrlNWZtJcWxuL9uISamg1eDlEvrGhyuFPQ=;
        b=FnXWLXeGS57qA0qI2Vb24nK8xQKMC8/Xpl+Ko9Ew/k36TFN+DpktAzI5DRJtdaBw1S
         3P1bf0gClJ2Qe4ezRkGtIsbFITK9twFV6g1OlhHnAKIsxYGkUOTa3WClHr6Ch74PyPGS
         y4v9ysoVwUk7dW+lIlFiJAYCs8zc7qf18GRF638+T6BKCPvX8XPZYTgDvTqEcE0bcNkC
         WJ6xLIO7EgeQQJPePUtlMQ4ObQoISXU99r/1p2aKFAw83e+K4BadjGDnlUXZ9YPggDBT
         RJyjWsLZ+DsTlWSfcL+rgR5X9s0ay0qbjugK3SZRPmhh0hPZ1T6wgOp/ttpdO0pfKzTE
         6UsA==
X-Gm-Message-State: AAQBX9ckd69lU+6aoYaHMMUkLM4IdhQ0Wr53Et79W3fCbUTxnf2/P/aR
        HlR1uBl/ilFPLrd1ak+YXd8=
X-Google-Smtp-Source: AKy350YFK7F0DLt6YErpTfaHQEO00hBV8b2vOZwYR5f+6B8U4Uhqq41gp2ng7E+uH9YtMu5/Ybu/lQ==
X-Received: by 2002:a17:906:4bc4:b0:8af:2107:6ce5 with SMTP id x4-20020a1709064bc400b008af21076ce5mr1707412ejv.35.1680610492673;
        Tue, 04 Apr 2023 05:14:52 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id me6-20020a170906aec600b008d173604d72sm5974504ejb.174.2023.04.04.05.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 05:14:52 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tegra: plane: Improve use of dev_err_probe()
Date:   Tue,  4 Apr 2023 14:14:43 +0200
Message-Id: <168061024450.2054665.10437080527226574613.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20210916073722.9110-1-caihuoqing@baidu.com>
References: <20210916073722.9110-1-caihuoqing@baidu.com>
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

On Thu, 16 Sep 2021 15:37:21 +0800, Cai Huoqing wrote:
> Return dev_err_probe() directly, because the return value of
> dev_err_probe() is the appropriate error code, and it can
> reduce code size, simplify the code.
> 
> 

Applied, thanks!

[1/1] drm/tegra: plane: Improve use of dev_err_probe()
      commit: d94e2de7bdb19ae76d9deb541999cff171e14931

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
