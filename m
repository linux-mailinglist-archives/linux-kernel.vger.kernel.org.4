Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692C86D8395
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbjDEQWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbjDEQWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:22:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF9C65BB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 09:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680711686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=63v+qwotnsCx4f/GeeRNr7QN5M8Bui6FmdbMn331KDo=;
        b=A1yLneCJOAWY8snVzlg0IZqNMfcP84/dlRAz8gir5Nt/Rep33qv+LGprrdsdXeBhugROQg
        eWodwQgXwAZKGM1HgRHeiEEmkCFlCAByO/r+Rr/by9JmXjISWFWceWFr8Sa3Djc4ANXQKd
        XPTcabUu6UQNovtQLzmADn2gSaOyA5c=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-zfCE1llzPW-2ysI4Gjidtw-1; Wed, 05 Apr 2023 12:21:25 -0400
X-MC-Unique: zfCE1llzPW-2ysI4Gjidtw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-5b27caf4dffso1361776d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 09:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680711684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63v+qwotnsCx4f/GeeRNr7QN5M8Bui6FmdbMn331KDo=;
        b=2clfZEb7v00Axs+Od4VgjY1oP6d+/NbFuwisb+V8wEhyYLINCnDEu6aKIuGb4gcmdi
         HpS6IToEY/qqjrbW42yrEFHBbzGtCeGoZwWostM08xrro/38NgOEkmI18m2jC0IEZMi8
         2uWQFvQ+m0EWkqR4IP7dv5kyW2dVChDohn/JccSShNrz48MR5/IPhtCd0NV4o5HUQWBs
         oQh4QReIVgTdnajaUYghggpNeuNADgyzMr0RbVE/ViR0WSLVhtpyvShfyHRzyKbrfmtz
         79WShQPvHiYHXmeK5uWweDuSXSzvaPfzYwAKxrre9lAdDlmZSKivvvFCztGe8stvE1pv
         9RCw==
X-Gm-Message-State: AAQBX9fzYFA8GMZRExzJ8d+ayUANfPhyRR7IXl5sjoGPOrAxj9vxFA2q
        ploqizwCvBLaKWLdPgZX1nscaIcAfKkDyXOvrWtjRRIoyHdbx7ctMZpdsJ7s0zMTopkrsgJGuD+
        KetPdrboZX7QB5a7xcbYXmV39
X-Received: by 2002:a05:6214:5283:b0:5ab:28aa:2418 with SMTP id kj3-20020a056214528300b005ab28aa2418mr4239283qvb.5.1680711684503;
        Wed, 05 Apr 2023 09:21:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350YeEZE1FQ6tTFOskybFt6nu2lyCqx7Q0qjeaKoCuLQMr/TOBdD8r8iOpQhc2I3GPY1Ooa0Olw==
X-Received: by 2002:a05:6214:5283:b0:5ab:28aa:2418 with SMTP id kj3-20020a056214528300b005ab28aa2418mr4239261qvb.5.1680711684174;
        Wed, 05 Apr 2023 09:21:24 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id h10-20020ac846ca000000b003e302c1f498sm2337539qto.37.2023.04.05.09.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 09:21:23 -0700 (PDT)
Date:   Wed, 5 Apr 2023 12:21:21 -0400
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH 16/29] selftests/mm: UFFDIO_API test
Message-ID: <ZC2gAQZAmkYhEH4f@x1n>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160752.3107283-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230330160752.3107283-1-peterx@redhat.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 12:07:52PM -0400, Peter Xu wrote:
> +int uffd_open(unsigned int flags)
> +{
> +	int uffd = uffd_open_sys(flags);
> +
> +	if (uffd < 0)
> +		uffd = uffd_open_dev(flags);
> +
> +	return uffd;
> +}

A (benign) accident when rebasing here..  I'll move this function into
"selftests/mm: Add framework for uffd-unit-test" which is its first usage.

-- 
Peter Xu

