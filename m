Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2925A67D5D7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 21:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjAZUBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 15:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbjAZUBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:01:49 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F676BBE8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:01:48 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id d132so3421741ybb.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r1CJR5tOhEksMn8lfZ84eKpWvrfIEAxzofpj29gTMT4=;
        b=J1qOH250f+BkniEn4lNLYA5PbUH5MuhUt79eYfJJpJYCFksRnNUWt5bY2wwj9WpAwn
         w5rrkUXqMJKODkUkdED93wmYPgCX05kLpqnz78SFTLUxPIW4iOoIbSi1K2KSCDTVkT5F
         3gdE/zT7/evVz8N3i5UAzPuL/ip6bXO/fvRYvA6T/hxzzetsOTitNf0+4dplLL0QvFOx
         jLoQxp3iwHqOr9J+bX7K7DlvBusGMCuTdDTL6gjG96J3g5sl3iyKgA87BpYpC1uGOWeK
         +AG9XsWdtvHRheMkEIK0efA4Qk3fq/Le9ZIkWXZU93b/Vl1bMEIaBHHbORZzH6PiH3uU
         +ypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r1CJR5tOhEksMn8lfZ84eKpWvrfIEAxzofpj29gTMT4=;
        b=o+1N0NXlMX/X0H48oA82v62e6CGR+YO+DP/PAQ8YIsxFuG+RAvvyuWCBc1WxY5YXS7
         BvSNRmFJm8pWPVTDQbpA9gV/l/o0VHhE1Z6zZ1cyPxgEB2Phqp/ApNopvGEYw64oHvKs
         szAg4fElhTok5JjePELveUkUPoKot2i8YAfDd2Gww/3zyLtIt7bOpj2QW808W8t2R5Yw
         p8c101mwWesfT/LRdm5GyEywhTrJeyPU3FiBj9UFiMAFiNyiegu4JHpFhC5/qFiXtWlD
         wLlTpgcujwOvyde+R+if1DdLUG+fZZ/kHmrF6qoBXShBz8cMJbvM7+iQbV6g3tFIEVIF
         ASYg==
X-Gm-Message-State: AFqh2koUqfRSNFQmNzcfUcWsTH8FIX1jRm00LH/BcIVO8jAFw7i07eL/
        qzg18CkAzcjJvKyB1KmrsvVAtQLZAspM1WaMChXNzQ==
X-Google-Smtp-Source: AMrXdXsylWAdOrWMDulA61btfwLbnjqkq2yfVzWLTOjro//4VbQs55PQdmSuimkWRkZkJBe1EZnFzDgLWr7zvvb4t0M=
X-Received: by 2002:a25:9d88:0:b0:7c0:acd2:6300 with SMTP id
 v8-20020a259d88000000b007c0acd26300mr3533414ybp.520.1674763307838; Thu, 26
 Jan 2023 12:01:47 -0800 (PST)
MIME-Version: 1.0
References: <20230120154437.22025-1-andriy.shevchenko@linux.intel.com> <20230120154437.22025-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230120154437.22025-4-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 Jan 2023 21:01:36 +0100
Message-ID: <CACRpkdb1gLt1q6CNC0dA805bnvsZ1+DiKRfFmbEoG67uqcZEAg@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] usb: fotg210: Switch to use dev_err_probe()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Jan 20, 2023 at 4:44 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Switch to use dev_err_probe() to simplify the error paths and
> unify message template.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
