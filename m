Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C1C616346
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 14:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiKBNCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 09:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiKBNC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 09:02:27 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1462F28724
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 06:02:26 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id l2so6531051qtq.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 06:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ui2spH7Ijxdyz3Q6yHTW1U/bSitTRDpSp5cXJ8JASQ=;
        b=L3mc3II/vblRGybKufSbD0XGkcv+/Ndo+Ncph5snlwdoLFIIf2N+eiTsnh/towV6SQ
         teA8vs9GdfKuarodtBR4J1ToeItpWVaPXKrj1ul87TpPTYsSc3ZiNeeh5/yGuI71HCVT
         0+Wfh6yPzkO9BRy8Qq5z2eU6tesodEKpfU8ey0AWdu1fn0duRiXQSyPulQNJXdZfRC4H
         G+OpJ3M1z+/HSxOflPI8DdDwADuwtSATZGd0VHJY2yuyiGW/gU/5HPKXgvAGdAg5J2dS
         aDauWRMkaJ4DgnDvbc/RHTLdkX71jWl7dpNkb4TU0d/ab6TuAYJpEndxgJoT6HlGFUR4
         5KlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ui2spH7Ijxdyz3Q6yHTW1U/bSitTRDpSp5cXJ8JASQ=;
        b=r6QxIg3d4J2R334W7D+QT7IRry1mhrx63GpSxKlhSWb7Rx5dWStANYdsTcU/RTE1S9
         s6Ht0jGK4S4rA1pjsC0SgKZR7sW/ioqoICInce2/RTlBECEQNRJVp1ZaL+P2zNb5k7Cg
         4EjIc1AuueO/kk+rPvw8Yv78c6774kyQgJc9PrEX9iVQ0Ee3NpWIgH5ZxNB//TfTeku6
         3EhdLWmSAf7e8OkCrg1+uQ9rOhtDvhwQiVFoNDWAnVnoRK3eiHsHCzm2sbhpMWe3+uMu
         ps05C2HuoZxwhBkT5uzOWN1SLYmL7V58rZm4bHpShRkqcOWtLWLxVQQFtgZ41/sA0DXC
         yNZQ==
X-Gm-Message-State: ACrzQf2Yc0Y+8gl1VO2A0PhncuxgefuZC+oTVrRFtD35SEWEXTax6zqC
        AIO8OpLoQedl92xjU4WWJLOB0g==
X-Google-Smtp-Source: AMsMyM4hG3J43eMr0N8kd2RNr5CGjH8FZCEj0O/saxYELV47TVbI18Z/MhuWquKg2CIuAW2tEMh2mQ==
X-Received: by 2002:ac8:60c3:0:b0:3a5:26c3:1a5e with SMTP id i3-20020ac860c3000000b003a526c31a5emr12641109qtm.247.1667394145195;
        Wed, 02 Nov 2022 06:02:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id u21-20020a37ab15000000b006fa1dc83a36sm7480299qke.64.2022.11.02.06.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 06:02:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1oqDNv-004VTc-Nq;
        Wed, 02 Nov 2022 10:02:23 -0300
Date:   Wed, 2 Nov 2022 10:02:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Leonid Ravich <leonid.ravich@toganetworks.com>,
        "linux-trace-kernel@vger.kernel.org" 
        <IMCEAMAILTO-linux-trace-kernel+40vger+2Ekernel+2Eorg@eurprd02.prod.outlook.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yigal Korman <yigal.korman@toganetworks.com>
Subject: Re: BUG:  ib_mad ftrace event unsupported migration
Message-ID: <Y2JqX3vC1mG/JDex@ziepe.ca>
References: <VI1PR02MB623706DA8A01842834FC191089399@VI1PR02MB6237.eurprd02.prod.outlook.com>
 <20221102074457.08f538a8@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102074457.08f538a8@rorschach.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 07:44:57AM -0400, Steven Rostedt wrote:
> > before starting throwing some patch into the the air  I would like to align with you the approach we should take here. 
> > 
> > my suggestion here : 
> > - ftrace infra should verify no migration happen  (end and start happens on same CPU)  in case not we will  throw warning for the issue  .
> 
> The scheduler should have. On entering the ring buffer code
> ring_buffer_lock_reserver() it disables preemption and does not
> re-enable it until ring_buffer_unlock_commit().
> 
> The only way to migrate is if you re-enable preemption. WHICH IS A
> BUG!

So what on earth did that?

I'm guessing some driver's query_pkey op, but AFAIK we don't have any
explicit pre-emption reenablements in the code - unless it is sneaky..

Leonid what driver are you testing?

Jason
