Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F586249C9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiKJSnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbiKJSnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:43:42 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968FB4D5D6;
        Thu, 10 Nov 2022 10:43:40 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so5608382pji.1;
        Thu, 10 Nov 2022 10:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=22YGope30CxF7wnVmBb+CTalfb7AH2KrLU5E8OfBKac=;
        b=JLqW4kbVWsuJMYd5cdg36682lQ0/NEVZqL1sTDhIb1X9vNr6vsuin+yExuQl8tf2PT
         ir3Ed76BVJJiJyCtVPoF2wM7bEu5TgeSKf8wLmKQ9uSeOguOMs6iWbTXbDqkr0YQhnCP
         5+JMtKmGVD5fbv0VtFjctZNN3+DYWLmLh1ejjg229+PuyMeq9/0C8/9mkjK5V9fhMb0x
         bQwIyiF7xniwNpB8eWKdR/scD5hCYlh2XDDfCpMSlXjD3TFrazFJMSD46ICSp/Anwy0M
         air/6GMTEJT58ZPuiqF4zDylweFrQBfPH9roo/Gy89ioHUAV0pY1vhK0pPcI4tO21fQ/
         BHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22YGope30CxF7wnVmBb+CTalfb7AH2KrLU5E8OfBKac=;
        b=qNyB3QMSTXQVAE1391/X8+axGhJRFnaiTVIXhYWCjZlyejS5fJ7hxEsVM64x3708ds
         wdPExTq1Gbpelm//uvkabq3JDhpXxxHBDu8tItTQBgyCh2OWBlxNcbCj7FKUtdyqr7us
         GRJTYNrIUg3I+cleNEPf5LEaXFl29kJK/jeOEl0xlvpqvuJsgVVul9Hoqc1gEDcMjESi
         mNP7GiWLEhLRU3v9V11wdd/DwWmYCYobP4KlxjTLwKjqcZLcI30p/xl629ddpyVejlJJ
         cobLpgadmsvfmyMqjT4zU1e/PNEnNeeg5QP/ed7kDLGDGbiyFPvcVd5YYb3AnZnx8HNU
         GpwQ==
X-Gm-Message-State: ACrzQf17+GNquRN2UmNlx1uLRTYsJQBFAU+5NXtBPQNPU7OYryVODMyM
        pxVtI3zbUMFl8W/B57xHG5Y=
X-Google-Smtp-Source: AMsMyM5TtsbNMXCaivVZ5520UewhwiuAAw6tUsmUDAkOKJrPlDl4EbJ7RCbVXsg4DU4dw+pasfm7aA==
X-Received: by 2002:a17:902:f78b:b0:17f:9c94:b247 with SMTP id q11-20020a170902f78b00b0017f9c94b247mr63376926pln.137.1668105819894;
        Thu, 10 Nov 2022 10:43:39 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:6af4:9e55:5482:c0de])
        by smtp.gmail.com with ESMTPSA id t12-20020a17090abc4c00b0020669c8bd87sm129413pjv.36.2022.11.10.10.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 10:43:39 -0800 (PST)
Date:   Thu, 10 Nov 2022 10:43:36 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: Fix NULL vs IS_ERR checking for
 module_get_next_page
Message-ID: <Y21GWE/AGbr2pmjm@google.com>
References: <20221110025834.1624394-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110025834.1624394-1-linmq006@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 06:58:34AM +0400, Miaoqian Lin wrote:
> The module_get_next_page() function return error pointers on error
> instead of NULL.
> Use IS_ERR() to check the return value to fix this.
> 
> Fixes: b1ae6dc41eaa ("module: add in-kernel support for decompressing")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thank you for spotting this.

-- 
Dmitry
