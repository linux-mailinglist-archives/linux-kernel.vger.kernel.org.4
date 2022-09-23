Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A17E5E7D23
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 16:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiIWOdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiIWOdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:33:13 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB7513F739
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:33:11 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z13so435466edb.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=JcLccmLtichVQvIjuBsBYfgR6Tl0L9ItGMwduiQP5RU=;
        b=N1FDyXNxx7GKDn5pw04aLrkqj3YsfyCHDjiwdabJmWdWqWNQhUTpo+fPEN2XRVXhe1
         ejCiZnSnNoANy2V1T3Mueo4FY01XvPX14egCssivRzTNQV1IC2BNigQkH1xYkvpKO9CU
         LMQHhQ+fgqXS4JBTLSKrGCTEkcTdIMgxan9/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=JcLccmLtichVQvIjuBsBYfgR6Tl0L9ItGMwduiQP5RU=;
        b=IdDOFvAMmEiBdTopbHiSWgcPflDkK+Whz5IX+hwghjBcYfdFIVH2gr0aldZiKs6coe
         ozYGup32uq7bOQnJwzFYvLzDEqqb538LHIZR9mJF4ym317fKMv3YL1mwDBdGj65+/Lqh
         G0EpQHk6KIicq10DcDmxw/DNqXrPHFQsAc6Z61lrgNy3xKHGpIBAVPKmAlIBcTXvCkaJ
         BFIMCfCni1sWH/QwgWG4PBQO3oIcjWWZ5TLu1qBtTTmYOsNor4I6n1pjT+gVt01YhPHq
         qQSKbX5E7A5lbkQfYOC7ieodDs80zmc5XE2+OXr88L69oHJ5YgyBst1tnjpZiGPgXbb0
         MUCw==
X-Gm-Message-State: ACrzQf2Ov5CQe6K6ZOuSWwdsnLu330QJOULa125mlCbRaraRDfrgVBTH
        TccBLzy867+RSfne5hjUPXACQ4+b8asRkLsw
X-Google-Smtp-Source: AMsMyM6t5soANWB002FsF5ez5EwKkr9MIaaneXIbecAPbqO4waG49CBA8ikGF0ZHDZUsVMPTKeImRA==
X-Received: by 2002:aa7:cc13:0:b0:453:52dc:1bbf with SMTP id q19-20020aa7cc13000000b0045352dc1bbfmr8727486edt.30.1663943590382;
        Fri, 23 Sep 2022 07:33:10 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id h23-20020a170906399700b00773f3cb67ffsm4045911eje.28.2022.09.23.07.33.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 07:33:09 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id u16-20020a05600c211000b003b5152ebf09so878696wml.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:33:09 -0700 (PDT)
X-Received: by 2002:a05:600c:5488:b0:3b5:634:731 with SMTP id
 iv8-20020a05600c548800b003b506340731mr4723210wmb.188.1663943588804; Fri, 23
 Sep 2022 07:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220923085028.306790-1-sean.hong@quanta.corp-partner.google.com>
In-Reply-To: <20220923085028.306790-1-sean.hong@quanta.corp-partner.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 23 Sep 2022 07:32:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WQs1EcafhPL0jh0Uj=LHumL1AT_YriibzGY6hvhxBNYA@mail.gmail.com>
Message-ID: <CAD=FV=WQs1EcafhPL0jh0Uj=LHumL1AT_YriibzGY6hvhxBNYA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add BOE NT116WHM-N21 (HW: V8.1)
To:     Sean Hong <sean.hong@quanta.corp-partner.google.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
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

On Fri, Sep 23, 2022 at 1:50 AM Sean Hong
<sean.hong@quanta.corp-partner.google.com> wrote:
>
> Add support for the BOE - NT116WHM-N21 (HW: V8.1) panel.
>
> Signed-off-by: Sean Hong <sean.hong@quanta.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

As with previous trivial patches that just add an entry to this
structure, there's no reason to wait before applying. Pushed to
drm-misc-next:

43bee41415a6 drm/panel-edp: Add BOE NT116WHM-N21 (HW: V8.1)
