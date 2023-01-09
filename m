Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DB1662301
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbjAIKTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbjAIKRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:17:25 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F26213E05
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:17:09 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o15so5871395wmr.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 02:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rDNF2nq4b9KxYEgBtOKFU9bGBLHmMD8mjcoecRR8JOo=;
        b=Egiyt8t8NeEPoldU+PsuMHoanqPPDdbLc5AyDm0+6oAWOFis5vdQtE5/FvQHaJJnhQ
         OuIfStlXNBRlfLFjDGfyTKUrPDuKQoyBgyHjErZyYUYct5mgqH9SeVXKMpbRF4KGIXWZ
         WwDyG99fgkUfBCwlWm8+yKbGSfbIbon+k6//kWKlqatplP0564wsAvcqa7e6HMxqG9ZV
         Prs+JDy8t6GKuek1QRak6deutcLpdTM+FsU1QoVwtl/yADesOj1EG7SvsswBTrbfWy/q
         3IUEcRv7PsptoNROWnj7mx9IFyBBRkjrgiLm05N0Kn4C2YhRrzDPTLHS3wuteHcs3se7
         i1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDNF2nq4b9KxYEgBtOKFU9bGBLHmMD8mjcoecRR8JOo=;
        b=I6QOlfwJob6JCHRqMEXWSOn/XE4ThtZ1hPc5Q8zN6ZrDtvC+8D9FfizbKjBRKEr8H9
         MIKDkdaejWiLeEKJfMwexUyaZc9hupMvM5BCGKsYtwKZPStR2gXcbem1T4bu/tQSeEkR
         3e422IYzZXgvRjH+O1ZoF68y8HxhPo0YjnYuC0985IWfjZx6f35ltCDLOcwSx2JPdIfj
         nLOhIxSD/zXzhYCwJUSBOUgoPu2RjEQsua34G443HaH3iDqTJYR4DPE+kexWMJGTg1Sh
         p8SF6EuAoAJTbmQ1C1X6lc2Ee5xDoEOhHz9XL974cdtI208FB3wBGrD/oXEI6UHWqBz9
         eI7g==
X-Gm-Message-State: AFqh2kpeegpLAwKrptVx8wAsg1B1K4z8OP1V6bP3SPjf8V+82zQC7F4m
        MV3kBo6cfOhXXFGXj7r9OdJpwQ==
X-Google-Smtp-Source: AMrXdXtDVvn4E0/j7oBFUTIF1bLHNjmYSsToEWXF24uuZxYxJl7CkWIxhyClEjlcLBHh4/n9Ls5fBQ==
X-Received: by 2002:a05:600c:4854:b0:3d3:5a4a:90ff with SMTP id j20-20020a05600c485400b003d35a4a90ffmr48166011wmo.23.1673259428083;
        Mon, 09 Jan 2023 02:17:08 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c22d000b003b4a699ce8esm14604643wmg.6.2023.01.09.02.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 02:17:07 -0800 (PST)
Date:   Mon, 9 Jan 2023 10:17:05 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 2/4] backlight: arcxcnn: Use backlight helper
Message-ID: <Y7vpof89LHgqdHvU@aspen.lan>
References: <20230106164856.1453819-3-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106164856.1453819-3-steve@sk2.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 05:48:53PM +0100, Stephen Kitt wrote:
> Instead of retrieving the backlight brightness in struct
> backlight_properties manually, and then checking whether the backlight
> should be on at all, use backlight_get_brightness() which does all
> this and insulates this from future changes.
>
> Signed-off-by: Stephen Kitt <steve@sk2.org>

For the tools:
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


D.
