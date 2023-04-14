Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68006E24DF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 15:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjDNN5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 09:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDNN5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:57:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB406EAC
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 06:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681480572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8yn9oGKAtbnMyVx5qmj+QwSOhdyTGUCXsEIfV/06ERs=;
        b=BTYxOG6z7MBchoh03SPscrLhXOLoIlwupkbtADrERENlV52b/tZUFVKLKdE2wxOThiDABW
        7X9HwkdJoB27RbwEGZvV99uYvQfgvB0w+s0Y55aMWJEcEvsHVF3lgDKT8MsXavwlX7jXed
        h/sOHob/mFNGUGeoTe2zm+oGn1yaXcU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596--ymmk3GgPKqm8aprbXxh8w-1; Fri, 14 Apr 2023 09:56:10 -0400
X-MC-Unique: -ymmk3GgPKqm8aprbXxh8w-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3eab4df3ef0so1904761cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 06:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681480569; x=1684072569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yn9oGKAtbnMyVx5qmj+QwSOhdyTGUCXsEIfV/06ERs=;
        b=jvSVq8B3ZH6POhJB5fNdy4M+NGeWNYOxo5kk1y4Q7IWh8f5S+Yw0p3AQFqWgsw/+of
         3ccMoQFiXTNOOgZHN1KDbic53LwW3xdwSWHtLT2p0yyOnKtol47JeZ6V4DF3/DaTn7eU
         lssod5ePq0j9PM6YLPRqpNI4z+/L+ABu1ElNqnZaK9Yg0bbOn4XDdjxS9HR4s1sh1ONL
         v7H8quUB5e4W4W1ghhWrpgH7N9feJsn5+c/nEu6TWZES7lHBvLktCkp14bv0A9gx1gCW
         yU8oZmrmUmooFLtYuTg/wQ9tWXpQ6zTXM8fND6z26nDP5QyD5aHWD+3xBgFV8oLNm3cm
         3mxQ==
X-Gm-Message-State: AAQBX9fVUrlNdPuZ5WQQ74MaVSy+xnkqEGzf+4D3t7L2EK8EJH0e8ufU
        V5XBN0HiqCT9jSNAtDVZUrpZdxU/2HHNxL72dI2c2sB9xDNXWMKJ9nQjeEE1jU6u9Hzy8Cti6yd
        wo6xQWrwjdyVrZeCjDb/9Q3gR
X-Received: by 2002:a05:6214:518c:b0:5e9:2bad:c920 with SMTP id kl12-20020a056214518c00b005e92badc920mr3648618qvb.5.1681480569714;
        Fri, 14 Apr 2023 06:56:09 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y6jSBHPtk3IeCHhEIAEgf1fn1u4H0MiWLW2uD7te0NluZlZxk71Oq4NrecPTy5dpOduS7tJg==
X-Received: by 2002:a05:6214:518c:b0:5e9:2bad:c920 with SMTP id kl12-20020a056214518c00b005e92badc920mr3648582qvb.5.1681480569211;
        Fri, 14 Apr 2023 06:56:09 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id z11-20020a0cfecb000000b005ef5e68b4a0sm92193qvs.90.2023.04.14.06.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 06:56:08 -0700 (PDT)
Date:   Fri, 14 Apr 2023 09:56:07 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 5/6] selftests/mm: Rename COW_EXTRA_LIBS to
 IOURING_EXTRA_LIBS
Message-ID: <ZDlbdxxfj1yT8ImB@x1n>
References: <20230413231120.544685-1-peterx@redhat.com>
 <20230413231120.544685-6-peterx@redhat.com>
 <1a2544eb-7d42-eda3-fafa-9bed1377841d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1a2544eb-7d42-eda3-fafa-9bed1377841d@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 11:52:40AM +0200, David Hildenbrand wrote:
> On 14.04.23 01:11, Peter Xu wrote:
> > The macro and facility can be reused in other tests too.  Make it general.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   tools/testing/selftests/mm/Makefile        | 8 ++++----
> >   tools/testing/selftests/mm/check_config.sh | 4 ++--
> >   2 files changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> > index 5a3434419403..9ffce175d5e6 100644
> > --- a/tools/testing/selftests/mm/Makefile
> > +++ b/tools/testing/selftests/mm/Makefile
> > @@ -161,8 +161,8 @@ warn_32bit_failure:
> >   endif
> >   endif
> > -# cow_EXTRA_LIBS may get set in local_config.mk, or it may be left empty.
> > -$(OUTPUT)/cow: LDLIBS += $(COW_EXTRA_LIBS)
> > +# IOURING_EXTRA_LIBS may get set in local_config.mk, or it may be left empty.
> > +$(OUTPUT)/cow: LDLIBS += $(IOURING_EXTRA_LIBS)
> >   $(OUTPUT)/mlock-random-test $(OUTPUT)/memfd_secret: LDLIBS += -lcap
> > @@ -175,11 +175,11 @@ local_config.mk local_config.h: check_config.sh
> >   EXTRA_CLEAN += local_config.mk local_config.h
> > -ifeq ($(COW_EXTRA_LIBS),)
> > +ifeq ($(IOURING_EXTRA_LIBS),)
> >   all: warn_missing_liburing
> >   warn_missing_liburing:
> >   	@echo ; \
> > -	echo "Warning: missing liburing support. Some COW tests will be skipped." ; \
> > +	echo "Warning: missing liburing support. Some tests will be skipped." ; \
> >   	echo
> >   endif
> > diff --git a/tools/testing/selftests/mm/check_config.sh b/tools/testing/selftests/mm/check_config.sh
> > index bcba3af0acea..3954f4746161 100644
> > --- a/tools/testing/selftests/mm/check_config.sh
> > +++ b/tools/testing/selftests/mm/check_config.sh
> > @@ -21,11 +21,11 @@ $CC -c $tmpfile_c -o $tmpfile_o >/dev/null 2>&1
> >   if [ -f $tmpfile_o ]; then
> >       echo "#define LOCAL_CONFIG_HAVE_LIBURING 1"  > $OUTPUT_H_FILE
> > -    echo "COW_EXTRA_LIBS = -luring"              > $OUTPUT_MKFILE
> > +    echo "IOURING_EXTRA_LIBS = -luring"          > $OUTPUT_MKFILE
> >   else
> >       echo "// No liburing support found"          > $OUTPUT_H_FILE
> >       echo "# No liburing support found, so:"      > $OUTPUT_MKFILE
> > -    echo "COW_EXTRA_LIBS = "                    >> $OUTPUT_MKFILE
> > +    echo "IOURING_EXTRA_LIBS = "                >> $OUTPUT_MKFILE
> >   fi
> >   rm ${tmpname}.*
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Oops, I planned to drop this patch but I forgot.. I was planning to use
iouring but only later found that it cannot take RO pins so switched to
gup_test per your cow test.  Hence this patch is not needed anymore.

But since it's already there and looks like still good to have.. let me
keep it around with your R-b then.

Thanks,

-- 
Peter Xu

