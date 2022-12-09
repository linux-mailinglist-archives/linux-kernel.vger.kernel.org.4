Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A17648299
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 13:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiLIMvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 07:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiLIMvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 07:51:37 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281015C0F7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 04:51:32 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id m14so5091595wrh.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 04:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OtnZ1kdjAPZRqPqQ9rwdeEDxyI3IJgipy4lZ3Z6DHOU=;
        b=mzhiuYzLh5MXO4d2/CaGSLQRvmAHHQmyihleIadBSeVx0urmsuaZmDMUhlN6s6G8Up
         KGqJ2YNpR9+iZiOaO1gzAodX6jigmaayrqo/LY5geqBf0KGwQiN28ak0hr+qKVhp41/h
         lwiBFZuTLTdW/6SDBpJfuU28ZTjfX0BYytaoyOD4VdJvI5R6qLbslN8pJoYKU/RUfBxc
         yqvA/kxuhhz9o5Y6B2qx95QtRTxAjXm4uEfj31X4efvNKWuxnGeFyjDP1kIh0Lgasnb7
         uO+8X9prY1dZNpqTfVJp2HvUy4jyN7/6zqEDrct7rMKKm1K8MijdUSHqH3O6ArIOH3Pl
         9/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtnZ1kdjAPZRqPqQ9rwdeEDxyI3IJgipy4lZ3Z6DHOU=;
        b=LGM5wusoeTMvzdU5SH5xlXOdRkW8V659licL6kdLDxI2j8UlDFvqWq04KGn2dK5ZJt
         fsRhXiJ+AcpzT4zdOXd64ug3sAV9yf+e6mzUEdEnn75q1wgsJgtULbStiE0Z/SW5DL6r
         kzqGOWhWmnvgsXJgxbNofQhbyDs67SoIfpth84WTIrktb6Z26cxvHS1oeKLdgtk3I3bn
         TuP+V6QO6LHVgVWjFgGF8weTDPDEEMIOSWGX93Gsm11x6MyWwyQJ10sj/HQpnUwq+fak
         YlH2++7xYcDn8rFZdstzl1ojdpcUkhlFkBsE9AtaWVtzcaIGK1MY+2ttqsUqyPyc7Oir
         od1A==
X-Gm-Message-State: ANoB5pkL9S1u+cjAlhFRgvGbBlYt8LImR7ttm7QDvJKQFj2Hhp/qR11i
        6sIf9aGh0Hyhll54oqHUg4lVlg==
X-Google-Smtp-Source: AA0mqf44qDADYcbcErOKO4f1THlbbJ0Qbkf2oOidypUvsQ4ltBNeY7SL3mw7aTGkms7BkKrITifFxA==
X-Received: by 2002:a5d:5111:0:b0:232:be5b:44db with SMTP id s17-20020a5d5111000000b00232be5b44dbmr3931759wrt.67.1670590290559;
        Fri, 09 Dec 2022 04:51:30 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id e4-20020a5d5004000000b0022e57e66824sm1538868wrt.99.2022.12.09.04.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 04:51:30 -0800 (PST)
Date:   Fri, 9 Dec 2022 12:51:28 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     ye.xingchen@zte.com.cn
Cc:     lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] backlight: use sysfs_emit() to instead of
 scnprintf()
Message-ID: <Y5MvULWEnqp7pzft@aspen.lan>
References: <202212051556478226726@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212051556478226726@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 03:56:47PM +0800, ye.xingchen@zte.com.cn wrote:
> Subject: [PATCH linux-next] backlight: use sysfs_emit() to instead of
> scnprintf()

Isn't this a v2?

(this isn't just a "nice to have"... I ended up delaying review for
several days until I had time to look up where I had seen these changes
before)


> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
