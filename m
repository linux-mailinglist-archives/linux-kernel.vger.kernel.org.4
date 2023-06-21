Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AF07385C0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjFUNwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFUNwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:52:43 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C06DD;
        Wed, 21 Jun 2023 06:52:42 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666eb03457cso2638438b3a.1;
        Wed, 21 Jun 2023 06:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687355562; x=1689947562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9tiahjZelkiWueW79yhn3HufREz9PXyjdEwpdn04DE=;
        b=BcMZ6kU3UqZBlpy9HEMbWpQBoF0GGm4mmzRUAIXLGfQZRmnyTWViSHOMowQOK6fNwY
         mYXStDTp1JovTM0RayLr/jBGhEj/VuJJ7svTPwtpKY4G/5i/1vfsEtjNijbdFuDGtxK7
         GbG557T123C/ul1l5emioT3j0hsL0uxeZAhvpHam8ovRI1U+8qxgAkYWNK1tAd8oG0kU
         NZU7ATkBaz2SSAyaGjEzqy9g4a50j69Hb0FXoIUYn4w8u673gIpFwaFk2bHaAkkJwvzS
         SEVX79Idjzai9siiGK+z5JRt7GC+QqCFrkDTKRind9+a4yFviPN+wtBN8DTrxxtwFawL
         i49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687355562; x=1689947562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9tiahjZelkiWueW79yhn3HufREz9PXyjdEwpdn04DE=;
        b=lx7u3zVZRicyX3QrPtRW4Ippv/F2S/F1HdbC8wBIXjMVpuw4Lo1O1avgRV12WPqlUJ
         ai2E1N3YEi3hbCXxA20FsZEZqbxamAECfUo530ptDc8Dngxva8Z1V+hHUsXjFYvdyeC1
         UA5KAzK00rPRhOgIMSju6FikGcSuKt6dhD8YOgTrhs7REcTGM843NUBWLl6QamF8meLm
         B0vp47/OPcTtCVJIzxV8SRvzSGNffUYJsju4GYPdcgEjRnxLQUU3wwmdJSF2vmtUEoA1
         FV2jGhayyu1GgDIUbKTBdPQydoarx/LZapqsq0lmNTy/+5ZK0yYiGAJl4s5Pmsw/02lA
         Yd4A==
X-Gm-Message-State: AC+VfDyh+wBP1gjRgwOOH02cXt7D4ksZHrfAhWKbiOIsQaHTwqG+QSxJ
        gqJInZh8R0qGyd2P0Z7uMG4=
X-Google-Smtp-Source: ACHHUZ41Q1vIMF6WNqQygbFdcnGFz9ipkUjr1jeaQGLyO2JD8aSc9phrrqCziBBcKPUwU7lfeVZnEw==
X-Received: by 2002:a05:6a00:2e8d:b0:644:d775:60bb with SMTP id fd13-20020a056a002e8d00b00644d77560bbmr13235480pfb.20.1687355561956;
        Wed, 21 Jun 2023 06:52:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k10-20020aa790ca000000b006661562429fsm3046110pfk.97.2023.06.21.06.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 06:52:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 21 Jun 2023 06:52:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mips: provide unxlate_dev_mem_ptr() in asm/io.h
Message-ID: <7cddcd24-c26c-43e3-8da5-88bd12e27709@roeck-us.net>
References: <20230516194000.548487-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516194000.548487-1-arnd@kernel.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 09:39:42PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The unxlate_dev_mem_ptr() function has no prototype on the mips
> architecture, which does not include asm-generic/io.h, so gcc warns
> about the __weak definition:
> 
> drivers/char/mem.c:94:29: error: no previous prototype for 'unxlate_dev_mem_ptr' [-Werror=missing-prototypes]
> 
> Since everyone else already gets the generic definition or has a custom
> one, there is not really much point in having a __weak version as well.
> 
> Remove this one, and instead add a trivial macro to the mips header.
> Once we convert mips to use the asm-generic header, this can go away
> again.
> 

This results in build failures when trying to build sh4 images.

drivers/char/mem.c: In function 'read_mem':
drivers/char/mem.c:164:25: error: implicit declaration of function 'unxlate_dev_mem_ptr'

Guenter
