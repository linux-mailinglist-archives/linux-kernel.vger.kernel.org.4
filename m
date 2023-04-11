Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891366DE484
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 21:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjDKTOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 15:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjDKTOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 15:14:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7651A420E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 12:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681240402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z6FiPt73jUvE9HN/xxHQnIU3dr3lCFLdEnuNJPVYshY=;
        b=EA8xy2pW/K9mN53j+z9HIbRltkmwUOs1JUGPM2v5n6cdOcAbV03oA4pZdMdtyTYnS2+ba0
        h7DS23aaSTyPJCkxMhy3VmFnCS7QACJ+gxBctu+Iw1Y3A3i820HMCfKrGCplpjU3kl0mot
        3OBJgY2bDKZiY7JoVYEuLV0bYfcelIo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-uljfVgt8OOON4wze-Zjc9Q-1; Tue, 11 Apr 2023 15:13:20 -0400
X-MC-Unique: uljfVgt8OOON4wze-Zjc9Q-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-5e9b05246edso2112986d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 12:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681240400; x=1683832400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6FiPt73jUvE9HN/xxHQnIU3dr3lCFLdEnuNJPVYshY=;
        b=xK9K8JOwPC7vMTNxmEiSuTZkg8RSofOvMSjXWiSdb/Ymgt+R3K+qtjaeuebgiv6UAj
         JkWijsItq2fkt+KEg7g0id/YlpLPhtDlJQR7fnX7/+csleHQlgO8+1/yrprgFajAjUQ5
         G7iGjF7TqOSzY53YtA8xKYX5TsMtzrHewSfy7ecmqboKEBpNANdPh7rTOomKa2FFX4Rw
         K3UjfLlziHG8UYgre34IdbojuPv17x4QSQ6ri4C9keYDVByCJGQgBobss3dMe279npPq
         hvajaDs2UHvKGtGOnJuwVgclzaadM7nYneDovEf/JfL7dF7PNOpEfbRxwq+ADmZ3CHE3
         A1xQ==
X-Gm-Message-State: AAQBX9e5pxNo1a6avaC6kxavDt4ZHnSufG1EaxFnWFRL1bRhGzjYtp8h
        jxES2ElTRejoxBm6h1LvFNjSQipl/DHfIJUE8sLX5fg3Jwnx+cEfE38DvmAtOzGDe7FhyOg2gmq
        XYP7m93K7MvZWM3+AKVUjqyHX
X-Received: by 2002:a05:6214:401a:b0:5aa:14b8:e935 with SMTP id kd26-20020a056214401a00b005aa14b8e935mr432354qvb.2.1681240400425;
        Tue, 11 Apr 2023 12:13:20 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yz/PVf5BMXpbem+zIl11PzhPIN0ay8hXNJgJqOaO3WtVPZPih40W1kkIj33fXsyBeTAw9RWA==
X-Received: by 2002:a05:6214:401a:b0:5aa:14b8:e935 with SMTP id kd26-20020a056214401a00b005aa14b8e935mr432338qvb.2.1681240400187;
        Tue, 11 Apr 2023 12:13:20 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id f9-20020ad442c9000000b005e26dcaa159sm4320158qvr.25.2023.04.11.12.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 12:13:19 -0700 (PDT)
Date:   Tue, 11 Apr 2023 15:13:18 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH 14/29] selftests/mm: uffd_[un]register()
Message-ID: <ZDWxTsJUTS1OSjJw@x1n>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160747.3107258-1-peterx@redhat.com>
 <ZC/5xstCOs8wp6nK@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZC/5xstCOs8wp6nK@linux.ibm.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 02:08:54PM +0300, Mike Rapoport wrote:
> > @@ -96,11 +95,7 @@ static void register_region_with_uffd(char *addr, size_t len)
> >  	 * handling by the userfaultfd object. In mode, we request to track
> >  	 * missing pages (i.e., pages that have not yet been faulted in).
> >  	 */
> > -
> > -	uffdio_register.range.start = (unsigned long)addr;
> > -	uffdio_register.range.len = len;
> > -	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
> > -	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1) {
> > +	if (uffd_register(uffd, addr, len, true, false, false)) {
> 
> I'd replace booleans with a bit flags as it easier to read.
> Other than that LGTM.

It was mostly for no need to remember the long names of macros, and easier
when conditionally set with some modes. E.g., we have 5 callers have things
like:

  uffd_register(..., test_uffdio_wp ? UFFDIO_REGISTER_MODE_WP : 0);

The bools simplifes it to:

  uffd_register(..., test_uffdio_wp, ...);

But let me know if you still think that's better - I can switch here.

Thanks,

-- 
Peter Xu

