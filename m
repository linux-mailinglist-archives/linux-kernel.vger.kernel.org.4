Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057596E1F67
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 11:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjDNJhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 05:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjDNJhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 05:37:03 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2335B89
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 02:37:00 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id g10so1352895ybu.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 02:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681465020; x=1684057020;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hcl5JAFIbTMP/d99z24jpTmHwsu37Ehq7P48dAk3gP0=;
        b=QJWrW5xmfhDVcnnegd8OGIGQIpRAntdxmW5mMBaD5grjhV6JDH5TF5FmU/2dRM2sfT
         PtkSEq2i03Ma4coBQgkyqhDTi6zWBXWQgjIFGMYkRO0lsFXLIh/Q4qEqulcLfMaR2R1k
         XSmaHuxVh9i0B1w6bkHsalMwdEqqSjRU0Na1F64qNrxpys2cynTbbgZeCSJPWwjIb7bx
         OAOjpEVELHgr2EBk2qEa6GQVUXPLUmxQD8ipzJZbom1NfAR3fF6PGIeecIwolwH0uYDh
         1/LEGz9qqS0/i0s5MapPfu96Dx9YREcm2pFmezHRz5gyE41vadFBMIZRWSEFMtMhioLs
         6T7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681465020; x=1684057020;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hcl5JAFIbTMP/d99z24jpTmHwsu37Ehq7P48dAk3gP0=;
        b=CTBY/qyygOaRrNCaehfIZLgV+PJUrebuzbjQmxmFNbZBsCQ3fnSg2SljPQGRQUrnMq
         dtTu7KjyW8ICW1SUHzkbxbowwJZ2IDSRvZyS2g0UgYz4J2VCnxzR9bpAFS7CZfV2sW55
         5n0wHzupGcUL9oU7Jc2sWwEqUQf+hAIs1YjJkFjjT3DnoQG7grSEBR1dOolWqG3FseIJ
         ciPs5D94hV8L8s72/uTJZ7iLj5QHSbjIm5dg7pB7mr2sVvDrNXaCzXYeGatCXxbU1c+b
         S/IomUlY5MmT2dtDscMlWYyzIcxbJCBCYdeI7nCak5+z61ZQUVJP5EsKJg2RF+2RcaY0
         LnpA==
X-Gm-Message-State: AAQBX9c3J5QoDdo0Tx8eyrEtCs8LArqIkN7JJNLUxi1x2Vy0J32inbH/
        3v7ruu+HPgt4S9T5iSatCK/M+oprvjyz3iy7p8m0QFFW6zVmbgE4
X-Google-Smtp-Source: AKy350af/jMUd4s2J8pKpwoSU0VLsLJyk5mrxg+vzfSVULhQkIrxCG0frEDy+bRtqdhH1Yi6v4k0kvISVsM7w/TqHJY=
X-Received: by 2002:a25:730c:0:b0:b91:b64e:743d with SMTP id
 o12-20020a25730c000000b00b91b64e743dmr313567ybc.9.1681465019951; Fri, 14 Apr
 2023 02:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230414084619.31524-1-johan+linaro@kernel.org>
In-Reply-To: <20230414084619.31524-1-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 14 Apr 2023 12:36:48 +0300
Message-ID: <CAA8EJppa6OUqaiN61mDr_xSEsAqJtLHGvwuwBDcWYaeLEwkVYQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2] firmware/psci: demote suspend-mode warning to
 info level
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2023 at 11:47, Johan Hovold <johan+linaro@kernel.org> wrote:
>
> On some Qualcomm platforms, like SC8280XP, the attempt to set PC mode
> during boot fails with PSCI_RET_DENIED and since commit 998fcd001feb
> ("firmware/psci: Print a warning if PSCI doesn't accept PC mode") this
> is now logged at warning level:
>
>         psci: failed to set PC mode: -3
>
> As there is nothing users can do about the firmware behaving this way,
> demote the warning to info level and clearly mark it as a firmware bug:
>
>         psci: [Firmware Bug]: failed to set PC mode: -3
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

For the sake of completeness:
Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
> This one fell between the cracks so resending with tags added.
>
> Mark or Lorenzo, is this something you can pick up?
>
> Johan
>


-- 
With best wishes
Dmitry
