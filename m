Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6998067CE4E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbjAZOhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjAZOhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:37:23 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90DE2529E;
        Thu, 26 Jan 2023 06:37:22 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id me3so5555443ejb.7;
        Thu, 26 Jan 2023 06:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojoaU79vsM9d6gnnSHhz/j9TBcg9S6MfuddKc11zkQI=;
        b=Qvk6hlDc1Y7T+h5eZC3/WtyiiG6rpVH0bci43kDVCCpE/XcXipEi4dTXtMkPl3jHCl
         Zua9JThVPpbqtgtqjvAjeLu8lA82Zd1tVi3kTA2zDuiYTXnlv2Y+RBZrJ7CTkpr9AtlV
         Uvwc74o1vvTQjbo82+RROoFCMPaEPzcG9VZoGxvAkXYqltOcfXGnVsMmoX4Wn6FVRnbV
         nd/qjdSgnDT9Y0naJmUTI4pRvVRwvXJE+C7AqbHKUfsut0kO+M+o4K6NXJ+gOqI7WrYH
         W2G4w3FxuOCCw0L/EVVBcx35Wh+ShQT5G6FEr9+iRTdEjGoHDTwh9rPkoUmo7QPV06IP
         0xxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojoaU79vsM9d6gnnSHhz/j9TBcg9S6MfuddKc11zkQI=;
        b=XRc92XtVjqRv8pYz/cG3mSrc8pocXA3kr+/shm4hTNPIfHUW6EwOSZ5H8N4QPIXjNq
         HcGoBCc2nEkHntg29ts2Z3cfyrUWkEnF6GT2ATp9G+Pem21jG/6SllQ+wDJ4eNqtcJOW
         4yo7ebfkPcVP9iV3oLLpgvjC0d3tvQ8ZjM5vC36Aw/BQAvR4otMXVokjr5u7MRZySBjI
         G7Y3q6N8/hFYsE0HLVqRv8wSlGp9/3E+NNc8X9gu2nD1cRwxmlCvdCYY8UY310VV96m+
         h2S3voQR7SS9kNX5vwiUqtJwI5T9xdaDToBbP2BepXWTItaWnRnrjD6gvH7BNti/VBB8
         cp9Q==
X-Gm-Message-State: AO0yUKVGX7Io2PQ3BlO+moEig7cM638YIqYs0ST5X9YQSCawtesOaTiG
        aFKfZFmDFCs1L/+CZSqCYS8=
X-Google-Smtp-Source: AK7set8dbBqhWX+8vueaZet6qki7SVYHve2oRacn2VrEua6nci8+6sOuxk2m//pfsWPfpmCMkPjwDw==
X-Received: by 2002:a17:906:4b13:b0:878:5e84:e1da with SMTP id y19-20020a1709064b1300b008785e84e1damr2699504eju.27.1674743841116;
        Thu, 26 Jan 2023 06:37:21 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id rh16-20020a17090720f000b0084c7029b24dsm674327ejb.151.2023.01.26.06.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 06:37:20 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mikko Perttunen <cyndis@kapsi.fi>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/4] gpu: host1x: Implement syncpoint wait using DMA fences
Date:   Thu, 26 Jan 2023 15:37:16 +0100
Message-Id: <167474380848.1640957.3846713642023225990.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230119130921.1882602-1-cyndis@kapsi.fi>
References: <20230119130921.1882602-1-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

On Thu, 19 Jan 2023 15:09:18 +0200, Mikko Perttunen wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
> 
> In anticipation of removal of the intr API, move host1x_syncpt_wait
> to use DMA fences instead. As of this patch, this means that waits
> have a 30 second maximum timeout because of the implicit timeout
> we have with fences, but that will be lifted in a follow-up patch.
> 
> [...]

Applied, thanks!

[1/4] gpu: host1x: Implement syncpoint wait using DMA fences
      commit: 10b8db9244e3545d7278016ffb878d5bfe3201fe
[2/4] gpu: host1x: Implement job tracking using DMA fences
      commit: caf0f8e3e318c7e1c687072293518c42befcea68
[3/4] gpu: host1x: Rewrite syncpoint interrupt handling
      commit: ba9218b16428dbfcdd167899f7e54c5c6a081c07
[4/4] gpu: host1x: External timeout/cancellation for fences
      commit: 93d08ca7ed728bf3bf70aa78caacdfb7011d6d03

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
