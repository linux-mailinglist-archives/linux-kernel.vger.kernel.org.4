Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95D6713A5A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 17:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjE1PNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 11:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1PNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 11:13:52 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FBEA7;
        Sun, 28 May 2023 08:13:48 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f6e72a1464so16259805e9.1;
        Sun, 28 May 2023 08:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685286827; x=1687878827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nO6qPJGhbjer7by395A2CsUOuGSa2fR1VydRgyfgHDk=;
        b=muEmw45P+vBYLFTffVyZpNO7Xrm+sxE4SfNKgVe8dRovDTkLpaY1153jNpGflGRLyx
         00LKoVS0AgttlrxxSVQ2/LMhCMBsW5QhCxbfkY7uMqBSLw3snq7u2ApW3jGPafeAWHiF
         n3aqexArb+wjWhHm4yoyF6MBaQmbZMSrMwJSonlHZA/BvbgZlSU//Joie6ePKskxYV2w
         Eori3WAwCWAV7i20uZF/juTVdeC+oY3Ezw2ry3fCLIFO4+AaPRWiJ3i+XeRsCtEyxNvP
         aqO6PkbWZayCyaNCUEO/DWitdk6E4L9Vr2zZ3LCnpfWAkvklKoefjRXFWl4p4a3IxfjT
         VWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685286827; x=1687878827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nO6qPJGhbjer7by395A2CsUOuGSa2fR1VydRgyfgHDk=;
        b=grMFH5zsG8ROFAnteUIrxh3amm+pD1GM2NapCC1PHO8QqUqjwBXKdyfDZ7O9qdnK2x
         t4tX15krJSMc9boR6sPFCagoOwf8pZJd1pVbxKqtt3Ctxxflg3lslHHbAQiLVFgqpCFU
         cO1x4UpDelLCzcafsTiMFNuE+kBpWZoiNTTfUrnmlHX73YMd0WhqdOYyzoaPswaaPbsH
         BVSdy2tXRiINBv9+ktOPa8o2BryJx0apkaKjilDZXBbYz3BMuD/TxFfV2YdtlHgZP6Sb
         L5rzCNMxmiWTe3b+QmMj5ogfXAWWxdeg3RvUPQX7dK47xuqsNCZfc4o5I1GmSGaMZNBc
         pK/Q==
X-Gm-Message-State: AC+VfDw4ZeBoCA5I84t1/QrxRx0YeuYuPGCLGnnvzGInQv5fY6+vyu+b
        rG7KP/Aeq6wmbC+H8dLvhLk=
X-Google-Smtp-Source: ACHHUZ6upY0LxibB0+d/OjXuVJ8gDVl67OPt4kAEPLpVmfcLyBt7kE5+uyvnqX2TM52So4QBcmzDtQ==
X-Received: by 2002:a05:600c:214f:b0:3f6:97e:b45d with SMTP id v15-20020a05600c214f00b003f6097eb45dmr7130383wml.24.1685286826878;
        Sun, 28 May 2023 08:13:46 -0700 (PDT)
Received: from localhost (host81-154-179-160.range81-154.btcentralplus.com. [81.154.179.160])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c214700b003f4f89bc48dsm15111555wml.15.2023.05.28.08.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 08:13:45 -0700 (PDT)
Date:   Sun, 28 May 2023 16:13:44 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] [suggestion] mm/gup: avoid IS_ERR_OR_NULL
Message-ID: <617c2e26-8450-4a35-9b47-c0482921f030@lucifer.local>
References: <20230519093953.10972-1-arnd@kernel.org>
 <5b071f65-7f87-4a7b-a76a-f4a1c1568ae7@lucifer.local>
 <ZGf1hV7iEQyqAim5@ziepe.ca>
 <1ca47b8a-292c-47ab-aa6f-ca24fdfc0d3c@lucifer.local>
 <ZGiEEPXdAMnKqkqx@nvidia.com>
 <0bc9dc2b-0da6-4d5c-96af-e21aa287eecb@lucifer.local>
 <ZHHSwRzksE+KukTK@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHHSwRzksE+KukTK@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 27, 2023 at 06:52:01AM -0300, Jason Gunthorpe wrote:
> On Sat, May 20, 2023 at 10:12:40AM +0100, Lorenzo Stoakes wrote:
> > > No, this returning 0 on failure is a foot gun. Failing to pin a single
> > > page is always an error, the only question is what sub reason caused
> > > the error to happen. There is no third case where it is not an error.
> >
> > The uprobe path thinks otherwise, but maybe the answer is that we just need
> > to -EFAULT on missing VMA and -EPERM on invalid flags.
>
> I think uprobe is just broken to think there is a third outcome. Let's
> just fix it instead of trying to pretend it makes sense.

Sure, will take a look at that if I get a chance. We can at the very least
adjust get_user_page_vma_remote() with this fixed.

Do you feel that a partially successful pinning for other GUP callers
should equally be treated as an error (and pages unpinned -> return error
code)? In that instance we'd need to audit things somewhat.

I have a couple more GUP cleanups saved up, so could add that to my queue
of things to look at between book work :)

>
> Jason
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
