Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8ACD624D81
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 23:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiKJWKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 17:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbiKJWKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 17:10:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DCB450B6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 14:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668118167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h38wWhVkSIZtB2RyPJKkf5rNtE65Gqs4wgaNeAIALcc=;
        b=VfPbbBDh85T1r1+etxMMeelfZvOvEHAOkTc9EzH9KoRr9ELiTHn38DVu2ugsWe7SgX+QHL
        eRsrWWZw/cwL75UeKo5Cmk6Cs0jJYcziM/OKbcdzprv6shCDTrjQop/ogcU2kGwrmGccaN
        59yY8zhVoiy2lxISIe68EouRa9WNLw0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-246-1VS5aqB5NnOLvbBYBOn1Xw-1; Thu, 10 Nov 2022 17:09:25 -0500
X-MC-Unique: 1VS5aqB5NnOLvbBYBOn1Xw-1
Received: by mail-qk1-f198.google.com with SMTP id bs7-20020a05620a470700b006fac7447b1cso3280906qkb.17
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 14:09:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h38wWhVkSIZtB2RyPJKkf5rNtE65Gqs4wgaNeAIALcc=;
        b=ar3zFiQ+ktz3TVnnItEQvK9U0Gqpz/7IAeS3SBvdVmOCEYf5LIiE+lkwHE8waYL1im
         XLPsoro6WgsnxHChTNoX2Ztn2AmynmH0Bi1jKgvgZehDf8zoKVWusA5HW+C/38hT8dQT
         +LprxfaxewLJfqg2JB2rin/QOMk7Doe3CTz6528STLkRSrNgp6zyRczebIeY4LxpFYxJ
         ABTwrd59t6ibyf2xEbeninMZAX8EeZS1qX51m17PiVzhP7MG8BUdyDK07RBfE8UACQwA
         j1B6uzfdcEVTEJZKsjaOAjDAB9PHusIkYUjF6LxZCkG244ceGahSCrrAhexLpQn+K/0A
         0akQ==
X-Gm-Message-State: ACrzQf1J0V+DIV6JUy2NX8rUuadKMdYxGIdfof8VuOVhQIDZrXoIrQgG
        K20Goab/ypb2h3GayvUJAHQC5nPL5MzTIf1/By29ejeNRqpAVZjOngLqvYlz347okjLwkGM2P9+
        CR/S2SmmR61k6oS5/m9ws+dKc
X-Received: by 2002:a05:6214:418c:b0:4b1:8788:21ff with SMTP id ld12-20020a056214418c00b004b1878821ffmr2170363qvb.16.1668118165056;
        Thu, 10 Nov 2022 14:09:25 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4zT6Kz79MRmDBsfpoBn32M93cP30ai8uShqGW0DU7ZFM+GRq+eHe4ng1aNLorRKZp5T5POkg==
X-Received: by 2002:a05:6214:418c:b0:4b1:8788:21ff with SMTP id ld12-20020a056214418c00b004b1878821ffmr2170352qvb.16.1668118164890;
        Thu, 10 Nov 2022 14:09:24 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id q45-20020a05620a2a6d00b006ee7923c187sm346175qkp.42.2022.11.10.14.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 14:09:24 -0800 (PST)
Date:   Thu, 10 Nov 2022 17:09:23 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ives van Hoorne <ives@codesandbox.io>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/migrate: Fix read-only page got writable when
 recover pte
Message-ID: <Y212k5F+/5xHksW/@x1n>
References: <20221110203132.1498183-1-peterx@redhat.com>
 <20221110203132.1498183-2-peterx@redhat.com>
 <65FA2E7E-1F12-4919-BD79-11159934CF2C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <65FA2E7E-1F12-4919-BD79-11159934CF2C@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 01:28:31PM -0800, Nadav Amit wrote:
> On Nov 10, 2022, at 12:31 PM, Peter Xu <peterx@redhat.com> wrote:
> 
> > Ives van Hoorne from codesandbox.io reported an issue regarding possible
> > data loss of uffd-wp when applied to memfds on heavily loaded systems.  The
> > sympton is some read page got data mismatch from the snapshot child VMs.
> 
> symptom (if you care)

Yes, but,

> 
> Other than that LGTM

this definitely matters more. :)  Thanks for taking a look, Nadav.

-- 
Peter Xu

