Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6875C5F4E03
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 05:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiJEDGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 23:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiJEDGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 23:06:44 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E45D67169
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 20:06:43 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id l1so1490035pld.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 20:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=q/zGlhb/6/D5Xkd4KCi7Y207Q24GuRcEqCbd/ccpKzo=;
        b=SKokA0th/dXHfDQS3nsb8z2Z2ppZDeuiQhw1p/wBd32fJemgyvsCAt3bgQrTsKKYqm
         sYvv8mev2CZGsmAPDpcwakRg7aVXj6WJcATx3M0Pj3y6yLACKmqpQ+31/GaGC+CA9SiP
         PihlLDYUcY3R+DZFe1vMFUA4jUZdXlBR6vW5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=q/zGlhb/6/D5Xkd4KCi7Y207Q24GuRcEqCbd/ccpKzo=;
        b=Pz88B3eVB64jJRVvxOD2K4t7TtNOiUrQJLS1EYPN/TWNY4srvr++Ke3bznrEXuAdsK
         9cD/c5pGi5YTXNykyuOL1z/0cZuro/LanQlrjsVmHS2bOWVzKS2q7VFv11lDQMOl6bKU
         /5qt0wmAd8fOWQIuzqZf08bVsC5gFMA2jYqr7q1KHL99UDcw2/wqDlJ7NI76p0V6f4TB
         Sycfl8GfWZnItaU9kqPRwifUKY5JavWVAawEXnKotSLyNyCwh+ZizkIH6N7hHGq5GOwL
         I8xfLgCVn+lw8X5sMdFwqD8vHrU6jFzIR0ozodUUHAuBJKTV4/2Bko//4yeBLrw5gs16
         lIKw==
X-Gm-Message-State: ACrzQf3O1EV/fUyjfPf/Afb7SujYJbfoUDyw0wRxgACrRV9UDKFBMHuz
        KV8GjyI+ZRjfgA3c4tnt+1hrsg==
X-Google-Smtp-Source: AMsMyM57nv7ccnMuOcGPE169V0innj8Ek7XT9d7ddkrET+x+x7ZIMJkEIJ4x3msMla3GdYi0FFvCeQ==
X-Received: by 2002:a17:902:e946:b0:179:d084:bbe1 with SMTP id b6-20020a170902e94600b00179d084bbe1mr30088816pll.97.1664939202905;
        Tue, 04 Oct 2022 20:06:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n18-20020a170902e55200b0017ca9f4d22fsm8991473plf.209.2022.10.04.20.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 20:06:42 -0700 (PDT)
Date:   Tue, 4 Oct 2022 20:06:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] cifs: Replace a couple of one-element arrays with
 flexible-array members
Message-ID: <202210042006.9A12D208@keescook>
References: <YzzjKyHDuFoQAVCu@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzzjKyHDuFoQAVCu@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 08:51:39PM -0500, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element arrays with flexible-array
> member in structs negotiate_req and extended_response, and refactor the
> rest of the code, accordingly.
> 
> Also, make use of the DECLARE_FLEX_ARRAY() helper to declare flexible
> array member EncryptionKey in union u. This new helper allows for
> flexible-array members in unions.
> 
> Change pointer notation to proper array notation in a call to memcpy()
> where flexible-array member DialectsArray is being used as destination
> argument.
> 
> Important to mention is that doing a build before/after this patch results
> in no binary output differences.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/229
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks good to me; thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
