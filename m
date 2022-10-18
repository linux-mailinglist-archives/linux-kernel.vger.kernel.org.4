Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C13603135
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 18:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiJRQ6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 12:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiJRQ61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 12:58:27 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F084CEC508
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:57:59 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id c22so17443572lja.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N2QegD+ETQQI3mRdeSdsqtt8NNjSySbMLRkeFg8er6c=;
        b=GAoo1b5eu+1yj0Ud2AVk7DUhlpyFCMGwvnIszr1KowZsu4giFsbahBqNKPTT6OXrFt
         /Drkpw6/d7WE6ltPYuSsJ4zQBqXL/sTcF9uh9Sb7lKiv+KMOkHqSuBcjKJnX/GuvddJV
         iA2rzJIwol0Au2t+UcptuL/fxwC6WMMo0/rP+vo1dynBg0A1fSGs3MBtVgzodZa08Jgs
         jeFANMF0VlbxODw0lVa5YAHkjJ4O5O2vBxwMSHfVOewQcrCtYweCemp0Wr5FtXYJ4/7i
         pldW3kJpMAt9xShnngiBoA4v37oAm6hG+YOBTC925x9LwfpXgDOQrQEjDqlQGvp41ce3
         HgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2QegD+ETQQI3mRdeSdsqtt8NNjSySbMLRkeFg8er6c=;
        b=iwnA5krScf2ARxQMjpAo9rPpnKPIPrJzU1MEqj9Z9SR461+kaCYBCz6LmMc2Ux9y/Q
         NvV+9tMoj1eau3DZLfn21KH23CDDxUCvxyRF4w84UdPNCLsTUNI67l2lc0Shb8+cPTAu
         IZv+qlRTlmfdAmo2qBGXCKlA1S13fKlBd7HB5o+MJoDhcr8z5fPPO8tzAgSHFnJpJ+jx
         PfM9UMl0Je8rCqfV2xb6o7cGtTC0gtBHXCBv5NGWKdBl6lgdDqFYbrb/92UuX8CEHMK6
         DEz0PfFwv4hnEHrT9unMoTCLlBHmcPPjPYka/tYLklUztOxW/IweHY7HWy33IhWKDOn5
         gQXQ==
X-Gm-Message-State: ACrzQf3m4+F8UBSzbS1ouY0VKfDtbd8J//Biu0tbz/0VBNeW5EZi95Iu
        8bw/nv1GzbrIMBXFEKG+Utg=
X-Google-Smtp-Source: AMsMyM66SGJ9a6tn0DE3b9iVt+A2R1O7LQqxIKbiY+V5GktrzGk1fMzvsQCpZBjQVA9uaefPXtiOdA==
X-Received: by 2002:a05:651c:983:b0:26c:1c6b:8473 with SMTP id b3-20020a05651c098300b0026c1c6b8473mr1320776ljq.341.1666112265513;
        Tue, 18 Oct 2022 09:57:45 -0700 (PDT)
Received: from pc636 (host-90-235-12-21.mobileonline.telia.com. [90.235.12.21])
        by smtp.gmail.com with ESMTPSA id bf12-20020a2eaa0c000000b0026c4e922fb2sm2052071ljb.48.2022.10.18.09.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 09:57:45 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 18 Oct 2022 18:57:42 +0200
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/7] mm: vmap: Add alloc_vmap_area trace event
Message-ID: <Y07bBsCBfHiKJ6Bj@pc636>
References: <20221017160233.16582-1-urezki@gmail.com>
 <20221017160233.16582-2-urezki@gmail.com>
 <20221018124127.2c5adf45@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018124127.2c5adf45@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 12:41:27PM -0400, Steven Rostedt wrote:
> On Mon, 17 Oct 2022 18:02:25 +0200
> "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:
> 
> > It is for a debug purpose and for validation of passed parameters.
> > 
> > To: Steven Rostedt <rostedt@goodmis.org>
> 
> FYI, it's "Cc:" not "To:" as I did not receive this email (nor patches 2 or 3).
> 
OK. I will resend it anyway and just put you in Cc instead.

Thanks!

--
Uladzislau Rezki
