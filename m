Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BF86C4848
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjCVKxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjCVKxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:53:06 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDD92BF3B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:53:02 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i9so16525433wrp.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679482381;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axAxaj7MXeeZyZASdvUOIHiY+xN3glaRGbzn8j1pi3I=;
        b=fTU6r6P40wLrXmxrzrS569jMfY8gbkSAEMkgKJm7KvjjpSM6nx7okd0eh6sNYmdRaZ
         Wz6lHFzIWoBBSJlXyWB1U/QrtAZ/g2FDDqt9Skim5vgyy2TY3Cy2yRYh1pMN91hGfZMs
         MJGuNzVND1OYtUl7eiNMImue/8CjyyX/VYwKODDMRPafTY6sZUgyv1xQwRsgr4V0m3Rx
         iQ1AEL+LRCRvTJXZIWq6yktGs8m5u5zmxLZW4q9HCR0ShToIqlQ/Tf3OcnTMmIzfSDVU
         VfL7oIZ6c1FR1/PNu9Ip4K3H34NOB/071VeAFz63oziyRuNoZDwH9FfuarI3wYSn3sDz
         wnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679482381;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axAxaj7MXeeZyZASdvUOIHiY+xN3glaRGbzn8j1pi3I=;
        b=d5DAxexqkthLyeyaYdekDD8M/8rGBZouTzDcywoKPUt6mVA+TC/klkY4tIjg+bxhmK
         q4hZtO+SQdW/Zf8jVVuXmm8M/Tra9k/qkloUIrFJUMDxilj4G44OuNNB+5Vi06WikeMp
         sz6jFeuUgPQuzaU4uPnumoUq7AHHobt70F3GS+kLKwr7EnMjmym4DLVT4gsX8evAefkM
         Ec3QM01CNDWgLXV9C2f5zOpYpyA1AtUKVqlrgD2N89x/aN2n/O1NioekZWnKegTv0yrI
         6vkandCJqzgBeWPU+acLiglFpPu1Oue7vSRjzf4hZMkY29lA/ES6m8isoFjKMHleqArt
         R4Wg==
X-Gm-Message-State: AO0yUKVg/SpYhhIYEuwaEdVXEjPxkAy5SOF6fFDOdNkrPKTd7ygbjmvW
        Ral/WRWxnsCdKBGFJH3FoJjRWQ==
X-Google-Smtp-Source: AK7set+2WWU70m5P+jJc8FGWBVyy/DorAETD1YkwMx34X/BnosCTT7ebWI0esUT4ANz3MrqZZsNFkw==
X-Received: by 2002:a5d:688c:0:b0:2c7:fde:f7e0 with SMTP id h12-20020a5d688c000000b002c70fdef7e0mr4856639wru.65.1679482381373;
        Wed, 22 Mar 2023 03:53:01 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id j10-20020adff00a000000b002d1bfe3269esm13555049wro.59.2023.03.22.03.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 03:53:01 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     laurent.pinchart@ideasonboard.com, ye.xingchen@zte.com.cn
Cc:     andrzej.hajda@intel.com, rfoss@kernel.org, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <202303221622511915615@zte.com.cn>
References: <202303221622511915615@zte.com.cn>
Subject: Re: [PATCH] drm: bridge: simple-bridge: Use dev_err_probe()
Message-Id: <167948238056.3845492.17020283681368412723.b4-ty@linaro.org>
Date:   Wed, 22 Mar 2023 11:53:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 22 Mar 2023 16:22:51 +0800, ye.xingchen@zte.com.cn wrote:
> Replace the open-code with dev_err_probe() to simplify the code.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm: bridge: simple-bridge: Use dev_err_probe()
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=db8496d0b50519540e1ee50f7e209b3a536ed671

-- 
Neil

