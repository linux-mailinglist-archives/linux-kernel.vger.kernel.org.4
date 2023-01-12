Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F3F6687CE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 00:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbjALXZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 18:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjALXZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 18:25:42 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1766E625CA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 15:25:41 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id cf42so30689939lfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 15:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uzvQTLIl4IsQotVAdtAgGVmuDwl5Q4M7f6FylARn+9c=;
        b=Nr7Y/WhaVdcQbYBYZpdYD/bbkZMdH3A1fULa10XQvTpJcJ2Rd+q6iOILylAXcrvZ3W
         k1VWAbetLG8bycRtyxz2WigmGfmShkeg0a/1AYKtaaFgQG+ldxw+gUWxfNfXFV5ayAP1
         4hoOHp9cv2c5vAE3yc/2HIZgp8HSFfmy36gec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzvQTLIl4IsQotVAdtAgGVmuDwl5Q4M7f6FylARn+9c=;
        b=1aAYdI6sYO1y6MLGB98pdQ5hXMbDaZQWVWsJYhBywz5EcxaGBcfYAI2F0U15GtXTsl
         ZqyLs9fCcQgtwCM5EhORbKbGDuHSEWAU6z5XWOj5tn4rEBvqL4bVACyvAeFr+lV6y15C
         V5d2zzD72OOaYe1Ox4ZoqpyEnUU5kjq9MOaexl4bI3kLiuAxw+jIUaE2x7X/AZwva7E1
         Jw6GsTgJeTB8fRXiCEDKAz0KvYPMGP26yBRq617UDjJhAtemgi/6SO/d6UlU1ZOwizJK
         r9PcSo2wDHOLvMtqtY975YPZ8K4sHYUsiD2qspA33W3smqMPTP48Sq7o2swXp9scH4yR
         A23g==
X-Gm-Message-State: AFqh2kpCodMte4k/7C33usIZAy9cPQlB5gTCzUBbkxgC+T/s+sKGGr4T
        wYjucIA7c48ihPR8fB4p8RT9Whxo1B4Y3bxCxfhCVw==
X-Google-Smtp-Source: AMrXdXtLVJx13oVwu3/q5cMKJRaL1ovVk7o4qBGW++HpDOkIGmRjjudkGZ+iTKU/U2CUTzTrZVqV2pLQdHocHer/C1M=
X-Received: by 2002:a05:6512:2346:b0:4cc:6ce7:6614 with SMTP id
 p6-20020a056512234600b004cc6ce76614mr1205998lfu.83.1673565939472; Thu, 12 Jan
 2023 15:25:39 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Jan 2023 15:25:38 -0800
MIME-Version: 1.0
In-Reply-To: <20230112230312.give.446-kees@kernel.org>
References: <20230112230312.give.446-kees@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 12 Jan 2023 15:25:38 -0800
Message-ID: <CAE-0n52aQpFe4q47=3=dmozwgb375zuCt2um8PTpYScLkgBs8w@mail.gmail.com>
Subject: Re: [PATCH v3] firmware: coreboot: Check size of table entry and
 split memcpy
To:     Jack Rosenthal <jrosenth@chromium.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kees Cook (2023-01-12 15:03:16)
> The memcpy() of the data following a coreboot_table_entry couldn't
> be evaluated by the compiler under CONFIG_FORTIFY_SOURCE. To make it
> easier to reason about, add an explicit flexible array member to struct
> coreboot_device so the entire entry can be copied at once. Additionally,
> validate the sizes before copying. Avoids this run-time false positive
> warning:
>
>   memcpy: detected field-spanning write (size 168) of single field "&device->entry" at drivers/firmware/google/coreboot_table.c:103 (size 8)
>
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Link: https://lore.kernel.org/all/03ae2704-8c30-f9f0-215b-7cdf4ad35a9a@molgen.mpg.de/
> Cc: Jack Rosenthal <jrosenth@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Julius Werner <jwerner@chromium.org>
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Julius Werner <jwerner@chromium.org>
> Reviewed-by: Guenter Roeck <groeck@chromium.org>
> Link: https://lore.kernel.org/r/20230107031406.gonna.761-kees@kernel.org
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
