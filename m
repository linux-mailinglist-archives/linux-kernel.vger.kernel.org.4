Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B327471B5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjGDMte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjGDMtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:49:32 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE86B1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 05:49:31 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fb77f21c63so8648274e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 05:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688474970; x=1691066970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hNuPDJgx2GdqBpIEifZmqZK6fZ2qXAmR592Qq8106yU=;
        b=cykF9vexMoyEoJ/cVWcIGdJPZe85ytzRs/27wf21J8dTiPDOXUG+1eMsCtQN608AMu
         kYOReUD+x75DTIve0vfAe/2lfiwrnz7fQZ6XQUN0oMtcKOu0ILQAFUTmPsTom66Vc3lm
         JZ9B5B1ApU3Uy9+EBx5VLS/uZsKLrw3lUB5jaGwiwklvQrHlU3mqT4XjCBsveCjhHnW+
         73ENtg7kBEgPSj2KjeEXf3X1Xq/v34D9eDLZ3k4ubiO3gt8E37o9hJ1j2dXUIJ7V6HzB
         lPwZjWM2MpxXZFn+n4aCSQCW+ULBVNGYSY54kwRJqghU3lWI2NQyLtcZLyijLg/lyCLM
         mtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688474970; x=1691066970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNuPDJgx2GdqBpIEifZmqZK6fZ2qXAmR592Qq8106yU=;
        b=VBf04+Q/9OXuGOdFIFEt9sMdo9IOxKAGPgUlQaJvTFjW2aHI8N6xPmG2T0rq2bNs2k
         J0IHbz1jHIa5IllLL31xNn8H40/RyDz61gR1KalCCv94gWAN2Sub4cGmMB3DnJDSrMgu
         JkTtxZobLeJjdwj+LK/BFsRU0iGfBu96viIZ6hErGaJK+n43onTaMX77BNNlkPic01Ot
         6HqDxXesBzCwtlGqGxcaZ6/kLTcrt3ppOS7ng8FyzbgPmquD4DpGVkM7FnUF6n0Tn/tI
         SILY1DnwrjpvLROTu8itZeopbeZe/e0OykiK1e8iqPJQ+Add4Dkgf8klKL0jEopkoIWS
         +YuA==
X-Gm-Message-State: ABy/qLZ8WNXWpcuyM+wtskK4b07cvHchG+wrxMC6wl4JOEWTkAs67Brd
        9tlEA6De/fb7xB+0zMmiPTdwwgr5m0/tQHThtH4=
X-Google-Smtp-Source: APBJJlF7tgH35Y0RUbCd8OG9DhPv95WQyZCWbEhDobMqlTPWxXKBhQ/38us9NfUF9HOFUvR7sfNYdg==
X-Received: by 2002:adf:e8d0:0:b0:313:f2b3:af73 with SMTP id k16-20020adfe8d0000000b00313f2b3af73mr10169742wrn.25.1688474949314;
        Tue, 04 Jul 2023 05:49:09 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x18-20020adff0d2000000b003141e86e751sm12461124wro.5.2023.07.04.05.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 05:49:07 -0700 (PDT)
Date:   Tue, 4 Jul 2023 15:49:03 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Koba Ko <koba.ko@canonical.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] EDAC/i10nm: Fix an inappropriate shift exponent
Message-ID: <af0b6cc3-1edc-46e0-a4c1-b8c10fd15ee0@moroto.mountain>
References: <20230704095939.119620-1-koba.ko@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704095939.119620-1-koba.ko@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good enough for me, thanks.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

