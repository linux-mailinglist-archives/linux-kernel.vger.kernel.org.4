Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F56724760
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238485AbjFFPN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjFFPNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:13:54 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DBDEA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 08:13:53 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f739ec88b2so23220345e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 08:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686064432; x=1688656432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oPhoOlX7tj4q0aOoQPFhXWKvOaJE49df7Ezg7KCTEto=;
        b=bsXrkIMaeLrySKSAyZ7v8eVAwoFX8EhuxpuuyrQA/+odODIEcPatIpKLhfJlcNkdjk
         EFrVKxUaCvSSRdwTzdozTqlSdk1VcaNG07jW4eK/4FTGXmRz3F8DdaI4Lni5rMR3R33H
         FNh5ZPY3ppWqwfpdjtLdl/QuyZbU4Z4xfVh/EfRu9P8cUGV+/06ewi85o8qDL3h+LMSb
         SOI8BaJO2QEO1sqVehRvpWKlmkSmcNaYdsNg8Baf5hjkhnasUNgjIw8i5cQH72oBCPau
         /zGmh7BOQnDKpq5HrpbjJX10d1ZzwhX+PEToS45srtYroLN/IJMfm2OwvjxnavBBiOp7
         DF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686064432; x=1688656432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPhoOlX7tj4q0aOoQPFhXWKvOaJE49df7Ezg7KCTEto=;
        b=Mfn3Z5NJzT8niiH7O8ErqpGi7C9ZRo4hA47e04xxqOf6iZlpWnpai3djEcLkOmpBTo
         Zqu+Hk7Wc47H0UuCW2hyfk5e8bw+Lsk2dK+v6A0spi1Gnw1F0bfKM3rZhm/6TaO12HoE
         8ykUzzl/4fMR9X64ZfQnReOKe6RPSzipZ+8rUebvoc7LK+CSfb287pdaGwgmIKy2rnk8
         INDaCSBPAn1zeJEnhzwkwfDEBTCgqhzxNSfgg/KiV/ZzGFHN24I/1VUdfCndhzWOSW1C
         lYNS6TCymj2IgnmzuNuU00gX+vw7caB0Fb7q2yB0JQO2c9hLY5GJbun9ykvBq1nKEXQ0
         Tofg==
X-Gm-Message-State: AC+VfDyBENPpj9mzSFh++22hQtU9A+4tYma//o3BedFFTLI9TL8+WNLh
        gPoNz4iWhZRnuHaIrvmQeFjROA==
X-Google-Smtp-Source: ACHHUZ4WXG1TkKdELDr72uY5SCiVtaOKmT6js1Fzo8KJqJ3dBhcliOzeE41TbUUAyZMAhcUjltaAig==
X-Received: by 2002:a05:600c:b49:b0:3f7:28d8:4317 with SMTP id k9-20020a05600c0b4900b003f728d84317mr2105139wmr.15.1686064432259;
        Tue, 06 Jun 2023 08:13:52 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id hn20-20020a05600ca39400b003f71ad792f2sm3106207wmb.1.2023.06.06.08.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 08:13:50 -0700 (PDT)
Date:   Tue, 6 Jun 2023 18:13:48 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>, Tom Gall <tom.gall@linaro.org>
Subject: Re: [PATCH] checkpatch: check for missing Fixes tags
Message-ID: <ac879d60-2d1e-42c6-89b1-16a52416e478@kadam.mountain>
References: <ZH7uo6ph8nhidxcV@moroto>
 <9717acd3dd00d607da718da251a0bba6b376da96.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9717acd3dd00d607da718da251a0bba6b376da96.camel@perches.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Joe.  All that is reasonable.

regards,
dan carpenter

