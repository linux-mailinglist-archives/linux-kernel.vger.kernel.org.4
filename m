Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D75702D1B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241976AbjEOMxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240871AbjEOMxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:53:01 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11BC199F
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 05:53:00 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3078c092056so6629859f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 05:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684155179; x=1686747179;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0kKvU8VcjZDCawm1uzpgifPJsmcOM7ycSUxGftpKlg=;
        b=kQQkiCuyGeHXbQ20FCvkY01rdbA3aktukV5cOjcESX8wfW/rZ9oJjouqt5mIKEhqsI
         PJV3ds2mEk2TUyI7S7xOG+4APL9bxRIQGGDfOGHCLXx/wbQf0HbDlF4S51t0R8rChBKH
         d9m6yO0N+aWBZYSJAaCBUHqxbji+yORNy6AVsQtBcQpb+YkgtPu2jfzEWkUOw2bUgvcH
         tc+1OBd1m8fNLUxTv9Hddv/qCLeu3pccjYlVoWzSnTAexzFijNJoVYW7XikJU+pQFyvj
         GAkyslBQvJrnQrtJNWwZOusXwsr4qvsZjC3TYxdXi/XFnD4nCcxvchRnqQeamGQFp3Oz
         HO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684155179; x=1686747179;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0kKvU8VcjZDCawm1uzpgifPJsmcOM7ycSUxGftpKlg=;
        b=ZO2TCymYERYk7SCD006jWKde14gVFw+t3u1rvS1dtY0P2gES1nb3GvO7oFhC8qoBma
         ODDYg8/4Ou6ZU8hAeFHRtnBBn/P0s0jCkrzWeb0Q7HzV8vAGWux9Ebhc3QxwPEHyKgGq
         f9s7jbp9DXHQmPg5x1dwayU2B+K1HDiP5iuEEwnReAq0pAnoanacrujReBL//MLrRdYf
         WBiJ5jJ7hUWjZjzNNj0vKGZcPmF5oP0ZsJ0Ol1HGtUyZGVjwUk7PcSkC87eqYM7CZXPM
         k/DVJA6uKXPK1B3DvB6cjsKYt79Xj7mfJZQ2UrBSnpEclISHll0ejbNk4pzMTIa1G4Hf
         flmQ==
X-Gm-Message-State: AC+VfDy0iBQjxIR1kSYbgTpb8+v8FMwLub57AkJdSZiBx8f8JoY8iCZa
        lfSyNnVyxMGYBQABlbLBbBsqAQ==
X-Google-Smtp-Source: ACHHUZ4pr0OZs/JDMmps+IUMP9qKK49qZJW95shiWiZOKkfFhc5PHKAymSNXqXTfWXrzamNqen0KYQ==
X-Received: by 2002:a05:6000:1b8f:b0:306:2b31:5935 with SMTP id r15-20020a0560001b8f00b003062b315935mr19376409wru.55.1684155179018;
        Mon, 15 May 2023 05:52:59 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id f16-20020a5d6650000000b003062c0ef959sm32197342wrw.69.2023.05.15.05.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 05:52:58 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     sam@ravnborg.org, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        Shuijing Li <shuijing.li@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        jitao.shi@mediatek.com
In-Reply-To: <20230515094955.15982-1-shuijing.li@mediatek.com>
References: <20230515094955.15982-1-shuijing.li@mediatek.com>
Subject: Re: [PATCH v4 0/2] Reduce lcm_reset to DSI LP11 send cmd time
Message-Id: <168415517821.3264861.11690266641021902230.b4-ty@linaro.org>
Date:   Mon, 15 May 2023 14:52:58 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 15 May 2023 17:49:53 +0800, Shuijing Li wrote:
> The panel spec stipulates that after lcm_reset is pulled high, cmd
> should be sent to initialize the panel. Within the allowable range of
> the DSI spec, this time needs to be reduced to avoid panel exceptions.
> 
> Base on the branch of linus/master v6.3.
> 
> Change since v3:
> 1. Rebase.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/2] drm/panel: boe-tv101wum-nl6: Remove extra delay
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=fe7f4e8d496552f880d7368b482d2ccac33780b7
[2/2] drm/panel: boe-tv101wum-nl6: Fine tune the panel power sequence
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=812562b8d881ce6d33fed8052b3a10b718430fb5

-- 
Neil

