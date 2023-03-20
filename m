Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01D56C1E5F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjCTRnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjCTRnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:43:31 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B86CA32
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:39:14 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id n20so2825277pfa.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679333953;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mj8BMtgaqpcJ2izjHoCa3UBL6C1oS24zpeZ0O+klY+Q=;
        b=Z3+VpLz+lOm8RKdKSJ/nRK4OcwRzXaiergdD3dh/LHJwXIL43nZZXSZvvei1uxJrrW
         FKrtsg2XIWSzkx7w5Hte2o0ryKqwv7ugIIeLufW35kLDiwULMkpcynmBfHqmBFbGsA6l
         OCIpwyBBoWAbT93Gxp+UflYk914/xh5zEO180=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679333953;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mj8BMtgaqpcJ2izjHoCa3UBL6C1oS24zpeZ0O+klY+Q=;
        b=50gOjEyzKAG8aBDE0TlnbV7dhu8uo34NZN14YHqW5nH23DZX53FebbOJV6tD5xoOhn
         vloZAijZ+IO93HPVkBJ7bmlTCk48wLE+77jEOKqEjxr/iZsy15lTV7HDZLOX/tpKxngz
         wG714WlRZh4URc6gfKpVF79MSCSfwYgnUJM1DtePcqJ/K76PiQ+g38S9KkHj+K4NENWY
         /k790+pokeTSm3oJ+EfwRJkSwfC+Rzk3QpouMcJjQm32cwDfTu82LFoEKVmiA8SWCbb3
         IKo3tfNldPMrJ/9Wr5lg6zQBAfkc40yYHDa1lDQbVsLatbHHVIrwGmiXpsoBhjnDLn2X
         6cvg==
X-Gm-Message-State: AO0yUKXDlCgbe8VxuO+1XQ5rx9SGoc0pjTWy2rkSHQIcyUPl1Vziurld
        92PB3AMVvA/28+PeymII0ZX4HA==
X-Google-Smtp-Source: AK7set8IIyRVLx7g0PGp9Q0H2+W3ieCdIjaAbxCxs39Qs/AxGF7FAqBfxjixUjvjyvOasatQ54Y7HQ==
X-Received: by 2002:a62:1881:0:b0:623:dfdd:f7eb with SMTP id 123-20020a621881000000b00623dfddf7ebmr152756pfy.12.1679333952731;
        Mon, 20 Mar 2023 10:39:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b5-20020aa78105000000b005938f5b7231sm6573800pfi.201.2023.03.20.10.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 10:39:12 -0700 (PDT)
Message-ID: <64189a40.a70a0220.70bd2.b03b@mx.google.com>
X-Google-Original-Message-ID: <202303201039.@keescook>
Date:   Mon, 20 Mar 2023 10:39:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] rxrpc: Replace fake flex-array with flexible-array
 member
References: <ZAZT11n4q5bBttW0@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZAZT11n4q5bBttW0@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 02:57:59PM -0600, Gustavo A. R. Silva wrote:
> Zero-length arrays as fake flexible arrays are deprecated and we are
> moving towards adopting C99 flexible-array members instead.
> 
> Transform zero-length array into flexible-array member in struct
> rxrpc_ackpacket.
> 
> Address the following warnings found with GCC-13 and
> -fstrict-flex-arrays=3 enabled:
> net/rxrpc/call_event.c:149:38: warning: array subscript i is outside array bounds of ‘uint8_t[0]’ {aka ‘unsigned char[]’} [-Warray-bounds=]
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> Link: https://github.com/KSPP/linux/issues/21
> Link: https://github.com/KSPP/linux/issues/263
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
