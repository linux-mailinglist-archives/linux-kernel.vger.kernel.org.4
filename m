Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CCA6732A4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjASHlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 02:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjASHlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:41:24 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22539613F4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 23:41:20 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id q8so789100wmo.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 23:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgG2FwvgVbALatyDiQTv2yfiCg1ShOPwxPOzuE7lY8w=;
        b=Hm5Gi9OwoeVtoxiHQJgLNbxVz8+wv2x0eXhe7xsVamqCXuAYPWWRQIsYEi5R1A7/BS
         kQBPB5SrKQ/jndNqMhzTVyg/hMEmfqt4uqnPxLOkOfeL8LSKunfGNdKrZVcOMSre6Seg
         CjyjenT8VJVgZSWOgws89ekyKbtGK2M+hl5UqmrLrfDEOFkHEN7B2Qaasu0Zpn3ZGXKs
         nJ9hicBPjkU4lafBf3YIxX4LjiwoLMKmdlBP+7zKz3/H3T9TwUCWCYGb0OG7ggGnvKex
         QyatAcDxiLiUCquK5y8BrCcjbq5NNxs2+PD9GSTRVTJMBpwAkX3WfJ/mSMAHR6jIyCYl
         O1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgG2FwvgVbALatyDiQTv2yfiCg1ShOPwxPOzuE7lY8w=;
        b=yAOffrxRfDg6yZTW+/857gOCewduXMKYdB2QcGxa+Vvg44cdQ5t8BtQNbBIlognzT8
         I929A7DQYEot7EFBVtIXnCoqjiIfJCOL910Yh5tzgDhzk8Rl52BUkjzDttjzaEenKBkM
         /71iGN1T+7u2aDnGSrJY1Thc7f8h40WX0eRv9bCncqdrC/Pt2mY94tgRwHRs31t9bJTf
         A60j3jysQGioCNQDaD9KILNR4rpoKRvWdONkVglUQzqw4m9gCpvVowbKBXPajxyzxYSv
         UMNZh9Qlw2sdeovOyyPlQIGA9Rw+5g/5QzV5Mob3pUR0PPIx+arTwO/d0p4FJTnLcGne
         6lfQ==
X-Gm-Message-State: AFqh2kprS5GrjP/54zkYAMuZyKSodeyHHas5mrycVgOjM76NdAwmrs40
        gpjwF20w81dsoDEbkOJTClYfdhd5b8AsHK6ajzQ=
X-Google-Smtp-Source: AMrXdXtFYetCnqJMuUza3ThlLq2gmtyA6w5C8ivcJj+POBDTQtKq6frwQjMMe5OHhZF4BdLBpB9o5w==
X-Received: by 2002:a05:600c:198e:b0:3db:1d7e:c429 with SMTP id t14-20020a05600c198e00b003db1d7ec429mr2096450wmq.40.1674114079084;
        Wed, 18 Jan 2023 23:41:19 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id bg1-20020a05600c3c8100b003db09eaddb5sm4380139wmb.3.2023.01.18.23.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 23:41:18 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     upstream@lists.phytec.de, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Wadim Egorov <w.egorov@phytec.de>
Cc:     daniel@ffwll.ch, airlied@gmail.com, jernej.skrabec@gmail.com,
        jonas@kwiboo.se, Laurent.pinchart@ideasonboard.com,
        robert.foss@linaro.org, andrzej.hajda@intel.com
In-Reply-To: <20221228145704.939801-1-w.egorov@phytec.de>
References: <20221228145704.939801-1-w.egorov@phytec.de>
Subject: Re: [PATCH] drm/bridge: sii902x: Allow reset line to be tied to a
 sleepy GPIO controller
Message-Id: <167411407820.262112.2141398001739030044.b4-ty@linaro.org>
Date:   Thu, 19 Jan 2023 08:41:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 28 Dec 2022 15:57:04 +0100, Wadim Egorov wrote:
> Switch to gpiod_set_value_cansleep() in sii902x_reset().
> This is relevant if the reset line is tied to a I2C GPIO
> controller.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/bridge: sii902x: Allow reset line to be tied to a sleepy GPIO controller
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=5688ca34698c734d5591add39e72380123132656

-- 
Neil
