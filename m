Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EB26710AA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 03:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjARCGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 21:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjARCGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 21:06:36 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F7C457C2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:06:31 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id v13so13604526eda.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPh85HDV7Jw4nWVOxnyUOQB6ME/srGkxE0cyhhHU/Yk=;
        b=QVIZgJlLk1umjAWsyCPwP7XPYhLhTT9losqSf5WkDA1WJ/TBaeqSo0vYTrysPHJnb8
         7pyZN8RlI8lYKRpA/1yX/+Ei5U5wxeM/LU1S26Sk/Uj5peY++NLxBsJPWcw63oUfvi2z
         8HyQvVXIy+CCd0JHJ3eGEdxrlhXOl4+m6pW9goseei2GipCXfvL2LX+2E4pidNj826yM
         j97TB9XMMs7qLQcdM9oMiayj6m97CCinuCcByh4SZ6OmwdMhXa5LXbaDNZhBpPxr/6Ie
         RxN/bWm2C4DthmWxU6ifh/wgVGtMjKXkbr43NBruyh8jisWbezeSvtjBu+jDni/fDXYC
         SxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPh85HDV7Jw4nWVOxnyUOQB6ME/srGkxE0cyhhHU/Yk=;
        b=LzhSXrTqCaTT6+kutHXLFba8m2eI/6CDMDSponlvAabO0phHEHiC5Z/WOAG2QTE5IO
         jE51Il85Inn9SzK9e8QWPARZ6iic80fHGDsveUOuiDCQkk2MWt6H/jXPFl+Gzy49n8P1
         KCBu0tR36TfZ+tvR+j73QUodJeiNfA5r7gFX9hiN7cEpXhI2c0EU+gWNM/BdbRLrbBMB
         gNmdsJgn5xN3s7b/30qsGlN238TlsdyFsOEFLrSX2vLEs1R/48/ZpUJS3yCKl1oZTg8t
         Q3UDDGkOQtk1Wuf2sPjjY2rFVCicFKEhJCm0jzexmruRVMu/HfvKOGx+nBPUs6cC1vxW
         lm8w==
X-Gm-Message-State: AFqh2kqncLe42nYg71Wq+x/G+WC10+cqWYrbNMmquvX/LzoyOTAh+JXo
        hWDYjBdBo2ltigO0T9xIaHJB4Q==
X-Google-Smtp-Source: AMrXdXtMG/C8Z6HucSOog75whRYOxAnKIALrlKkOKMedyIiyZJTMJBZKlKtfCmnPPSpnF4D8Wc/TOg==
X-Received: by 2002:a05:6402:298e:b0:496:6a20:6b61 with SMTP id eq14-20020a056402298e00b004966a206b61mr5469620edb.22.1674007591554;
        Tue, 17 Jan 2023 18:06:31 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id kx1-20020a170907774100b0084d368b1628sm12702694ejc.40.2023.01.17.18.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 18:06:31 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run,
        airlied@gmail.com, sumit.semwal@linaro.org,
        christian.koenig@amd.com, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/msm: Add missing check and destroy for alloc_ordered_workqueue
Date:   Wed, 18 Jan 2023 04:06:13 +0200
Message-Id: <167400670545.1683873.7363279471120139264.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109022038.2163-1-jiasheng@iscas.ac.cn>
References: <20230109022038.2163-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 09 Jan 2023 10:20:38 +0800, Jiasheng Jiang wrote:
> Add check for the return value of alloc_ordered_workqueue as it may return
> NULL pointer.
> Moreover, use the destroy_workqueue in the later fails in order to avoid
> memory leak.
> 
> 

Applied, thanks!

[1/1] drm/msm: Add missing check and destroy for alloc_ordered_workqueue
      https://gitlab.freedesktop.org/lumag/msm/-/commit/643b7d0869cc

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
