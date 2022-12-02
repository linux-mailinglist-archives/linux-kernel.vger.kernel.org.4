Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687E964079C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 14:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbiLBNTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 08:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbiLBNTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 08:19:36 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F867A1C1C;
        Fri,  2 Dec 2022 05:19:35 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id s8so7343483lfc.8;
        Fri, 02 Dec 2022 05:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0RrzZhGsAZb/yohgQXedgXT5kq+CvYi3WTHTbxK9mi4=;
        b=ggwivpUXeqzvn8eKOxkFvnkwswODIws2gt1YYmiF4KzIVtFJVwfaqxxlsAYH36Bna3
         4K8YWamWtEP1w72B2MedzUIoaMUkVYOkSn0X/ir+wHSnbkdirFY6C4umd3RCJnkd30Ze
         uO7K9wgre3micl7gif0HqMUDCFV1YK/ZIjVNeH21OEogGecurTjZa6d9Yn/StMIub7/k
         vjrLJF9UCQWxyhjqhLCWuVrWrJoOAettK5uKgFm3q6fD7Ol3nHQ/9ID26BgIfx2Cusl2
         yi71GNk3/Zw/EmUe8g431Ol9zx9EQ1xQGdM864Jkcp4SBnqug6LTOhelnDBkjnDSVX9b
         CgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RrzZhGsAZb/yohgQXedgXT5kq+CvYi3WTHTbxK9mi4=;
        b=NswCo4pmqsSoZUvC5IFApIcx9PU2TwqMbVtoBHfTy9MU/RxUHTIWhiBvURc/wPi21z
         HzXwnOdsqHUpNXhbv+Mi3zjqj0Pz8FIS4lRpC6AfBunNtzfYenBuFk+kUiEgNxPd75Wa
         Jycu9CqwAI+0easJ1r5RSHP9QKrXtZC1eh4sWumHcx41C7WDJiVcM8MeFuS+XgblMvgc
         swT5UQkO4whKtcsCoKpscyStOvJisdaPWgIXajEhQQOxszOK9YlQBZTtdC9dAP8M7ZA0
         1JYqtHzfVrfI9MT6Tobk24KaTnDU/LpVjo9PT0N2C3FQjI2N8VvUndf1YJbTSxjQ0ych
         8eQw==
X-Gm-Message-State: ANoB5pneg9InebaN0MXELDaSjg+DKw4ua9xSfzi7NUABUWniupqlPXD1
        dZ5cruwOX7yKExNlCPqFltA=
X-Google-Smtp-Source: AA0mqf6/gUyQD+wTZw+3MgNB+eREixgA9V1hN5oF2QX//bkvtunFEiGZQNFOEAE/OnZUFh1aMVnRWw==
X-Received: by 2002:a05:6512:23aa:b0:4a4:65f0:cdc8 with SMTP id c42-20020a05651223aa00b004a465f0cdc8mr22734536lfv.609.1669987173860;
        Fri, 02 Dec 2022 05:19:33 -0800 (PST)
Received: from pc636 (host-90-235-25-230.mobileonline.telia.com. [90.235.25.230])
        by smtp.gmail.com with ESMTPSA id s24-20020a056512203800b0049480c8e7bcsm1013948lfs.176.2022.12.02.05.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 05:19:33 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 2 Dec 2022 14:19:31 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 3/4] rcu/kvfree: Move need_offload_krc() out of
 krcp->lock
Message-ID: <Y4n7Y9opAEbNmMLx@pc636>
References: <20221129155822.538434-1-urezki@gmail.com>
 <20221129155822.538434-4-urezki@gmail.com>
 <20221129233833.GA154809@paulmck-ThinkPad-P17-Gen-1>
 <Y4dS8X+Ir7egYBTD@pc636>
 <20221130184455.GQ4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130184455.GQ4001@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 10:44:55AM -0800, Paul E. McKenney wrote:
> On Wed, Nov 30, 2022 at 01:56:17PM +0100, Uladzislau Rezki wrote:
> > On Tue, Nov 29, 2022 at 03:38:33PM -0800, Paul E. McKenney wrote:
> > > On Tue, Nov 29, 2022 at 04:58:21PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > Currently a need_offload_krc() function requires the krcp->lock
> > > > to be held because krcp->head can not be checked concurrently.
> > > > 
> > > > Fix it by updating the krcp->head using WRITE_ONCE() macro so
> > > > it becomes lock-free and safe for readers to see a valid data
> > > > without any locking.
> > > 
> > > Don't we also need to use READ_ONCE() for the code loading this krcp->head
> > > pointer?  Or do the remaining plain C-language accesses somehow avoid
> > > running concurrently with those new WRITE_ONCE() invocations?
> > >
> > It can be concurrent. I was thinking about it. For some reason i decided
> > to keep readers as a "regular" ones for loading the krcp->head.
> > 
> > In this case it might take time for readers to see an updated value
> > as a worst case scenario.
> > 
> > So i need to update it or upload one more patch on top of v2. Should
> > i upload a new patch?
> 
> Sending an additional patch should be fine.  Unless you would rather it
> be folded into one of the existing patches, in which case please start
> with the set that I have queued.
> 
Done.

--
Uladzislau Rezki
