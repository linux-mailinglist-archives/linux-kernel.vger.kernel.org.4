Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA5262E2A3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240617AbiKQRM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbiKQRMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:12:54 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069085D6A6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:12:54 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso2450632pjt.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1R822jcgCiPh3CxEI4LZqZZ6f8Tc9V1v0R26xcOw7ZM=;
        b=KDavSi0mdYdPpqiYNYkyB6ALcKpDiqvA6qoBp6uo6WPci0B62WhYU+tEdx9RvVST13
         nElxU5sXpxk3vxdRv+MV45hsoF0ryXbvYsAViuobUqZoG9JbGFahBbsKCrbMj5XI9nC5
         FJGIZdApp0fONaw//XhTp7kkKzXF8Y5TisIVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1R822jcgCiPh3CxEI4LZqZZ6f8Tc9V1v0R26xcOw7ZM=;
        b=n7YhkpBUpiHK5ibHYcB9lTJ7s0UedNEZSWN1Remv04IfPQp0YfAmd1efGbqNrwJNKS
         3sG4uMeyohTCaV8z4dfhHVdBo4N73NTN20FAn0tJTz4Ro71QgPeX9IkuvZPyLnxGTzkx
         bLqcaPkcMr+8NfuS5sEpKnyYCw+Sm4lTaLU3pmD71fmxIhcbNiSBJIX1uI+6jc4yJV4/
         8QzUuiEb22oJVwN/ES/iFn40L3YLdSbA2gMROmE4ujLYPJkUznhCzyJ/PYTrBOxkO2Mp
         npnS5nkNHsE77MILiEQzjnzvjOQtLw95GvuzUcd9PjDrOBXwvZH8ZFkU0OwVh6SP1fM5
         4cMA==
X-Gm-Message-State: ANoB5pmZ7IKrueEBlo1vnlM73/MBxQo475qvgp2ouwgxzrVrdgpo2oNK
        9T8PTqygwTT0IDIX/fa4I0ZRIotDWPTl0+BWBoLvAcO7ENg=
X-Google-Smtp-Source: AA0mqf4Sr75qf5iJL/dTTs3yLXtqkRa5F/ANwcf6gxNnYDL3LMROj1R4pCZt6TEyz7OGaduAq6Tj4R9nhmFejgKpai4=
X-Received: by 2002:a17:90a:5317:b0:213:34f7:fb14 with SMTP id
 x23-20020a17090a531700b0021334f7fb14mr9449761pjh.25.1668705173302; Thu, 17
 Nov 2022 09:12:53 -0800 (PST)
MIME-Version: 1.0
References: <20221117110804.1431024-1-hsinyi@chromium.org> <CAD=FV=VEC=GzkDfaOqauBB5Y79teS1ENA5wFUHZmnTRkg6Z4tg@mail.gmail.com>
In-Reply-To: <CAD=FV=VEC=GzkDfaOqauBB5Y79teS1ENA5wFUHZmnTRkg6Z4tg@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 18 Nov 2022 01:20:19 +0800
Message-ID: <CAJMQK-gQj83N1MBu1s+_YDJ4qbqN4McSqCnOwWAq4iaNXo5Sfg@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] drm_bridge: register content protect property
To:     Doug Anderson <dianders@chromium.org>
Cc:     Sean Paul <seanpaul@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Allen Chen <allen.chen@ite.com.tw>,
        David Airlie <airlied@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 11:57 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Nov 17, 2022 at 3:08 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > Some bridges are able to update HDCP status from userspace request if
> > they support HDCP.
> >
> > HDCP property is the same as other connector properties that needs to be
> > created after the connecter is initialized and before the connector is
> > registered.
> >
> > If there exists a bridge that supports HDCP, add the property to the
> > bridge connector.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > Reviewed-by: Sean Paul <seanpaul@chromium.org>
> > Reported-by: kernel test robot <lkp@intel.com>
>
> Not sure it's worth spinning for, but FWIW I wouldn't put
> "Reported-by: kernel test robot <lkp@intel.com>". The emails from that
> bot are always a bit confusing in this regards, but I think they mean
> "if the patch has already landed and you're sending a separate patch
> with a fix then please add the "Reported-by" tag". ...but adding it to
> the original patch just doesn't make a lot of sense.

Got it, thanks. I think I'll wait for a while to see if there's other
comments. Otherwise should I send another version to remove the tag?
