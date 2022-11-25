Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC45A63830F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 05:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiKYELR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 23:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiKYELO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 23:11:14 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D33223148;
        Thu, 24 Nov 2022 20:11:14 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id o24so1581590vkl.9;
        Thu, 24 Nov 2022 20:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z6xGPbOWAf7JZrf++AW+6YCeSuMNzGuLwd7KZYx2Mto=;
        b=OlPJ72YU643fQygc9+7SjoG48fNJdudXQn6KgiwafLzVelIqt0FAo7M66+txhtfZUK
         Bga91RCXaVW8DRRiE5sKHqhQjmtaIxK+7epK4BCj1HZRN6ez/ckZrirhBUbOvaqx5pZ2
         nqWu2jo5sX6yozloI5c6drexP4YX+AbFIQ3j8fBabRAK1z8GWJLwJIw80EphehqqG+Vy
         X53LqihmqaaMSgXLuu/n8AnHnLdzcoJLhVy+77ANXWiRAtvgbnCGHNtZllBZlXpJEAUZ
         V3Y3v5eFw2VCgXhHKZwHUAKqYL0LNfuTNM9Jmv0syy+BIUorHvX1goFqHO16PzWc8mY3
         +8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z6xGPbOWAf7JZrf++AW+6YCeSuMNzGuLwd7KZYx2Mto=;
        b=DyQHQqsKbBbQ4xwUviH1A8bdZC+8Wue5etUgTw+13jvVA7jyeHO1yKQbeEH5OYJ0Ri
         bu1MHCbkb201BXly07c0ERWZaOBhf1VJFtgNibBQ8dh7vj8le5H5tIQQy226O4q/dYRM
         n0cRMDgkqYdx43WbBFRwWBsQpU/Dvh6D5gwcIKxRhrugqtHUeAiToVk9j9gnlRh200zJ
         jUymXB52DqimZQf/YFmV3mKlGr9+JEJvmZ3HYeAI4vTMwZPODh/l61diwEzZqutCAEVo
         +2650sd5QkqHhmSB8PVsAy7bo2WCPoX4E9ZaIgUKNyQCblx79olAMiKJIokFshZ+4fv4
         aXvg==
X-Gm-Message-State: ANoB5pkZM5iDA216xborb/MkjwYt+88e+2XPHykSArYgNHdWTBEVM+zQ
        JKfojBYDASdpWhgwtV5kLkccKYH4YR3swGiUgIKbKNlJ
X-Google-Smtp-Source: AA0mqf5EDjAWfU+XZ8KN3rtbQYuAap4+U5qZvIbbkpAYs5XJBlsRFm/CvnXcDJIsoYS0WdBatlY4OCJTsFCsyRzZLuU=
X-Received: by 2002:a05:6122:2144:b0:3b8:1bb4:b750 with SMTP id
 m4-20020a056122214400b003b81bb4b750mr9952515vkd.20.1669349473173; Thu, 24 Nov
 2022 20:11:13 -0800 (PST)
MIME-Version: 1.0
References: <20220928165018.73496-1-Jason@zx2c4.com>
In-Reply-To: <20220928165018.73496-1-Jason@zx2c4.com>
From:   Sandy Harris <sandyinchina@gmail.com>
Date:   Fri, 25 Nov 2022 12:10:58 +0800
Message-ID: <CACXcFmkyoNu5fU=pAxPNY-bwGyJ5bd2LkmVkxHGOubZmbbzT_Q@mail.gmail.com>
Subject: Re: [PATCH] random: add 8-bit and 16-bit batches
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 1:33 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> There are numerous places in the kernel that would be sped up by having
> smaller batches. ...

>  void get_random_bytes(void *buf, size_t len);
> +u8 get_random_u8(void);
> +u16 get_random_u16(void);
>  u32 get_random_u32(void);
>  u64 get_random_u64(void);
>  static inline unsigned int get_random_int(void)

To me, the 32-bit & 64-bit functions look like an
obviously good idea. However, I cannot see
that the 8-bit or 16-bit functions are needed.

Even library functions like getchar() return an
int & whatever you return, it is going to be
handled as an int-sized item if it goes in a
register, so what's the point?
