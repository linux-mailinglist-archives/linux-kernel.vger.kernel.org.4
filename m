Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3A873074B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjFNSTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236257AbjFNSTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:19:03 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C6A2120
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:19:02 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-65311774e52so5293910b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686766742; x=1689358742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DVA52p4YcILRY7L9DFLvbAPwmdSgMbGdjvMaWJxlDM=;
        b=gSR6K+IoSV4UcCbyThkovBW84pwErtTdN1Lf7dIi/cT8a82OBj/zR29k4NSaiwqtOV
         7cF8XAMnN61CQS7d0sNglKn71UYX2nesvdOVddooAVbOyKrTIZZKSCtAY9RE9t6DzcWb
         VjfBQ8FsLUvPZiGPjEyfjN+9oZ0Yo1ktN6GfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686766742; x=1689358742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DVA52p4YcILRY7L9DFLvbAPwmdSgMbGdjvMaWJxlDM=;
        b=k8021BzMCN3lN3PTjz1Baw0CSGgmIL4m9GWhgSBm/9M6Y8fEO/S7rWpWDKbG4lXwlO
         YnjjHCRiiHMz+TfBWmtRr3DAbHCHyfLfQ5nEuwDK6W+kclUEsXkTA9G8Id2SNT1y+VdM
         R8O5hZIUn+LaiFdOSL0L0zPabnG1XTUO9jlaMselTXDGxWQWAU52WZ6cDzWytvr9XcyT
         wYlTFLKUk63ro367SYv7K4DR5XlsWb2qCCIQbGnm5TzKBlqG3lAqEiLbuzBcWjZfTjT8
         5RxE/wyyVU2cQckWUwXY0vny602dbcbGpJg8ktGkgkU0DIceJM5/M3vb2th8L7sFFtbG
         HaIA==
X-Gm-Message-State: AC+VfDy6ktxPXzygUyh1hVHQ+/o9qbIjjqqZluztgrnC7m3WHegI8cr/
        ZsPM/WUj0QBlhHuWRDGqNFiAcg==
X-Google-Smtp-Source: ACHHUZ4GcPsyjlJGS/SC+rTk2s17/0RS900BeVxk31L9Js8pVErRtiRqW2zIDPgZTsdmkP5avz+iig==
X-Received: by 2002:a05:6a20:3d8b:b0:117:a2f3:3c93 with SMTP id s11-20020a056a203d8b00b00117a2f33c93mr2636606pzi.2.1686766741971;
        Wed, 14 Jun 2023 11:19:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902b70c00b001b3f9a5d4besm2585326pls.255.2023.06.14.11.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 11:19:01 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     azeemshaikh38@gmail.com, bcain@quicinc.com
Cc:     Kees Cook <keescook@chromium.org>, linux-hexagon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Hexagon: Replace all non-returning strlcpy with strscpy
Date:   Wed, 14 Jun 2023 11:18:31 -0700
Message-Id: <168676670780.1815023.2376604888079665488.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530162608.984333-1-azeemshaikh38@gmail.com>
References: <20230530162608.984333-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2023 16:26:08 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Successfully build tested with Clang 17.

Applied to for-next/hardening, thanks!

[1/1] Hexagon: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/f0e212de87a1

-- 
Kees Cook

