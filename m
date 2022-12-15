Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF8764D883
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 10:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiLOJ0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 04:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLOJ0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 04:26:09 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2FB33C38
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 01:26:08 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso1219313wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 01:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rT5nYetbt/rUXKIwgJbVz9fS9IuJsFVtRBisMphoNoo=;
        b=uuryZsdS88lObitkX7oxZa7cfGT9633pRc4WZIgl5bJUbG9D8CBtD15kZGCxNXmd8W
         SRwLhAR2eiJIhtAEZS9smEviFkVCL4zLFUaDE7JDGN1o0y6dDq5KSuqrYfCGczRFjXLj
         PRVNRc9lFvKfpmul5ElCdoG0EIX0ixYU9SENXyrO6n0qDwLTyWlK8mOiKjQ7ktNyxmUl
         2RIPHyh1eqJzELF1iNAtxlDnABfR2/fXoi3rbIIMnqkxUTRC/8qhTx84nZajQjMSYIDm
         gdF/kr5djm6fIGjajwNgGSaXkRThEWBLjPNuOWiBwU6h+w1/gQEknxYtY+LQMgPwu+rI
         2kmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rT5nYetbt/rUXKIwgJbVz9fS9IuJsFVtRBisMphoNoo=;
        b=r11MungFy6HYtuP3lb0CbBod9a6leZvUbgr/UIDU1EeG7n83hSu48RdDTRSxAZKHcm
         IComSnesCHzr7qhk3C4ilXMi1YEYZUYyAdeJeXRAPCLw6QFHL22Usuv8blxBLLeXs2CZ
         ljE9ybBvzcFrI45uoZBA3+JxVwkvYtj5W7kYZG4e3rMpxrv7OOn9lH9O2Ob54axhG2w1
         3iRjZaucYU9u6HI6jf4vkkmdaMzWbUVtYeQbJzairTHKdNEbLZ2tFdqbcZCTIb7cdk0m
         2DHIihUG54Ewng1lokSUMxrcRPbQYTyLRZIHzSdgIPMXs/J2ixvwCOQOFwhUheIunx2W
         wVAg==
X-Gm-Message-State: ANoB5pkd+ZkPfJ92NBFTzQh6GEVHdMa09OepjCXoAa2CdF9TtsLObRFz
        eHKZcOc+1vhkiXjrWI7jhgjszQ==
X-Google-Smtp-Source: AA0mqf40a/Y200wMJ6a9mSLz6nlNT4JTAlNOWT8f3KhBY+g472ukIetY/DrD+llEO7lEN4DsR6KLsQ==
X-Received: by 2002:a05:600c:4f05:b0:3cf:85af:6a4a with SMTP id l5-20020a05600c4f0500b003cf85af6a4amr28838749wmq.25.1671096367213;
        Thu, 15 Dec 2022 01:26:07 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id v6-20020a05600c15c600b003d33ab317dasm1152748wmf.14.2022.12.15.01.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:26:06 -0800 (PST)
Date:   Thu, 15 Dec 2022 09:26:04 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: backlight: Fix doc for
 backlight_device_get_by_name
Message-ID: <Y5roLFINjM/GjWPK@aspen.lan>
References: <20221215071902.424005-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215071902.424005-1-linmq006@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 11:19:01AM +0400, Miaoqian Lin wrote:
> backlight_put() has been dropped, we should call put_device() to drop
> the reference taken by backlight_device_get_by_name().
>
> Fixes: 0f6a3256fd81 ("backlight: backlight: Drop backlight_put()")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
