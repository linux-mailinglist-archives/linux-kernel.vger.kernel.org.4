Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6F2739186
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 23:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjFUV3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 17:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjFUV3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 17:29:47 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA901BCD
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:29:45 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6687466137bso2473450b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687382985; x=1689974985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LVtcBpBVguZA8qoqqhoUInWb/zY6DUWD1bjs2LWSb0I=;
        b=HVXsgsJ2YYMXYdInroPiqaqbGEH1WjW4jAMh+uUvV+Uw5eiEQ2T1cO3J24tu2UHtEC
         3/qMGW8RCfpt140xoltctrA2zl28kzVYi2S0Np2xPzOBl3Kj668sHAslYlppaiOa6Huv
         dIPfWyUQGWS0cdms7hGp/ovR66Ul7OKcNJqqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687382985; x=1689974985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVtcBpBVguZA8qoqqhoUInWb/zY6DUWD1bjs2LWSb0I=;
        b=JYUiabiGv8FKa6pNosMNPaBxU+NlHWOTnL5FSWHDiWVzJ6H3wTEhV25erA5anEtXTy
         332AeOYFlTNcBHxUyUP0itNMTq6Eo35j6GymmKlN9v7ryz/40CBq8p021hBjZ3Ya6QTC
         WwAgxt9cCOzmEfD0oiJ3j8QoqueWoC2yWQZY38vK0QNLiBf414KpIghTFAb2h9xHLiIQ
         7bfr1liDirFIM8ZToUynxa2bPCriF8vN7sPhPxhQKUBTT7od+iZSlv4A3mYBTjCqNadr
         wJtZPqBNwyNkpyDnN1vzYWuJrdImaGflDmD76PYdI2nUXNM4+BSn5pwZd97pcCMtHVmA
         /CTg==
X-Gm-Message-State: AC+VfDyMggWH2DFyx5UPmAYvUizq+6EVVPuS14ODnW+R8cVhCBrcAUEq
        G+1q5l+PA6vOatIYElYTRnXNmI7FcudxLx/NU+A=
X-Google-Smtp-Source: ACHHUZ7FddK1YoVB0as/jTCHRhdsySjJdOFSovi73J3mIp/EqwtFEAHJ+xDMzv/2QuWePq2bUK2WCQ==
X-Received: by 2002:a05:6a00:2484:b0:666:ecf4:ed6d with SMTP id c4-20020a056a00248400b00666ecf4ed6dmr12103959pfv.18.1687382984779;
        Wed, 21 Jun 2023 14:29:44 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 5-20020aa79145000000b006689ecd0ff4sm3061860pfi.208.2023.06.21.14.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 14:29:44 -0700 (PDT)
Date:   Wed, 21 Jun 2023 14:29:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ksmbd: Use struct_size() helper in
 ksmbd_negotiate_smb_dialect()
Message-ID: <202306211429.DA43E8D39D@keescook>
References: <ZJNrsjDEfe0iwQ92@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJNrsjDEfe0iwQ92@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 03:29:22PM -0600, Gustavo A. R. Silva wrote:
> Prefer struct_size() over open-coded versions.
> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
