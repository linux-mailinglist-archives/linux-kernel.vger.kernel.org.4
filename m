Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7467D5F4222
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 13:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiJDLlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 07:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiJDLlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 07:41:45 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8C74E60A;
        Tue,  4 Oct 2022 04:41:43 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bp15so7244179lfb.13;
        Tue, 04 Oct 2022 04:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=w6aHeemfKJ2dWcTzYlwuaWCnO1Xf4PrC8flGzPMZQ1M=;
        b=NbJYQKJTpScov9Li3/wLZxcfyjdtxdMmZYmv9rmuj4nq4DoP3pPLGgfpHCvF9thEB/
         xd/jAB8eDpeYWAorhJA0uYQTrJRfHm2zJntLV0+G4AV7GO9fIFdpVWBDOm7l8rzjnEYc
         0qomOBRSkwqvBUVzogvuwb4XbHRXTI9u21RZlPOs+UUsQf0utgPjiAuBIs08IWohrraq
         +mfN5IuOKD6fjgYPtK6It0kWWbjxsToYXeGdChRQFqVsB96FxlNmHNfk6ArQHyU5aXfs
         2CWuhsnGN3EjRLP1399Mkqqze+w49UjIauB+AxBUYmhhGhr8Ab6uCVzJJi+ra0JNupYZ
         P2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=w6aHeemfKJ2dWcTzYlwuaWCnO1Xf4PrC8flGzPMZQ1M=;
        b=Pm/U++DwIXMEn4rTwc0VkJTNmv+1Hl0f4dWokzLvIaLkOP52Xc/nI5NwV9iU/rIwbh
         DID7kBIsj9hAyABQpMYPskbXVS+NbQtUAMFRHI7yZV/bCzweLI7QO1qo7IpA3rbC47OW
         ULrCTYit+zxTDIBp4bC53WIhXhl3oxAAV15DfKbth8b4WX+SWXr1nuIFzyGD+mrm9Ejf
         HmXPykmXD1qoyru4vzXr0OcyfgHL808QP6xAcxem1r0LRMEm/sXCvIPh63wnEYse/wel
         Abre9gMp1XCjhLvW1nECob+ggckRhjGlTV2HeGT9uwguRtTS5s4qlTMDBZ0Ikj7fdhJf
         Prfg==
X-Gm-Message-State: ACrzQf29GCi5omGLxxOQqzlRMSyuj6znbLnt1/p3ijJmbxXvFwFF81dR
        288XqS1f3Kny1iKE3iVHcnw=
X-Google-Smtp-Source: AMsMyM7Vd22SsoCN43V1pttf2L8dkOi5cIiC7r4XGhGCc7WTovFNjcSMK8FQvvQFobbD5HZgvZih6g==
X-Received: by 2002:a05:6512:6ce:b0:4a2:530a:33d0 with SMTP id u14-20020a05651206ce00b004a2530a33d0mr1027041lff.270.1664883701735;
        Tue, 04 Oct 2022 04:41:41 -0700 (PDT)
Received: from pc636 (host-90-235-28-118.mobileonline.telia.com. [90.235.28.118])
        by smtp.gmail.com with ESMTPSA id v2-20020ac25922000000b004949f7cbb6esm1882073lfi.79.2022.10.04.04.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 04:41:41 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 4 Oct 2022 13:41:38 +0200
To:     paulmck@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org, youssefesmat@google.com, surenb@google.com
Subject: Re: [PATCH v7 02/11] rcu: Make call_rcu() lazy to save power
Message-ID: <Yzwb8vgYhAvDJzK+@pc636>
References: <20221004024157.2470238-1-joel@joelfernandes.org>
 <20221004024157.2470238-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004024157.2470238-3-joel@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
>  		rcu_nocb_lock_irqsave(rdp, flags);
>  		lockdep_assert_held(&rdp->nocb_lock);
>  		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> -		if (bypass_ncbs &&
> +		lazy_ncbs = READ_ONCE(rdp->lazy_len);
> +
> +		if (bypass_ncbs && (lazy_ncbs == bypass_ncbs) &&
> +		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_till_flush) ||
> +		     bypass_ncbs > 2 * qhimark)) {
Do you know why we want double "qhimark" threshold? It is not only this
place, there are several. I am asking because it is not expected by the
user.

--
Uladzsislau Rezki
