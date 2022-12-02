Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727A2641163
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 00:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbiLBXUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 18:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiLBXUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 18:20:34 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98DCF7A29
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 15:20:33 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id 21so6269626pfw.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 15:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hp97z6Oq94kD4oNk7hwdd9jEwMoHqPZsQxvRNRE9SgY=;
        b=BqLJ8/+5cvlb+cGyYMCDD7XiYBv9EPehcr1jyW1WNfSLU6aCDvBxWm5YuzDczHH4c3
         03C9HscCa1iN2yyNG2uH2+wY6uFVS+V+G7xCeau/3RW7UW0RCVGdqzyKHQrVeUt42qN9
         deaXd7hnR5VKSqotdRfwcCJx+UaKb5Jf+u07Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hp97z6Oq94kD4oNk7hwdd9jEwMoHqPZsQxvRNRE9SgY=;
        b=slPsfhWzp0Vhy8mnWU4C2H8wWZYAucEcDBJ/4Ij5sbfNJTOvtF7pSRIr7GKDXkbiLp
         iczhpd2gwOUxvcSVo1voV7AawEAFI7iVJaC4Zj1mDZzvwIlUWkYgxCIKQ+mf+45mwElK
         0aHpamUtQLh2CyQGJKfc9YzdfEC5R35FWsc5CuY6WyhCccl2m7xppFShk5DJqGTEY1ao
         2zFuCEjSggYS/S8YEHlElfTOZqP5+m2JDUpjmqvSXuoSlu1ER28lX5qVuR0wWeBDGr+I
         jkbhM/Zy7mMXTvNKf352Xwr34tmg3YrpTFswL7uHEhSgRQ4Ij593gOscCMOzUaHlniFB
         X+MQ==
X-Gm-Message-State: ANoB5pm5jnEWB2mtuSXYuUgqpdDum9ZJcLRqAZkTsJgPXxxdGR4D2n7S
        rHSzvyvKxmGMyTjx4/vHL/PA5w==
X-Google-Smtp-Source: AA0mqf4T9TJyQbDOf0dtjKSyMK90c1hdCJq/irFwsc+mcvGS3AFqvFNaz5u0PIxynr/Gvn7oCQPOMA==
X-Received: by 2002:a62:8648:0:b0:56e:cbe8:9353 with SMTP id x69-20020a628648000000b0056ecbe89353mr54493372pfd.5.1670023233308;
        Fri, 02 Dec 2022 15:20:33 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t3-20020a1709027fc300b00187022627d8sm6060166plb.62.2022.12.02.15.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 15:20:32 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     wangyufen@huawei.com, ccross@android.com, anton@enomsg.org,
        Tony Luck <tony.luck@intel.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore/ram: Fix error return code in ramoops_probe()
Date:   Fri,  2 Dec 2022 15:20:29 -0800
Message-Id: <167002322852.1897586.7406208701529652326.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1669969374-46582-1-git-send-email-wangyufen@huawei.com>
References: <1669969374-46582-1-git-send-email-wangyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Dec 2022 16:22:54 +0800, Wang Yufen wrote:
> In the if (dev_of_node(dev) && !pdata) path, the "err" may be assigned a
> value of 0, so the error return code -EINVAL may be incorrectly set
> to 0. To fix set valid return code before calling to goto.
> 
> 

Applied to for-next/pstore, thanks!

[1/1] pstore/ram: Fix error return code in ramoops_probe()
      https://git.kernel.org/kees/c/e1fce564900f

-- 
Kees Cook

