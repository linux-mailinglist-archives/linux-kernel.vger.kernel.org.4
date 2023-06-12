Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0368772C394
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 14:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjFLMAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 08:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjFLL7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:59:44 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A2093
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:59:43 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f60a27c4a2so4674866e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686571182; x=1689163182;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jkz7sQ+AjflJ9fndE58gpR+mMJbc6S15wD8YPJ1livA=;
        b=lQmd3/+uEpPiru4mq2gE7A/rufnFAW4ooqeuSotzHPn4OsujtbclnEWb1xgsY4uR/X
         TMJsFdgddX6AAh+4A3ic27LT1DSkO9UWGXX4agNuUgLv5kJzDpqEqKx5prcEHH54IR38
         y8OAEt4ZKBiL6y9zYdFsgiRWBcIzj3CaKyABKKHuhObjxkKo9bi4u9HxH8QOdlLgMVTh
         N40UE3fPpKULjwXE+9tjmIL2V5S4CJDkh7LtsAywKpAOTAhL4HlsJPz3uRs2+Wu/Dsm8
         DLkBae66jmQruaNXRNhUd6Qs2EimrGOdjroUutM7qtSkMa9A+ptk4JRjFzzyEiaD4KPB
         PGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686571182; x=1689163182;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jkz7sQ+AjflJ9fndE58gpR+mMJbc6S15wD8YPJ1livA=;
        b=Wgq1U9JsHwxtTGiOzfvnMAXyoL9XJLgKAZX6914jckc6DsyBHDFJ9DEYdfeyE0Pcmf
         if1pTeDaU+YbfVOJsnyY2lWpQLV23W1H/koC06nRiycGOGzi/SpWtr4mvbcrseTKer8G
         S6A/KwRiXLtKFe7YTKyaRs74ZuEyuDlJi5XTKr0KzNBYzGb0HJxQD2tjyW+fgQ5PdgRn
         kBmAaYE9sjHfEzRnrvG/XGzc18Z69K3b+oUJqoATe32iclhwHPUWViiMKZvPrS/KJZp6
         PdN6VnaKRdLFvZjEb3EGHZKC0QMp9UrGVB1MjzOdReOPgMxk0bUGvHdhERm+6DyuwvEF
         V4hw==
X-Gm-Message-State: AC+VfDw/QZ4DZsbrF44fwE8HMTcEO2gIslISKH9Ynw5L52+jumPFhaTD
        Ehm97g+jUrCQfcE5oAfsQAruuYqLFPyc
X-Google-Smtp-Source: ACHHUZ5xi/PJQ9EixW6m9oDqHXMA47nnh9vAnySFs92UHh7eXo6D+NCVI9BQJArRjZz1n8PQVeN+oQ==
X-Received: by 2002:a05:6512:2f5:b0:4f3:8260:f18c with SMTP id m21-20020a05651202f500b004f38260f18cmr3897799lfq.57.1686571181643;
        Mon, 12 Jun 2023 04:59:41 -0700 (PDT)
Received: from p183 ([46.53.253.153])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c230600b003f41bb52834sm11286149wmo.38.2023.06.12.04.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 04:59:40 -0700 (PDT)
Date:   Mon, 12 Jun 2023 14:59:38 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Lee Jones <lee@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 0/4] Make sscanf() stricter
Message-ID: <6ab6adce-2318-4ae6-bde6-4317485639fd@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	bool _placeholder;
> +	return simple_strntoull(cp, INT_MAX, endp, base, &_placeholder);

This can be done without introducing dummy variables:

	void f(bool *b)
	{
	}

	f((bool[1]){});

> > lib/vsprintf.c:3727:26: error: unknown conversion type character ‘!’ in format [-Werror=format=]
> So NAK.

Yeah, ! should go after format specifier like it does for %p.
