Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F239E6DB27E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjDGSIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjDGSIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:08:40 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F5FAF0D;
        Fri,  7 Apr 2023 11:08:34 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id bi31so31568717oib.9;
        Fri, 07 Apr 2023 11:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680890914; x=1683482914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyNeQjqjXmdCX5Ucvov2m/XFmLigHPT0qRyQLFkEqn8=;
        b=TNdSS3Yk8QukDtK86HPd/Qc2P2QkU8X3Na+0m3EtKGrSfCQcutWWJGtGO870giTKJb
         D+izeuDlG8xMPImwRiHKIWP0KJJ8t5O5c0yx4mNU7DTbcwTay1U4LZioZhtI3Me2sAqT
         xb2y8xszZ4LQhYUAGjIt99g17l49B6i44E3TASX0DRj4D+l3vMFF+3THFkcyAoEKsa0Z
         ylpUziCtBKKmgsFwuSkQYsEU01kVpsD5AD8v4daFRlMVEzEI/wggLpihlOJh/DHpGwFt
         mrl5gkQ/BSsC38P1pYxEMWVnnWu8sybbqN9cpn3TXKKZ9xDmrNJam9ua8LEPGxwO5hF1
         SVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680890914; x=1683482914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OyNeQjqjXmdCX5Ucvov2m/XFmLigHPT0qRyQLFkEqn8=;
        b=7PpkpbJz78P8dodGZ4NfW6toLSoyfh0DmkgO2kUw0sU3UXJi029dYmlMM/6Gvdi4Zu
         zNLpeDps3vUHERtW9bjVt5DzoFSH4DV/mO14VS1ebDOPVC/l4RDW53JGsKd0DmdTXULN
         iZMm+DTOeOAQeA0ccyZUHEIK6c01syUX6rV9VY+fShVLEvo66bxt7I7c9nvA543LxL3Y
         exphh0o9ZU0KoT1GW2olDHARdqCWVaO7SlZ8rFgpnrMZySkRbAYMeU0qmUCW662Kb5rY
         4bIpdCg9H1Bm2c3FMe7r7XlNfypqZsWtKc/6lYTpxn1gi92oahe1UnQCtZN3iy/MNhth
         QJmQ==
X-Gm-Message-State: AAQBX9fVhh42/T+TVHSa6GXaK5cfAs1Pv2/TcXZlBbOOdWIPJXMDKvvA
        4Dz8gJ9OVu7Tb3tfCOWILyk=
X-Google-Smtp-Source: AKy350ZPJGYf188pep6pTQAz0ddSy5x2ncHueGH1lsLIwzcQ23DP1hn7SRmnZ2Jr05GRhE8SbdbIjA==
X-Received: by 2002:a05:6808:351:b0:389:7d66:131a with SMTP id j17-20020a056808035100b003897d66131amr1433446oie.0.1680890914199;
        Fri, 07 Apr 2023 11:08:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o11-20020acaf00b000000b0037fa035f4f3sm1899688oih.53.2023.04.07.11.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 11:08:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 7 Apr 2023 11:08:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] media: i2c: video: constify pointers to
 hwmon_channel_info
Message-ID: <2294f1fa-019e-4278-804a-3a9ea807b23f@roeck-us.net>
References: <20230407150015.79715-1-krzysztof.kozlowski@linaro.org>
 <ZDBP7vG498h2FQ7N@valkosipuli.retiisi.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDBP7vG498h2FQ7N@valkosipuli.retiisi.eu>
X-Spam-Status: No, score=0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 08:16:30PM +0300, Sakari Ailus wrote:
> Hi Krzysztof,
> 
> On Fri, Apr 07, 2023 at 05:00:15PM +0200, Krzysztof Kozlowski wrote:
> > Statically allocated array of pointed to hwmon_channel_info can be made
> > const for safety.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > ---
> > 
> > This depends on hwmon core patch:
> > https://lore.kernel.org/all/20230406203103.3011503-2-krzysztof.kozlowski@linaro.org/
> > 
> > Therefore I propose this should also go via hwmon tree.
> 
> Works for me. Please add:
> 

But not for me. Krzysztof jumped the gun here a bit.
I do not feel comfortable applying patches for 10+ subsystem
branches through hwmon. This is asking for trouble.

I created a stable branch at
git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-const

which everyone may use to merge the pre-requisite patch, or wait until
after the next merge window. 

Guenter
