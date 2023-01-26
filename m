Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4558767D4EA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjAZTBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjAZTBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:01:25 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11A467792
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:01:21 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id me3so7675599ejb.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+PV3o64mySToMwB+lYwZix37qEFlzbLtvyQStVksaE=;
        b=br8II8E3lVtGw4b1UqtDJw9xLmFQVU23gZp5vs8W7xufTsvviQxqJs7JuOPE1U0v5k
         yVDsOWYlyobuD2sEN4bAyoiufOthIExRq9MUIkTNQ+v69C8It9cxqlbv4rQpHdcbplwl
         /FEr36Ej1VaUmZ9mrkaaRuwjDnebICJ7FUuPEUDuDtzFEmvFppgdmW6gjS08oYGeRr3C
         RsOvP2y7O5KSyQkJQs92M+Cqv6JOVFi7BatoWKa10JqlzP28OgzxbZ+cex6KxOZ487UX
         GXDlcvHrxkz3wlLT+nA058ePpcggG99nhrlsoDpgFHXWx1fQkLC29qMQJE/6Ie+aWjPt
         xPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+PV3o64mySToMwB+lYwZix37qEFlzbLtvyQStVksaE=;
        b=IltsPbx5/o8NrS1ENa7BYjHnhzAsL/EP+e0vfVwpzGPG8XbOAyznKg4gJZyIMdOXh6
         48v1qS9bxAME1GP+IBBMH0DYJCy2CZV9kpyNlYP9PDsUeniOf7br6TJXIFe4lqP0tljZ
         QseC686fW04RA/ixNMHLGfX5cH+iY1GsZMmrjZX11p8ClsKoBXY5cZBQ4BB/y3l1SXBH
         Vy2qsjjC5nqFXW2MIhHms9j55GLDBKz+lPcv/inhUfAvmwUIExjaeASDH8uSEL32d/gt
         +/hKAfIkl2nQ2dmR6cPCvNyED98LW8OXuj5a+d3GaNqkoyszLTXjigbnWe1sMmj+LvgB
         szWw==
X-Gm-Message-State: AO0yUKXeew2TbhQgAE9gjsG4C8B9a5d9YnWITv+LhGD3sPap/T2/ur6N
        yf2R41pAyP519OsQ6IrLTCAJUQ==
X-Google-Smtp-Source: AK7set+i6HKxfdpJxTA7ijTraS9Vw4nPNPJJDNQ8xDtWwc9qKbtnSjGlUTVe66JQ+Y82lX7IY88ZvA==
X-Received: by 2002:a17:906:d974:b0:878:7a0e:5730 with SMTP id rp20-20020a170906d97400b008787a0e5730mr1936103ejb.56.1674759680548;
        Thu, 26 Jan 2023 11:01:20 -0800 (PST)
Received: from eriador.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id o25-20020a1709061b1900b0084d4e9a13cbsm974982ejg.221.2023.01.26.11.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 11:01:20 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run,
        airlied@gmail.com, daniel@ffwll.ch, quic_jesszhan@quicinc.com,
        ville.syrjala@linux.intel.com, yang.lee@linux.alibaba.com,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: Add check for pstates
Date:   Thu, 26 Jan 2023 21:01:03 +0200
Message-Id: <167475959090.3954305.1335839969306082106.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221206080236.43687-1-jiasheng@iscas.ac.cn>
References: <20221206080236.43687-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 06 Dec 2022 16:02:36 +0800, Jiasheng Jiang wrote:
> As kzalloc may fail and return NULL pointer,
> it should be better to check pstates
> in order to avoid the NULL pointer dereference.
> 
> 

Applied, thanks!

[1/1] drm/msm/dpu: Add check for pstates
      https://gitlab.freedesktop.org/lumag/msm/-/commit/93340e10b9c5

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
