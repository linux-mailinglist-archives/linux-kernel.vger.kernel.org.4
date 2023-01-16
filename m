Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CCF66BBCD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjAPKeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjAPKeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:34:05 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD791ABC1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:34:03 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-4d4303c9de6so224043887b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m/tYLsguvhNX76zD17hbPH2qZrPUhffkR6haBjKQqeM=;
        b=lOAzNQu8eznDMDQrcDCeg8Fr+f4UMLS1VKaRsPuieAhkt0buE9051t1htqoIaxTiPe
         J2ypkmPum8BdNAzSBXwbQiS/RJgBXZ9uNJNoY9p7/4ECG5i2eJFzWSvxsI7w4VLi95qA
         65cm9Sgww5hrMlBJO/mkMjzNxRTk/Cl+Kalzz/jTRBSAkeoZSnD85r5K9fe5Y427m9Wy
         GvpTxzOk4uy1F9NJo5kgPKyKkrs7kCcWQyuGdxvFOlD7611X+u7Zcgpm/7NGRA8MkNaf
         ZCvdaxDS1JE4r7/uoMTLFgylYdR+JRh1ELrm209maie8TVQlHpLfuGkkkOdZyBAT06X1
         NhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/tYLsguvhNX76zD17hbPH2qZrPUhffkR6haBjKQqeM=;
        b=TjscNOFhz80HC7uAQDECdQBY4LpmnIy1pxN5DGc9TMXmjpmduDlkUH/pnXwOQGO8lP
         3eMujUIrolHplKA2WjiqyKxDTU2xn/DSqLOPkMp6Hr9L4jZMDLoNLj/z0XBHeeWMVK1+
         f7eXqPfGVIv/E2ceWCtPo7Ku40ZoU8Uru84ptadpAj11RG9T37CdVoBpW/1bgJ40sXtS
         1jChxJfdIUf25pKrXYPQApzfIVoOpvaPA2Knt0WaCO0Q4slOCUAWsO5/YaNJMjPoWaMU
         0JwMFO5AWWtbuoZUCkkzZYP44SYYCNLBfG4lv1vbAQdeb6CludEQI6/6D7j3rsgUzXvt
         qt5w==
X-Gm-Message-State: AFqh2koz1IFQP8PNckar0sYSIJ7iqEU/juqhAspxELpXPhNdZ+TWjzAa
        0cjYK0+zQY2ToErjnPHNXXuqrCuVO69lqQFLSZL27vDWPc5soA==
X-Google-Smtp-Source: AMrXdXtW6TKCnRsDE0wvhiF6XGnwo0I29h/efOhVdU9ndWaVGtkwJJu/nRXufdrfHsXPEx193xkQYwrYct1AIhwg7Gw=
X-Received: by 2002:a81:a084:0:b0:4dd:ff06:1358 with SMTP id
 x126-20020a81a084000000b004ddff061358mr1574748ywg.488.1673865243057; Mon, 16
 Jan 2023 02:34:03 -0800 (PST)
MIME-Version: 1.0
References: <20230112140209.61228-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230112140209.61228-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Jan 2023 11:33:51 +0100
Message-ID: <CACRpkdZLAOfJ4YHWhK2qfcfC7unex0fHRHdxsCRWhgHmkhacAw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] power: supply: collie_battery: Convert to GPIO
 descriptors (part 2)
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 3:02 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Finish the job started by the commit ba940ed83218 ("power: supply:
> collie_battery: Convert to GPIO descriptors"), i.e. convert the use
> of gpio_to_irq() to gpiod_to_irq(). No functional changes intended.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
