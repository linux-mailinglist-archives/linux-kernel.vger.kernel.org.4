Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0606B3ED7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 13:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjCJMLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 07:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjCJMKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 07:10:37 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8212A18AA1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 04:10:04 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c18so3228808wmr.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 04:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678450203;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TUAuSSPihufsLwgjlVUlKLuXucoFIBlJ+9NyNxEoo98=;
        b=ZESYpzUhv7+DuMbIjF977hrg9hstxGIBskEMYk5RCkD8E5uUg/0ZNbjW/iE1lv6pOP
         6nu9fydk1vICd+WfgHAydze4VtPWdXdTnCZ2YKi9i8Z3QnOkvIfsg3Rju5IzbFgcgeG2
         SV0eZe+wc8YK6F5rAqFuTFJl60lgy55GG/EHOXeb/GcJip04jmf6Ed5YPJA/sVF0IFvL
         yPQH2KxZSgx0TT70gWk5ZQ/c+pQeCuC14wpXR9JJrWJD/fU9tgcbm7f1fvDeUGJkzNWc
         duTOjJJX7YoIVBNhTHoTSADtfcHHotsPkyX28Tgi2O9W+s7sXsUYZVHLd75SXK9ejEx4
         w++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678450203;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TUAuSSPihufsLwgjlVUlKLuXucoFIBlJ+9NyNxEoo98=;
        b=o6X+Q4Si1sIVo/HVoC0/0jfYPyOyu6Ucb2JVKkiezqDzQx7uujeyy41uv4XQC0/L+O
         Lf91A/xqPk0bZZ8esVLZvVbtX+QKH9hT6bWr7JSuKj901NoUqN27BgflgCAO1+9RWyzB
         sFiBXVkGKIWY6llMemkeAeX+2cqCo64jDhu9Iq0JrhFpBRxZANNHQ8+ITT/timWglMq0
         UqtkqUQy0vMJrMvW+Fqbh6RmM0gJ9QHO4UHjOVVHPSDEFTXcJhZ0zwO6KWtQTf813FS3
         seC+yr9kPStjqzIfNVqagCeKwtwgAIhz0TMzNh7kuzFsLy796g7jqkjW5ZQn0GaU8Qz+
         b0sg==
X-Gm-Message-State: AO0yUKWX4hJ0MyIqwzgI4E81ZS2iJ5zWl66YAwW/A881vtJnsWqO8pKJ
        Hl8ZCzLXkz7wABCIu853czk=
X-Google-Smtp-Source: AK7set9drKQBOGo1Ki4CARaraRy7/TexN2tg5PXXGGfnbPbHcQ5aYlYlVu2CBKstMtd0qhXarFjKRQ==
X-Received: by 2002:a05:600c:524f:b0:3e2:5c3:bcfc with SMTP id fc15-20020a05600c524f00b003e205c3bcfcmr2534635wmb.18.1678450202989;
        Fri, 10 Mar 2023 04:10:02 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id y10-20020a7bcd8a000000b003eb5a0873e0sm1907730wmj.39.2023.03.10.04.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 04:10:02 -0800 (PST)
Date:   Fri, 10 Mar 2023 15:09:54 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Khadija Kamran <kamrankhadijadj@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        paskripkin@gmail.com, gregkh@linuxfoundation.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] Staging: r8188eu: Fixed block comment
Message-ID: <bb4e7ac8-5ddf-46c7-8c5a-08839794c5d0@kili.mountain>
References: <Y+8p7Hyaf4LhO/Sw@khadija-virtual-machine>
 <10238267.qUNvkh4Gvn@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10238267.qUNvkh4Gvn@suse>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 12:52:55PM +0100, Fabio M. De Francesco wrote:
> On venerdì 17 febbraio 2023 08:17:00 CET Khadija Kamran wrote:
> > Fixed block comment by adding '*' in each line. The Check message was
> > shown by using checkpatch.pl script.
> > 
> > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > ---
> >  drivers/staging/r8188eu/core/rtw_br_ext.c | 19 ++++++++++---------
> >  1 file changed, 10 insertions(+), 9 deletions(-)
> > 
> 
> Hi Khadija,
> 
> As Greg said this driver is not here any longer. This makes me think that you 
> forgot at least two things...
> 
> 1) Please pull and rebase the staging tree every day while working on patches 
> during this period of the Outreachy project. If you had done so, you would 
> have noticed that your patch cannot any more be applied.

This patch was sent long before the driver was deleted...  The patch was
fine and would have been applied if the driver hadn't been removed.

regards,
dan carpenter

