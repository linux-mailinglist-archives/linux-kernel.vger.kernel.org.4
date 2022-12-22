Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C230B654570
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 18:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiLVRCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 12:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiLVRCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 12:02:37 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE621E3F4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 09:02:36 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 1so3632724lfz.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 09:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G0zwrWaJTSxw3FyZ39kBOoqd4YNPUpidpLFzZ+RxT1k=;
        b=hOpI4SLV7JV/1IMHBv213oGOwibWOK+cj8fNq1w1+yHyTBj2613eL/ViztMiZDqoBR
         PTXOQi1paMCRU8xVdRWa4E1sNWn9ml8z1D4aOPEiqdOm3L86sQAmdzsWPpDnsBhZXNOJ
         H7MpS5aU8hjascgb1IadA7gN085EVdfKS4/hZzLs158M5ZvQgtCZAyRTbPh9+AvJGtHN
         I4SHMQraCd8Lpp8v836+15QzuhZa+x1JwBLicqbqugRN/WqRSyLcJJiiMsARAogRAUMw
         zE0yE3zW/EZj6+2SKjjtKuX0Y3y0EmYa3RAjV6ieKEIVNIAS/WCmHeZOcayIPf1tsCBj
         O3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0zwrWaJTSxw3FyZ39kBOoqd4YNPUpidpLFzZ+RxT1k=;
        b=LOXUQDCcQpn4jPas0vPthjh8RnnbsTx/u0Ycs28bP6Z6JCmDBrHBWE/nJka2ioM9Q+
         T4Y1Q9bHiWs657kRjIE5ywgVt9ToaNUjrbt01Q9FhgmwsIT0TD0QVxeZm6TM4JH6UQN2
         BP+9Ku+MgASZX7sNy1QoPnHKlvPCqLmdsnt3crVGGg75y3s+r0RDqZPyYsR2HkBy6qTt
         78qeqUdg2Waw2HvkO8u63t0T/yCZrOFjpuHPGN5Q3/KiywdugappuTb4+6S60TwmysdJ
         FEcw8bzzSCUGG2E3X5IiG+1GZeSOgs2Y/+vACmj/Wl3BAfQWn+SY5Xfab7RH6M3gVfTQ
         BdpQ==
X-Gm-Message-State: AFqh2kochbydv2rjLg1k9fSEZPtHcsBVCCFPOQxn+/YQedOnKxKOpoR3
        FFKAMytcHMvwuALFY4iZYElzr3r6reM=
X-Google-Smtp-Source: AMrXdXtw2QKeMO9Ss4aP8DGMJ3BEhSqaDP/ca13UPBAWjQMhvBMTxW1sleQsr9iFC6Hsis7Qr7y+sQ==
X-Received: by 2002:a05:6512:3a8f:b0:4c8:5f19:ccb8 with SMTP id q15-20020a0565123a8f00b004c85f19ccb8mr2311564lfu.48.1671728554709;
        Thu, 22 Dec 2022 09:02:34 -0800 (PST)
Received: from pc636 (host-90-233-218-120.mobileonline.telia.com. [90.233.218.120])
        by smtp.gmail.com with ESMTPSA id k2-20020ac24562000000b004b4ea0f4e7fsm126172lfm.299.2022.12.22.09.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 09:02:34 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 22 Dec 2022 18:02:31 +0100
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH v2 1/3] mm: vmalloc: Avoid of calling __find_vmap_area()
 twise in __vunmap()
Message-ID: <Y6SNp5Wmiav68yT3@pc636>
References: <20221221174454.1085130-1-urezki@gmail.com>
 <Y6QbvYfvhUI3J7S+@infradead.org>
 <Y6RsmcvZ8Ru211Jk@pc636>
 <Y6RxMQnevF++FlRG@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6RxMQnevF++FlRG@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 07:01:05AM -0800, Christoph Hellwig wrote:
> On Thu, Dec 22, 2022 at 03:41:29PM +0100, Uladzislau Rezki wrote:
> > Do you mean like:
> 
> Yes.
>
OK. Will eliminate that local variable.

Thanks.

--
Uladzislau Rezki
