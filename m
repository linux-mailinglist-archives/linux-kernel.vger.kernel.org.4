Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5346D5B792E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiIMSLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbiIMSKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:10:47 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EEEFD4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:16:41 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1279948d93dso33882600fac.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Ocxjo35udI1PCsICedaTIJJcwxQkPE4mGIgm+5z0B4w=;
        b=L4STRuLquN7OF6csoCKryCpsHF+MSPT7hmt1txFq+InyL3o95Ywbg85vdW+RTSamWM
         n7x1kYjK1Op6F0QRalLsLu4qnduc6ycrWfKJ+60UTYkSvf4WmAWy8b5nv48vnQkDhf28
         ZVpqFIv3PlnHjRHk17dEaL/NWf6G6oUxFpkkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Ocxjo35udI1PCsICedaTIJJcwxQkPE4mGIgm+5z0B4w=;
        b=q6QWDCuGcE6rurBGXtqITniVtL4UbldlCOoW5dLbFmgyUxAnUPjmE8dFUX39LXrJVl
         GQON5pANqGMM0qOxsgIx0EjBsP+k4rqtCn84lIzv83GyOf1nZgYtF1yYwleAKgFtWFuu
         e5W2DEquIQg07FyYenaivkoOdmVD6PRgnOW3cdlAqsMKdLXaVTqaqtkzIYdfsLiS7hxl
         lT//LZhj4MPfbKvznyGATmbqSdVqP5Z3UNOUupFGK3dIt6vlPlzMnTup/fD/Ji6zmxVa
         HKy/jZWiIFglERZsyKrW6GCIGxR8yBjPQ2iK8bj1iDI0e1nM4Bj0CA5EBMCyU+u9us6Z
         OvHw==
X-Gm-Message-State: ACgBeo0LHIw2ARxuSYDGb/LS8OArQPpdQ99U1vW3OsFZJUQ+/xQKf0RF
        Ng0JYcDfiY3bA7kCj2X9FdvtOBFuEYjLT8FR69gxMg==
X-Google-Smtp-Source: AA6agR77mKkDP8FTqTEYSb6srnrUgzoDsFso5T+v7aX7QStSNpPwXjJg8fgug8gIBkXUryKmIszsiJh9NwLV8w96mmw=
X-Received: by 2002:a05:6870:1719:b0:126:4acd:fc16 with SMTP id
 h25-20020a056870171900b001264acdfc16mr156352oae.295.1663089400556; Tue, 13
 Sep 2022 10:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220912224745.2716345-1-jthies@google.com> <Yx/1neGOF+0jsqvz@google.com>
In-Reply-To: <Yx/1neGOF+0jsqvz@google.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 13 Sep 2022 10:16:28 -0700
Message-ID: <CACeCKaey3XHBT7u6t9k65CYXTgZ1pUaRGDear+S8L7XjukYjXg@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec: Notify the PM of wake events
 during resume
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Jameson Thies <jthies@google.com>, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, bleung@chromium.org,
        groeck@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 8:14 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> On Mon, Sep 12, 2022 at 10:47:45PM +0000, Jameson Thies wrote:
> > Update cros_ec_report_events_during_suspend to notify the PM of wake
> > events during resume by calling pm_wakeup_event.
>
> Could you add some more details about "why"?
>
> > Signed-off-by: Jameson Thies <jthies@google.com>
> > Reviewed-by: Prashant Malani <pmalani@chromium.org>
>
> I didn't see where the R-b tag comes from which has been attached since
> v1.

I asked Jameson to do so, after having reviewed the patch off list.

> You shouldn't attach the tag even if the patch may have been
> reviewed somewhere but not in the mailing list.

That is not a requirement (at least, it is not stated anywhere in
kernel documentation).
There are plenty of examples of patches being uploaded after being
reviewed. Here
is just 1 recent example [1] but I'm sure you can find plenty more.

[1] https://lore.kernel.org/linux-usb/20220913055316.23050-2-shruthi.sanil@intel.com/
