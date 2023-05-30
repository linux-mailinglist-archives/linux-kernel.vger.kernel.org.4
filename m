Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE3C71714C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbjE3XGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbjE3XGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:06:19 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13D2102
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:06:17 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-52cbd7d0c37so3239185a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685487977; x=1688079977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcDYCA1ly3FY36KE9EWIOvW5CJ9uAXN9yGVuBTepsnc=;
        b=QmpIBCm0bgCPUs09dyc/o5eU4i6Dw1qVFrByK3z3774DuokLJJ5Dr8qcL8x3GSlukA
         +Es5uMz6GG+AxG59ttJN6rWn/S6DbMZFTkGpodUtwPYNq94ST62VcynrQ6QRWXvciOtf
         sRjTJOSxq67nMa2MM7IZi0If0EEtCYUCpXzVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685487977; x=1688079977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UcDYCA1ly3FY36KE9EWIOvW5CJ9uAXN9yGVuBTepsnc=;
        b=l2W/FKk73NfD0O/E0LLewrNmHVtE8TUTaxwQytrbyUqjB0GRRtG0M81ueKhc89bI+Y
         7pRmh701koVImerSshe3esPg2/mCVS7ykMRLViOinQeIWJtI5jZf2u99FyQpdhEYm0rW
         23iSM1P1+4GD7wSu7ematynwu0c55uyhAzFy4oz0x/14Azvceno4tuuzQbatGr81grt1
         7oL1kSM8nX4IDsrhOm3CLzl9HpNH4T4N6ZaHj4POdt9d4JAeeqJixZw6GI/ihAf5IK4x
         i13VGWu/m1kNHcTdV66FUOTrP2BPSr15FXglq2AWOTWbW7oSRMHlh8Pqf2+OmFxbbzSA
         UERA==
X-Gm-Message-State: AC+VfDxi9qF/Cnyom2YDrPcSyw665SZy7lfoBzrNpU4otxAkEweHYeU8
        /xqPOYM8isHplKNF2yGCkZAK7w==
X-Google-Smtp-Source: ACHHUZ6+T0rn+23nFZ2bBysdZXPkmLl084nIIhu+nk6HaZ+/iu7UziuIVXBJvj2OWpYs0rE6mYzohA==
X-Received: by 2002:a17:902:f687:b0:1b0:74f5:bf10 with SMTP id l7-20020a170902f68700b001b074f5bf10mr1904564plg.65.1685487977534;
        Tue, 30 May 2023 16:06:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f54200b001b052483e9csm2810211plf.231.2023.05.30.16.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:06:15 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     azeemshaikh38@gmail.com, krzysztof.kozlowski@linaro.org
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] w1: sgi_w1: Replace all non-returning strlcpy with strscpy
Date:   Tue, 30 May 2023 16:06:07 -0700
Message-Id: <168548796310.1350188.6990158151809298087.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523022023.2406955-1-azeemshaikh38@gmail.com>
References: <20230523022023.2406955-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 02:20:23 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] w1: sgi_w1: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/4e4424b20cc4

-- 
Kees Cook

