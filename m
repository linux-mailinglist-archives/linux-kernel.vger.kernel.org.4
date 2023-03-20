Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947796C154F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjCTOp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjCTOor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:44:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9526585
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679323440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MkxAqySEXMl0R33PqRVjUbl51OSwhSQixWd8OI14xk4=;
        b=AQ9ZEpQxT76hRKCB1bVT+S1s4DNqDOdi+BhNlUJJgrsi4wVPWx2Hz9DFNcqhRxIntAlVpO
        7Lqs0p+yVpTHYZfxqxxE+x+6jVvUWYURe64jPtAJmzC6eFkRKqUQp6QzLI5NuiGM4JRqhR
        dVD5blZGDi8LQVdDOKOErbcTuIdx2s8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-CzIkRHnvMl2kBeV95hzCSQ-1; Mon, 20 Mar 2023 10:43:59 -0400
X-MC-Unique: CzIkRHnvMl2kBeV95hzCSQ-1
Received: by mail-qk1-f197.google.com with SMTP id 203-20020a370ad4000000b00746981f8f4bso152050qkk.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679323438; x=1681915438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkxAqySEXMl0R33PqRVjUbl51OSwhSQixWd8OI14xk4=;
        b=0OsiCZvBkJKirgDVWGRGNYwxn9U5jGysxAUDVs7wVo1oPVEHeVXV/pHHMOiB/wTz67
         Y+5BiA6sIRKzKviGi+In7Ulh8OMBABdnytgq+A+6AMOPYH+Bx47sRdi0EWIu8sV0Zi73
         9p86a2OJX2SdKXS5w40iCL/n0x3/5MDKNWLSVuFLn7QoCV41YFZ3yBzvaoEq6HRzez6V
         eOu3pqKgpnVpF/Gz6+9700JX3bRWM89TnvyEi+V4Oc8BjRq/QQnbI4UFZYWFRglXPyUQ
         id8rD8ql9lPGxsfxN71q1Fnj466Zu6HCKnQgRVns1BzWjNx2jqyfZv/6jLkHPhwTpVCK
         L32Q==
X-Gm-Message-State: AO0yUKV3I+ANkgFE/TX6oVPlDQIOBlAS9cPFVhP26HoUH4X5a3EYchud
        zG44uN9XPgY04ntbpXDPRosJzxMvq6WPWsIAVgpay1WULhf3qe9RDY2SU0J/qIcGoHvuuB5Fm+O
        wB8N0pqs06FLtb8k9VdwqKCi5
X-Received: by 2002:a05:6214:224f:b0:5ab:af50:eb45 with SMTP id c15-20020a056214224f00b005abaf50eb45mr33845736qvc.3.1679323438487;
        Mon, 20 Mar 2023 07:43:58 -0700 (PDT)
X-Google-Smtp-Source: AK7set94Mxdb5LXI5fakGqoQUEz6o2Jw3M+bhIYPR7UKsBQKN5OuQZCRLIwwCui0WSKxTLGej/NOBg==
X-Received: by 2002:a05:6214:224f:b0:5ab:af50:eb45 with SMTP id c15-20020a056214224f00b005abaf50eb45mr33845711qvc.3.1679323438265;
        Mon, 20 Mar 2023 07:43:58 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id g2-20020a37b602000000b0071aacb2c76asm7262870qkf.132.2023.03.20.07.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:43:57 -0700 (PDT)
Date:   Mon, 20 Mar 2023 10:43:56 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 2/2] selftests/mm: Smoke test
 UFFD_FEATURE_WP_UNPOPULATED
Message-ID: <ZBhxLOBocC7mCYDG@x1n>
References: <20230309223711.823547-1-peterx@redhat.com>
 <20230309223711.823547-3-peterx@redhat.com>
 <4ab36009-51c0-6583-4948-b267f8fbf32a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ab36009-51c0-6583-4948-b267f8fbf32a@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 11:25:43AM +0100, David Hildenbrand wrote:
> On 09.03.23 23:37, Peter Xu wrote:
> > Enable it by default on the stress test, and add some smoke tests for the
> > pte markers on anonymous.
> 
> Would it make sense to make kernel support optional and test both paths --
> once with the feature enabled (if available on the kernel we're testing) and
> once with the feature disabled?

Yeah, I think the current uffd selftest is not friendly to old kernels so I
made it simple - IOW the test should fail already on old kernels AFAIK.
Maybe I can prepare some patches this week or next to cleanup some parts of
it.

Thanks,

-- 
Peter Xu

