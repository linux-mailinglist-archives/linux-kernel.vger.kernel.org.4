Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6254B72EBE7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237890AbjFMTZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjFMTZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:25:14 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACA7199B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:25:12 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-662f0feafb2so4337470b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686684312; x=1689276312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pF2h1PhbUZCakO9HzT4Rd+vAXkEtKn6aAJnn/Olzk7Y=;
        b=ZU3MjfCE6Bh7fjFg1BjEDJSesHastV05YBYNgqy41DzneH7oHeJm0hjPHEGpA+EXOf
         SG0w/KdxLi/052dMX5jl+FhfITGRS8mugUn3zKE3/eLMipX8oltrWHNWBmc0cN1ljQZj
         mHbEmFHWq7dz7xcNdDtR8r5WSwa8L+3oVanTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686684312; x=1689276312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pF2h1PhbUZCakO9HzT4Rd+vAXkEtKn6aAJnn/Olzk7Y=;
        b=DjRp8E1+YM8eQeH4ZhK8tQaMjX4/XPdrEIAx37s1zuJOo2d9O1lrAyto/hEqkrac4F
         9NWT1PCLbdHZ7zeOF+15NflcvXEkbXxqlOJaYRmbA5lDDISnBwXimb3oXzGP9CoDZ+xt
         DBsMXM0f+DEnLgFkFgB3V2RtwG0MVaIYiVLZ4Ld6jHfvV6QzJhYBvxKVtG/xmE3N3CXY
         McK7onYs5Du33pO8OoeP0IB7LDZr6ph/JaA304z0ThsjYJxOAjw08M6NWOAAxIMy0KYJ
         zEwCNAQ4rod5SbD2CZsXUcWZXZSBm29FPwgCOBk4g38B9dJt5ySfcvk3DnZdcW4DjJP0
         7ebw==
X-Gm-Message-State: AC+VfDy2GBZSvuxzIVI8lAc8LLXvasQeWUs4AuqTzOf6WBJu/fIK4DUn
        v4QWlQ2Xat/Sq0b1wRvQ/rtibA==
X-Google-Smtp-Source: ACHHUZ5PcTot62BlDuw88kgBfTRj1f+G5oPoENpd58CdgZFu8Kh7kup0ho97mveBi1GFUbg3BuXnpA==
X-Received: by 2002:a17:90a:d252:b0:25c:2a59:fb2d with SMTP id o18-20020a17090ad25200b0025c2a59fb2dmr1703066pjw.8.1686684312104;
        Tue, 13 Jun 2023 12:25:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a194300b00253305f36c4sm12184899pjh.18.2023.06.13.12.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 12:25:11 -0700 (PDT)
Date:   Tue, 13 Jun 2023 12:25:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-hardening@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] mac80211: Replace strlcpy with strscpy
Message-ID: <202306131225.1480125B66@keescook>
References: <20230613003404.3538524-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613003404.3538524-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 12:34:04AM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> Direct replacement is safe here since LOCAL_ASSIGN is only used by
> TRACE macros and the return values are ignored.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
