Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B396631D5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbjAIUtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjAIUs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:48:58 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D5E1A3AD;
        Mon,  9 Jan 2023 12:48:57 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id o7-20020a17090a0a0700b00226c9b82c3aso11069976pjo.3;
        Mon, 09 Jan 2023 12:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ozgtWXStaifDCNgxslV51L9a9hMuGEd0/nehBJs5fnk=;
        b=T8qovgWlSZC8V8Nu5uttH59MXaChBsCI/gnRaGKVGLwOPQP6JFSyxkip3cXJyVVf4C
         D1lTIpYnSayynxqxocTY1T9GjZ27L5IL4oJMha83QTPliGYrb2NIimWL6HTbDgeUukF/
         sw/ucV9zAwNXGqArc4hctwBhSUSyZrb4DqBbm8HFR9xoVIQQrlNeNe+0R/rQ2eiV+b39
         uLqnlqmESQe7kw1/Q/CxwryGKiaibMv18//JGsUPhnCBmehCTomfIZzKXC7hWb82tDwz
         YygbLAukH01JVtMnE5vf1+hVqAXXYtj/7AOMvBRR4dQczyc1rQJMtMaqy1qDIpwXwjMc
         9nng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozgtWXStaifDCNgxslV51L9a9hMuGEd0/nehBJs5fnk=;
        b=zTdNcrGvo/50YGE/05ws8RQVjrXDRuXOdLdNrNcZfGV9UUUtfUbbP+VWI6ZoQzm9T4
         GVbTckOBz9ooIfPqLhlBS/rPaAzbSrldQGL/6ldZ0fvMebMac5DcY9VYWZ+5AgGEN8st
         Ve6N4SS4S1NOG9dJxMmpczhK/BF3KC5q2hdmNiHmKpmBgeqF1ZDpo0vtNKcd1sf7Y5oc
         v+1meQWj8wPmEdHmYdeyDR3Nbxo/NXYtY1ppz/o0FZF2VqSR4HhiXxK/gU0Vyi0dRwHZ
         B2DtkJe79rCMgr4UA/tl3R2PUwNQBo94pv74DeBKEhfLWOVEMViHL46gnmzbxQ0t/Pl6
         h3SA==
X-Gm-Message-State: AFqh2ko4Ox7d6l6fDZy64GKlrF6LfDmG/np6sf4SHBXYRNDQ7qp1dd/E
        2N1MrTMsk36DC+eKek5d0lM=
X-Google-Smtp-Source: AMrXdXudu3zGX1Bk6RQEqbaxea7o8PBKNte85xa8wTy0U7BSYdzI3mqcMO0/sha5+LEP8Yr+76tpJA==
X-Received: by 2002:a17:902:7583:b0:189:4bf4:2cfc with SMTP id j3-20020a170902758300b001894bf42cfcmr66193787pll.31.1673297337405;
        Mon, 09 Jan 2023 12:48:57 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id a16-20020a170902ecd000b001868ed86a95sm6526556plh.174.2023.01.09.12.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 12:48:57 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 9 Jan 2023 10:48:55 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] blkcg: Drop unnecessary RCU read [un]locks from
 blkg_conf_prep/finish()
Message-ID: <Y7x9t+4EwXFl7OwS@slm.duckdns.org>
References: <20230105212432.289569-1-tj@kernel.org>
 <20230105212432.289569-2-tj@kernel.org>
 <20230108170240.GA19165@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230108170240.GA19165@lst.de>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Christoph.

On Sun, Jan 08, 2023 at 06:02:40PM +0100, Christoph Hellwig wrote:
> On Thu, Jan 05, 2023 at 11:24:29AM -1000, Tejun Heo wrote:
> > Holding the queue lock now implies RCU read lock, so no need to use
> > rcu_read_[un]lock() explicitly. This shouldn't cause any behavior changes.
> 
> How so?

Now that all RCU flavors have been combined, holding a spin lock, disabling
irq, disabling preemption all imply RCU read lock.

> > While at it, drop __acquires() annotation on the queue lock too. The
> > __acquires() part was already out of sync and it doesn't catch anything that
> > lockdep can't.
> 
> This makes sparse even more unhappy than it was before.  For now
> please keep the annotation.

I can drop the changes but this actually bothers me. The annotation has been
broken for a *long* time and nobody noticed. Furthermore, I can't remember a
time when __acquires/__releases notation caught anything that lockdep
couldn't trivially and can't even think of a way how it could. AFAICS, these
annotations don't contribute anything other than preservation of themselves.
I don't see why we would want to keep them.

Thanks.

-- 
tejun
