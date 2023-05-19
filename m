Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5DD70979B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 14:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjESMxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 08:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbjESMxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 08:53:14 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A557A18D;
        Fri, 19 May 2023 05:53:12 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64d247a023aso1209218b3a.2;
        Fri, 19 May 2023 05:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684500792; x=1687092792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SlSC5gAlSXnToYmUu/sgOcjEykIkE6DHvgXD5U+xj54=;
        b=UKWj7gNY5FT++SNCrJYnd72T2NQPNrNjWaOs177/qY+jyyfHtrmrZd72vqIK6TiG9U
         Jqf/1SnX9JtFEijWoaAGnExRyaSKJAn28O5z0G7LSx5aX3tqrzeAwTFB4EzKd1PIcLRP
         7DP5ioH8rS0OHVXMh4N8wCO7yRY01o+w2zmf4cvl+x4Y/DE93aFl/ySg2IYx4b56AeKR
         Q7/u9kT42KoiEWXdTUZ/2TPfvKDKb4nwx8KOO21qIcYZCSEev23pKPykelI61zzu7fZW
         G6Va7s/4Ag0udzUVWJqIYb8fTryqTZxPTqw54iB4SMs49l3Ng4Ifg9YCKHU4mm87Q4o4
         d4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684500792; x=1687092792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SlSC5gAlSXnToYmUu/sgOcjEykIkE6DHvgXD5U+xj54=;
        b=JbhoTvXF3ubMDMCqb7pK+iHorbEk6ZMeJeGIC5aXyc5jfl/S7X3JLCb9Zv3d4j6PZn
         mzLvPCAhcBD8aJw2w7qqHmKXppPf8Bhkcj90S+9Yk3Vve2XOpI0rlCYhOADKxn43/GS+
         KMNEOODv9D9vqD1w/yCLtc7FMA3af6P7csUP3fCC7sIVA6FuPu74ikN8DsbxZ4bTE23i
         vaAT9K4mao2CiRSanXxUizNtjcDT3UvfoT40isIPpWQZTsDBFoaS9TiGQhf0E323W8n7
         nXIHrCEMHupKunxXXLqHPG7q2y8v1/9ZwYHfqooeCloTCMq3YhYi3vIu6DaIehvFh+1p
         XL1g==
X-Gm-Message-State: AC+VfDzxjixcVbFwVl8S3rQu8KW+bPOlbbHzJnXwqoL4HRhgfc28PL52
        0CxwbHjCUssWAC6u9dwXQRfjADRVoH4=
X-Google-Smtp-Source: ACHHUZ66Dg61w6FuRrM+Q0rw453FF2MyRAWuWHW54C6TTdb3852VDU1T0wgnbihGbF6BaYDoOaS7Pg==
X-Received: by 2002:a05:6a20:2d23:b0:106:bb67:d684 with SMTP id g35-20020a056a202d2300b00106bb67d684mr2075822pzl.42.1684500791984;
        Fri, 19 May 2023 05:53:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f2-20020a655502000000b0051baf3f1b3esm2763663pgr.76.2023.05.19.05.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 05:53:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 19 May 2023 05:53:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Gopal Prasad <llyyr.public@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (nct6683) Add another customer ID for NCT6687D
 sensor chip on some MSI boards.
Message-ID: <f7b24380-cbb1-410b-9507-006c142c41b0@roeck-us.net>
References: <20230517042025.16942-1-llyyr.public@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517042025.16942-1-llyyr.public@gmail.com>
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

On Wed, May 17, 2023 at 09:50:25AM +0530, Gopal Prasad wrote:
> From: llyyr <llyyr.public@gmail.com>
> 

The above is still wrong. Never mind, I fixed that.

> This value was found on a MSI Z690-A PRO DDR5 with NCT6687D.
> 
> Signed-off-by: Gopal Prasad <llyyr.public@gmail.com>

Applied. In the future, please version your patches and provide
change logs.

Thanks,
Guenter
