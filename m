Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D716182A7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiKCPZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiKCPZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:25:42 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93FA1929C;
        Thu,  3 Nov 2022 08:25:41 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id m204so2308517oib.6;
        Thu, 03 Nov 2022 08:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w0yJDjVaa8CK7Zh+Yg+dLsD3M1CdI6efU1k/W84Y0cY=;
        b=QCO7sVUYL78hch9+q3cvlRDg4d/U8RF/+oi24omMzqJEmtq3vxjhMM9Om7UuaszObE
         LnaYtBwo17UylZ7xO3o8vK354lJszs+va/RVz3DW4qZip8bGPsX/KwlFr7v4pWg41UaO
         oDI2HiR5Lm7YSkDb8o/dGm23bmdtUSHFkP3DGrWCXEw20GJCXuZFOVD0MPY9/hseReWv
         XhWedlwyjmz+lDLtLGLjlYDDO18KHhmb5Ax+IUPU6tDtj4s5KzkUT1ilyvIkIMKOTxLm
         K5CVIb0LC7hG4ttcVoZNmiDMhV9WO2hLVTYdHeqOC1D6iOfnO26RxmqOPhFOibPzQN9Q
         viXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w0yJDjVaa8CK7Zh+Yg+dLsD3M1CdI6efU1k/W84Y0cY=;
        b=qgJcBxWKbHSL4ho5ytgEFVRP8HITcF/Nrq9p9l4244zwYNjCLlmfjpUrpmS+AgNoSE
         7zCjLRVKuvp5EjoVTpQYwKc+snMZwDyuwlewwqdSEGUdqk/9RgoPP+xU55Lz8Bzgr1Zu
         Rcj4noboY0TY8G1VW8WQRUdi49YfJ18XkwPCPTUb6J4T9QKZ3WY3tiNyfdSGanEj1owl
         jxU7efT3o/4bANhunMHEO4lRZ92x/Blcgl9I5Otz1QACeASvUjJFmdD4Vi9/4J1wU5Se
         MUTZYtYAAFmaL8qRAGA8+VAGqYLKzu617KELjZFkkoPuv7cHEsrfFigrJ5Rb0zlPBmiu
         LdLg==
X-Gm-Message-State: ACrzQf34OeWuBtWgvLpjJVtbeY3E01PMHetRqtETsmSqUzY1QWF+fnrM
        CnyD5RwXEvULkFXfxszK79w=
X-Google-Smtp-Source: AMsMyM6g/S5qAZyDD2vuIZei8r+THzEAk1XIMSlMdCfOBIj6hvZYkhmCQHBdVoWBBPm6K1jH8uP7sw==
X-Received: by 2002:aca:1c0c:0:b0:359:fb5e:727b with SMTP id c12-20020aca1c0c000000b00359fb5e727bmr14364409oic.132.1667489141178;
        Thu, 03 Nov 2022 08:25:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j16-20020a056830015000b00660fe564e12sm440647otp.58.2022.11.03.08.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 08:25:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 3 Nov 2022 08:25:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     wangkailong@jari.cn, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (amc6821) Fix unsigned expression compared with
 zero
Message-ID: <20221103152533.GB146501@roeck-us.net>
References: <1872639a.89.1843b5106aa.Coremail.wangkailong@jari.cn>
 <f699bbba-69e6-2e62-98ed-0482f4c9a900@infradead.org>
 <20221103141727.GA145042@roeck-us.net>
 <a530b209-36bd-c2c3-8196-a9c5001f6333@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a530b209-36bd-c2c3-8196-a9c5001f6333@infradead.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 08:03:35AM -0700, Randy Dunlap wrote:
> 
> 
> On 11/3/22 07:17, Guenter Roeck wrote:
> > On Wed, Nov 02, 2022 at 07:59:06PM -0700, Randy Dunlap wrote:
> >>
> >>
> >> On 11/2/22 19:27, wangkailong@jari.cn wrote:
> >>> Fix the following coccicheck warning:
> >>>
> >>> drivers/hwmon/amc6821.c:215: WARNING: Unsigned expression compared
> >>> with zero: reg > 0
> >>> drivers/hwmon/amc6821.c:228: WARNING: Unsigned expression compared
> >>> with zero: reg > 0
> >>>
> >>> Signed-off-by: KaiLong Wang <wangkailong@jari.cn>
> >>
> >> Hm. IDGI. What's wrong with comparing an unsigned value to > 0?
> >> I mean, it could be == 0 or > 0.
> >> Please explain.
> > 
> > I don't get it either. The real problem with this driver is that error
> > returns from i2c functions are not checked. However, that problem is not
> > fixed by this patch. That means the patch would change behavior without
> > fixing the actual problem.
> > 
> > I wonder what kind of (broken) compiler or analyzer produces above errors.
> > We'll have to watch out for similar broken "fixes".
> 
> It says above that it's a coccicheck warning.
> 

I see, unsigned_lesser_than_zero.cocci. It actually complains that an
unsigned variable is used to hold the return code of a function which
returns an int. In other words, it really tries to warn that the error
return code from that function is not or not properly checked.
The message is misleading for that situation.

Guenter
