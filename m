Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F2870E7C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbjEWVqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238682AbjEWVqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:46:47 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D725F119;
        Tue, 23 May 2023 14:46:46 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64d293746e0so19874b3a.2;
        Tue, 23 May 2023 14:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684878406; x=1687470406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EPUHuPEdS1O9T/6qdNTmqpTzsbixnf5MzsB/1qIuHjA=;
        b=ZyLwvXIXAoTy0w71K3zjkqPULZ6EimCFq9xm4oqr3pwXBWfDcPE6xq3SwY80LP/tr4
         hQ7BD/gSX+QDa8LGx6E8viSOy7OWkNTRjMImLwj75qrAmsZzkFM5FfrSZysh5E+WWxO4
         kItws/5Gm6Xhxc+1Y5j524Aw0Oc9GdWXp7+aasGbSfL+GmhVmHwNGVsu0TXpMRveRAUw
         E8/O+aYzOetG6AozzS2haLTEbDX3pap83/qSt9aabb/gAwfaQWAXg+y4u2hL4DakGsdH
         zjs6fNgPX2/Nw43w+DdUyEZ/r4vgLcuXhBe6pAanRseX6hppPY2/JQveKqvH8yDTXZVa
         RnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684878406; x=1687470406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPUHuPEdS1O9T/6qdNTmqpTzsbixnf5MzsB/1qIuHjA=;
        b=Dn2Gh3BVC5aclvB1LyRP8cbaC7BlWkCnuN5g7GzBYVBzuPbZlKqreJf3i8cV2hZvBk
         AUB/eSRfxB/NVIbUQDoJSZoCrdRfq9R2RR/02U1Zguo5eywg27LfM5hcyo3VrPO3ablT
         1nxXQBypeZyVUmcVQ2Ic/VQ01h76+pUnluRxnrZIvRM1ej05heptNHnOfoBHngXywq4j
         oPP0VWDZwpDt3aPV4Ai9AyglTSnagsEZiRwaOTUjA3ONTJkmSlJqQMAvLWGUfqd+mSUR
         SCGCS0CcVYlesVznxGbCkAqG2NRr0Vp6fQabMVFJsm3MNFeJdzlRJlQfp9aFkDzDyosY
         BNdA==
X-Gm-Message-State: AC+VfDzXHorxkyu1z3ZNF3hvlfcnEtZEbSevn8921bKLgBdMqc9nnIGt
        6ZUG2VxNXeigbuhJFjX88vbneQbT8oo=
X-Google-Smtp-Source: ACHHUZ4iRH+7sX3dPJCiTFvyLNH85ASD3kZKS3pL1C7nh6cZtltSqQpfToZy1SkAji9b4hLTIwb0DA==
X-Received: by 2002:a05:6a20:3d0c:b0:104:1f67:1157 with SMTP id y12-20020a056a203d0c00b001041f671157mr18267140pzi.26.1684878406159;
        Tue, 23 May 2023 14:46:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u12-20020a170902bf4c00b001ac7ab3e7ecsm7191269pls.210.2023.05.23.14.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 14:46:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 23 May 2023 14:46:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Baskaran Kannan <Baski.Kannan@amd.com>
Cc:     babu.moger@amd.com, clemens@ladisch.de, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (k10temp) Report negative temperatures
Message-ID: <68c53a76-efd5-42da-af98-442bd80c7300@roeck-us.net>
References: <20230523204932.2679-1-Baski.Kannan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523204932.2679-1-Baski.Kannan@amd.com>
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

On Tue, May 23, 2023 at 03:49:32PM -0500, Baskaran Kannan wrote:
> Currently, the tctl and die temperatures are rounded off to zero
> if they are less than 0. There are industrial processors which work
> below zero.

This was introduced with commit aef17ca12719 ("hwmon: (k10temp) Only apply
temperature offset if result is positive"). This patch would effecively
revert that change. Given the reason for introducing it I am not convinced
that it is a good idea to unconditionally revert it.

Guenter

> 
> To display the correct temperature remove the rounding off.
> 
> Signed-off-by: Baskaran Kannan <Baski.Kannan@amd.com>
> ---
>  drivers/hwmon/k10temp.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index 7b177b9fbb09..489ad0b1bc74 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -204,13 +204,9 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
>  		switch (channel) {
>  		case 0:		/* Tctl */
>  			*val = get_raw_temp(data);
> -			if (*val < 0)
> -				*val = 0;
>  			break;
>  		case 1:		/* Tdie */
>  			*val = get_raw_temp(data) - data->temp_offset;
> -			if (*val < 0)
> -				*val = 0;
>  			break;
>  		case 2 ... 13:		/* Tccd{1-12} */
>  			amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
> -- 
> 2.25.1
> 
