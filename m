Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE865E7D2F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 16:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbiIWOeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbiIWOeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:34:06 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D15140190
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:34:05 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id sb3so1063178ejb.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=e4LOIvkqvEQf1PPlP5H8S1k+93vEgQ21MykK8wpOxMw=;
        b=L9b9Tj3kOV+wemLtGDPI+SbrzmTy/CcQP4KSNrhfR5VENbNRpMjeph2jzcUGjKOmPZ
         qoPdqD4eTrVl30jhohqE/+erghlWjkxsP3o4PTKjWNxQ2dmBEsCMS90r/KxJxvTBi9Nn
         DUh5WqWOsnbAwQFjPs/l+mP8CK/PNZtjYxChs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=e4LOIvkqvEQf1PPlP5H8S1k+93vEgQ21MykK8wpOxMw=;
        b=PNZriH/sLNFRCEtCQ/F+FcfkSymfNbapCrpLlo74c/4muXjCoI34qIrnYNqYM+D7ow
         0q5ln++mpZw8SslWXv9Q9Tu++QDhrQ5ZSbj+6ERcRszSEVUiUsGznbhZeiS9bcX/Goar
         dBGkYom2ZF1IdscMzAY4lJSrCf2CNUbnCgt7lw92jUCRwoTPhbamYIOwv28FmtP4JLBk
         dTQY2FL9WZeSRyHxPVxytNvPqDpo67zL7/DfxC8d7V/CS7KEMgyXMUC/Wf/X29Y1EUQ1
         JwWs4SGreMW4pQK7xZe4UwLvV+JBnBN3XcrAsxsJT9nHEEBvpEdnY9RQZws0WZ8Ewwnk
         O63g==
X-Gm-Message-State: ACrzQf0SyZdwvmzzCF46SvYbUHriknWvbhGexRk8NudtcvHuryFRmo2m
        mO+kdVID07zSeheU6HSO/nHEIo+Z6eRPCJXO
X-Google-Smtp-Source: AMsMyM63Su1tbQ8osWaAmhzV+TYdwTCXOKGVdqJXhHaqGWWja2dYHRUIfkN2TcX5wInb4pwhc27sOw==
X-Received: by 2002:a17:906:fe04:b0:777:b13d:30a6 with SMTP id wy4-20020a170906fe0400b00777b13d30a6mr7110255ejb.248.1663943644201;
        Fri, 23 Sep 2022 07:34:04 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090604c200b007415f8ffcbbsm4155949eja.98.2022.09.23.07.34.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 07:34:03 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id o5so362372wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:34:03 -0700 (PDT)
X-Received: by 2002:a05:600c:1e18:b0:3b3:b9f8:2186 with SMTP id
 ay24-20020a05600c1e1800b003b3b9f82186mr6378087wmb.151.1663943643491; Fri, 23
 Sep 2022 07:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220923055133.302740-1-sean.hong@quanta.corp-partner.google.com>
In-Reply-To: <20220923055133.302740-1-sean.hong@quanta.corp-partner.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 23 Sep 2022 07:33:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uhk2jTYWVU6Lr+d1xEAyScbQr-8w84F7gAbkRgP_YkgA@mail.gmail.com>
Message-ID: <CAD=FV=Uhk2jTYWVU6Lr+d1xEAyScbQr-8w84F7gAbkRgP_YkgA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add AUO B116XAK01.6
To:     Sean Hong <sean.hong@quanta.corp-partner.google.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 22, 2022 at 10:51 PM Sean Hong
<sean.hong@quanta.corp-partner.google.com> wrote:
>
> Add support for the AUO - B116XAK01.6 (HW: 1A) panel.
>
> Signed-off-by: Sean Hong <sean.hong@quanta.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

As with previous trivial patches that just add an entry to this
structure, there's no reason to wait before applying. Pushed to
drm-misc-next:

a70abdd994cb drm/panel-edp: Add AUO B116XAK01.6
