Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9876D121E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjC3W3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjC3W3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:29:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04577C17E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 15:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680215291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ULC/HBV/7CZFRuQfLV54dZLIGK3tnK9UHOG46WhNr2I=;
        b=KPvIU9sgqGahtvwgGlV3CNDN63OPOyQgw+p/LN5yZ98B7I5QcTihMmkYaR1iyzIuX9ibz0
        TG7bAIysj8kuI3BWc16d7cj1Q9sjymczZ3zzZggEMMcb+UiHVvHxtYDZSgyXXwCoUwn+7r
        Xvwwh/EiZcCOzku9d5gHQTmjEbbFsjw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-B5TSYhsnMWq-76UWUjDOkA-1; Thu, 30 Mar 2023 18:28:09 -0400
X-MC-Unique: B5TSYhsnMWq-76UWUjDOkA-1
Received: by mail-qv1-f72.google.com with SMTP id l18-20020ad44bd2000000b005a9cf5f609eso8960192qvw.15
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 15:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680215289; x=1682807289;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ULC/HBV/7CZFRuQfLV54dZLIGK3tnK9UHOG46WhNr2I=;
        b=QakCgfu99JtdrJ4UOMbsnAd+lwV8DQif6wzZ6DP6NuvEzaXbhIffZya+vYeA7IJJ5y
         lnz/jkZWyLReoPjpT8KBFGnGXgNcvtHuI24oir/VqKx213Pxvf8XX7wDTCZKaSO90BDq
         W0PGn7asnUgTJtrMY2WRgDP1bIKrRP8yuwgRk6RVdfGFyQgrzasMdXahmqW0vvZMJiSm
         mrcpas6RLcS7qYqtrvRp3TQRds4M1eSTSJ2PFD6ny1HDzS7snZo6F86iczNlP5HgaSuS
         jPiX0Z3H6LuVICEb+HeERjOE3UYXWLa5HNgUjK26vRKIdZf1gdE2fUrHW2Yo2U0QPZj/
         GkSQ==
X-Gm-Message-State: AAQBX9dlcE0T/25WezjAS1vuHCag2d1AYyABAaye+AgCRSqgs1iwVw5t
        /iHQXh7Tpuu1UjT4EFBZgLDCYuz+xIf5gXypbK+CoqsxGFnak1o0CxJyXwsLN17Q5cCVKqAT9L8
        cc1Sm9t2bbBBzKCDco7zQ2yfK
X-Received: by 2002:ac8:7d56:0:b0:3e2:ccf9:bf96 with SMTP id h22-20020ac87d56000000b003e2ccf9bf96mr6542356qtb.1.1680215289387;
        Thu, 30 Mar 2023 15:28:09 -0700 (PDT)
X-Google-Smtp-Source: AKy350YKjAMLZAUVJh4CtZ5TZF8rqQt4SfPZZvlrc2tPeFEO2G6SSONhU0BamzMoZ1+Ak6vhWHrDpA==
X-Received: by 2002:ac8:7d56:0:b0:3e2:ccf9:bf96 with SMTP id h22-20020ac87d56000000b003e2ccf9bf96mr6542339qtb.1.1680215289166;
        Thu, 30 Mar 2023 15:28:09 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id q12-20020ac8450c000000b003dd8ad765dcsm169428qtn.76.2023.03.30.15.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 15:28:08 -0700 (PDT)
Date:   Thu, 30 Mar 2023 18:28:07 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH 03/29] selftests/mm: Dump a summary in run_vmtests.sh
Message-ID: <ZCYM94ifcsZYCkJq@x1n>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160646.3106903-1-peterx@redhat.com>
 <CAJHvVciUGEfdgTLHUxAxCpKxXbMt202nsPhArsckHm7bDOdqFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJHvVciUGEfdgTLHUxAxCpKxXbMt202nsPhArsckHm7bDOdqFg@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 12:07:24PM -0700, Axel Rasmussen wrote:
> On Thu, Mar 30, 2023 at 9:06 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > Dump a summary after running whatever test specified.  Useful for human
> > runners to identify any kind of failures (besides exit code).
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  tools/testing/selftests/mm/run_vmtests.sh | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> > index c0f93b668c0c..9cc33984aa9f 100644
> > --- a/tools/testing/selftests/mm/run_vmtests.sh
> > +++ b/tools/testing/selftests/mm/run_vmtests.sh
> > @@ -5,6 +5,9 @@
> >  # Kselftest framework requirement - SKIP code is 4.
> >  ksft_skip=4
> >
> > +count_pass=0
> > +count_fail=0
> > +count_skip=0
> >  exitcode=0
> >
> >  usage() {
> > @@ -149,11 +152,14 @@ run_test() {
> >                 "$@"
> >                 local ret=$?
> >                 if [ $ret -eq 0 ]; then
> > +                       count_pass=$(( $count_pass + 1 ))
> 
> Actually, inside $(( )) there's no need to prefix variable names with
> $ too. Running "shellcheck" over the script written this way will
> generate a warning.
> 
> Same applies below.

Sure, I'll fix.

> 
> >                         echo "[PASS]"
> >                 elif [ $ret -eq $ksft_skip ]; then
> > +                       count_skip=$(( $count_skip + 1 ))
> >                         echo "[SKIP]"
> >                         exitcode=$ksft_skip
> >                 else
> > +                       count_fail=$(( $count_fail + 1 ))
> >                         echo "[FAIL]"
> >                         exitcode=1
> >                 fi
> > @@ -279,4 +285,6 @@ CATEGORY="soft_dirty" run_test ./soft-dirty
> >  # COW tests
> >  CATEGORY="cow" run_test ./cow
> >
> > +echo "SUMMARY: PASS=${count_pass} SKIP=${count_skip} FAIL=${count_fail}"
> > +
> >  exit $exitcode
> > --
> > 2.39.1
> >
> 
> Besides the nitpick:
> 
> Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

Thanks!

-- 
Peter Xu

