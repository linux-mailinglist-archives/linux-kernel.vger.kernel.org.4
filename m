Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5300705811
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 21:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjEPT4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 15:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjEPT4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 15:56:31 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FAEBF;
        Tue, 16 May 2023 12:56:23 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-52cbd7d0c37so8632422a12.3;
        Tue, 16 May 2023 12:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684266983; x=1686858983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ECtJdgJfH2s001rdU3aqL8iJMS6YphxwR2iWhytmgc=;
        b=F5MtMCsdGttgWNrYF01YFVXc7FQQ6JrkXRzxq66obxeH6kttagpKDHcvalKH9ig08l
         BZWQ9Nb6h2d3kgf7ubeSnewQUtidG5xeD+fTh3c3k5DtjOgJV5PRPaSz4lpbfIR4kTXg
         zvfpLOz0FBHJ4KbtI6uYZdMsF8lxsorwN8cwmbxSGmjunwSNzcOf5nXl4FUZ1GQvO0V5
         drx7+khwbPFZfGcxb/uC+pT7BTXFg9y/LtEsENZsDvLk6tAwnMKnxvXthaHrBCx1Go3T
         EchUyhhx0KmgrPpVaJwl4qboAAahXXxBmccuBk5l6ZaygMN6qlRjjd2zO4M1kuSkNLyp
         vRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684266983; x=1686858983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ECtJdgJfH2s001rdU3aqL8iJMS6YphxwR2iWhytmgc=;
        b=asD2tOMwXC2wBqc5onwDaavfo7JSq7Rnl1tGBvlRpkqNtowLWV597FgLsJ31ieyf3Q
         M+Rzgo+Zem8p7ShSDjYu2+p1PnKps0P/pJQCdX341OxvARMuIcMZRtttDgeqk2EP1b5q
         Z/ugJXrlJ8ch6frvECo56QQn5bQ8QcJDVsEbUZnB9HLXr3y5yxpcJ6vWmAyX05o8Oizb
         j5kYG0ZeEtNLra1kb3flX6/3rMqioHjS2zng/gNq2LmIspvWHOnaY+IzF7zaOzXU//8m
         9WaVpSh9rYb0SHz3fKmykDG43Xe+hrFcZc1eg6r0iE3yyH5iV/l9rBPzrHUHMniuz2b8
         u73A==
X-Gm-Message-State: AC+VfDxMlg/azAp+eT7cvsGHKxDisrUEaTEHZR8qIoY2Yy1wn2Nq4lWe
        ZqAkd2sjBP1LOWKwY0kXW3o=
X-Google-Smtp-Source: ACHHUZ6xsXmRm4VZmKh7AOS5xctPG/BSjfiWPphLJnS6kQn43K3wIy8xv0ATtZSNeqAHgX87GY48rg==
X-Received: by 2002:a05:6a20:840a:b0:f1:8f7:eeb6 with SMTP id c10-20020a056a20840a00b000f108f7eeb6mr51589883pzd.59.1684266982734;
        Tue, 16 May 2023 12:56:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x13-20020aa7918d000000b0064858e255d1sm11405964pfa.65.2023.05.16.12.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 12:56:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 16 May 2023 12:56:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     llyyr <llyyr.public@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (nct6683) Add another customer ID for NCT6687D
 sensor chip on some MSI boards.
Message-ID: <b1ab3a54-2dc3-4e21-bb64-6db82736d682@roeck-us.net>
References: <20230515144910.13514-1-llyyr.public@gmail.com>
 <54471eb9-3cd0-429d-b652-07fd380f359d@roeck-us.net>
 <b9999e76-357f-44c3-23a0-f1554ceb11af@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9999e76-357f-44c3-23a0-f1554ceb11af@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 02:22:55AM +0530, llyyr wrote:
> On 5/16/23 00:29, Guenter Roeck wrote:
> > On Mon, May 15, 2023 at 08:19:10PM +0530, llyyr wrote:
> > > This value was found on a MSI Z690-A PRO DDR5 with NCT6687D.
> > > 
> > > Signed-off-by: llyyr <llyyr.public@gmail.com>
> > 
> > This needs to be a real name.
> > 
> > Guenter
> > 
> 
> Do I need to resubmit the patch, or can you change it to Gopal Prasad then?
> 

Please resubmit.

Guenter
