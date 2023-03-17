Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C07F6BEABE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjCQOKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjCQOJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:09:56 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40A61115B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:09:54 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id m6so3526393qvq.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1679062194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7soAOZz6NR1eZEWlBBPKzE8Phw744HY/clHBuCipMIQ=;
        b=GJE2sGyV/zNswHv/7z89KXA6Cb429VDXVVNbH4B5+f+XRZPbPKi7IKo29LF5wh/bbS
         bdV/flZ2c4Qx4e1cMLrbTXBz1PjOtmDDfuulOzISfCWtEomTOJH6MLe6CH10fL+8XBm3
         AOZVAtagi87V8voZUBBleOn0Zs6BO/iI7hGWfXhDRLiU3JzVB6q9g2VUZh5z+qY4pa1/
         XSH391RhIP9GWyxr2Tgv1F1po4q5/5IambFCWiIByQ+zTWbx6+4yMpjIz+/5mYd4DSaa
         X98LcGZOCKPUfaYjpG/Lq5k7yDyUqkPn/QwKPg0KXyH61oT/7A9LmCrPlIadxrOKznt3
         zzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679062194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7soAOZz6NR1eZEWlBBPKzE8Phw744HY/clHBuCipMIQ=;
        b=fv7ZySHuDpaVQEVYMb+hNUHmPEkU30aXiH9xE7cR3Ua3Cz1TNVzO5uhKDdXrPZCLN4
         YMDBADytnTrH9LMefu64DebjMchU2ZciDsLpAjMw7tuncGhPrkpVg36KE6DvmZzCMWQ4
         N7yr6R4M8SvC8DTeAsJkdQ1stlcOZsF12s6uGXySml0qY2zNoDFCv1ZUasZiI0va2pZs
         wsB8lzW7oGl09TPJwlwzXjwkiu/hnIldbM+2lYGG+k3pMqUczkgJg2BbMW2aeuZ+J2oK
         XQOcUZB41IUn7gcfsqdUJ6AU9wHYaaqJLTMMUFGx6keKhAP0IkoYwddqezVHCrBcscvI
         o7eg==
X-Gm-Message-State: AO0yUKXdhjGFiGNvzp+fAaqwQreY59loYkRA7xuaAtUmtN857Ky8Qjq0
        A1qM1gIedQ8Tb4y9zNX8TT7FdMD8UWQDS0WNnHs=
X-Google-Smtp-Source: AK7set+qN246fWnzI9pdVkkjz8IcefLkz8J54CXZP+n5oPR4V1S/SUbYc3X9+w7bLhhjTLghkaGjmA==
X-Received: by 2002:ad4:5962:0:b0:56e:9986:4fa9 with SMTP id eq2-20020ad45962000000b0056e99864fa9mr45763775qvb.7.1679062193817;
        Fri, 17 Mar 2023 07:09:53 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:62db])
        by smtp.gmail.com with ESMTPSA id 4-20020a370504000000b007458ae32290sm1693202qkf.128.2023.03.17.07.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 07:09:53 -0700 (PDT)
Date:   Fri, 17 Mar 2023 10:09:52 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yang Yang <yang.yang29@zte.com.cn>
Cc:     akpm@linux-foundation.org, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org
Subject: Re: [PATCH linux-next] mm: workingset: simplify the calculation of
 workingset size
Message-ID: <20230317140952.GA153257@cmpxchg.org>
References: <20230316143007.GC116016@cmpxchg.org>
 <20230317015903.16978-1-yang.yang29@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317015903.16978-1-yang.yang29@zte.com.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 01:59:03AM +0000, Yang Yang wrote:
> >On Thu, Mar 16, 2023 at 05:23:05PM +0800, yang.yang29@zte.com.cn wrote:
> >> From: Yang Yang <yang.yang29@zte.com.cn>
> >> 
> >> After we implemented workingset detection for anonymous LRU[1],
> >> the calculation of workingset size is a little complex. Actually there is
> >> no need to call mem_cgroup_get_nr_swap_pages() if refault page is
> >> anonymous page, since we are doing swapping then should always
> >> give pressure to NR_ACTIVE_ANON.
> >
> > This is false.
> >
> > (mem_cgroup_)get_nr_swap_pages() returns the *free swap slots*. There
> > might be swap, but if it's full, reclaim stops scanning anonymous
> > pages altogether. That means that refaults of either type can no
> > longer displace existing anonymous pages, only cache.
> 
> I see in this patch "mm: vmscan: enforce inactive:active ratio at the
> reclaim root", reclaim will be done in the combined workingset of
> different workloads in different cgroups.
>
> So if current cgroup reach it's swap limit(mem_cgroup_get_nr_swap_pages(memcg) == 0),
> but other cgroup still has swap slot, should we allow the refaulting page
> to active and give pressure to other cgroup?

That's what we do today.

The shadow entry remembers the reclaim root, so that refaults can
later evaluated at the same level. So, say you have:

root - A - A1
        `- A2

and A1 and A2 are reclaimed due to a limit in A. The shadow entries of
evictions from A1 and A2 will actually refer to A.

When they refault later on, the distance is interpreted based on
whether A has swap (eviction_lruvec).
