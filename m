Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A78717115
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 00:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbjE3Wzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 18:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjE3Wzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 18:55:40 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DA2EC
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:55:39 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d341bdedcso3709526b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685487339; x=1688079339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BkBhxE3ytz2kF3tpYV9IN2L47NlunYx7yD1fvIugVDg=;
        b=JkL4TkmaBIayj5OCIMW991JmgQnj/gOpmqu0Jw8iYq3PMtBsrylqK5iciUUO1fhYgS
         2o7CARmlg2bDXlKcJclJ9S/L2d10IK4UribgkAI3rT5ddfJwfkzp232e3xf8cjAq3sQt
         imoZlKZvz+c0GKoP6pL6IeBJqKSiae+R/iNng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685487339; x=1688079339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkBhxE3ytz2kF3tpYV9IN2L47NlunYx7yD1fvIugVDg=;
        b=ganh58nfey4ZJ+Dag4rMYMBZfgSX25nu1ZrTVx/UUjIbOu/t74rDotPJIwYP18Gs4y
         ZUwaAXuaVob98ZtToBNl2KK2xjV51ce7HBFoJOJXYHrOkQaNj4noz/sXlH7x18pw4ICe
         03mIPAYu8A0ZJop8HTIAg8JDKLOYfi0fWg+sdTH0RCFe99vTP5OOpr3b8JIwCZXvBmeA
         ojXg8zhoRszuz+3SDtl/srPe4IJvuedawxqyKtlBNtQiVWTBTFXWLOrfFjBG8cxgrQxk
         9wimM84J1iFynqGHtfDRhDyPLgrvvSecIWWbnqcZyFyEv6djGCkdvsQtlYmtGOfnEqWz
         SFeQ==
X-Gm-Message-State: AC+VfDyymmQJuZL7TaFE7PXeQixvp1wBva8+1USZDcaQI7T9O92gMAiY
        W9pukv+O/xblTECpElGghFVSKA==
X-Google-Smtp-Source: ACHHUZ4QeCYlGPt+yRrQ988Mpa4bp68BlE3Y+Yn/n1L6hGlqQLXCt+xE8FWGrglyjI0IqtiDNi9FTQ==
X-Received: by 2002:a05:6a00:2e12:b0:640:defd:a6d5 with SMTP id fc18-20020a056a002e1200b00640defda6d5mr4441213pfb.12.1685487338720;
        Tue, 30 May 2023 15:55:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s22-20020a63dc16000000b005344b30d449sm9336232pgg.86.2023.05.30.15.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 15:55:38 -0700 (PDT)
Date:   Tue, 30 May 2023 15:55:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     John Johansen <john.johansen@canonical.com>
Cc:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] apparmor: aa_buffer: Convert 1-element array to flexible
 array
Message-ID: <202305301555.102E1890@keescook>
References: <20230511213441.never.401-kees@kernel.org>
 <7085879d-4d21-b90a-c08d-60450d1c7d38@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7085879d-4d21-b90a-c08d-60450d1c7d38@canonical.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 02:48:29PM -0700, John Johansen wrote:
> On 5/11/23 14:34, Kees Cook wrote:
> > In the ongoing effort to convert all fake flexible arrays to proper
> > flexible arrays, replace aa_buffer's 1-element "buffer" member with a
> > flexible array.
> > 
> > Cc: John Johansen <john.johansen@canonical.com>
> > Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > Cc: apparmor@lists.ubuntu.com
> > Cc: linux-security-module@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Acked-by: John Johansen <john.johansen@canonical.com>
> 
> I have pulled this into my tree.

Just a quick ping: I haven't seen this show up in -next yet...

-- 
Kees Cook
