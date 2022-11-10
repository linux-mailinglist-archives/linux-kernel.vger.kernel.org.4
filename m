Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EB0624BC8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiKJU31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKJU3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:29:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF89EDB4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668112114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s3qJXkjwOhbGiwzYiY8uWUuyvmMsTBnM2XzNPe9LD9s=;
        b=AFu1fihkMf4yAkIY7TX22vzAQeuKR7aUoMOIM9pzFEM13Xvk2q3QZRe+eTtRgtIR6xtuPJ
        twKMb3OMQ3Aan8unZNR0/j+9djDYy4TeJ4YgAn8cwWkVGu87KpEOJ0MGOLutcexpXzbRVH
        m7nWmyIV22nDRN7oTtxMiX2IQKt5SZI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-414-GMM8V5iYOdiaA8Ue18gi3Q-1; Thu, 10 Nov 2022 15:28:33 -0500
X-MC-Unique: GMM8V5iYOdiaA8Ue18gi3Q-1
Received: by mail-qt1-f197.google.com with SMTP id g3-20020ac84b63000000b003a529c62a92so2236556qts.23
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:28:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3qJXkjwOhbGiwzYiY8uWUuyvmMsTBnM2XzNPe9LD9s=;
        b=YUhN6ARHhdcgT5WTyBoG5fe3/EgfprPEZbVMvqUC8jw8f81EoCyUYdQ4e30HIyfXs8
         BHBfIBMBrHssxNSaZOJcGpx+jg096981tefWaTkfbx7VWZrBrt1zg0jRL/9Fop8mQctM
         T8l5IPw5nCMZHN15LM0axBKn30YW52R35pYh5TRYinpFCdeuxtVJumfpgvyDVnOi9B3w
         a+3qowrSoBQPNVMqbIy7RcDus/3IFIiknLph8Yx5L45Y1XlqdymkVhLJnMpL+2SEpXq0
         dS8hgwKBLXZO0lHGTGLr6/kTj1rNDT/Iy3lBibmMPybD/YTB87PdhTKG69RGgq7Uxv2s
         7jyA==
X-Gm-Message-State: ACrzQf1rq3TfoOpY+uVau96xyqG5+gc/FEftx1YeDHMNkTFZK2yisLzt
        sQBbnl6FcxZVf2oTP0an1RfS7/6DlbSzufBdEswcoFEGa3TtZwisX4LESI/e4ukajB/89gONIGV
        iSM4pMzW2CtNyr9+cM7J57lsf
X-Received: by 2002:a37:8246:0:b0:6f9:bc42:699a with SMTP id e67-20020a378246000000b006f9bc42699amr1741832qkd.496.1668112112502;
        Thu, 10 Nov 2022 12:28:32 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6U7SlZJzxRPAjnUqO/P0jD8kNSK5YAVkzCKarP217RdqceVGneo5WmOtTIZWolo1PJX/v1Lg==
X-Received: by 2002:a37:8246:0:b0:6f9:bc42:699a with SMTP id e67-20020a378246000000b006f9bc42699amr1741822qkd.496.1668112112298;
        Thu, 10 Nov 2022 12:28:32 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id y201-20020a3764d2000000b006fa7b5ea2d1sm138582qkb.125.2022.11.10.12.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 12:28:31 -0800 (PST)
Date:   Thu, 10 Nov 2022 15:28:30 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ives van Hoorne <ives@codesandbox.io>
Subject: Re: [PATCH 2/2] mm/uffd: Sanity check write bit for uffd-wp
 protected ptes
Message-ID: <Y21e7vvP54JrtkAp@x1n>
References: <20221110151702.1478763-1-peterx@redhat.com>
 <20221110151702.1478763-3-peterx@redhat.com>
 <58FFF1A3-DC37-4D9F-ABF0-3C5DA519BFFB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58FFF1A3-DC37-4D9F-ABF0-3C5DA519BFFB@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 10:43:25AM -0800, Nadav Amit wrote:
> On Nov 10, 2022, at 7:17 AM, Peter Xu <peterx@redhat.com> wrote:
> 
> > +#ifdef CONFIG_DEBUG_VM
> > +	/*
> > +	 * Having write bit for wr-protect-marked present ptes is fatal,
> > +	 * because it means the uffd-wp bit will be ignored and write will
> > +	 * just go through.
> > +	 *
> > +	 * Use any chance of pgtable walking to verify this (e.g., when
> > +	 * page swapped out or being migrated for all purposes). It means
> > +	 * something is already wrong.  Tell the admin even before the
> > +	 * process crashes. We also nail it with wrong pgtable setup.
> > +	 */
> > +	WARN_ON_ONCE(wp && pte_write(pte));
> 
> How about VM_WARN_ON_ONCE() and no ifdef?

Oops.. Will quickly respin, thanks.

-- 
Peter Xu

