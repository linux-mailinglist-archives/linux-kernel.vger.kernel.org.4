Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982656FE411
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjEJSeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjEJSeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:34:14 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412443AB3;
        Wed, 10 May 2023 11:34:11 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1a516fb6523so71528205ad.3;
        Wed, 10 May 2023 11:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683743651; x=1686335651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RTL6KI+FzimfP09Cdj+vBoewl1/Sq0gy8EpV1qcK/T4=;
        b=LhdoluKau8rsbUuReUYbVvpidI8/Et37XLy7Kx7YJMfasKeUv337TVESgldPXk7dOQ
         0CEVC5gWVAJeUVxieTi3/QPhGCfX31uksM1UuglwJeSEfphJYzHxcLfCLolaqvFjP56h
         EpUeZuF9mdcq6sMvf3AXxpAx0V5frghjUdps4AkN+EvNktNb3Pwqe/LsX+jpcQeQxLBK
         F04AjIwgy+QdsAQV+WujUSGAFU3HVBMSITN+U3c/Bz4eqk6wBC336UDxbZPgzZpGAaX8
         B8jC+4IXuRafGPDAEu1x2hgJrOUhlFZUojY8SIG+Edzxf6v4IMwu3u3mKV3DuhO7Zx0/
         x4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683743651; x=1686335651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTL6KI+FzimfP09Cdj+vBoewl1/Sq0gy8EpV1qcK/T4=;
        b=PDTmx2v5ITMNJKgL2ayu3PpAZERvkfravtANk7fWXo9ncbTC7exQrN0y4/IFxp7r93
         xSNBTz+HfqV5LRNbyFioAWcMex5wUG6FTo9QQPJzkRG9F/qaN0NosVUOCDE5bVhmDFpy
         kIxp2ldj1OHPGlzjo30hEowvpRoFY85+QrXWNuecK5F6CQ1n91QdFFAGuzrTbghpTRwr
         ZmM8zCXxt/uzA1Kyh43HihjTO015ldLBKbN7GkHGDVB5OLW0exeuFFkO+5cmP+pZXh5l
         3hN5jWdl6urTL/fbzFUm+375d2ArvvaSLeUfUHgpJIL2xdDNDdNL2UsjH+0m44EMFdEv
         WKZQ==
X-Gm-Message-State: AC+VfDynRJqSQUn3OEIzNfHH77tgjIPOdwIDDipaaICJ9VoXaPx4bBSN
        JQdddVnRdcvTy3Jc9jmPbKo=
X-Google-Smtp-Source: ACHHUZ5wbNJbMNIJUP+OMFWr6Kdhszr3nNKbhcmK3xkKUZAf0hJlVpzjnlzMI4JeydCR6ZQqKdkOxw==
X-Received: by 2002:a17:903:41c1:b0:1ac:4162:5922 with SMTP id u1-20020a17090341c100b001ac41625922mr21743865ple.66.1683743650537;
        Wed, 10 May 2023 11:34:10 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902bd0400b001a260b5319bsm4110643pls.91.2023.05.10.11.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 11:34:10 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 10 May 2023 08:34:09 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [RFC PATCH 2/4] workqueue: support holding a mutex for each work
Message-ID: <ZFvjoUtg2ax11UlC@slm.duckdns.org>
References: <20230510160428.175409-1-johannes@sipsolutions.net>
 <20230510175846.cc21c84b0e6b.I9d3df459c43a78530d9c2046724bb45626402d5f@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510175846.cc21c84b0e6b.I9d3df459c43a78530d9c2046724bb45626402d5f@changeid>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 06:04:26PM +0200, Johannes Berg wrote:
> @@ -2387,7 +2389,13 @@ __acquires(&pool->lock)
>  	 */
>  	lockdep_invariant_state(true);
>  	trace_workqueue_execute_start(work);
> -	worker->current_func(work);
> +	if (unlikely(pwq->wq->work_mutex)) {
> +		mutex_lock(pwq->wq->work_mutex);
> +		worker->current_func(work);
> +		mutex_unlock(pwq->wq->work_mutex);
> +	} else {
> +		worker->current_func(work);
> +	}

Ah, I don't know about this. This can't be that difficult to do from the
callee side, right?

Thanks.

-- 
tejun
