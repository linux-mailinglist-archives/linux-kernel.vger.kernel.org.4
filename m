Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEBB73E60C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjFZROC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjFZROA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:14:00 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAF1E59
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 10:13:59 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b7ffab7ff1so7803605ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 10:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687799639; x=1690391639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rm5U58cD44+DDKBRtN3VxAo0yyecspa336dzUa4UwTo=;
        b=aI8AZTzdbTFTc9aZaQ69mXSrqJz8ntv6XBHtRuJ+ekDoeQx/KVIMC6vB47neSkI5oF
         dnjgxnIQvm1XAu5iMJYOq4IBHYDm6PUjtT7dMy4lUFvJ/g7rChURMmyy6RV5nNAP5H4S
         rDSeobE634bpdDnWPO3ofSQWJG+28O5xExYDD364r07q/d3osWRT1DYZ5++e1Jqks7Cd
         dxG8tPBivYmGQJJRG8sqwqr4FbLOHUEot8ByO4WZ+VYRMVk+9GuiTesNnYm0X2nj+n9l
         WHVYv7n+n/Z4HuJI5Bea2OLg71/lT8AGCQgllAlaQcWQFcgWzIcJdkXX3XXnV1LTf1iz
         TK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687799639; x=1690391639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rm5U58cD44+DDKBRtN3VxAo0yyecspa336dzUa4UwTo=;
        b=ibZwpCSFXMR71rC2pw3tArOCPL0HOl6u3puxQSGoE3SW6B5ykY/YefxT3WAyr72eTH
         8Yiy9QnJRdN1GX8Rt5rbtlOc5++iu3iVDq/EKI8pAVmJ6SLKLMNWcmCu6iFuQcN2PDjd
         EdEdFqSCE8XgP+Hr6BJ43B11pNT3bZova+YaGPwnFFMTl/KkXRHEiAVsecy8jL7gmBSl
         kxviFElI8XN9Ul78WXK4CpzMNr9cVMVA1yNUCF9uJG/nKOudxLuIX5sTCiBqKX+UVuhQ
         KaExyhd1Xka1TQYweB5B20KBCT0mDCK1W94xgVVeif4gsOiBBP6CppLAVfU5JQ5VI87V
         D8kw==
X-Gm-Message-State: AC+VfDy5W/tktz5p38HsR0Vf+9QkozJBHbnGwOFWSeSd7W/pQthChhva
        yZueT/sVxF9NZfNbmA/Ewu0=
X-Google-Smtp-Source: ACHHUZ7JmVx1FatMFel0fO+FJBp6+hDCsBp0wVFJcm3h+43QEylImVo9l2iKh7YSuk/loqj1b4H6tQ==
X-Received: by 2002:a17:903:228c:b0:1b3:e6ba:1575 with SMTP id b12-20020a170903228c00b001b3e6ba1575mr4788858plh.16.1687799639142;
        Mon, 26 Jun 2023 10:13:59 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:9abd:c54f:4c3a:e10a])
        by smtp.gmail.com with ESMTPSA id f1-20020a170902ab8100b001b80b428d4bsm1662026plr.67.2023.06.26.10.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 10:13:58 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 26 Jun 2023 10:13:56 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 2/3] zsmalloc: move migration destination zspage inuse
 check
Message-ID: <ZJnHVPifB6oFnYhl@google.com>
References: <20230624053120.643409-1-senozhatsky@chromium.org>
 <20230624053120.643409-3-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230624053120.643409-3-senozhatsky@chromium.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2023 at 02:12:15PM +0900, Sergey Senozhatsky wrote:
> Destination zspage fullness check need to be done after
> zs_object_copy() because that's where source and destination
> zspages fullness change.  Checking destination zspage fullness
> before zs_object_copy() may cause migration to loop through
> source zspage sub-pages scanning for allocate objects just to
> find out at the end that the destination zspage is full.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org> 
