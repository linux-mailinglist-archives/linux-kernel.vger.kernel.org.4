Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0216D0016
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 11:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjC3JrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 05:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjC3Jqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 05:46:43 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1902D9020
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 02:46:13 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r11so74122472edd.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 02:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1680169570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lPgtvlf/qIcPSIDm9oie4jBONsd+NAifAYT84sgHmuU=;
        b=UAOZ8f5FgutdQdCpEMiKfWKeP5NfNwWFvCLsZ02lBz8DBAUgsP6Gk5XjLVhtoyghWF
         giCRsHrL2oDi5PRFsP+J2jXI9zfMWovn0FMyXo63XcklkF+4shxBMCoIcnLJldTgessy
         bc1pobCxt1PJqk9Wxqdg4srdVOgIAV72Do3fKCOAvFTX3JQOGLcE3CkhX2r6J9cEvZdN
         Z816itFG2QpyeI5SQPrRynyCuzTqSTcWFSqfDS+u/UEuHTtVb2ZyxgC0CmffKgGqTwyJ
         Jb4cbqo72aqghoHyFLuwkXz/GE7C0oG3mZv6qWqi4ZxidO2WpRpDLOg4Xdwse8bij6hF
         GkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680169570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPgtvlf/qIcPSIDm9oie4jBONsd+NAifAYT84sgHmuU=;
        b=s3GXbTHQ7yEAbT7XqdnPFInb4rf8MTBBOzmIXKaeZUmVMWlV2z+2GeCSnLHxj5FGsk
         4oTM/a+rU+pq0AjzcgtgkvWxMMR0JQ8AcrfVJqJqiNhUyNJjfxQPugDMl04A9avMSA2a
         z3Cp5C51oAHQlJu/4/NEtMyMKCW5oKCPsnc9bGK2ZoeKSxv1njF1A1Ql3wO3vjnYLjJ4
         IvMxRkLixiQ69aPxss4QbByl0SatR3E0b4sXOfL+ILGsMNMJdbAxeZEODavnYpyxbcLc
         L3u58uKImkEGp9PD39Lhu8j4OYJGzzLDcD6XZrnY5m/hT7dSGl4sS5td9pmFy9bnSgIl
         e7Pw==
X-Gm-Message-State: AAQBX9cpLNs7F0F2qCph9SDsB1GJ35j+c9D0e3hvcqbGgO8aaVuTIXb5
        jUHvdBi9Q2x0fDFvVfkuATMSxV/cjZu1/zPhXoHWFA==
X-Google-Smtp-Source: AKy350YwQTox/HJ1lOGaXvTEU6nrQP9MbYXFj9UA5+0pdBW//mgcPofpajDduOgwKKAnXNortfjcQg==
X-Received: by 2002:a17:906:54cc:b0:932:c315:b0d with SMTP id c12-20020a17090654cc00b00932c3150b0dmr22690353ejp.34.1680169570355;
        Thu, 30 Mar 2023 02:46:10 -0700 (PDT)
Received: from localhost ([2a02:8070:6387:ab20:5139:4abd:1194:8f0e])
        by smtp.gmail.com with ESMTPSA id h5-20020a50c385000000b004f9e6495f94sm18113646edf.50.2023.03.30.02.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 02:46:10 -0700 (PDT)
Date:   Thu, 30 Mar 2023 05:46:09 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        surenb@google.com, brauner@kernel.org, chris@chrisdown.name
Subject: Re: [PATCH v5 4/4] sched/psi: allow unprivileged polling of N*2s
 period
Message-ID: <ZCVaYYmPZsFmc+/1@cmpxchg.org>
References: <20230330081100.11871-1-cerasuolodomenico@gmail.com>
 <20230330081100.11871-5-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330081100.11871-5-cerasuolodomenico@gmail.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Domenico,

thanks, the destruction path looks right to me now.

On Thu, Mar 30, 2023 at 10:11:00AM +0200, Domenico Cerasuolo wrote:
> @@ -1319,11 +1353,16 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
>  		rcu_assign_pointer(group->rtpoll_task, task);
>  	}
>  
> -	list_add(&t->node, &group->rtpoll_triggers);
> -	group->rtpoll_min_period = min(group->rtpoll_min_period,
> -		div_u64(t->win.size, UPDATES_PER_WINDOW));
> -	group->rtpoll_nr_triggers[t->state]++;
> -	group->rtpoll_states |= (1 << t->state);
> +	if (privileged) {
> +		list_add(&t->node, &group->rtpoll_triggers);
> +		group->rtpoll_min_period = min(group->rtpoll_min_period,
> +			div_u64(t->win.size, UPDATES_PER_WINDOW));
> +		group->rtpoll_nr_triggers[t->state]++;
> +		group->rtpoll_states |= (1 << t->state);
> +	} else {
> +		list_add(&t->node, &group->avg_triggers);
> +		group->avg_nr_triggers[t->state]++;
> +	}
>  
>  	mutex_unlock(&group->rtpoll_trigger_lock);

But creation needs the same treatment. group->avg_triggers and
avg_nr_triggers are protected by the avgs_lock, not the
rtpoll_trigger_lock.

I suppose the lock taking and the group->rtpoll_task creation
(anything with rtpoll in the name, really) should be within a big

	if (privileged) {
		rtpoll_trigger_lock()
		kthread_create()
		init-and-link()
		rtpoll_trigger_unlock()
	} else {
		avgs_lock()
		...
	}
