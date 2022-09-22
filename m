Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3058B5E6DA8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 23:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiIVVH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 17:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiIVVHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 17:07:53 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5F110FE17;
        Thu, 22 Sep 2022 14:07:48 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id a20so7216692qtw.10;
        Thu, 22 Sep 2022 14:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ecyshP9j3ieQiVtqcrVKcfHI+EZgR+N9QT1aadqbnBw=;
        b=gTyMCru59o6lN/Zq9tmcC1ZzFBktfSE5fxq6a6up/wIo0a0Mx/LTn8c1bLGtsDSYRR
         uPnypacwHSgf1OlCSaJB3WAZ1uTtUpbqBMgSO99VrPw+ruJI2eBzr+huVdTFmVz08duQ
         rdNelC/XUROr7FRqgUSyTLFvHUOCccoqXyInZC34Wp1jnDqZpK4PqdNh9Z+NhAGnZh/b
         N5V0L4SeHzDRBImoty6ny35j2dF9EQ3yZcdEYD6YVGB4935QQaF2kW8jxVPJFtCl/T/C
         YYSPDwJffq2ENYK+2O6SW9UnC8agsv73jJ3avj5baP0zQ1evImioxXfKwAI0XeJh0pNZ
         1hNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ecyshP9j3ieQiVtqcrVKcfHI+EZgR+N9QT1aadqbnBw=;
        b=ItCQtYQFo5BcP5B7ZnzGaWCckVPX7Pk4QVAPW5nYqnRY8V/q1NotEDYRaFcNRAMgi1
         p63U4WM63CoDu+ltIAI/RTe499LlRPJJgT+ywO7hdfK8k7tA7htTI8qbalfQMNd94GB8
         dKfyHTT9DLruyEcwedmiSItYOcFmQKF2B5ACSp3y0iwwiqTvIyV/msRWHmxSGlWfjNdK
         60PgEQvHUwKHqicBJAoutPaTOOnt2b6IjHfuJk5XJRaxnaQYHsaZlnIbaNsZXwbn9cea
         1tdfKEJnHPwdnhhO8l0vwov0cOvd4Jmsolt6x00TSxolikRQtP8mW5DZW72tIzyA3Fid
         rqog==
X-Gm-Message-State: ACrzQf1OMI5mh5YXO3XpeQk0W0HDFLfIHkIuYM+HD5aO7/eJCC4QE/Ja
        Fg3d2Cb16eGl0v1nyXql/Or1QA4WCufPlbRoBpk=
X-Google-Smtp-Source: AMsMyM69eEo3i/ESrpEvHhGexOjR9B9Yk2Z6Gspua69uCRdZDofYp8r+H0PusLOCxunDgmLXDKd+llmY5d4gwTyyfk8=
X-Received: by 2002:ac8:5e07:0:b0:35c:e7fd:1e94 with SMTP id
 h7-20020ac85e07000000b0035ce7fd1e94mr4650112qtx.384.1663880867897; Thu, 22
 Sep 2022 14:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220922194639.1118971-1-marcus.folkesson@gmail.com> <a34d9ee8-8bf8-3158-7fe6-cbde513aa1a7@linaro.org>
In-Reply-To: <a34d9ee8-8bf8-3158-7fe6-cbde513aa1a7@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 23 Sep 2022 00:07:11 +0300
Message-ID: <CAHp75VcEGb3kS03QG0ebOJYH1X_D5EbBjL6iNWUxQ5j=aCu29A@mail.gmail.com>
Subject: Re: [PATCH v7] iio: adc: mcp3911: add support to set PGA
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, Sep 22, 2022 at 11:00 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 22/09/2022 21:46, Marcus Folkesson wrote:

...

> No need to cc-us. Use scripts/get_maintainers.pl.

While I understand your point it's much easier to Cc all related
people for all patches in the series, given the fact that many (code)
maintainers ask for that (Cc'ing them all patches). So I prefer to be
on the contributor side for the sake of ease of contribution.

-- 
With Best Regards,
Andy Shevchenko
