Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BDA738EE2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjFUSde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjFUSdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:33:31 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758B61735
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:33:30 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-25e7fe2fb51so3273977a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687372410; x=1689964410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R2S4gS2xsl31ZVbj5QmbK/bF8pdwruLrQ0Of/mUlG7M=;
        b=hIQg4b6dBFhr8M1cB2wCKdDIS2BqrZFkxpeYC9/r/Fm4/PFRkhINjLnndweKacJ7IP
         V8cig2c3cCv7oAvLssc4iBdvgeuMqkMdvBVCb2TTShovFY5Gf4Mfmm1haAIxoTVhcXAh
         OT5ZmbC2Hz2Fbpo93tqT6X9u8qiANoR9cGeOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687372410; x=1689964410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2S4gS2xsl31ZVbj5QmbK/bF8pdwruLrQ0Of/mUlG7M=;
        b=lqUIJ+Yw+jFGsfgKjPW0dKPeGrOzOkkUxVrLIr+l6BpxrDzyvz1ZTuNVOmJ54cNQJg
         HM80peeXBcXOgJC2dG53GfU8Xo+pwHTS9kwCsc9exoNcNpAPvB8vTyxlfZ7RqFE9k665
         9+LOS2qrsWEcTtSoFSi5npiRJOAPcL0oeJvQO5SgBV/4MPff3OsXJ+mNL3FxVhiO+bDg
         yO8gJa/Sxcag5e42PtHTaZi6J+bb9tGnXZrzf3QXSC2bMTHeLr2M56rpb9aL0i8Q7JsX
         7rjaK795osHovE2jL63T0/Bz8oP6wUSp+JbktgcVLtaQYRcM2mfqW1e1ya7ioWNu4bW3
         Arcg==
X-Gm-Message-State: AC+VfDwkgnIPPAb/seLQ4qfEawcBatYxTtKclyYLLT9XyEvi3jN3WFPs
        xRca0EomhYu3aQbZcBjaoURSGg==
X-Google-Smtp-Source: ACHHUZ55HAlLqELh2ztTLy1Zy882zddDnIs2ffNwpxg18Goh1qFJ8fhZuoht6oim3Oz/H9kVw+iajg==
X-Received: by 2002:a17:90a:69a2:b0:25b:f9ce:d8df with SMTP id s31-20020a17090a69a200b0025bf9ced8dfmr13250289pjj.8.1687372409966;
        Wed, 21 Jun 2023 11:33:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i18-20020a17090ad35200b0025e0bea16eesm3466415pjx.42.2023.06.21.11.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 11:33:29 -0700 (PDT)
Date:   Wed, 21 Jun 2023 11:33:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Krishna Gudipati <kgudipat@brocade.com>,
        James Bottomley <JBottomley@parallels.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH 1/2] scsi: bfa: fix function pointer type mismatch for
 hcb_qe->cbfn
Message-ID: <202306211133.DD89F45965@keescook>
References: <20230616092233.3229414-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616092233.3229414-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 11:22:09AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Some callback functions used here take a boolean argument, others
> take a status argument. This breaks KCFI type checking, so clang
> now warns about the function pointer cast:
> 
> drivers/scsi/bfa/bfad_bsg.c:2138:29: error: cast from 'void (*)(void *, enum bfa_status)' to 'bfa_cb_cbfn_t' (aka 'void (*)(void *, enum bfa_boolean)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
> 
> Assuming the code is actually correct here and the callers always match
> the argument types of the callee, rework this to replace the explicit
> cast with a union of the two pointer types. This does not change the
> behavior of the code, so if something is actually broken here, a larger
> rework may be necessary.
> 
> Fixes: 37ea0558b87ab ("[SCSI] bfa: Added support to collect and reset fcport stats")
> Fixes: 3ec4f2c8bff25 ("[SCSI] bfa: Added support to configure QOS and collect stats.")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
