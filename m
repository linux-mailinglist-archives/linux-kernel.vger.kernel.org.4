Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0038F63EAFB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiLAI0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiLAI0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:26:15 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1E360353
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 00:26:14 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d1so1414048wrs.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 00:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFqLP9k0bT0Mt44DPB2mvhK9vHSamghHlQLp/vyzST8=;
        b=U4NmYdKBUx9QdKiyriy5EwHSu8ZdemV5FMZ0WZoeSDd/MeA3b0sg6tfj0CpFSguPFW
         +U6A6+Vdcha3723PsWPhkeMWkMIkSsHDkDcjT5MU8q1X4MH36b50tWzqtzk/lqy5knMF
         zBplGMWWnsa3Eg+wFewWUQmhq9gAYJRThFp3rXiJkobm4wJ2R+YpKq6b2zcpyB/fWCGx
         wcRJXL43lcJQivcPG+EYQdSiUayYl0qIj+HTFlb53Iq6AE47P/rq6YkPQhl745qtYPgo
         auvpMyt7QPZAwEXytAfeKETc7pelQLqr4Rp5Scsj0mU639NkHNVw1i2U4IjrXlukyLU7
         JG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFqLP9k0bT0Mt44DPB2mvhK9vHSamghHlQLp/vyzST8=;
        b=DWnpzI0LmGSiQgaKg02cbJbHkt6pqjpm620YyOueqsgHpwvJOkZ8mCT0jnP6jnpwAC
         jKxr4bntMK3rLyGikIpZO9YwTi0xCC8tOaz9sCHZFRkzBsg/6K2DzzV1vsoI1CxyDg87
         sFkQepYIrZsTyKNlHHmQ6n2pT4/UGKScRU5R6m0HjBU6ZhnJKe5Z1tfx2sKbumpD3BAp
         rmpxJ5VMLTiE40wJ9tjXtjywldGejodvZzHdzh/pg/4J1dOxi1NnI4zLT6VE68r0oRwi
         bkq448XbHDekjYFdIN3WKanHzxPjBkK3xbvXKL7WN5xoB5Ieamp5J2stDS8OK/9bhdNC
         EovA==
X-Gm-Message-State: ANoB5pkNPQj574G7r54I2w88lZpidFLnITvoT9VTTGQiPskqaYnMqx6g
        z/EahKSjDfkmEjnVocnUm8ceboAb2CiBqEFV
X-Google-Smtp-Source: AA0mqf4a5Z0PH/UgvFikZjY+k5KPvJuMO75nsDbR3SRjCEInYm+8Ie9RFm4XdT39bhTe30ft+HlBSQ==
X-Received: by 2002:a5d:4887:0:b0:242:1b2e:a8c3 with SMTP id g7-20020a5d4887000000b002421b2ea8c3mr11002249wrq.296.1669883172607;
        Thu, 01 Dec 2022 00:26:12 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m9-20020a5d6249000000b002302dc43d77sm3756176wrv.115.2022.12.01.00.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 00:26:12 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Guillaume BRUN <the.cheaterman@gmail.com>,
        Robert Foss <robert.foss@linaro.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
        linux-amlogic@lists.infradead.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20221116143523.2126-1-the.cheaterman@gmail.com>
References: <20221116143523.2126-1-the.cheaterman@gmail.com>
Subject: Re: [PATCH] drm: bridge: dw_hdmi: fix preference of RGB modes over YUV420
Message-Id: <166988317174.1947573.2294084268751804752.b4-ty@linaro.org>
Date:   Thu, 01 Dec 2022 09:26:11 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 16 Nov 2022 15:35:23 +0100, Guillaume BRUN wrote:
> Cheap monitors sometimes advertise YUV modes they don't really have
> (HDMI specification mandates YUV support so even monitors without actual
> support will often wrongfully advertise it) which results in YUV matches
> and user forum complaints of a red tint to light colour display areas in
> common desktop environments.
> 
> Moving the default RGB fall-back before YUV selection results in RGB
> mode matching in most cases, reducing complaints.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-fixes)

[1/1] drm: bridge: dw_hdmi: fix preference of RGB modes over YUV420
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=d3d6b1bf85aefe0ebc0624574b3bb62f0693914c

-- 
Neil
