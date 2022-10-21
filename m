Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC06E6079AD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 16:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJUOfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 10:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJUOfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 10:35:38 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480953AE56
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 07:35:37 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id l22so6613196edj.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 07:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cD7mqBkh5qwfVTvi95wXIFTJK3itHGA52frEt6EKQdE=;
        b=TAUhFVPuOmb+DlZVZ8ohiV0s+oEoLMyPa0PBQM4UUppI4TJRvnNHUVrR++1mnpHJsO
         bxWyvsLaaSNBlXMQdsBm7Enjc9CYJW1rEURQda/VxZicmXxez6isIJfK+2QmTS8CrFM0
         OMSl9f5xvWS8YBhDjRhBIcxoXNQckGAR+epT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cD7mqBkh5qwfVTvi95wXIFTJK3itHGA52frEt6EKQdE=;
        b=UkzeztcePxcFvVlldHaRmHVkJvOvIQWpQYRtw98gvdhAnqz/Dt7FPCy0oOP14usw+3
         uwFpupK3hHxqkF+qbyvpdyYFL70Bb0hRFnEEwM/pjN2daDZ6ENqR8f1MXlHzkbqRLxCH
         +LwL7y1H+vxbemIZmTNcbC5nrzgepY865tOZX7SBBZmJ+Z4J255NOoUTUy2dgJbYotjR
         STdkd7fTvtfAQMlyVtDoStPg0ASnDMdR23nSa6s8e5oXTbRBpr1k6FYpaehTRdD8c6oJ
         hSHEMzfWj85CwfCeX0z2f6yUmNsQfZ7sk90xym54hRzMlDfNMqOGt3+8M6ZfF+RRFdKN
         7lHg==
X-Gm-Message-State: ACrzQf1bi7xfbAqawKcLIap73+qgGdkUStgVyy/HH4DCnur8w7nQBelM
        l106s77vj975FzNzGBNRpyrxQneuVvBzbyj5
X-Google-Smtp-Source: AMsMyM6sOiWxZuHAJZmofUalGyKaUxCXsJwWYM+sdAFI40izlirH/+Qi0Pgboh4DIiBXNWDzfm2jqQ==
X-Received: by 2002:a17:907:2723:b0:78e:22f9:f16a with SMTP id d3-20020a170907272300b0078e22f9f16amr15122716ejl.682.1666362935515;
        Fri, 21 Oct 2022 07:35:35 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id kv2-20020a17090778c200b0077e6be40e4asm11938802ejc.175.2022.10.21.07.35.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 07:35:34 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id y10so2348863wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 07:35:34 -0700 (PDT)
X-Received: by 2002:a05:600c:4b19:b0:3c6:cc7c:763c with SMTP id
 i25-20020a05600c4b1900b003c6cc7c763cmr13608198wmp.57.1666362934256; Fri, 21
 Oct 2022 07:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221021031024.2899082-1-sean.hong@quanta.corp-partner.google.com>
In-Reply-To: <20221021031024.2899082-1-sean.hong@quanta.corp-partner.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 21 Oct 2022 07:35:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X-71=PsBHf51thsBN=G=2NhxK-_UA2yxpEiX=FrB1fsg@mail.gmail.com>
Message-ID: <CAD=FV=X-71=PsBHf51thsBN=G=2NhxK-_UA2yxpEiX=FrB1fsg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add INX N116BGE-EA2 (HW: C4)
To:     Sean Hong <sean.hong@quanta.corp-partner.google.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 20, 2022 at 8:10 PM Sean Hong
<sean.hong@quanta.corp-partner.google.com> wrote:
>
> Add support for the INX - N116BGE-EA2 (HW: C4) panel.
>
> Signed-off-by: Sean Hong <sean.hong@quanta.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

NOTE: please send patches in a 2-part series in the future so I don't
have to resolve the merge conflicts when applying.

For these simple table entries, I don't see any reason to delay before
landing, so pushed to drm-misc-next.

3facae064964 drm/panel-edp: Add INX N116BGE-EA2 (HW: C4)

-Doug
