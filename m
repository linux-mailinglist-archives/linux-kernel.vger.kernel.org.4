Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04DE6E26C5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjDNPWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 11:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjDNPWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:22:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B030F1998
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 08:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681485714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zdbEwiahBwBXRaQHbJvtM9eClPW37i0c/e8eWpmB8cw=;
        b=QTi1ci9gvRt3oFkjOEuJHMnbFR2j2WaAGcr1k5+DjBg/y2FxJLIWPY3v9VL7pqlahXPaPM
        HMUFvWZhyywKDEG2EamtkpoFDYvPjCV/aje70eVza3DQcL+cMQAC87Q6LFlG1bzqtOitz6
        TOMUZx+CEKL/9MHi7nngH80x0PenRs8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-N_wJ-MRKNK2uOC2t7M1MCQ-1; Fri, 14 Apr 2023 11:21:53 -0400
X-MC-Unique: N_wJ-MRKNK2uOC2t7M1MCQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-74ad69ad9a1so20280185a.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 08:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681485713; x=1684077713;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zdbEwiahBwBXRaQHbJvtM9eClPW37i0c/e8eWpmB8cw=;
        b=Ip7fEcSs4W5btYjEo4Po6LAyx2aBu7pfy1gBSsUJPg582ie+kxMKBoUVCkVUHJ7Mwz
         UkdIan5wiUI/ikMFl/+0EvvVxY9nP2Bn4O2ygegPCmpO89ol9VeVxNxFbwzXEtVAmS6w
         kwUlpPYy1Wk/hygoO7uBa3jKSGiiDDyx7kmw2N/TgVVQ0mH1X2PmPjUTy9c/OyOHwi5k
         wsEfoSFYDf9dc2lY9YMhtZTUm9MuTSMddpye+fz/posXnUPb2Yf+dW5SrnPEd7v2KDTB
         TQZ0BFJkVbUdVpQsrMM13wDq5TtaH5V4c859fM7YMCeoVaAB2SveITXXwrjTb1kO4rZ5
         FWbQ==
X-Gm-Message-State: AAQBX9elnVdnm3nnwoLhZ2vcBe6FhuCiiLV/jTt6ICdTAb4XI0UH2cbD
        Lo6wgNUZ8P9IEqv8x0v8frgEKXSDhTmGrLSO70xkDjQeWcRpuqCnx7MaWcPWOnTEc/SZoRzdSmO
        m3Jvc1fahEOKJHMlT6H01GyHT
X-Received: by 2002:a05:6214:3001:b0:5ac:463b:a992 with SMTP id ke1-20020a056214300100b005ac463ba992mr4105657qvb.0.1681485712849;
        Fri, 14 Apr 2023 08:21:52 -0700 (PDT)
X-Google-Smtp-Source: AKy350YVMekG3fi9eYn45rlgF4IHcf6ljNGAcY26V2wE8u/UOoyEqKIJi7gtK1xsqy+LkNdk+7QsnQ==
X-Received: by 2002:a05:6214:3001:b0:5ac:463b:a992 with SMTP id ke1-20020a056214300100b005ac463ba992mr4105629qvb.0.1681485712554;
        Fri, 14 Apr 2023 08:21:52 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id ly7-20020a0562145c0700b005eb1611872asm1173774qvb.83.2023.04.14.08.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 08:21:51 -0700 (PDT)
Date:   Fri, 14 Apr 2023 11:21:50 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mika =?utf-8?B?UGVudHRpbMOk?= <mpenttil@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-stable <stable@vger.kernel.org>
Subject: Re: [PATCH 1/6] mm/hugetlb: Fix uffd-wp during fork()
Message-ID: <ZDlvjlcTXOyFTdaA@x1n>
References: <20230413231120.544685-1-peterx@redhat.com>
 <20230413231120.544685-2-peterx@redhat.com>
 <9cb84b60-6b51-3117-27cb-a29b3bd9e741@mbosol.com>
 <ZDlet0+oZ2nrnUdu@x1n>
 <d14ddbc6-5315-78a2-cdfa-72a77d3603dd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d14ddbc6-5315-78a2-cdfa-72a77d3603dd@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 05:23:12PM +0300, Mika Penttilä wrote:
> But the fixup not dropping the temp var should work.

Ok I see.  I'll wait for a few more days for a respin.  Thanks,

-- 
Peter Xu

