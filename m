Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D06705802
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 21:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjEPTxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 15:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEPTxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 15:53:42 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E3F13E
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 12:53:42 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1aaf21bb427so473205ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 12:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684266821; x=1686858821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CWBO492YYUrIjC7hJ3nSFPMfAcwXlNtVy2XWpYw1CoY=;
        b=HIoRxX64H+DbjHKrlu1aSp9m+D1i+79BuNFn53F+1cckmOhBkvFlP/9ZitZ2fXGYiv
         9naosVE4ajtbM3iiyLD6A0e1zeZwkAtK522+G6D4t8hp87X+HlLrIX7HZ8Cf2sC0fQhx
         gUpsDTRA9IpbMXHHQYKygv/yaXNzzAUdOMGkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684266821; x=1686858821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWBO492YYUrIjC7hJ3nSFPMfAcwXlNtVy2XWpYw1CoY=;
        b=aAN9MCPtTfwcUmqImrDwEtaBhWExMyXqFzJcmqJ/AszCanILvSwTgwUi8N3/doGM6M
         d5qjGpgB7HPvgpenMl6M8wvF/vxVCyxSxJHcDASAZN2o4Fc4ElGuU1NpJuzaLWyMxafV
         MKmmlYf+zqjEPAuSbvniwjmwMY4wuhelWWtmC+j+Nrcs4DUDNsD9GvarYxE7c7ueSkce
         Hq1zxCReLktr+HT4a7Fus0nzJbs3oeCp1k6qWwi9Wi/Y/St2wWYGB4kBGCxF6CoyxYdW
         SqS4s82jOGKNQsg19u0XrcycGBYjfRMEXWnUQHNm9nWopEvuy7/G3nX+JFsj+Jj0b5UR
         KVHg==
X-Gm-Message-State: AC+VfDyrAUBPYD9y3EJ/FIuTXcP4a1tUed56X3esqrS5B8uFWF75qPzJ
        unyYIypcnBAcA9T1MAFJSxBoTw==
X-Google-Smtp-Source: ACHHUZ6NpkYmVwQtlRW58gR36TztF3mS5d3F6fqtF65RhScpaxUfW2fNz4YI2hj/sYhwSjJG2cgW3g==
X-Received: by 2002:a17:902:c94b:b0:1ab:675:3e0c with SMTP id i11-20020a170902c94b00b001ab06753e0cmr51404941pla.33.1684266821413;
        Tue, 16 May 2023 12:53:41 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i1-20020a1709026ac100b001a64011899asm15902530plt.25.2023.05.16.12.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 12:53:40 -0700 (PDT)
Date:   Tue, 16 May 2023 12:53:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH 00/15] arm64: address -Wmissing-prototype warnings
Message-ID: <202305161252.24E9E9889@keescook>
References: <20230516160642.523862-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516160642.523862-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 06:06:27PM +0200, Arnd Bergmann wrote:
> This addresses all arm64 specific protype warnings. As with the arm32
> patches, the majority of them  should be straightforward, either adding
> an #include statement to get the right header, or ensuring that an unused
> global function is left out of the build when the prototype is hidden.

These look good; thanks for tracking these all down! For the series:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
