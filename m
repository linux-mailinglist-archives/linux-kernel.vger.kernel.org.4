Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C173B74BA40
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 01:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjGGX6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 19:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjGGX6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 19:58:36 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D94128;
        Fri,  7 Jul 2023 16:58:35 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1b3ff2460ecso2338484fac.0;
        Fri, 07 Jul 2023 16:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688774314; x=1691366314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S6eL5nr6Nk1rZTEECNFgxuQom9O+jnlr3zDn+Htet7U=;
        b=rJbu/o9jUa7x7ny9UvaYf4Zrq+/Yrm76jI89jkxDOJutSg2tbX0t1f+jByZ2LI91xa
         gyFfNLvcCWFyLlQ7i0edJ3dYtVOs8j8rucLgk84DgrMGEW9Rh7Hx00daPrrmF5+CLZT5
         VIR6KEwsawFECyQ9CxH5kKBxegiHvv2W8uCA/lDUv6PWJph6ZQ5tdOprqolD3TpX7147
         XiY7zkEPHy5pPhSbRfWdLnaYI6cerBm/J/8sNJsjxwhI0Ri+MTBh95DNAp1MHJK/qXnf
         caHsQYgi6YCxtuHsM2vkMtaI/CZs3W1q58OXtlTbb51eEn99fSdsao6/QQn87+5Z/rZD
         6K6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688774314; x=1691366314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6eL5nr6Nk1rZTEECNFgxuQom9O+jnlr3zDn+Htet7U=;
        b=JD3o+dTkiIcr4JEDbUcxv5ioLkxT28ExzxBhgN56zMvJjWOjKleHoSZQAeqjtKm65J
         knwiEnUjaNkqoQRmKZ/L202//PUOrzvrmH6LcJMMS68FurV2GKLpN+E+G3POasgjzCNv
         Rsn/6vPGPPMuSS1BIaIaZgiyf6jdoBgsgIALIsDAoFMTme7YrMwlwhjJmY3fK/+mO6g8
         MkAyE0igcuT9AtLrZjGfcm+V/Pj5NG6E6Pw4kj2Tw1j2hxU3zS9RQtjBtCtoDxl1lQYZ
         mJdek6iiCQKionJVrIdTKj9t8DPbO8akL+koiQ17uVFRkuP18h26ICLyGr61I1W9G6fS
         bxVg==
X-Gm-Message-State: ABy/qLaidruuWnBdDH/sr34384U3Y7BDo+OugqtgAhSxO+FSps4Apl7G
        /9OCacF3MSUawAHPnA3rv+Y=
X-Google-Smtp-Source: APBJJlFscm1KEUL9wwHSwMQV51AHitnXKGceRfk+/HnD3zE2YRKQ4lmQsgGAkrzaAd4km1irpj2Zaw==
X-Received: by 2002:a05:6870:548e:b0:1b3:caa2:eedb with SMTP id f14-20020a056870548e00b001b3caa2eedbmr7571581oan.44.1688774314204;
        Fri, 07 Jul 2023 16:58:34 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:38de:2bd4:8f55:60cd])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090341c600b001b896686c78sm3792834ple.66.2023.07.07.16.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 16:58:33 -0700 (PDT)
Date:   Fri, 7 Jul 2023 16:58:30 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bastien Nocera <hadess@hadess.net>,
        Sangwon Jee <jeesw@melfas.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Mika =?iso-8859-1?Q?Penttil=E4?= <mpenttil@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Andi Shyti <andi.shyti@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 00/24] Input: Simplify with dev_err_probe()
Message-ID: <ZKimpkYz/aAgOPEX@google.com>
References: <20230625162817.100397-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625162817.100397-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 06:27:53PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> Three years ago I sent v3 of this series. There was never an anwser from Dmitry
> - no comment at all. Maybe after three years this can go in? It makes
> the code nicely smaller.

OK, I give up. I still think that this API is wrong, but I will not get
around to making producers note the reasons for deferral, so be it.

Applied the lot, thank you.

-- 
Dmitry
