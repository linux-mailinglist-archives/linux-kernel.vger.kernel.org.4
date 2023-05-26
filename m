Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D607120C5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 09:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242202AbjEZHS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 03:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjEZHSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 03:18:55 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D54B9B
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:18:54 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f60e536250so10039515e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685085533; x=1687677533;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7x8EaOVciQbaWaP7P7FJjb990SGfOsPyezBQlBQ+Diw=;
        b=gbIOZDLWvLSxweRWLTzaY8XBjZ5q08yrxVQxiv39jl2zy6TQZa2lgdlICWZEWDSIHZ
         fpabCR6kGa+foz/21JE4Cojs3fkY4BI/iG3y4epRfXiX7j5xEyFsRzYYW9HBUNNPkbj+
         6feD5bHx9YvCa+CqFh8q91RZ4uFIpTPKgNdXi8ohDHul0t+99soOoJx6yo8Vxtyxr/c1
         h1/sjhkffuOOrS8lxEUxW0OSChsIPxBPuICJeRAPI3rSRDYKcY70uh+IJnUZyX4XOy2x
         WL7yZyBfYkb5uM8OjhkM+htw9dkUB/8CaB7nGsQ7vkgmYUhl/yoiZha5An+LjS9Wd0Bx
         Wuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685085533; x=1687677533;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7x8EaOVciQbaWaP7P7FJjb990SGfOsPyezBQlBQ+Diw=;
        b=g9+2+TLlFvt+1PGABczaTfdYlezo/poZVRmZDwHuXGk1jx8WEAVMLhTtvOIUR0rTGk
         TivMawwCH0UD/MjWkUuD72r8U1o7y/ji/KICFEVzCqVBLzqXBEGejh4MdNEduX9FoOUr
         Btv2ExdjApOe0UQpjfc+HDKUB1MkaLrKUeQWRpRmLta/0CZXVWaIOdOcThwC6LQSZLx+
         jp9xn9a3X55DEHneOyr7uk+0h64QgAkX37PQq7Udxf6Ump4q1ftVXwFBoeUJj51v+ZMW
         y62x5vjzbfX+ShhIgNQ4DCL7lZbwLqiVLrr7geZQ7fSlJVYSzBDc8UC3ocmETcjmepef
         zhGQ==
X-Gm-Message-State: AC+VfDxTrkwQm3eT2rob0lGrGAHZ9/QzuZU3R5EGrL3+ER7O2QtXs37+
        Xa6Rgm6feEWDfgcX/2juYeBr6w==
X-Google-Smtp-Source: ACHHUZ6R6U6shWgeZfTSnEZIBLJRJhvCBwuNhpQtzNz+PMH2uTCIIEyZulY1YDZ4YG/YtXlVkmmLqQ==
X-Received: by 2002:a5d:4402:0:b0:30a:bd8b:b102 with SMTP id z2-20020a5d4402000000b0030abd8bb102mr591334wrq.19.1685085533126;
        Fri, 26 May 2023 00:18:53 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d6849000000b003078c535277sm4085490wrw.91.2023.05.26.00.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 00:18:52 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>
Cc:     Rob Clark <robdclark@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Guchun Chen <guchun.chen@amd.com>,
        =?utf-8?q?Marek_Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>,
        Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
        =?utf-8?q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230525155227.560094-1-robdclark@gmail.com>
References: <20230525155227.560094-1-robdclark@gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Fix no-procfs build
Message-Id: <168508553213.1425379.11727335048829128937.b4-ty@linaro.org>
Date:   Fri, 26 May 2023 09:18:52 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 25 May 2023 08:52:24 -0700, Rob Clark wrote:
> Fixes undefined symbol when PROC_FS is not enabled.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/2] drm/amdgpu: Fix no-procfs build
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=1a56fcf08ae463a4564d111356091b2bdb6c7bce
[2/2] drm/amdgpu: Remove duplicate fdinfo fields
      (no commit info)

-- 
Neil

