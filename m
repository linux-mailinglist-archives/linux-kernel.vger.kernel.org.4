Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913F3645508
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 09:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiLGICS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 03:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLGICQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 03:02:16 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870702AC41
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 00:02:15 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id r15so12147426qvm.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 00:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w5fcjl3iXxwvf0nTzB6a96TQKeVskSzuKAx+3Sz7I0M=;
        b=eqtXjWjMQ25qJ2mOlMaqcvTcJZ7PaVUnh69+j8Txro/amqjy1lIQ8hNGkgzDrq7aIO
         vKXLMhmZchDWwzgfaBr/rXhoFkHt0ETeGv4//2ijgK1DKHijEimdtwWvG1sSxtqUbBXy
         Jyyx3FHG3lKqpaRCTN66FGOpvmShm+Xc/qh4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5fcjl3iXxwvf0nTzB6a96TQKeVskSzuKAx+3Sz7I0M=;
        b=B4rBsO8qeQZ2oxu/jpW8Nu9cEedJiOgObq6Fvwo/IsQSmeQpBj2XoUAGDZ+Q2YchYq
         PdkNnBC9FHHDKW2w8OqF6aPrXZl3BSzbD4BYIhy1DhqHRMZqF6Zuc8THsDY22R+lyqkG
         oIixRf4P9rgJ+DvXPOyHKNw09h/u+yswZrTwlW1SjfMfdmHEjSNUJ9un/NIwRFR5ISDb
         VZj/N77l5NYd7PnJFAdNHluxxKw1WQsRNf+Y9QCKCih2D6kL3UPvzjDg0hnITXvalB3r
         KzrC9A+bEVKb6Kphd2Qh6K2DS95ln/+UBF/vUZjxjWsA52Up7QZ5rI5lOcGHKaP7hySf
         lgZg==
X-Gm-Message-State: ANoB5pn/bTuE/Y4+e/n3dwdTzgz1YVUilf3RFHmNvu7oY8MfLnN6Vc0u
        gEN+U7UmhTZWUqs22142chbixTL9kA80zWoMYPrw1w==
X-Google-Smtp-Source: AA0mqf45GJw3kVfsNaKS+UFTth9dJVIhicBfSvEwAufgiuVCMV57UtcEJIUJSav4qeifsNX1wy2fXzy4dkueNvYp1KY=
X-Received: by 2002:a0c:ea49:0:b0:4c7:660f:1845 with SMTP id
 u9-20020a0cea49000000b004c7660f1845mr11563049qvp.73.1670400134636; Wed, 07
 Dec 2022 00:02:14 -0800 (PST)
MIME-Version: 1.0
References: <20221207040049.1.I1864b6a7ee98824118b93677868d22d3750f439b@changeid>
In-Reply-To: <20221207040049.1.I1864b6a7ee98824118b93677868d22d3750f439b@changeid>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Wed, 7 Dec 2022 00:02:03 -0800
Message-ID: <CACeCKads-Kwqr5iMj9=+ryXFiFnPoyNnhOuzpYspwKo5yP-+mw@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: zero out stale pointers
To:     Victor Ding <victording@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        tinghan.shen@mediatek.com, gustavoars@kernel.org,
        sebastian.reichel@collabora.com, dnojiri@chromium.org,
        bleung@chromium.org, lee.jones@linaro.org, groeck@chromium.org,
        tzungbi@kernel.org, gregkh@linuxfoundation.org, dustin@howett.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Victor,

On Tue, Dec 6, 2022 at 8:02 PM Victor Ding <victording@chromium.org> wrote:
>
> `cros_typec_get_switch_handles` allocates several pointers when
> obtaining four handles. These pointers are all freed if failing to
> obtain any of the four handles; therefore, pointers in `port` becomes
> stale. The stale pointers eventually cause use-after-free or double in
> later code paths.
>
> This patch proposes
Please use the imperative form [1]

> to elimite these stale pointers by zeroing them out

s/elimite/eliminate

> right after they are freed.
>
> Signed-off-by: Victor Ding <victording@chromium.org>
This should have a "Fixes" tag.

Best regards,

-Prashant

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
