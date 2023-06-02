Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5197720669
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbjFBPkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbjFBPkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:40:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D9B18C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 08:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685720357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uD2qZ/qBPDgZT2JpIjaNujnRPmSBG4jkPCjfmwc9oFg=;
        b=UaiaLDZGVhkIwwuK8l57dNotx5tzabqe9m8pcSbATN98IBwgPQ2fPk8XR9cXRiX2RHRdcl
        Tl8+W820CPdvOGE0qIlC9QW8ssQQ/INC4WVdWRVVOZapR4LVt9NN16PK/ibIlG/ydov9iO
        3dMYC216zdBCcjr4GrcYsA5g1q6Zp1A=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-QkamSmpTOamEEHBhuEHbgw-1; Fri, 02 Jun 2023 11:39:16 -0400
X-MC-Unique: QkamSmpTOamEEHBhuEHbgw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-62829b2aa10so2213716d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 08:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685720053; x=1688312053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uD2qZ/qBPDgZT2JpIjaNujnRPmSBG4jkPCjfmwc9oFg=;
        b=V1SWR9QmQUX3k5hn57Hvy6krjYqhNc0RlMH3lbVoMNhRx6nKyrlH1JJ8nq4ADilvwW
         2qlSLJ7mUC7u1Dfz4ncrMUuxTsDvo2NhzlfHcGauIXHz8TxeLYBnJjKweZktHN3T0q+P
         v8RXp2f3MSXZ6exKOc1Tbd7p72YqqElniYIso0stTZ+CSKgW289oi1HxjHhOWkykzedF
         6e//TLC1EAYjmXWwEyA64mipQYF7H5Q+cg5qct+fogX8w/hcL1HMrKBEecNxeif/8LZj
         WIBl+1FFK1uSU1myOQCYwFXv2rRWhTY8JR4SUGXS74Y1W4/WR9MxPFBep3vPX1YML13S
         sjog==
X-Gm-Message-State: AC+VfDz3pHcfEKNb8ZYJVCfKBOHNthEgy/ggbXC6ZtO8vgIAYFWSrkot
        uw7p/KrUqrVannZNP93sMGLTKEVsvzMC5s/u4vYc0o2NenmCpU1xE17fBBCy1hZV6/MScXGsYyB
        dvELcZjDTAr1ZYwx1fjgOQTsTKqMpzjA6
X-Received: by 2002:a05:6214:27c9:b0:624:dcc5:819f with SMTP id ge9-20020a05621427c900b00624dcc5819fmr14033515qvb.1.1685720052849;
        Fri, 02 Jun 2023 08:34:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ67nKBkF1jqjQP2JomHmChO+t94LOD9xFbjI7zyZuubFq3mLRke90T5US2VBjRhPerN+vUzzw==
X-Received: by 2002:a05:6214:27c9:b0:624:dcc5:819f with SMTP id ge9-20020a05621427c900b00624dcc5819fmr14033495qvb.1.1685720052553;
        Fri, 02 Jun 2023 08:34:12 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id p8-20020a0cfd88000000b00623927281c2sm946905qvr.40.2023.06.02.08.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 08:34:11 -0700 (PDT)
Date:   Fri, 2 Jun 2023 11:34:10 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/12] selftests/mm: fix invocation of tests that are run
 via shell scripts
Message-ID: <ZHoL8vJPIUzP2RKN@x1n>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-6-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230602013358.900637-6-jhubbard@nvidia.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 06:33:51PM -0700, John Hubbard wrote:
> We cannot depend upon git to reliably retain the executable bit on shell
> scripts, or so I was told several years ago while working on this same
> run_vmtests.sh script. And sure enough, things such as test_hmm.sh are
> lately failing to run, due to lacking execute permissions.
> 
> A nice clean way to fix this would have been to use TEST_PROGS instead
> of TEST_FILES for the .sh scripts here. That tells the selftest
> framework to run these (and emit a warning if the files are not
> executable, but still run them anyway).
> 
> Unfortunately, run_vmtests.sh has its own run_test() routine, which does
> *not* do the right thing for shell scripts.
> 
> Fix this by explicitly adding "bash" to each of the shell script
> invocations. Leave fixing the overall approach to another day.

Is it possible someone just doesn't have "bash" at all?  I used to only use
"sh" without bash installed I think, but that was not on Linux, so I'm not
sure how much that applies..

Maybe use $(SHELL)?  I saw a bunch of usage in the tree too.

-- 
Peter Xu

