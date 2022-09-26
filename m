Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1365EB40C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 00:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiIZWCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 18:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiIZWBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:01:47 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466C5E3EDA
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:01:43 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id a29so8029137pfk.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=jyUZYtxAtN1iTCX6RvQjDGcCuH9kvS5eYzROcFEThqY=;
        b=MzGhAq5OFEs2Jw3eI9RLQ+YxWhJkO64hQtgKbJilL0PzjLuQEVe9C+/uRy4PdTG8tz
         bG/i1MUi6O6fNF6xlb8WrrVfZWKq91jRdsDITIW/6qF8KZWGb0TzYKKhR/KIZDGttILa
         jSjcZeLBLVxe8wgx2SPAqVZWq/GXhl8HuDA9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=jyUZYtxAtN1iTCX6RvQjDGcCuH9kvS5eYzROcFEThqY=;
        b=rgxCHqxWMAMw8QhVJoC80Pycpf+tKD1K+BRRbzQzxrco7UngROrnUG2+YflXk2P5nW
         4J25U3VAmrkMQg8AWkFjKHEKbLQLUP0CwBTrhSNOv7kUJ34SobVPz9p4TYhC0qMyDgi3
         bBzCusjXTD5fjAbVswgQpY9KN2WTRlbOcHQbI8xmYYodpqyQ15JXeE/qR7YI9L+utLsi
         YExOO6O+XTSIr1ulRaXaVNgwn9qKaTQWGoxR7rXR6CMXa5CW4Pb5YimPlecQVyqb08W9
         D0y5ScKFjhQs7kYxED3ANLOys+Yig9pFNkBbkYnvCAQOlTJ/zjGSUnDAAk+66w3fb0M+
         U4AQ==
X-Gm-Message-State: ACrzQf0RmvckSnfDED0uM7pQUGkBG3l81HY9eGx2a7a4Gu4SXwvErh+2
        ypsnxE4WY98BCSz94SbnFdm15Q==
X-Google-Smtp-Source: AMsMyM74ae4NJ4uEWNYiyk2e2ui6FrMQMT3qMJP8N0KnVh3xSmJR82MhWuJadxiI/Ex1FCEuybYffw==
X-Received: by 2002:a63:91c8:0:b0:438:d55c:4484 with SMTP id l191-20020a6391c8000000b00438d55c4484mr21974518pge.157.1664229702792;
        Mon, 26 Sep 2022 15:01:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f1-20020a170902684100b00173cfb184c0sm11728552pln.32.2022.09.26.15.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 15:01:42 -0700 (PDT)
Date:   Mon, 26 Sep 2022 15:01:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] crypto: talitos - Replace zero-length arrays with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202209261501.D540C881@keescook>
References: <YzIdiQLXup1qtf6l@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIdiQLXup1qtf6l@work>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 04:45:45PM -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/216
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
