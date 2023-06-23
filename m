Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFAA73BAAD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjFWOwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjFWOv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:51:59 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9F01987;
        Fri, 23 Jun 2023 07:51:56 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f8fcaa31c7so10441215e9.3;
        Fri, 23 Jun 2023 07:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687531915; x=1690123915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtzBfY6r4HwJtzsGmqq6nuAWX8H50xr1/TUUt/sizv4=;
        b=R0OQd0ln1HOSSbJBUIwdwWsFr0aaSepJTaFHeQFMG6OCyXRXHgLGEsC32SIrFXka2B
         6S8Ne8yetJYFQDBgD+6SeL6WU5/rq0iT/BQMTWHkAb3IflmKibHS6+9VgaGnq+R4nEPL
         2am7HUrZ500jsDphPATykiSwAGZMHw+7LoX73TZ0uNKjQTknpeZdxl4hGrXKh3L/uaPH
         3/hGBoDFNc4FAaCCfPN+E8Kl2UJZnMKW23uTjkl/k4JZzeliyiqHw86FvDmKKtssiHOx
         F7rTdyT8Vk4aLqWZSuac4u/EPrQ3yOkXiGmgIcL9BdHSCfyKNxeZmBUQ9iI9lgAvebXT
         OdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687531915; x=1690123915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtzBfY6r4HwJtzsGmqq6nuAWX8H50xr1/TUUt/sizv4=;
        b=EPJHmdQ9IdYVRqm4VGRE5EyJYcfioMoJcXude0DQpipA3FzfBsHIlbTa2UMeywOwXG
         9/ejVuNwHq2VjcHcrg6C/UH3P1mwFquDCmjrZiweiVnMqse/IKHIs2mOqUrLZagj2YWl
         /xtsfArhk9x1OPLUf0Yo3mE+xeWNkDikgd0VvHu62Mi/qH6A4tT2Iy8E34jSUhpLuprX
         clpBgZC/p5+r2bOkYeSvsh6VLMqE0qGMb6Tj6zGYsxb5atT3ek5jjbE3V1XTy4Pyq6+2
         WBi5ibybCPxrKP9l16lfY+Qd1UtrZrHeVbUQN9T2WWIT2guFHVtUfzoQj9Q/UzXKZN9P
         +k5A==
X-Gm-Message-State: AC+VfDzLG67rHsyPdhExn7ZgHyFl/NqDonqhCZOeIY3nTGQCKfQmbcth
        8PHfeJYq80bK1o2Z2UHjwrY=
X-Google-Smtp-Source: ACHHUZ4DbGiN2wR7fMKXOwdI62llEPrZSO2U1WPtEnBPAVTIcAhm4rJ1IobFYnR6nXcQxBLhu/tgtA==
X-Received: by 2002:a05:600c:205a:b0:3f9:b45:78cb with SMTP id p26-20020a05600c205a00b003f90b4578cbmr19016306wmg.22.1687531915295;
        Fri, 23 Jun 2023 07:51:55 -0700 (PDT)
Received: from localhost (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id f6-20020a7bc8c6000000b003f7ed463954sm2552269wml.25.2023.06.23.07.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:51:54 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     u.kleine-koenig@pengutronix.de, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        Shuijing Li <shuijing.li@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        jitao.shi@mediatek.com, Fei Shao <fshao@chromium.org>
Subject: Re: [PATCH v3] pwm: mtk_disp: Fix the disable flow of disp_pwm
Date:   Fri, 23 Jun 2023 16:51:38 +0200
Message-ID: <168753171979.1191890.11949731883748981636.b4-ty@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230531031001.7440-1-shuijing.li@mediatek.com>
References: <20230531031001.7440-1-shuijing.li@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 31 May 2023 11:10:01 +0800, Shuijing Li wrote:
> There is a flow error in the original mtk_disp_pwm_apply() function.
> If this function is called when the clock is disabled, there will be a
> chance to operate the disp_pwm register, resulting in disp_pwm exception.
> Fix this accordingly.
> 
> 

Applied, thanks!

[1/1] pwm: mtk_disp: Fix the disable flow of disp_pwm
      commit: bc13d60e4e1e945b34769a4a4c2b172e8552abe5

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
