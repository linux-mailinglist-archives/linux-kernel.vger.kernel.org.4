Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BECE64D461
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 01:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiLOAND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 19:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLOAMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 19:12:35 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738C756D7A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 16:06:46 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so979666pjo.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 16:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Io4os3gTaCz4PVaBpjHUj2dUPT6iCaDC19vKypF5Q6s=;
        b=i/gqh+ULBL84l7W+HaI+YPVA3abaIfQIMOgVOnljOmr/KVA68zwjp++CaIKotf3jQg
         ZUOzQKPjmqqy4B/7LyynthiKp6gDWwdZ0BWj+GzLXpD3URXB/Z683HOwIBXxeh93b6GF
         S1iZx+2M8h1CY+bK9AdVvDyvmaaHb+Ig46C2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Io4os3gTaCz4PVaBpjHUj2dUPT6iCaDC19vKypF5Q6s=;
        b=Bf4GYSB3ZVinVJ/bAOi1vnq3cJR0N51uZ5GmRKDnylQURqMDIkepyNZknnvK6LbiA/
         RX6tZexRSSu2jQjAwEMfQ4KUs4sc6tVjNiJwoG7IJH01fBbbSal9CCC9IAYJwsfohW0+
         CMDs72vlMWyvAiVSxoaygPnuMlL1f+6t82AZH12ykSbB60Z1/1gU2DkE7H/kj0X4K3RI
         T1bCeNgWw+EIdsABUAC87DtErurJaMjb1r6LLeAd/nXpcztGIigHb8nTa6Skca77mnzU
         lBcHvLM+S8lYhqwjq8IDAimK+Xt+LXV5zZdWeFz8+8WzTTVb/zv+n6/IS3J2nGAqb9DJ
         CyuA==
X-Gm-Message-State: ANoB5plVsWAI2U4qhaVKhcx4DBsBGGPEGCyLKIz//WevXJCnk2m2QkmT
        4vgV9q3rfwPcIKntJYUpYfkqO8WSh7FeFlIy
X-Google-Smtp-Source: AA0mqf7K90bP3UUUfX9ygJAAX4zTnSIy4/T4H3TdPQBfKafxMyTh8efvMuJMEGl3HGTGWDSfjK9dew==
X-Received: by 2002:a17:90a:b908:b0:21a:8c6:c89e with SMTP id p8-20020a17090ab90800b0021a08c6c89emr27261520pjr.2.1671062806002;
        Wed, 14 Dec 2022 16:06:46 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gj1-20020a17090b108100b002086ac07041sm1910624pjb.44.2022.12.14.16.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 16:06:45 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     ndesaulniers@google.com, nathan@kernel.org
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        trix@redhat.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, patches@lists.linux.dev,
        llvm@lists.linux.dev
Subject: Re: [PATCH] security: Restrict CONFIG_ZERO_CALL_USED_REGS to gcc or clang > 15.0.6
Date:   Wed, 14 Dec 2022 16:06:19 -0800
Message-Id: <167106277582.3571286.12639413013649335692.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221214232602.4118147-1-nathan@kernel.org>
References: <20221214232602.4118147-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Dec 2022 16:26:03 -0700, Nathan Chancellor wrote:
> A bad bug in clang's implementation of -fzero-call-used-regs can result
> in NULL pointer dereferences (see the links above the check for more
> information). Restrict CONFIG_CC_HAS_ZERO_CALL_USED_REGS to either a
> supported GCC version or a clang newer than 15.0.6, which will catch
> both a theoretical 15.0.7 and the upcoming 16.0.0, which will both have
> the bug fixed.
> 
> [...]

Applied to for-next/hardening, thanks! (And I'll send it for v6.2-rc1 too.)

[1/1] security: Restrict CONFIG_ZERO_CALL_USED_REGS to gcc or clang > 15.0.6
      https://git.kernel.org/kees/c/d6a9fb87e9d1

-- 
Kees Cook

