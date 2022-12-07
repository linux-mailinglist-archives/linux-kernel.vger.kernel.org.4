Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCBF6457EE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiLGKe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 05:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLGKe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:34:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648172A71C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 02:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670409214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ls/fVzNOQDXdkwGawkCzgkRpahtmHyBL8VCkLV4JQsI=;
        b=QnpGxv/3WbhkxYxL3Ad7myYk4nCNvDW6lvZqXa4YHgwCz3yQ4HQuCyWh2sU1haXjcDCZ+d
        5N1cbc1A7ETM7FcJXPtZ7DQO8k6yKkMGg75oGMsHP574q2h8up31N7lEX51ST5A2tMEWte
        IZt2ma6w+GM8qHj2TKzsdqMtg4zbfao=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-184-DRat6p5kM5Km6kouVFEnPQ-1; Wed, 07 Dec 2022 05:33:32 -0500
X-MC-Unique: DRat6p5kM5Km6kouVFEnPQ-1
Received: by mail-wm1-f71.google.com with SMTP id f20-20020a7bc8d4000000b003d1cda5bd6fso441642wml.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 02:33:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ls/fVzNOQDXdkwGawkCzgkRpahtmHyBL8VCkLV4JQsI=;
        b=K0UcBoHMajD9tR+etbyvVQSZbe5ilsDUXYVBe7N+fb+x+K6i5uTnYugIbjbeARANbe
         q+RXwtv88fPiu009IJ47Ju3m0HxHOzpGTF4lI+xLnjQ/R1yAdYrr54cfcBRI99l0ZXI2
         N25NTVAJrPWQaeknVg0ukplG+Ip9h80jgBSSG0nsbfS8iDs1EarHjdnoxpqRs+U3F7Ll
         EwtjyKni0TMEaDJAIIMTHVL0w2fHJ8VxUlsVmOMnq6xtB/Xt7IOWCmjNPMC+5con228N
         84c4Q+qqwA+mFJEU/oqThl3ZcrgxcRHvcpI0Fkr31/iXYkIblqcGH8c0QoT+rbJMoPtM
         I5UA==
X-Gm-Message-State: ANoB5pl9/0y10xhRuEQvgPzLzIFw3vSE2kM0eIBeNiTrLfv6tce00V4l
        OHQ9TbNH/QsCWIJyU1fumpjOo619U2YuKFy5wvkcjnzWKJpxrJ4ma6Eh/ZEpN7rx17xP4sCdagA
        yOEOuajoq0ryjPE6f7HpOkTnI
X-Received: by 2002:a5d:6dd1:0:b0:236:75a8:58d with SMTP id d17-20020a5d6dd1000000b0023675a8058dmr56602608wrz.295.1670409211072;
        Wed, 07 Dec 2022 02:33:31 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6FBlRBE2GeVd3WJhHDz0cWwP9kKA/AUXb7mzTw2ZMVDwXZf0YLLk4DOpcAQ2mrMfXIGB+xvw==
X-Received: by 2002:a5d:6dd1:0:b0:236:75a8:58d with SMTP id d17-20020a5d6dd1000000b0023675a8058dmr56602601wrz.295.1670409210856;
        Wed, 07 Dec 2022 02:33:30 -0800 (PST)
Received: from redhat.com ([2.52.154.114])
        by smtp.gmail.com with ESMTPSA id b18-20020a05600010d200b002423a5d7cb1sm16105958wrx.113.2022.12.07.02.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 02:33:30 -0800 (PST)
Date:   Wed, 7 Dec 2022 05:33:26 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Gupta, Pankaj" <pankaj.gupta@amd.com>
Cc:     Michael Sammler <sammler@google.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Mina Almasry <almasrymina@google.com>, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Sammler <mich.sammler@gmail.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2] virtio_pmem: populate numa information
Message-ID: <20221207053242-mutt-send-email-mst@kernel.org>
References: <20221115214036.1571015-1-sammler@google.com>
 <CAFPP518x6cg97tK_Gm-qqj9htoydsBtYm5jbG_KivK5rfLcHtA@mail.gmail.com>
 <3f7821a0-7139-7a97-ab24-dfca02811fc0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f7821a0-7139-7a97-ab24-dfca02811fc0@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 05:09:42AM +0100, Gupta, Pankaj wrote:
> +Cc [MST, virtualization-list]
> 
> Hi Dan, MST,
> 
> > This patch is reviewed and tested. Is there anything that needs to be
> > done from my side (e.g. sync with mainline)?
> 
> If there are no further comments, Can we please merge this patch?
> 
> Thank You,
> Pankaj


I'll take a look. Generally if you want my attention you
should CC me on the patch.

Thanks,
MST

> > 
> > (Adding my alternative email address to this thread as I will soon
> > lose access to the address I am sending this email from.)

