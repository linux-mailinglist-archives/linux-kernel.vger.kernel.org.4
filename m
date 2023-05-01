Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B806F3382
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 18:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjEAQZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 12:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjEAQZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 12:25:06 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F27F10C2;
        Mon,  1 May 2023 09:25:05 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b50a02bffso1956578b3a.2;
        Mon, 01 May 2023 09:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682958305; x=1685550305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hi2i6+2A7Vme+8Bw6/DbpVhur6f5/wfyKbNa3KD3XxY=;
        b=gKLjxs75WmlwBqGSSx/wYqqAvwTtUA4KSx3Q+z9o2JPteLVSk0sM2ydoaJwub4ui22
         SOQj3Hr/OBBQGZiKcaY/tkwCH1cFVUf95hckaIUMnP/YmYsiIVwVX2r1KXALMrpR9f6b
         xWcIlT67GL5GhbGiLla+ta52oY22/KZUh4AaEGbasgUQ+MnGDfJFOs7orIE2FBMKq8in
         Y+acU0h3zwre5KQlbqL5v78b0omZIqoZyteSaQciVGjjztuc6SzQK+VW0Yjtzky7hSUj
         DbiFe4R94r9EigM9dVoEVAyvn9qDEsNZHzfQvTwKtsiIvVFNF7UpdSRVaEzMkJASM3Y3
         q7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682958305; x=1685550305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hi2i6+2A7Vme+8Bw6/DbpVhur6f5/wfyKbNa3KD3XxY=;
        b=jb8vmoF2oFF8Q4CCGC/etTW8OJbpB5XXeuwLUfm0vhuy3/y/00JEID+XULENuNsJFs
         Usu/g0qg55ms+O8fWJvllja1LxW9JSrreVZqJwKlnU2IkR0c03a7CDLd8Qglz/WO3UDP
         q7O8Lk2g07efIZxfsleGzRylcOk1Hh0BAVHL/avfVGA5f3xs/oZzMM9l/uo/NO38h6vs
         xIENycmeh6ShfQvutsW/4OAPbgR5xEkSFruH+lAjUKjTkd7LAOKkGyPwxnAnbXapnMVX
         gn2gV27Mmgl2PRYaJ8sdrZhwfkbDaJixEigWmZgvmEsO5Ch2HS4fdNrHQPpcVXQRKykr
         /0Rg==
X-Gm-Message-State: AC+VfDxActLdoNGEO8VKvEFVLnulMYQsl1NQd3i/iIrB1efDWdoBvFhi
        ysa49BhhhKyt0/Gq9LXL1wI=
X-Google-Smtp-Source: ACHHUZ4n14UICtaTafCBlV7ibiarxus3+l8PeLea8hsV8ktohlB6MROy3QkUnTl+1BhcVh+jXYIMxw==
X-Received: by 2002:a05:6a00:848:b0:63d:23dc:7760 with SMTP id q8-20020a056a00084800b0063d23dc7760mr21489004pfk.2.1682958304491;
        Mon, 01 May 2023 09:25:04 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:b6ce:736b:e4f7:adb])
        by smtp.gmail.com with ESMTPSA id q5-20020a056a00084500b0062dae524006sm20078819pfk.157.2023.05.01.09.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 09:25:03 -0700 (PDT)
Date:   Mon, 1 May 2023 09:25:00 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lee Jones <lee@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: MFD: Convert STMPE to YAML schema
Message-ID: <ZE/n3O6eZRCeBTJy@google.com>
References: <20230426-stmpe-dt-bindings-v2-0-2f85a1fffcda@linaro.org>
 <20230426-stmpe-dt-bindings-v2-2-2f85a1fffcda@linaro.org>
 <20230427161633.GA3112472-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427161633.GA3112472-robh@kernel.org>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 11:16:33AM -0500, Rob Herring wrote:
> On Wed, Apr 26, 2023 at 01:21:39PM +0200, Linus Walleij wrote:
> > This converts the STMPE MFD device tree bindings to the YAML
> > schema.
> > 
> > Reference the existing schema for the ADC, just define the
> > other subnode schemas directly in the MFD schema.
> > 
> > Add two examples so we have examples covering both the simple
> > GPIO expander and the more complex with ADC and touchscreen.
> > 
> > Some in-tree users do not follow the naming conventions for nodes
> > so these DTS files need to be augmented to use proper node names
> > like "adc", "pwm", "gpio", "keyboard-controller" etc before the
> > bindings take effect on them.
> > 
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > ChangeLog v1->v2:
> > - Split off the GPIO bindings to their own schema, as the old
> >   bindings didn't even have any GPIO bindings. Put the GPIO
> >   schema before this schema so we can use GPIO in the examples.
> > - Drop nodename and pattern as STMPE is not a generic name.
> > - Add maxItems to the resets.
> > - Make wakeup-source just :true, as it is a generic property.
> > - Move unevaluatedProperties for subnodes right before properties
> >   as requested.
> > - Name devices "port-expander" in the examples.
> > - Use lowercase hex in line init.
> > ---
> >  .../devicetree/bindings/input/stmpe-keypad.txt     |  41 ---
> >  .../bindings/input/touchscreen/stmpe.txt           | 108 --------

Since Rob is happy with the bindings, for the input bits:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
