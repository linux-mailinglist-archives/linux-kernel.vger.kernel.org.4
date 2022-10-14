Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4AA5FF41B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 21:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbiJNTeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 15:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiJNTeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 15:34:10 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5302165535
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 12:34:09 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id e18so3762252wmq.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 12:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QfKY6wRs5DX/nBwR6bSysvUzWBr3pwHzNK/uKJ79NdM=;
        b=yjeEDa1/BJTrKFihAE/iVnfBSzA4NB+cXDIau+vtc7TnNiGa21F/9d/xANOM2Y5836
         2VEpHUi7KNscrN6Crx247kvOZx+gn1aHK6KTmjqCt54lT23lQoBITOtCYsGblaCPakym
         QBYl+EzOQj6fXKS8xGmfnlmuWP6auRUfmN/31MHNMWbGXbd/RMmmNzjyZUBQARBDCv0Z
         rnzQs27DEykEHf8Ab+7Sp5y4d7H5InDUXFuAYib0gjgIet5Hy4h7yiGNq+5uT/FLBwo3
         rrek/5H6soO13bZEPMbWWKf/FYKnw5OCjhdrvilyhCDDmFc1IonDm8OIqknJRvTORwOP
         nKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfKY6wRs5DX/nBwR6bSysvUzWBr3pwHzNK/uKJ79NdM=;
        b=Kv/gKbgfMqE9rIkwtu/aqAJ5ShjHhfuSv8yP6zqWIKna9X8rQVsedX74m1lI/J5gZ+
         v+cpGczpgxkJj9xsr0CX7MxQdGkG4p4J4wqsnGjwgCbTxo8l6J2eZ32eVh2Gf0A4CTK1
         cozWi6NFxRyczmBlibE1C5vpLZvlUi5mgrJVbKOk7boA85yUpDkW64Un4mvnyVsjAS4J
         UgWinhZ8BDb0m5J9B+ed9k8ofFZlFOPoja4L3ZyXQwoa1/uASadr6GeyYdzCPUeenXGd
         UgvF6EDagH1kGXZMFAWldKA6QCdftGlawgU7kV3650jZXKgDK9i2h/mwXu5Jy0XtxrDT
         +VKA==
X-Gm-Message-State: ACrzQf11kkiLW4bOQF83QN79kHhiAfeI5s0ctxq4Jy8Mara6rd76gPYv
        DnhfW0Ss1Bk5V6KbBppmqk3kdbMbraiLIKZs
X-Google-Smtp-Source: AMsMyM6npKryELVjs18ibh73/XOtLrZazbqbNoEmp4mOVV7lkfgOXajay/3cCNk2FQiMTazPfSIXig==
X-Received: by 2002:a7b:c051:0:b0:3a6:36fc:8429 with SMTP id u17-20020a7bc051000000b003a636fc8429mr4680582wmc.78.1665776048115;
        Fri, 14 Oct 2022 12:34:08 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id bz13-20020a056000090d00b00228cd9f6349sm2566032wrb.106.2022.10.14.12.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 12:34:07 -0700 (PDT)
Date:   Fri, 14 Oct 2022 20:34:05 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 3/9] gpiolib: of: tighten selection of gpio renaming
 quirks
Message-ID: <Y0m5rRd1EqGSX5Dl@maple.lan>
References: <20221011-gpiolib-quirks-v2-0-73cb7176fd94@gmail.com>
 <20221011-gpiolib-quirks-v2-3-73cb7176fd94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011-gpiolib-quirks-v2-3-73cb7176fd94@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 10:54:27AM -0700, Dmitry Torokhov wrote:
> Tighten selection of legacy gpio renaming quirks so that they only
> considered on more relevant configurations.
>
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
