Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD9B6CCD47
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 00:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjC1WfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 18:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjC1WfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 18:35:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996AE2D75
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680042845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vkpdjubpMQjiQrtoGJ7oK57t1Yfgq8+XT8+ZZ9ZSzy4=;
        b=UiWHKJJ6ICsP19TzoZ0Hg9Dpc643ubm3785YrpgSvXM+oQfLs00vtfnl0euY8vn7UoGmXv
        D2flF0HuDlbpBwSBeNkiVf7h6PfNhq8cr9CBv50j7UvCw9AwEIF87pdECBB4TnJdFwQngy
        h0OlFh97Fk3XFhX2x19UzFy5RuXHsMU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-TVQ-YffgOa-PDgxezWauCA-1; Tue, 28 Mar 2023 18:34:04 -0400
X-MC-Unique: TVQ-YffgOa-PDgxezWauCA-1
Received: by mail-qk1-f197.google.com with SMTP id z187-20020a3765c4000000b007468706dfb7so6349143qkb.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680042844; x=1682634844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkpdjubpMQjiQrtoGJ7oK57t1Yfgq8+XT8+ZZ9ZSzy4=;
        b=AZczk1Mh6wurbdjl6t9vtWB/nKWbL6xya8PptTCNoNlF0/VwbzjQaEWRLPuyeon4D/
         YZdHV+WZD3KdYmMatPYglJI9h6/SKPFIc+rtqxu/jax+Ezz2ZhprrdD8+xbE/C4bpS69
         hc7HOVQ+Vayhq5ItAna8QYtaX0YL7y/QspI0WRfJEnroIvl3xVGaiSjwI1/C0+y3DozJ
         eEmaoXztUjKnFT9FIEfrSeJ90jxoS8t/kImhFMfsj1MQrHLsnG1pT1Waya6mLn31EYK7
         y5DptY4FjeD2HKFUva0ybW0mQP4XYlbioxAhe8nZ7Yg9g/3GfyxNpt+d2yeCo9aKDj3S
         gOlQ==
X-Gm-Message-State: AAQBX9d8C4J20JZoo1PjTgoC41+p4o+fseyvlNZG7EMHJHZ591+y95wn
        SyV6+3/zwAL3Zwg/bhOLECSDYrCfTXGm39W1W4CeAkYmbbBWhXzbHMYa6QIIbA3xcMMA+PymlkQ
        xXOC67qy561bsvE3JNDUlbdon
X-Received: by 2002:a05:6214:5193:b0:5de:5da:b873 with SMTP id kl19-20020a056214519300b005de05dab873mr18587368qvb.3.1680042843875;
        Tue, 28 Mar 2023 15:34:03 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZlkAe0JI1+oDavIAHK0xd280kRJjj3GuPG2q8zblgmaz2X3JUxxxw5dA5sSDbyGlM93yJtow==
X-Received: by 2002:a05:6214:5193:b0:5de:5da:b873 with SMTP id kl19-20020a056214519300b005de05dab873mr18587348qvb.3.1680042843586;
        Tue, 28 Mar 2023 15:34:03 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id 11-20020a37030b000000b00745a55db5a3sm12310243qkd.24.2023.03.28.15.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 15:34:02 -0700 (PDT)
Date:   Tue, 28 Mar 2023 18:34:01 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] userfaultfd: don't fail on unrecognized features
Message-ID: <ZCNrWRKl4nCJX3pg@x1n>
References: <20220722201513.1624158-1-axelrasmussen@google.com>
 <ZCIEGblnsWHKF8RD@x1n>
 <CAJHvVcj5ysY-xqKLL8f48-vFhpAB+qf4cN0AesQEd7Kvsi9r_A@mail.gmail.com>
 <ZCNDxhANoQmgcufM@x1n>
 <CAJHvVcjU8QRLqFmk5GXbmOJgKp+XyVHMCS0hABtWmHTDuCusLA@mail.gmail.com>
 <ZCNPFDK0vmzyGIHb@x1n>
 <CAJHvVciwT0xw3Nu2Fpi-7H9iR92xK7VB31dYLfmJF5K3vQxvFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVciwT0xw3Nu2Fpi-7H9iR92xK7VB31dYLfmJF5K3vQxvFQ@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 02:52:35PM -0700, Axel Rasmussen wrote:
> I don't see being very strict here as useful. Another example might be
> madvise() - for example trying to MADV_PAGEOUT on a kernel that
> doesn't support it. There is no way the kernel can proceed here, since
> it simply doesn't know how to do what you're asking for. In this case
> an error makes sense.

IMHO, PAGEOUT is not a great example.  I wished we can have a way to probe
what madvise() the system supports, and I know many people wanted that too.
I even had a feeling that we'll have it some day.

So now I'm going back to look at this patch assuming I'm reviewing it, I'm
still not convinced the old API needs changing.

Userfaultfd allows probing with features=0 with/without this patch, so I
see this patch as something that doesn't bring a direct functional benefit,
but some kind of api change due to subjective preferences which I cannot
say right or wrong.  Now the patch is already merged.  If we need to change
either this patch or the man page to make them match again, again I'd
prefer we simply revert it to keep everything like before and copy stable.

Thanks,

-- 
Peter Xu

