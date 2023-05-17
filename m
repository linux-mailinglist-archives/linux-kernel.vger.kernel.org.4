Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DD37075C7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 01:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjEQXCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 19:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjEQXCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 19:02:14 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DB361AE
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 16:02:06 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-528cdc9576cso923761a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 16:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684364526; x=1686956526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NCOs9XFCFeYjn/qRnbFLhpqd0QIqRRTHRKO1/+0RAUk=;
        b=hblzA3PbsTRQj6+lS+RlZl1Bd8A+m4ZU2gRkGKogDTW2wJqSkEx6ZBxuNyeQhCXmO/
         7U6aPZGf5+vHz+ckkVvoPkEV42PklylLIZkRyTnzUlpACKLZIomqzSnqlpjZ0O8yve08
         FxK3KLI7abAFw3PZBgAl5IPQmQOw7B7VwPl3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684364526; x=1686956526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCOs9XFCFeYjn/qRnbFLhpqd0QIqRRTHRKO1/+0RAUk=;
        b=jsbV4nVjrZbkGj79hFwLn+ETIFFKcK738wF+Yh4voVb6idMyvKsf6zO55RMsbYPJ6J
         ASHjw5VByzmGJ4TtWesw6EwQIHVfEXViJ8nFEo/uapKJGFFyemkcocsaVSobJvirGxNA
         GKoSldqM9S1uwNcqKcELT2j2Vq01qIsFhGGX9OulPLny0xX58e48IGNSDuyCyCFZZyrs
         8+u+lB8sFmEObd3JoTPOWt+zIDSziiIQIjhVQkr2aOAq8Hrq42f3MSSuW72jSd240O4F
         dYsuMM3aJ5wvFQ2VdRR2uQz3bKRbrr/teGQVXOWALUXHYxfFma+FBXaivPU2hT89eWk8
         mZRg==
X-Gm-Message-State: AC+VfDyF0u5bVe3Ph9PdH4mRW38VP73bRDT3NUs8uqWAQ4o559xsO/j1
        tiIkjKPaJ1KZQdKKlEqYP9K9e5+/0xkhhenu7DY=
X-Google-Smtp-Source: ACHHUZ7Qe0iBjeZmvcgnaHOBEs733JZVei10a9MeOfdNB6l5X05u502QW9KQ28OgeMcXVjjkg2bwog==
X-Received: by 2002:a17:902:ec8a:b0:19f:87b5:1873 with SMTP id x10-20020a170902ec8a00b0019f87b51873mr342789plg.62.1684364526317;
        Wed, 17 May 2023 16:02:06 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d15-20020a170902728f00b001a69c1c78e7sm18008090pll.71.2023.05.17.16.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 16:02:05 -0700 (PDT)
Date:   Wed, 17 May 2023 16:02:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2][next] scsi: lpfc: Replace one-element array with
 flexible-array member
Message-ID: <202305171602.2C715B078F@keescook>
References: <cover.1684358315.git.gustavoars@kernel.org>
 <6c6dcab88524c14c47fd06b9332bd96162656db5.1684358315.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c6dcab88524c14c47fd06b9332bd96162656db5.1684358315.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 03:22:45PM -0600, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element arrays with flexible-array
> members in a couple of structures, and refactor the rest of the code,
> accordingly.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/295
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
