Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43996E0A51
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjDMJea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjDMJe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:34:27 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2812E6EB7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 02:34:26 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id s12so5084280wrb.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 02:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681378464; x=1683970464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EgPI3gMFMJEkAVADKRKSeSLuWmFN3Bcqi6q46VgRbTA=;
        b=JFWqqQBu8G5gyyjXXDCP43dCBt/tUf9DdkbxPWRKp18d12TOj45oCjHZXqABhYgHN+
         C7N0nXnmz2C2spc++Xe1FFlF5hrjnAYJnfmmaF3GyZBf49QCqhbDVRrhdfE9PuuWgfJT
         977UPgd6Aj92JJa3ck9tIhBTTf6AmU4hGsYGeJVGDAzQHWgdNN7qQmkG3b6AjueGBfFd
         XsR8UqakRmH/qBW0VuLiLGcjWJZcfL0AZ9sROjFCm7QQF9SYgvH7bx6IwlLNNJaq55Bf
         Bd8nxdI1IsEUiy21+CL0qj/TrNODhltA4F4CjgCGFaSILjGUdJXiYDuLeY0mVV2/Svc/
         HB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681378464; x=1683970464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgPI3gMFMJEkAVADKRKSeSLuWmFN3Bcqi6q46VgRbTA=;
        b=NyvI3eVXKrQsqubjND0z93J5qoXL/y7dtcwGt7jMNzD04w9HCH4fdNML+NrJ/L+QHP
         rzKZCITwiUmuRb8x2dpedVvGay4vsmRqXAG2Y6YVoGF/tKqd414YcqBo2xZ2xwvh6v5c
         utYdlwrLL5W+OeylDierDldAdZEuOHXK86a8pSaBhZKO7lRxScbqSGlT2lVxGyD74JFG
         RWaYlByqtYcpZiC34RNi0ec/qZRrd5KupnuqZO3kSEW4/E8bdMOkTRCHJvgHXbSlOI61
         G304FSbqLugRhsqfsFJpdYMs0Bo4fk6wo78WQ7pQL/lZxP1sDThbSQDRhMihjhXrvRi4
         Vquw==
X-Gm-Message-State: AAQBX9eAXUJIQnypB67WxAzSFuAw2SXPpXmGxfgOEFUdtEL6fkC/Oasb
        HlfQUezwI9+mwacVi/4lJRFkTgdTK78=
X-Google-Smtp-Source: AKy350aPY+Add69Yo0JYmqkazACQr3ccWteMx5Yc6vXPq40qd7bw4l7wVUHyG2x0kTTH+ksosS1nLQ==
X-Received: by 2002:adf:ef03:0:b0:2ef:ba57:ee2d with SMTP id e3-20020adfef03000000b002efba57ee2dmr1037772wro.51.1681378464532;
        Thu, 13 Apr 2023 02:34:24 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h8-20020adfe988000000b002efdf3e5be0sm883657wrm.44.2023.04.13.02.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 02:34:24 -0700 (PDT)
Date:   Thu, 13 Apr 2023 12:34:15 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [BUG] staging: rtl8192e: W_DISABLE# does not work after
 stop/start
Message-ID: <3f71b782-e52e-48cb-9a41-4097a3329ae3@kili.mountain>
References: <39dc735c-fd6d-e405-856c-788a52704d63@gmail.com>
 <248ec330-b4c3-aa7b-61eb-69ce8d333b69@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <248ec330-b4c3-aa7b-61eb-69ce8d333b69@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 11:02:05PM +0200, Philipp Hortmann wrote:
> When loading the driver for rtl8192e, the W_DISABLE# switch is working as
> intended. But when the WLAN is turned off in software and then turned on
> again the W_DISABLE# does not work anymore.
> 
> Reason for this is that in the function _rtl92e_dm_check_rf_ctrl_gpio()
> checking this every two seconds is an conditional return.
> 
> 	if (priv->bfirst_after_down) {
> 		priv->bfirst_after_down = true; // PH: useless line
> 		return;
> 	}
> 
> 	tmp1byte = rtl92e_readb(dev, GPI); // PH: GPI for W_DISABLE#
> 
> bfirst_after_down is set true when switching the WLAN off in software. But
> it is not set to false again when WLAN is turned on again.
> 

Is there a question here?  You're like the expert on this driver and you
seem to have figured out the solution...  I'm confused.

regards,
dan carpenter

