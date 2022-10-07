Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DA75F7346
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 05:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiJGDUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 23:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJGDT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 23:19:28 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D545C1162D5
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 20:18:41 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id cn9so2151480qtb.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 20:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=+hx0EU2RLAQ3o5tIiwSkGGZgPKc+L+R/ZKiXk87Fu3E=;
        b=AND1wOuZI0nTKAtCUDz87miknuAd6bmCob6xc924Y3rQRZPw/R5flKAN5tM7t7GcFl
         5oIJP6V7YnA+avfVqNaHGDOlk+9fU+CHIiuW5kRF2VxZ6iVaInT1KmjUBArIQBVepprN
         WT7ov/4iWc953AsSTrb2Apb6yGOH36Be9oK6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=+hx0EU2RLAQ3o5tIiwSkGGZgPKc+L+R/ZKiXk87Fu3E=;
        b=0Y6KgOLndUxYfpBanGjdUbpo12801Q7tH8r4YtQv5nDglY/A0FOHgaeUIlQ2HM+lkY
         0BVrWywOnb3jUg3/76GwfZFC3OY4TjpTwvw/O73SA4FwPtttnrref2UNmTOC6TmoBkfX
         CZiVNvABblDUqtZJqNJYx26ImyrfKOiYeU1n2Vzba791U056vQ4qk0lJUieaTY9NXU5M
         kIo3R6+xfsFFMrFL0w/YZbjPeN1cVn+RItq/BMbmRwD/6AkIl3t7pkgIZtDvqIl5lIYQ
         FJEvrkYUzAbYGXio0zqvf/OaRZumawlYoNLZ4tt+bdI0YqWxSHKYVRrtvCTVOeQr0qKs
         DpXQ==
X-Gm-Message-State: ACrzQf1qBmOoCIbpkfPEg7kusQmvDVRrUO5c2YmL6rR2BCh2CzsngoWz
        wywaaEsjaa5J9gJ1Qcf5vI+iTglWrCHh0w==
X-Google-Smtp-Source: AMsMyM623f/v5fQ3Eu4rsyrUKGtIuGN8r83wpAvvv+pqkCkDXQjYBwYCmVaXDqjbZB6h5IYdX1z6iQ==
X-Received: by 2002:ac8:5f47:0:b0:394:7602:d9f0 with SMTP id y7-20020ac85f47000000b003947602d9f0mr2791965qta.683.1665112707253;
        Thu, 06 Oct 2022 20:18:27 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id u14-20020a37ab0e000000b006ced5d3f921sm832599qke.52.2022.10.06.20.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 20:18:26 -0700 (PDT)
Date:   Fri, 7 Oct 2022 03:18:26 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com
Subject: Re: [PATCH v7 10/11] scsi/scsi_error: Use call_rcu_flush() instead
 of call_rcu()
Message-ID: <Yz+agsJrvHg18FeC@google.com>
References: <20221004024157.2470238-1-joel@joelfernandes.org>
 <20221004024157.2470238-11-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004024157.2470238-11-joel@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 02:41:56AM +0000, Joel Fernandes (Google) wrote:
> From: Uladzislau Rezki <urezki@gmail.com>
> 
> Slow boot time is seen on KVM running typical Linux distributions due to
> SCSI layer calling call_rcu(). Recent changes to save power may be
> causing this slowness. Using call_rcu_flush() fixes the issue and brings
> the boot time back to what it originally was. Convert it.
> 
> Signed-off-by: Uladzislau Rezki <urezki@gmail.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

And I successfully setup Debian on KVM and verified that this fixes it, so
now I have a nice reproducible rig for my
'lazy-callback-doing-a-wakeup-detector' (I wrote half the detector thanks to
ideas from Steve, and will finish the other half tomorrow or so).

Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> ---
>  drivers/scsi/scsi_error.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> index 448748e3fba5..a56cfd612e3a 100644
> --- a/drivers/scsi/scsi_error.c
> +++ b/drivers/scsi/scsi_error.c
> @@ -312,7 +312,7 @@ void scsi_eh_scmd_add(struct scsi_cmnd *scmd)
>  	 * Ensure that all tasks observe the host state change before the
>  	 * host_failed change.
>  	 */
> -	call_rcu(&scmd->rcu, scsi_eh_inc_host_failed);
> +	call_rcu_flush(&scmd->rcu, scsi_eh_inc_host_failed);
>  }
>  
>  /**
> -- 
> 2.38.0.rc1.362.ged0d419d3c-goog
> 
