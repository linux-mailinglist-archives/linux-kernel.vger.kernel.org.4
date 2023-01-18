Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA3F672931
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 21:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjARUWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 15:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjARUWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:22:42 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34744CE70
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:22:41 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id tz11so277252ejc.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z31UZq+ra6dwYLRmeWNfidrgM6CkETt8j45PwUnj6/E=;
        b=q4HWs4kLOPSjUxzD//Ilw6Io9iWHzeJddygOJyk5I4Dl3cra3ZbmNUyvG9+02N6yG9
         iHwHlDfv4FnOMqQAO4VPV8GowY/5vwqvbmcdqZm9JxJlZn75CLjq2RZ861R+37GsH3w2
         8pu8z3+mbf4rOqrbs1d0CPVTIHOuuS1eoRSFnjbdEkXve6IA5yOpj0WcpiuH59WE+ac9
         HS/t71Pko92qXz7WYPddxL5TdjrxRGiwAnHnkB4FY22BxH5QnFW5NsLYK0v6QNRRSO1U
         Gt0eB/CLEQlZkTemVbwTs6Rg22/LzsxJZOKLguRkVrXjBerFAb4ClnMhq5pYLfERvVX9
         c+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z31UZq+ra6dwYLRmeWNfidrgM6CkETt8j45PwUnj6/E=;
        b=fP7WflFuy+Nu0bdYzgTm97ptRrp/tA1+a4H45agroxnxo/hwKGRSW8kvz3FazO5kkW
         ntlAtCq1FOAr9udMLO/ZXXYDBaG8A+DVCte/XUT5FStKGRlmFeOMOm5v7XJfrV+iNDFq
         H4Tznb5rYti7ZIf7qcQ+OS5tC+F3QZVg7Y3ykGLhBrtzJVngYMO9/uSpAqC+r8MQsdNS
         gC7jF1I0RUT5pbXyNU7LXwl0uRJQlCP+RCUaImCsoG/yzqRVyPSQ70phNhxOb/O+ZewF
         PDrYrgQFfY9fSquVZ4GS5K6wD9fI56iOl15+xEYJJqx2rsIYEXANCF0N84BMzVh2xH/B
         OWgA==
X-Gm-Message-State: AFqh2koswwGWsiyBWThxINfn2LT9Q7V4IHF4e5sdlnLkNaEhH9mlMmHW
        w08xJJ3TN01MM/Az+TYlC4JpwjQviQILQg==
X-Google-Smtp-Source: AMrXdXsTyWs+GUs4TPHP1xlHkQpFRozMQYxo3a0Wuzv/EMcENC5Dh+3mtsinlohB+uZ6YAWMQuS0Ug==
X-Received: by 2002:a17:907:a4c6:b0:86f:1283:7b1d with SMTP id vq6-20020a170907a4c600b0086f12837b1dmr4909243ejc.71.1674073360194;
        Wed, 18 Jan 2023 12:22:40 -0800 (PST)
Received: from andrea (host-95-251-43-234.retail.telecomitalia.it. [95.251.43.234])
        by smtp.gmail.com with ESMTPSA id ec20-20020a170906b6d400b007c0f5d6f754sm15268421ejb.79.2023.01.18.12.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 12:22:39 -0800 (PST)
Date:   Wed, 18 Jan 2023 21:22:35 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        paulmck@kernel.org, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org, urezki@gmail.com,
        quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/memory-model: Make ppo a subrelation of po
Message-ID: <Y8hS5iq2+vbcYlkT@andrea>
References: <20230117193159.22816-1-jonas.oberhauser@huaweicloud.com>
 <Y8hN7vs/w8LhMasT@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8hN7vs/w8LhMasT@rowland.harvard.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It would be nice here to have a separate term for a potentially 
> cross-CPU fence.
> 
> In fact, why don't we make a concerted effort to straighten out the 
> terminology more fully?  Now seems like a good time to do it.
> 
> To begin with, let's be more careful about the difference between an 
> order-inducing object (an event or pair of events) and the relation of 
> being ordered by such an object.  For instance, given:
> 
> 	A: WRITE_ONCE(x, 1);
> 	B: smp_mb();
> 	C: r1 = READ_ONCE(y);
> 
> then B is an order-inducing object (a memory barrier), and (A,C) is a 
> pair of events ordered by that object.  In general, an order is related 
> to an order-inducing object by:
> 
> 	order = po ; [order-inducing object] ; po
> 
> with suitable modifications for things like smp_store_release where 
> one of the events being ordered _is_ the order-inducing event.
> 
> So for example, we could consistently refer to all order-inducing events 
> as either barriers or fences, and all order-reflecting relations as 
> orders.  This would require widespread changes to the .cat file, but I 
> think it would be worthwhile.
> 
> (Treating "barrier" and "fence" as synonyms seems to be too deeply 
> entrenched to try and fight against.)
> 
> Once that is straightened out, we can distinguish between fences or 
> orders that are weak vs. strong.  And then we can divide up strong 
> fences/orders into single-CPU vs. cross-CPU, if we want to.
> 
> How does that sound?

Sounds like a lot of work, renaming and review, for no clear win
to me.  :-)  But hey, if other are into it...

  Andrea
