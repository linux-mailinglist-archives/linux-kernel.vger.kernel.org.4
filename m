Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03D1735E20
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 22:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjFSUDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 16:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjFSUDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 16:03:18 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20088E71
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 13:03:17 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-517bdc9e81dso1531116a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 13:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687204996; x=1689796996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T2vsVFtTkQYhqMmseMllBPLpJkQ52+kcj5AVBSFXuKs=;
        b=JsVpqeSoU9JGqhw/Knvq+EH87u0+brLVuGMPOl8wehYwMXal8PD7rLPtJBQ/LuIXD5
         q3wqzN82EFF2hMFosDRrnb1S1epH4esiYijM7wdbAxvyvzl4rwMrBd7CSb+DzCUf5j3q
         T3LWRqxFv4IL50FXaZc8BOq6WyjU0DNPTavMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687204996; x=1689796996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2vsVFtTkQYhqMmseMllBPLpJkQ52+kcj5AVBSFXuKs=;
        b=S9839OxkmxNg3RbtWiFTtnMtcxi3jYdUko+1VBnR/1IJRvRcE5oDb1tRjMRF7W1do0
         0n0aiI8TZMw+eIa+u215yk3nKK7+EyUKNcMw8SThkMHwxh5XGMWtVrtD51nwVGJo5oAl
         KRk588ED8kwVdyLygrDsaGaDVJsUVK3ZLxM8WNOcDvosm3Vu3PAbUtSeOsX4gFeYrrR3
         dMZbvfizaNZOwmVLLQ8z2yjGabOGlsAz0tWZd/fF7N55Qy7Lawdbt1lv9FVFwcWm35eQ
         SGyOKDIuObketWiIz9T6U+KsbEzkt2Vdbky87uQOZDg1eAZ4UpQMbjSCW7irCmHxc7hx
         Q94g==
X-Gm-Message-State: AC+VfDz013gGQrbC9Vz9no+jD/SVykcbixDLSOu3fhLSVif/CXL42bNu
        +sH0wLaCo5g2Ap8n2Z/mUbbVGQ==
X-Google-Smtp-Source: ACHHUZ5HqjiOiMuPXsXe61fAouVKC1e7CFohAxEHW/IHu7rnhqq6QlH4Id/lSqykOkNqmpqcNWkgTg==
X-Received: by 2002:a17:902:eac2:b0:1b1:ae33:30de with SMTP id p2-20020a170902eac200b001b1ae3330demr8178420pld.13.1687204996405;
        Mon, 19 Jun 2023 13:03:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z11-20020a170903018b00b001a072aedec7sm221542plg.75.2023.06.19.13.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 13:03:15 -0700 (PDT)
Date:   Mon, 19 Jun 2023 13:03:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Subject: Re: [PATCH v11 11/11] LSM: selftests for Linux Security Module
 syscalls
Message-ID: <202306191303.7F374EC@keescook>
References: <20230616165055.4705-1-casey@schaufler-ca.com>
 <20230616165055.4705-12-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616165055.4705-12-casey@schaufler-ca.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 09:50:55AM -0700, Casey Schaufler wrote:
> Add selftests for the three system calls supporting the LSM
> infrastructure.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
