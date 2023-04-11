Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51836DE587
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjDKULf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjDKULe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:11:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9C059FC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681243763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K45z4IfIS5W9aFNj1M79VvTcq0if3B4l0IQI1OCADJQ=;
        b=FYiqk2sCBHF+5wc11gnS3r41tuDToEsB/cssDW8uY2UFHWuUjruZGhISkqdTA0UBpmR2w8
        uB+omiB3aCiUSI8MtKcPKaN006rMU1hYb7QgJ44HAdEIBpjwTZyvDB7aLCc/34BZGRppmf
        aZ45mA2ZBcvGqIiTkzne7pGQTvOccno=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-wUQybkdjORSiUQ-BQK6f9g-1; Tue, 11 Apr 2023 16:09:22 -0400
X-MC-Unique: wUQybkdjORSiUQ-BQK6f9g-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-5ef4122d2dbso150526d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681243762; x=1683835762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K45z4IfIS5W9aFNj1M79VvTcq0if3B4l0IQI1OCADJQ=;
        b=I7D6iwRZUsx2g8E7DQ295Dd5KFVmDFtkxONVBJ1egiLDGZNNRmioFdpt7qLyqYW0Ow
         8jkbtdItUvsYt4Yq9Is4CG3ahYcXjpKwrps3Ea5WB2goF4/JYI+Hudmta7jLI1uMnFMw
         NTW8Ec7qDF0Bl8KPcfeVFXh4bMrdtglLUE2JCYnB/BSWyKJ2NU0Psn6pfpBbwLHEKoxy
         m8ZiQ70qKVy+UrcJg2sSLwQcki6lI9lUrwLS7qAbdr2p+8uoJvTGEjlIKxmN9g44FUGy
         QsV1bYIDZieXnr4OyTkhb1psRcI4rK3/gUSRFCcd9C3cR4sSPSsT2IKd03BJ+TNJZD70
         Viog==
X-Gm-Message-State: AAQBX9f9jNEcfTicnXuAHTI8g5kA7BrPw6PPIT1Zm7s7DPk9epr0Bh5H
        33XBLHKNyGM6FdqnSW/dfv+ipM9/YzELWWQB1XExgkbC/0C64xALDdLZZjvon1IJ5qN2Cm1uPmC
        56dtmYeMnXWFbn27kRikYgAN0
X-Received: by 2002:a05:6214:5294:b0:5ad:cd4b:3765 with SMTP id kj20-20020a056214529400b005adcd4b3765mr666407qvb.1.1681243761902;
        Tue, 11 Apr 2023 13:09:21 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZCVgYw2bwsduB2+jIpza6191NF737UXdgYyngMJ9F5Jv++vn9ogCCGzim2cMadewXaMln8xA==
X-Received: by 2002:a05:6214:5294:b0:5ad:cd4b:3765 with SMTP id kj20-20020a056214529400b005adcd4b3765mr666375qvb.1.1681243761561;
        Tue, 11 Apr 2023 13:09:21 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id me3-20020a0562145d0300b005dd8b9345aesm4365069qvb.70.2023.04.11.13.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 13:09:21 -0700 (PDT)
Date:   Tue, 11 Apr 2023 16:09:19 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH 21/29] selftests/mm: Add framework for uffd-unit-test
Message-ID: <ZDW+byWzRP2WEbd3@x1n>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160818.3107545-1-peterx@redhat.com>
 <ZDU//1RXYUMIRMk3@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZDU//1RXYUMIRMk3@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 02:09:51PM +0300, Mike Rapoport wrote:
> > @@ -119,7 +220,31 @@ int main(int argc, char *argv[])
> >  		printf("Userfaultfd not supported or unprivileged, skip all tests\n");
> >  		exit(KSFT_SKIP);
> >  	}
> > +
> > +	for (i = 0; i < n_tests; i++) {
> > +		test = &uffd_tests[i];
> > +		for (j = 0; j < n_mems; j++) {
> > +			mem_type = &mem_types[j];
> > +			if (!(test->mem_targets & mem_type->mem_flag))
> > +				continue;
> > +			snprintf(test_name, sizeof(test_name),
> > +				 "%s on %s", test->name, mem_type->name);
> > +
> > +			uffd_test_start(test_name);
> > +			if (!uffd_feature_supported(test)) {
> > +				uffd_test_skip("feature missing");
> > +				continue;
> > +			}
> > +			if (uffd_setup_environment(test, mem_type)) {
> > +				uffd_test_skip("memory allocation failed");
> 
> Maybe uffd_test_skip("environment setup failed")?

Sure.

Side note: the line will be changed after "selftests/mm: Allow uffd test to
skip properly with no privilege" to contain an errmsg pointer instead, so
it won't affect the last result after series applied.

Thanks,

-- 
Peter Xu

