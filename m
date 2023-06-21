Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B58D739175
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 23:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjFUV1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 17:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjFUV1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 17:27:16 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511041B4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:27:15 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-668709767b1so3034558b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687382835; x=1689974835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rTuIqYcfgKZv7QSK0ovHDNEK7QMFVmXAOC03AKV5k1Y=;
        b=lDc0ADffPTMYgrAgqhsG2RHOz8keNLf7QKfYlBJrheSHsBNpPcqqE1v++Kx9BUzGQt
         0hhpJ//377VwOH4P98a8IiUkbjKsT+DPIvXwgOTK5HHQjnLyI60VlJSNeWnNyII4P32a
         gnJ5zqjdhv7iSh4eF2brhTRwoPjJNuRhXcgng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687382835; x=1689974835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTuIqYcfgKZv7QSK0ovHDNEK7QMFVmXAOC03AKV5k1Y=;
        b=Q8P58Hx3eCJ1g4+QE3veaaSWhO1ZvHB+kgNV3WxA6y0hp8uV0/R3qiFzQANldVqbpR
         6lMjfQOhryQRRzAb0f3up/DKZK3qOTJ7FnJi4UkIlzkjKaSyqXaDWcVA2n8qKFZm1kbz
         Csqj/+7J7FAr/0nPIoMz6PEC+RHBcj3zhxhIwQR3tHOxo4j/jNgqg2H8Hh6pWxjUVHIz
         Baoald08xX8ORE7C1a8s9kYIbA3iN4ba/10WqHfHtxSEhyW6Tv0/AJoCCTGS6twU2Pv2
         jtS7g6HCKxTVoXsVm/OQbUY8l7JaXPTIjD7frsaaUj0GKlhiNP1B70tWRGxHapcjJj5z
         SQjA==
X-Gm-Message-State: AC+VfDzcoVrpqYuyz5UPPh5hIszUqaL7xywixoezfxL/UxcOM5mhLaXj
        bNQpIDxVgqaQZG0J1Ze6tCxMyQ==
X-Google-Smtp-Source: ACHHUZ7hDwL12K7vy21uD1u7QqOEq0vUvhx2DIvZ4gXF2e4I/pT4S2SYmti4bg81HlhOwI6Wry3TXA==
X-Received: by 2002:a05:6a00:23c8:b0:64b:43d8:a57d with SMTP id g8-20020a056a0023c800b0064b43d8a57dmr16791010pfc.13.1687382834771;
        Wed, 21 Jun 2023 14:27:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e6-20020aa78c46000000b0065ecdefa57fsm3349261pfd.0.2023.06.21.14.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 14:27:14 -0700 (PDT)
Date:   Wed, 21 Jun 2023 14:27:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Don Brace <don.brace@microchip.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        storagedev@microchip.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] scsi: smartpqi: Replace one-element arrays with
 flexible-array members
Message-ID: <202306211427.B13420A395@keescook>
References: <ZJNdKDkuRbFZpASS@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJNdKDkuRbFZpASS@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 02:27:20PM -0600, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element arrays with flexible-array
> members in a couple of structures, and refactor the rest of the code,
> accordingly.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy().
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/204
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
