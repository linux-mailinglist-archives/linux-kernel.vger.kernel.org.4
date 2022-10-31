Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D486138CC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbiJaOPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiJaOPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:15:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6AF1131
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 07:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667225683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LTs94zq/shOCy359RmNZp+4/qUMkgxFrS5T5YTdFLQE=;
        b=iadQHgxjWA4nOg4uP/1tWX9jxran0mRwmZw+3tdbMepB97epsMXjVDvj9ORfAaNWN3ME70
        W9gMfmy19CEvcAlqlGdc27JizvSyPxklnwqtbvwFRZ924SQE97d1TjnsKfJ4PUwNmjaGf6
        YjsX6nILAZlMqYrYUGUI/6I748UKxfE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-530-X0rTXUj4M66BU4ZaXuR86w-1; Mon, 31 Oct 2022 10:14:41 -0400
X-MC-Unique: X0rTXUj4M66BU4ZaXuR86w-1
Received: by mail-qk1-f199.google.com with SMTP id i11-20020a05620a404b00b006eeb0791c1aso9543891qko.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 07:14:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTs94zq/shOCy359RmNZp+4/qUMkgxFrS5T5YTdFLQE=;
        b=KfXMumS53x8/QRIh22jBR1UmtVFO/8llE7mRSpJmkO71WuDZsyHGFRDWGFkMRmqDRa
         PZWZ58pxwO/NclMR2DWXea+JwAFHZs+GvxXNGTHYs+oYh73Lryugi5G0oUYusUU8ILZh
         2FpjmGkJWvarDeLhhVCTncNA3dVxD76G2U7t+zjmPD/FNDBQRycmUfh5J4/2TC5XrEMt
         xXcmaTLZnv0sanyvqBMsb+v8ybaIzllKCmQnd2HJfiT9bBhEqHgJf4Dq70bUpjUSqTDn
         IZweAi2qf51XMjOm7z/YDmcDgSpkO2s/YMt5qb2y4ttTo0SQTy9V1xn72qV0j7sM7fyR
         xUbQ==
X-Gm-Message-State: ACrzQf2cpoq9nSx9iTpXiUdfRr9QC5fPKk0s+cT6sampdtEZ3ck4h8NK
        HD57fNx2C/zVcmTA9Y9RUhYncvwTX2XpL474ifzWcjyILRma8tSH6Nuoz0AzN09kSiG+VQ4rRBn
        5RkF3XDVW5kgyUOWL4m9NHvYp
X-Received: by 2002:a05:620a:215e:b0:6e7:dafb:a71a with SMTP id m30-20020a05620a215e00b006e7dafba71amr9315729qkm.61.1667225681459;
        Mon, 31 Oct 2022 07:14:41 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7bVyEw/34BP+lHFL+RXtnVPg+QNYFQTs2hEwQOQ7unwXixqknY5SeloWiMVBGh7TYvquRTlw==
X-Received: by 2002:a05:620a:215e:b0:6e7:dafb:a71a with SMTP id m30-20020a05620a215e00b006e7dafba71amr9315706qkm.61.1667225681219;
        Mon, 31 Oct 2022 07:14:41 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id h4-20020a05620a284400b006b615cd8c13sm4665283qkp.106.2022.10.31.07.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 07:14:40 -0700 (PDT)
Date:   Mon, 31 Oct 2022 10:14:39 -0400
From:   Peter Xu <peterx@redhat.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 0/2] mm: Use pte marker for swapin errors
Message-ID: <Y1/YT9/PcF6kx/gq@x1n>
References: <20221030214151.402274-1-peterx@redhat.com>
 <87h6zkepog.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h6zkepog.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 09:40:15AM +0800, Huang, Ying wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > rfc->v1:
> > - Rename SWAP_ERROR -> SWAPIN_ERROR [David, Miaohe]
> > - Added r-bs for Ying and Miaohe
> >
> > Hi,
> >
> > This series uses the pte marker to replace the swapin error swap entry,
> > then we save one more swap entry slot for swap devices.  A new pte marker
> > bit is defined.
> 
> Per my understanding, "swap entry" describes one swap page (4KB on x86)
> in one swap device.  So, the original swapin error implementation uses
> one swap file (or swap device) instead of one swap entry.  So your patch
> saves one swap file (or swap device).

Yeah I was definitely not accurate enough, I wanted to use "slot" to mean
"type" here but obviously I didn't make it, sorry.  Hopefully the whole
patchset is still clear enough anyway so no reader will get confused by it.

-- 
Peter Xu

