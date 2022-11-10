Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E76623F47
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiKJKCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiKJKCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:02:18 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D114B6B22E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 02:02:17 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id l11so2294134edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 02:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VU3oEISNUYg+d9wlGb/h98JkMGsEQ9ti4i8WQ+4TZ8Y=;
        b=l+2q3EoEkmW8KGxjLUAosaPRqu2QuiS97YcetdfBswNY2l1mTPG41tKL/97tNx2aqd
         7mSqpF6EUPeU2jC3TP48/iKnJqPBF5FE2P6AjYJZGIu56KfW7qJL3cmD08aTmnBO9lVE
         07dTococsvCklATL4SyE1b/aEr4+0J06VUIQYMJyDglGDouF0LJI4htyQq8QwuxsUsyo
         w7oHSV75DAvKrCuBRg1V+HMXwXlBMcPYYy1GwTQXuMfSt+qEFbOJz2ST/Akt2O71n796
         mpvHe1TqQ2cvW+5JN36H8uHw/pkQ/k8tQPO/FF9mBxquofw6+JXnXMMGJ3aOa1/7hOxc
         aV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VU3oEISNUYg+d9wlGb/h98JkMGsEQ9ti4i8WQ+4TZ8Y=;
        b=cQwa+PJSXvUwa+wm465LinF6OxKbIdTIMtaBR1DAmWvr9iL5Am8W3QUvO/Y+lOL39+
         QJXgmWlegd0nTODjeL4cOkGXsn0EBzGEFCkZzUhNExxJeJBFnCv9jpUQDvyfru6TKKqS
         fH3me6HixJOIa7H/mVWvQ/vE2ppFVX1xpiyp4qh6x5rBtlTa35SiLWS+bvlPiwY5YmsK
         4AfbkZMlvBpHCov7eRjpgxrGDCyTqIL7mo17xMHYQRSf20hLL1IoHL2oRA3YRwitsKvc
         M6uZJU8otoxBqk8aTqZOqzOuZ1WQSiGehRK/4YJsFMZbZfh2nwbYnArg6aNRUa09AB1Y
         9/mw==
X-Gm-Message-State: ACrzQf1nJhSDgq+hZndGy4yb94DSMaFp1HoqcgA6d3vaYlqAbsO+IpDH
        moQpra7nrMV+3DwyMOMjqnJvPBccl84iLUwuoh6tZA==
X-Google-Smtp-Source: AMsMyM7KfumBAxq1O0Hu284/fJyh87E4kMzRSpVWatlLqnsWvCWqK/Oe0aeHJFcUG6KvsBG6hLjUYXOuJ/9EBvQNA3A=
X-Received: by 2002:a05:6402:659:b0:463:a83c:e0af with SMTP id
 u25-20020a056402065900b00463a83ce0afmr1914987edx.158.1668074536441; Thu, 10
 Nov 2022 02:02:16 -0800 (PST)
MIME-Version: 1.0
References: <20221109165331.29332-1-rf@opensource.cirrus.com> <20221109165331.29332-6-rf@opensource.cirrus.com>
In-Reply-To: <20221109165331.29332-6-rf@opensource.cirrus.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Nov 2022 11:02:05 +0100
Message-ID: <CACRpkdbY7W2rDZ4knkrRHBSTn7MKYV3LYh_r8Wkn1Hh=j+oL5A@mail.gmail.com>
Subject: Re: [PATCH 05/12] pinctrl: cirrus: Add support for CS48L31/32/33 codecs
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, broonie@kernel.org,
        tglx@linutronix.de, maz@kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 9, 2022 at 5:53 PM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:

> From: Piotr Stankiewicz <piotrs@opensource.cirrus.com>
>
> Codecs in this family have multiple digital I/O functions for audio,
> DSP subsystem, GPIO and various special functions. All muxable pins
> are selectable as either a GPIO or an alternate function.
>
> Signed-off-by: Piotr Stankiewicz <piotrs@opensource.cirrus.com>
> Signed-off-by: Qi Zhou <qi.zhou@cirrus.com>
> Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

This looks OK.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Does this patch have compile-time dependencies on the other
patches or is it something I can just merge separately?

Yours,
Linus Walleij
