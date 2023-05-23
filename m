Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C3B70E3DE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237721AbjEWRcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236990AbjEWRcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:32:18 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23721E62
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:31:48 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d1a0d640cso22151b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684863105; x=1687455105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BsLdbOtWZqGDDhIfd5JSowpIYslTFlwc+eis5/CXhg4=;
        b=mjGZ222BMeABgspQ4C00XVzXG5HI5E5DX4AnVojL6fCi7mMtye2/kuf3yZCxyLNWpm
         8CewfWrrxrGpy8G5PCFtQRWfGQlLIpI7Oj5oZQwhtD140OXGZvb0tfuU0UiufDzMtL4T
         9J58eSM5hSaBbQnFUcCeZcWoIZa6L/1wBYE3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684863105; x=1687455105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsLdbOtWZqGDDhIfd5JSowpIYslTFlwc+eis5/CXhg4=;
        b=VJmDbOInZmqDIORK0v+UBbUzRhiif1S8Z1GZaQX8qFH9SrUER7TWhGrHGvZvqg6Btj
         xU9WPnsWIZHt+rG7mNQNOpSOpx/GwPHMR81GRlohaB6Hx6u6BvPnnb++97+wTiyiDLAX
         uejWW6XZcinpDaliXVPGM2xtV6KtmhuzcpEeq/u6Fgwkw0IgVYfOHRd3qNcrNPh/Autn
         zs+MOKfnV79uea0UmYV2wOCakd4cSneYh2SKyyunMj2XQrqeTgtHvwk6Q4UWHvgisQAF
         DVsDlXdQmFre/7deWmYrAEfnXj4fP9IdMAOSxDcHY2gSIams3g27nFlMFyL/VvNMquiJ
         GjaA==
X-Gm-Message-State: AC+VfDw1Anw0x5hnbpjdPk5uxE10aw8akGIL5jrl8ttCLr9iV8ibosvv
        mMFkh4zwPjwsS26umdTO3YwkMg==
X-Google-Smtp-Source: ACHHUZ4yKB8IpGx14IYy5bz+N/arqjLssi9jJEin6ZmCQLH3NCJpVHrJTIVD/nZQfE595frik+Pj5A==
X-Received: by 2002:a05:6a20:1590:b0:102:8f0a:5acf with SMTP id h16-20020a056a20159000b001028f0a5acfmr16420291pzj.62.1684863105011;
        Tue, 23 May 2023 10:31:45 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g13-20020aa7874d000000b0063f2a5a59d1sm6064087pfo.190.2023.05.23.10.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 10:31:44 -0700 (PDT)
Date:   Tue, 23 May 2023 10:31:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2][next] scsi: lpfc: Replace one-element array with
 flexible-array member
Message-ID: <202305231031.C9E6124@keescook>
References: <cover.1684358315.git.gustavoars@kernel.org>
 <6c6dcab88524c14c47fd06b9332bd96162656db5.1684358315.git.gustavoars@kernel.org>
 <yq11qj8nhy7.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq11qj8nhy7.fsf@ca-mkp.ca.oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 06:02:21PM -0400, Martin K. Petersen wrote:
> 
> Gustavo,
> 
> > One-element arrays are deprecated, and we are replacing them with flexible
> > array members instead. So, replace one-element arrays with flexible-array
> > members in a couple of structures, and refactor the rest of the code,
> > accordingly.
> >
> > This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> > routines on memcpy() and help us make progress towards globally
> > enabling -fstrict-flex-arrays=3 [1].
> >
> > This results in no differences in binary output.
> 
> Applied to 6.5/scsi-staging, thanks!

Martin, I think this patch is not right -- can you drop this from
staging for the moment?

-- 
Kees Cook
