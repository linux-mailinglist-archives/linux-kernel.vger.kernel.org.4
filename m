Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D1F68A767
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 02:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbjBDBAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 20:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjBDBAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 20:00:15 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33D860C96;
        Fri,  3 Feb 2023 17:00:14 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id l4-20020a17090a850400b0023013402671so10360382pjn.5;
        Fri, 03 Feb 2023 17:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DyRW2kRkALJvfbqyo707FmQ9B014BcAVIGtudI89BsI=;
        b=CS1bM11NDKSmGMg2bZmf7FAS0PGdMB29eY2ABsRjIUKdwOoMBiNGrwNcwobiebr0Tu
         Nay8pDaWLmSIbberHSjXfc8SUMU0fndN+WxcIYsc40eeP71i0jwdC6L2B88H9S3qnzKT
         U+vDvUFkN1DydA5rX9a7KTZJ7GX1skJG4Vd2mxPohqF5yTvrMTSGCgZYwptutkBGT0hO
         TOTFxGDhFz/4lvEwdvfOLVHFhgBdhT/5StZTwbz1Wn2t+rScrPvAgiSkV9gEF+ZlkPOU
         3vd9EljXIJQEVaRsnQgG2J09fR3/rBB2Szj4SYptakvyHFmYd9X8aYm/PF/X+TEDM0PW
         einw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyRW2kRkALJvfbqyo707FmQ9B014BcAVIGtudI89BsI=;
        b=EaBrDU9AkRbyBIU1fmDKObTx7h0Vphqd+MMjjEpd5QmZQKM+UPme5E+YzEu+nd6XDi
         SDLmKXRWqwxVJVK9tnax8fIwjKOTwy+paLwmlbYqWbWKEO7j5oYOtCh2H4bgcY+ziyvO
         6JobtXtzn1y+BGsjLh8OaxGy5OmgceMNX64X0MZc5acW2VfBFs6P5+D8GfgBIMawDH73
         D0+k3/u80/mzFg13vVta2PJldyk1wZg4II17C9rURk9gKfvHnmbWGQ124mqU8eNFNNKr
         rW1iidcxyCb360VXi5DAZeC3e1rs6Mn5qRqaGwyP2Cu/2drWY9Rj7P/xfJV0OPtdla1c
         koLg==
X-Gm-Message-State: AO0yUKV36RMJFJsT+5Uj9OzDBLvb8lRE7IZkRrVYat8zb8SONsgVPHtC
        DUJwIUFv42Fxmg4lHZjrxQ1yIO4SZpM=
X-Google-Smtp-Source: AK7set8fH9kPxGyYsa4tZXLKYBOFk5JlRG9CIXqZzLKiuavsHGP6b1IpAD4E4Jyj1WoXB09wq2+MsQ==
X-Received: by 2002:a05:6a20:d38f:b0:bb:b22a:d7ae with SMTP id iq15-20020a056a20d38f00b000bbb22ad7aemr6340062pzb.2.1675472414260;
        Fri, 03 Feb 2023 17:00:14 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:5a16:81a3:86ec:ceb2])
        by smtp.gmail.com with ESMTPSA id j9-20020a63b609000000b004e4ea77badcsm2042369pgf.80.2023.02.03.17.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 17:00:13 -0800 (PST)
Date:   Fri, 3 Feb 2023 17:00:10 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: touchscreen: st,stmfts: convert to
 dtschema
Message-ID: <Y92uGr0uxDWQ2ose@google.com>
References: <20230127202040.196411-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127202040.196411-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 09:20:40PM +0100, Krzysztof Kozlowski wrote:
> Convert the ST-Microelectronics FingerTip touchscreen controller
> bindings to DT schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thank you.

-- 
Dmitry
