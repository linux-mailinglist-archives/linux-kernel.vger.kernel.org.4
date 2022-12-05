Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD255642642
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 11:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiLEKAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 05:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbiLEKAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 05:00:12 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065A7E0BA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 02:00:11 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so55402pjr.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 02:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NQ6cAl+86TDUB9cUa1/EWsCMl2DdMF0dDV8o8yg5Vqo=;
        b=Dbxfud1EIQCczeM8D9qo8COwwUq+htWEyYt1aSASCGolP60aSlSkGvfIRY3Rermc9u
         X5GRzZ7JcDLi/ldCbMiflREi3JaZChi7ELkotb/7nyPofwcTUp4G6zeIoao9gbEhpr8q
         8c+EUEW3AMqohdDWA3ZEJV+vyQzGcqjM7qQu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQ6cAl+86TDUB9cUa1/EWsCMl2DdMF0dDV8o8yg5Vqo=;
        b=JfQpVqZlXr2Z9eQZjhAMNZzwpYtjU27XJzrJiL0aCBm6+r3p6+U578KK1y8IMJ6y+z
         yUCulqC0Ul1ry3HhcKEwFpIyB2A4GsxuOuhtrQys8uvT/Tbgmtg0mHKwZlVqBuPUK12N
         xziYmSSdB8WmujmtqaQusJQkiBYbnEI7VMpInFSSayFXm04yANX6W9cF276ZK+0OMSoJ
         G1xnZ46zCSAF5DMl51vDuJHRznlxvHbL7UdDnW/sW24NqzbCryJM7qwy+trDMPzIked5
         WvUK2NDKE5GKB5M0SQJFG1sZlotrgzK1XR+rZwOCHBTkhKh1WIRjpLUaihJX7jCgZ2Ym
         793g==
X-Gm-Message-State: ANoB5plVwpS68z9n32UoVWY9XIcbJ4HcZS1dDkfXjG/H85TulWJdIoBE
        j4ob9FahfJBSNZ9xruP8/vNQe73J7Q6n/z0T
X-Google-Smtp-Source: AA0mqf4QYZN99TQvaiqwaj4nboSHkfQYtYLllku2zIHP9FNU0z0yJP2t09klFeEMAEQU3Tew8Wz/hQ==
X-Received: by 2002:a17:90b:3c4c:b0:218:a8a1:933a with SMTP id pm12-20020a17090b3c4c00b00218a8a1933amr73171225pjb.14.1670234410351;
        Mon, 05 Dec 2022 02:00:10 -0800 (PST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com. [209.85.214.171])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902e54900b001898ca438fcsm10220857plf.282.2022.12.05.02.00.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 02:00:09 -0800 (PST)
Received: by mail-pl1-f171.google.com with SMTP id jn7so10296506plb.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 02:00:08 -0800 (PST)
X-Received: by 2002:a17:90b:944:b0:219:33a1:d05f with SMTP id
 dw4-20020a17090b094400b0021933a1d05fmr40319988pjb.116.1670234407771; Mon, 05
 Dec 2022 02:00:07 -0800 (PST)
MIME-Version: 1.0
References: <20220921-ad5820-v2-0-3e5cabb04786@chromium.org> <Y43A1WbaLSa042EJ@paasikivi.fi.intel.com>
In-Reply-To: <Y43A1WbaLSa042EJ@paasikivi.fi.intel.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 5 Dec 2022 10:59:56 +0100
X-Gmail-Original-Message-ID: <CANiDSCtBk+HCzd6bc=WS8KQWjB8HrsoUBaS_CsJRDAdqp4z6Gg@mail.gmail.com>
Message-ID: <CANiDSCtBk+HCzd6bc=WS8KQWjB8HrsoUBaS_CsJRDAdqp4z6Gg@mail.gmail.com>
Subject: Re: [PATCH v2] media: i2c: ad5820: Fix error path
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pali Rohar <pali@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2022 at 10:58, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>
> Hi Ricardo,
>
> On Fri, Dec 02, 2022 at 05:35:59PM +0100, Ricardo Ribalda wrote:
> > Error path seems to be swaped. Fix the order and provide some meaningful
> > names.
> >
> > Fixes: bee3d5115611 ("[media] ad5820: Add driver for auto-focus coil")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> I'm afraid v1 has already been merged. But I understand patch content
> wasn't really different so that should be fine.

Sorry I missed that :)

Thanks!


>
> --
> Kind regards,
>
> Sakari Ailus



-- 
Ricardo Ribalda
