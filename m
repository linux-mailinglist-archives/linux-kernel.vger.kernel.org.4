Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B521C666A8A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 05:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbjALEsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 23:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236270AbjALEsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 23:48:03 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE601D0D6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 20:48:02 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id o63so17909951vsc.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 20:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/iFkf8dHZxV1Ge0m0weqa7TetCQZl7ZILZ6zxgWwBw4=;
        b=nmSBF2GeML2BxZ5iKmqSNZCgcfDR4/DPvEBiO6C2Foa+6Xi2RHvBvLTExrvjax3xQm
         gV5j2hjBG4n7dvmsTySwwjw0ItQx4Rw9yF7Z2XckEz0aOsmQmRCg5MlTB0Y3owqwxAaR
         tLR/PNSrxA5P603aQAyd1lw5QOyRLHnBQ8Dok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/iFkf8dHZxV1Ge0m0weqa7TetCQZl7ZILZ6zxgWwBw4=;
        b=0L/TlYSLMtPCP+GiHtjrDR9/kk/P7o0cbHDXkgBMsa3FOs8LBDbHQLeYunhw8ZdpsZ
         DHgQ5Iht/bWtUblJcIzQOWd6+2055SZfDSsBIYvdYviMw6g3oh1I4mcQnYHrSC2Dppxq
         DJ0hkC2uJo5xZTCPBGTsDAkapWmixjDMRkRf8uFsqxOSM8A2116RqcC47BnBvxIxijSB
         dEwz+FWHoHAxIRQysbxOmpkNK7Ww7Y1ZxsNI3PKlnh5aFmczc/1moGeMEuOH2NSP+uLE
         D2AlfTTNUrlTek3lSQHK6a4XUwwDjkOt9MMAL29ES6GsMzE1cGudSSK/q4CRi/9q+2TR
         0eRw==
X-Gm-Message-State: AFqh2kp6RA9croJFcSdhJfUIgG2Dny+s+/u4M3Oy/QBWKCVNSFGOMPP0
        t2BeCamsHxlhNSOjyCyRXc8lGPqFSMt17j9AH59cxJBJzId4VQ==
X-Google-Smtp-Source: AMrXdXsq65Pfq1n8QvzT8E7hNMWVMZtanS9I0KqgdCOuK7AxjGS5DbAVk3aWa2DpvwDgRbwjaHBoJi5yz+ayizGbupE=
X-Received: by 2002:a05:6102:3d9f:b0:3c4:4918:80c with SMTP id
 h31-20020a0561023d9f00b003c44918080cmr8931474vsv.9.1673498881458; Wed, 11 Jan
 2023 20:48:01 -0800 (PST)
MIME-Version: 1.0
References: <20230112043908.2938964-1-wenst@chromium.org>
In-Reply-To: <20230112043908.2938964-1-wenst@chromium.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 12 Jan 2023 12:47:50 +0800
Message-ID: <CAGXv+5EebW8MP7M-Bpc695arsPGdkbQzSq6iSWBsM99MBF6v=w@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec: Initialize panic notifier block
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 12:39 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> Commit d90fa2c64d59 ("platform/chrome: cros_ec: Poll EC log on EC panic")
> added a new notifier block, but failed to initialize it properly,
> resulting in a warning and stack trace (omitted):
>
>         INFO: trying to register non-static key.
>         The code is fine but needs lockdep annotation, or maybe
>         you didn't initialize this object before use?
>         turning off the locking correctness validator.
>
> Initialize the notifier block properly.
>
> Fixes: d90fa2c64d59 ("platform/chrome: cros_ec: Poll EC log on EC panic")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Looks like someone beat me to it. Please ignore this one.
