Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0322A65DD5D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 21:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbjADUFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 15:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjADUFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 15:05:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C451C130
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 12:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672862670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KsNn6+8herE45H4IfoHjfH1DQT1MJEJp3AWNOg7phZ4=;
        b=R5FkZQZLufZxUj9rNTSwhR7WH6arQ5lubzsF+HHXu1YQDGElc+yhpOoMb+WSBSw140N4rc
        nrUUHFbO3A8ymcemebQekNglMkWeO+bIb3ch3cQa0rNUE/V9UocXR0bFHBm0AGTnCy+ksy
        OV9lNTmFpUHvL9yKc1uUMbCNUcLgzEw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-354-1QVCV-CIOOWaj4F9GLOwCg-1; Wed, 04 Jan 2023 15:04:29 -0500
X-MC-Unique: 1QVCV-CIOOWaj4F9GLOwCg-1
Received: by mail-qk1-f200.google.com with SMTP id f13-20020a05620a408d00b006fc740f837eso24012197qko.20
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 12:04:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsNn6+8herE45H4IfoHjfH1DQT1MJEJp3AWNOg7phZ4=;
        b=F/u0u5j+hUsQo1QMSSCpg10fsOyhze8g0e/SuxX4zNR0vBGtwsytEkwJipnSWegEYZ
         9SVrh9CRFhhIhZmdIhcCkuUsp4RARWDtAXB9jtWN9ZK1WoQIt7YjhmX2SbtXxXJxfbFY
         y0dgA7MTs1CRNBPhMMjCvCYSNl0mdgjHG17Z7R/gwijQCyJp/xLJLrX+Dp83kc9jpL3K
         8SLS3iLwkXWOpJmRvXADd02Q0i3x4cM3whj+6sOeYvUmabXfwPS6xocWaATRTH5eXuMR
         hvMH9nXXqBVzuPcYL7gZy2j7CYGvP9OaobeA3bUAV3Ej5EDiO8aQB5a518f31oy/csGn
         lSEw==
X-Gm-Message-State: AFqh2koOe2iizGAoKezVZgV1orObFS8RDhqOmxrYCsVaU14a7SiJ558u
        wPwatu4uFsc8LSc5fmHQkNfkTFhgON00BHHiW8GmLkiLA1etu/fSmsU/4fxM0yz8MtMcsbd58M5
        qQdUDxyuwK8MT4/rHVOJbdmXM
X-Received: by 2002:a05:622a:488e:b0:3ab:6e0c:16b1 with SMTP id fc14-20020a05622a488e00b003ab6e0c16b1mr62941497qtb.45.1672862668700;
        Wed, 04 Jan 2023 12:04:28 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsaFjL7h6gQ5ju41/7AtQskfQjy5co76i3OES7n6IcqFJfbhbilKb/W4LhkpckOGdBE23hx0w==
X-Received: by 2002:a05:622a:488e:b0:3ab:6e0c:16b1 with SMTP id fc14-20020a05622a488e00b003ab6e0c16b1mr62941486qtb.45.1672862668478;
        Wed, 04 Jan 2023 12:04:28 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-39-70-52-228-144.dsl.bell.ca. [70.52.228.144])
        by smtp.gmail.com with ESMTPSA id 6-20020ac85646000000b003a6947863e1sm20297948qtt.11.2023.01.04.12.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 12:04:27 -0800 (PST)
Date:   Wed, 4 Jan 2023 15:04:26 -0500
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hugetlb: unshare some PMDs when splitting VMAs
Message-ID: <Y7XbymU+hy6ZJO+/@x1n>
References: <20230101230042.244286-1-jthoughton@google.com>
 <Y7S0lDCeBYLMHBvR@x1n>
 <CADrL8HWSym93=yNpTUdWebOEzUOTR2ffbfUk04XdK6O+PNJNoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HWSym93=yNpTUdWebOEzUOTR2ffbfUk04XdK6O+PNJNoA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 07:34:00PM +0000, James Houghton wrote:
> How about:
> 
> /*
>  * PMD sharing is only possible for PUD_SIZE-aligned address ranges
>  * in HugeTLB VMAs. If we will lose PUD_SIZE alignment due to this split,
>  * unshare PMDs in the PUD_SIZE interval surrounding addr now.
>  */

Even better, thanks.

-- 
Peter Xu

