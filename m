Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37530743CDB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 15:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjF3NfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 09:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjF3Nel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 09:34:41 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F493C22;
        Fri, 30 Jun 2023 06:34:40 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D39BA1EC058B;
        Fri, 30 Jun 2023 15:34:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1688132078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bzFFqTy0EcRSwkDePvlSP7HckW8PeiGxRa692w6XqtM=;
        b=jkVEpK0PVhCToPQYsj2UCmB1cCYKDOPEnue0DoxEN9NSYRcoDK9SdCGDQNjhiCd0XoA5AH
        3mxTEL2/iDl7+1ZRaw7RztJ0pvjvUtsqifnOXOHXC4fyFjhEkUQc79NvYsRlpRUtaOPgPq
        7GaNTGb7zwW8OBZRSvf1UBW5rbwhQeI=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UxmK4IjONyF2; Fri, 30 Jun 2023 13:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1688132075; bh=bzFFqTy0EcRSwkDePvlSP7HckW8PeiGxRa692w6XqtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k8ny5QVTJemCt7ciIx05B6xOXm2LjFWZqLy6jS45shQp3PUgMRxGL9OLuYipR8zrL
         NcS6ibvR4hUPPzkBYelT7RlJPpNjYE5a+oJO+LJCquerBT0xzm1BtuG6oNPplPzS7z
         a7MXUbOKVHUk/7eIOWuEbsTIFXc/afNwADrUN9mfDU1/oavfAg6KygoGbHmI/tlNsb
         Tv1QGo4WmcGFiniBrvzBKIa/xHzLgTlkrpSZ24YPLmy3aCZishtqW2HZUsOWUw7fH0
         9KLK4vJiX1ZJOLex4xE/GCyMM+Q6puklwNYMU90zgZ0Ul/FMZOpmB0BUPtQHfT5IYe
         WaqYLg4rAXzkbV4KQDCWqQvG1mKw5ZGfdIO8IukMOAyWEmZnExSqFrIgRzEdwS19V8
         IApsHpaeQZrePHsTDSKEEpP/p/U8Sw8YDzMZU9c/Km8IzjHY2NYrOXDW7FYqJij0U6
         I0HMmBlAuSOxtlRpZo95Tgni/553UHgvPBT7Lwoq+rd1ueFF1bnNHh6xc/HhepoXzG
         2IS8GmbCrpTnKxwqPqvVEGAQ5C3dKNYddi5VEOLrotrCrhrRfWB4rLfldP99nO4Few
         OyUBdqTbtLCRcD4ovhglvn4l+ocFgb0+U1SgxpeSyLTmNpiRToC+YZNsdac07bwiah
         bNd9mvWB+C8QR8Cnn6sY5Bek=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 33FFF40E019B;
        Fri, 30 Jun 2023 13:34:29 +0000 (UTC)
Date:   Fri, 30 Jun 2023 15:34:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        =?utf-8?B?SsOzIMOBZ2lsYQ==?= Bitsch <jgilab@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] usb: ch9: Replace bmSublinkSpeedAttr 1-element array
 with flexible array
Message-ID: <20230630133423.GAZJ7Z35+udZ1F/1MH@fat_crate.local>
References: <20230629190900.never.787-kees@kernel.org>
 <2023062950-landowner-goofiness-d5d2@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023062950-landowner-goofiness-d5d2@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 09:17:23PM +0200, Greg Kroah-Hartman wrote:
> Boris, can you test if this fixes the issue you see or not?

Tested-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
