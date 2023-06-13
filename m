Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8B472EBEE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239618AbjFMTZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239585AbjFMTZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:25:36 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D62E1FCF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:25:26 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b3c0c47675so24991185ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686684325; x=1689276325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FqljQgltrTWXp4tBsVykV34K/W0vrExZI9E6BwVeYrk=;
        b=Vuk5lprGVMjZyBqOAnxPZ1cP0qnAz1VOxXLVHd6COwWrk6uWeCNnFqJLd5ZlTB4xBN
         dzgZf7Jh9tixFAfZz3fmSPAlXZ/It7xgz3OZdv0ga4USAGY4venLvhA6oqd85Vcqq+o1
         kX6/a+xeL6i8dTiBdduqpe2IX31UD9Xg8A/SY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686684325; x=1689276325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqljQgltrTWXp4tBsVykV34K/W0vrExZI9E6BwVeYrk=;
        b=FtvD7HOGUxqiY1chdnlvHJx07yC2568tHYCN+yZqYbmzY+N92D1WHc3kCx0jWVVoeu
         W1VTx5PRDUK3ECKIYD5qF6ctSfKBHaNYmIZUkhSKlbZ+Vks2QHPjPNJIC2/iXJPGFnIr
         s7pt6RYZGMPMqkwPQeMjTgkfWAQ+BOKzZaoFGUFZHLp1WIG3PdNM2tI3XOF1Lwb1QvCe
         Qi6yyi3Uq2H7UxStZSIteLy0kXGaSyNnV6rPh9POPfT85DZ32qiBLG5F6m415sL/36uq
         jT+CJD5qVJeAy8DgrPyIVlWJTi2mOpVLFVrWcFgHlTVJOJa8UZI/aA1S33MipI9Yiar/
         4DiA==
X-Gm-Message-State: AC+VfDwP3VAFtTURr2QsLF1Qd3tv24kpsPiH0MV+cDhZGLFjtiDuS4Io
        LTTPUzS3/wLFypfLNmf0ObOOPHyhZxyjlAc35NM=
X-Google-Smtp-Source: ACHHUZ7qXyztF8y1MkcPh+Rc6qnYC3E972aaXz8caME05mHnNSqufHjosMNobu5acZ7aPD5pnWR3Bg==
X-Received: by 2002:a17:902:e887:b0:1b0:f8:9b2d with SMTP id w7-20020a170902e88700b001b000f89b2dmr12528414plg.29.1686684325037;
        Tue, 13 Jun 2023 12:25:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l10-20020a170902f68a00b001a072aedec7sm10714545plg.75.2023.06.13.12.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 12:25:24 -0700 (PDT)
Date:   Tue, 13 Jun 2023 12:25:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-hardening@vger.kernel.org, linux-wpan@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] ieee802154: Replace strlcpy with strscpy
Message-ID: <202306131225.779997E@keescook>
References: <20230613003326.3538391-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613003326.3538391-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 12:33:25AM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> Direct replacement is safe here since the return values
> from the helper macros are ignored by the callers.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
