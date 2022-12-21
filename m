Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB367652BA4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 03:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbiLUC6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 21:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbiLUC6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 21:58:40 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3861A07B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 18:58:36 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 82so9614153pgc.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 18:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NRw+m8nNjXYtJqRDkMvJhQtNbIxdEmEHtQugBvnugPY=;
        b=f/gXfxm5Oos3aftCC/BicSJ4DTs7zXIHePDBtL0Xjh5C3kKjeE9oKRylTWmSO5EUPQ
         PTkF+i1WG//8NTXPgBZLCSFBnulr1j10EIIYCnjDqzlUt1NjVqleqkIGqCKyLbiR/xCz
         9lYjh8TXgh54wSwbmytYBd+AlX4ifGY1CcuQszDHY42jx7aFFvk9U5sDTtaonQEL3OxO
         VmwGzBuEBbCY8e1VXed5/IabpuOUxQ45QrW/6nHpYme7XOjij6d/3mWHpHL2BK8DaI/h
         uLU37GYH48xMo8QxKVQoKcLHfvhMGDlL4YlwNUlGx4qe/gPdm7AGG87qWi3JqxHeihqy
         0KbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NRw+m8nNjXYtJqRDkMvJhQtNbIxdEmEHtQugBvnugPY=;
        b=7fGVDDAOiNqxTgoA7nrGu3A9kz9wBcb7BT3NVyvXSx7v9jMs7UT9X5u2zx2DZNT3z4
         k1PDScFXOA3VJh3QvkquI0YOPezJsAdoiQ7h2jyyHiGvTNsTR6ci4Is1LmwB2/W/tvml
         IFQkW9W+JtNynISPnZpyCax3ka5o2vOCC5/QFEiTg1rKUXTP2VxUsUPQUnd22EdGzIfw
         QqjJw4ZNCZXnO0UUaAwQc2Wwk/o0vyYw06ZOH43+EOS1Oi5xwm8qUpqUrm4t8p+pmFlV
         cVtCIbjrnRK+W4GN65dAbGim8+IO3/+Wd5iOaBJs+hB0G9P3EOs7eVsrMB3yCW35sV9F
         6ieg==
X-Gm-Message-State: AFqh2krXj6uOAcZniPsimIB0Vn1iREuCN13I7ugyvLRGrFxmPWKzF5AL
        TUvcXUWhoUBq2VhjmY3IQPzesA==
X-Google-Smtp-Source: AMrXdXtC8On6ZvwiaEaSKPweU6RM41vuTK4l6tbFI2Bi0TVJyRJwWM1PLc6/iZhrox3aifkuYi+s6w==
X-Received: by 2002:a62:2fc4:0:b0:576:d50b:7e6e with SMTP id v187-20020a622fc4000000b00576d50b7e6emr737339pfv.27.1671591516191;
        Tue, 20 Dec 2022 18:58:36 -0800 (PST)
Received: from ruihai-HP.huaqin.com ([101.78.151.205])
        by smtp.gmail.com with ESMTPSA id g28-20020aa79f1c000000b00574ebfdc721sm9636793pfr.16.2022.12.20.18.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 18:58:35 -0800 (PST)
From:   Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>
To:     pmalani@chromium.org, bleung@chromium.org, groeck@chromium.org,
        knoxchiou@chromium.org, weishunc@chromium.org
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: deferred probe when typec count mismatch
Date:   Wed, 21 Dec 2022 10:58:32 +0800
Message-Id: <20221221025832.26391-1-zhouruihai@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221220055954.11197-1-zhouruihai@huaqin.corp-partner.google.com>
References: <20221220055954.11197-1-zhouruihai@huaqin.corp-partner.google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I think that is problematic. It might as well be that nports >
> EC_USB_PD_MAX_PORTS.
Yes, you're right. so we should consider it's a invalid argument and return -EINVAL
if nports > EC_USB_PD_MAX_PORTS. right?
> Is this really seen in the field ? The EC should never report a wrong
> (random) number of ports. If it is not ready, there should be _some_
> indication that it isn't ready. Does it really report a more or less
> random number in this case ?
Yes, I saw this on corsola boards. The EC report a wrong(not random) number.
because corsola emulates HDMI MUX over the current type-c mux stack. The ec has to
fake a type-c port to pass the MUX info. But the task are not initiated on starting up,
and increase the type-c port counts after the tasks finished. In this case, I saw
the typec->num_ports = 1, but the nports = 2, which will be probe failed and block
the HDMI MUX function.
I will send v2 patch, if nports > EC_USB_PD_MAX_PORTS, then return -EINVAL,
but if nports > typec->num_ports, we consider wait a second to ec task increase the
type-c port counts if there're HDMI DB attach, then return -EPROBE_DEFER.
