Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3984465EEAB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbjAEOXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 09:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbjAEOX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:23:29 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC475551F9
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 06:23:26 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id bk16so23074724wrb.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 06:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2O8qAtal3UIh6dVVxKSeZtPNmNVJVzzTrbBSvkVmU/4=;
        b=OnBXfld0yK17k8BzxzH6dsorYAl/PqiA2lMaWW8T656ZlzW8aUSwRpgLiNsGEwoMSf
         WgTvcrFyjbBEXdpoXNYNVqT5BJyH6MNlLEHJjzF0FN9Lt/AHWz7hirl1C0m2NMVOkCiX
         EwNGVSxmcxTRJwHiX1bM1sa8rV4rgJKt6y3h4muOSA0ghYIawn+Oxq8bOLTgU4iw4u83
         VBFWNF4EJsCQGQMO0K2n3RWeR4FGMyQz9v+pVapkRfwXc46yjeBfPKvPe/HNhPCz9tok
         d4UcHzX623NtPkDCjzr9ePPPSFiSjxKCUMJOAysfFjy3trEa2EmqAmU08hGxUvlTKgYF
         ODXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2O8qAtal3UIh6dVVxKSeZtPNmNVJVzzTrbBSvkVmU/4=;
        b=pAJRBtFSEhkRRuB+iTLAPifCdrNTTMq/FdWjFpQXJ8aykmvA3hUqSwc99EfjRfIr7X
         D9sh5vtqU4hikJyxpXBiCaObxl0hEzKHOyCKsjw5C+FweelqyvJsvt7sXxhYJQRQlCAM
         zEc60wE0mqGQaGd0IDacwicNsdWnZ7kcsFFNGOO03VmB9jQOC4Pvl4IBVx+wJVVHLfuq
         RKvw/ZU6grvZyVKo9HBkbnifKkFYhTlG2RseAYoThh/yUWe/MSOWsusgkILZ/HWt/G11
         d6l56PQ9Jnp8i71ucHtWDha+l3VEMYSU7mDh8Z0FIJEWMbyPdWzxRzizcTq8Qb7kiOMv
         D2hw==
X-Gm-Message-State: AFqh2krm3QLO/+RKRF53/HtlHHamv6gc7Y+7M2ZcvqEN4VqRIggKr7EK
        K0bJifls/4AQaeEDaUJjVWQTy5u37rxwvgsEEW8=
X-Google-Smtp-Source: AMrXdXuKaNUVjrQTANx/S3IuaYZuFDw62Vq63XtmQR6uWzRVkHezN/Wl0vZekaskc5e/xo+44czkqw==
X-Received: by 2002:adf:e307:0:b0:2b6:8a41:a949 with SMTP id b7-20020adfe307000000b002b68a41a949mr721487wrj.46.1672928605403;
        Thu, 05 Jan 2023 06:23:25 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id h7-20020a5d4307000000b002a64e575b4esm3922790wrq.47.2023.01.05.06.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 06:23:24 -0800 (PST)
Date:   Thu, 5 Jan 2023 14:23:23 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 09/27] backlight: remove pxa tosa support
Message-ID: <Y7bdW4maNBCZinLz@aspen.lan>
References: <20230105134622.254560-1-arnd@kernel.org>
 <20230105134622.254560-10-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105134622.254560-10-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 02:46:04PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The PXA tosa machine was removed, so this backlight driver is no
> longer needed.
>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER)
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

OK by me ;-).

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
