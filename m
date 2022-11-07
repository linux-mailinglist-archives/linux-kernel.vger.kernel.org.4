Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1351961FEE2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 20:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbiKGTsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 14:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiKGTsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 14:48:36 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7F61A39D;
        Mon,  7 Nov 2022 11:48:35 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id q83so1602891oib.10;
        Mon, 07 Nov 2022 11:48:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pC3VraCs8s6YEvpVTV0I2PtrYdEY09JJSU0EEtgPIig=;
        b=8Ff7h7c7PzfRTraUgtt8CqdPg/AT/y3NcWSq3rEmkNeZuCdZ6XilxmxEwRcIO88hVp
         L3joOTCR/AASQkSrog+CnHnM6E8K3e/VQs1iVvYYXfK4PuIhIfAkgClk2Karc15lHhAy
         VdxrVO9mgb7KbrqO0MJP6DBv5/u6h+zx0QFyAf0lH7KKHtTRPkQ4xBIaAU6BYDdF2x8k
         +Ri88DPumSxor7scCKhCqvaeUeB5KhXDDHb+pPsmj8T0QRqAzUOlA3G7EDOobHXfbfV5
         Ny+sJJdGNEwDlqgnivyJ4vWYhvwTot9Ns+RroEQsVnOu3CKjJU4iwdlxP/ohU5jgJ3vm
         tjKw==
X-Gm-Message-State: ACrzQf3+IsyaDl8S4ebimafd7v/JrogrPcdit1WPonPXhvghxyMctiJo
        khzIkFG6cIc4GFGLakSQTN6f1lM05856aXBmuWI=
X-Google-Smtp-Source: AMsMyM4Z/18xRjOjvwABmJlezj2L/eczEI73izOERN6BTvW3w6fEqYeDeoy80slhhl69ZKNf1gn6csGrVR6G4/dsA4Q=
X-Received: by 2002:aca:2805:0:b0:359:e340:d53 with SMTP id
 5-20020aca2805000000b00359e3400d53mr26615294oix.209.1667850515046; Mon, 07
 Nov 2022 11:48:35 -0800 (PST)
MIME-Version: 1.0
References: <20220825-arm-spe-v8-7-v3-0-87682f78caac@kernel.org> <20220825-arm-spe-v8-7-v3-8-87682f78caac@kernel.org>
In-Reply-To: <20220825-arm-spe-v8-7-v3-8-87682f78caac@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 7 Nov 2022 11:48:23 -0800
Message-ID: <CAM9d7ciYabTpo0q5Z8h229dZ+RXG7JP1zgOoR1fgdZZCH87vow@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] perf: arm_spe: Add support for SPEv1.2 inverted
 event filtering
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Ingo Molnar <mingo@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, James Clark <james.clark@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Nov 4, 2022 at 8:55 AM Rob Herring <robh@kernel.org> wrote:
>
> Arm SPEv1.2 (Arm v8.7/v9.2) adds a new feature called Inverted Event
> Filter which excludes samples matching the event filter. The feature
> mirrors the existing event filter in PMSEVFR_EL1 adding a new register,
> PMSNEVFR_EL1, which has the same event bit assignments.

Just out of curiosity, is it possible to have the event filter and
inverted filter at the same time?  What if they have the same?

Thanks,
Namhyung

>
> Tested-by: James Clark <james.clark@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v3:
>  - No change
> v2:
>  - Update for auto generated register defines
>  - Avoid accessing SYS_PMSNEVFR_EL1 on < v8.7
> ---
