Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0471462CDAC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbiKPW35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbiKPW3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:29:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEA3AE5D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668637734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jvzvnWWvvncWVJBoG4PM/NRp2jE+Ki/mZmdWbCmPuG8=;
        b=E9MstKDlqJIQV86kgcd3wuf5gwO0OGJE5lSvr/ZLhX2lk3Amfle/6TD9EjXH2RnG/XNWn3
        TNcQ+fnb4/plCs0DpnScrv1AUYkZwrI1Lm3RYZfN4j88PJHcLfmGdzlkx3S6Aw31Qtp6sg
        P6hWpoKp7JVoqB+cDClBQSIJe3ysK54=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-630-7UGhh377MyeBItNxeNqnNw-1; Wed, 16 Nov 2022 17:28:52 -0500
X-MC-Unique: 7UGhh377MyeBItNxeNqnNw-1
Received: by mail-qk1-f198.google.com with SMTP id w13-20020a05620a424d00b006e833c4fb0dso106739qko.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:28:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvzvnWWvvncWVJBoG4PM/NRp2jE+Ki/mZmdWbCmPuG8=;
        b=XVhkuM+BPDlGm1ryWwWrKBzzaGE7tNGhagGObQhC68WZo4JqJ4oGRpDGCFt1oxCErt
         +x34HCrk78Olnwt+ga8wLA/UY6YNTRjFwH8Ce5o0h+EfOWeSvEhJ6k4woA3zdEDb50FX
         OeMV89LXdrqm37WjswzrQm7Z2DUPbglg5muCUoXBeBdJibV5AAmMhV0290J99IwxkhXr
         mQvsrbEkfp3Kyfj7PGIvsi1Ny343B+bPCiXJ0rh9v1f5pUOgLpYAYwh9068Kz67NWvvf
         NgonGF3ZqC/OwvNbVGBkL6360bttPHATSsL3iJ6+BJ6iDNX955vD7PlGSY5fc15ipjE0
         Nz9w==
X-Gm-Message-State: ANoB5pnBsvgbfiEWIpHJohASG55CLvQldHvsVXGit5m9jHCZ8odqGP6n
        FqNGmIgjpkOuXuNhorJBZDw+SSn/n6niEbMEzid5eLd/beVnDNf/6659y890yqo4/ybHbIntlVL
        LuWyRngRBhR784SP8ZmW7OQdH
X-Received: by 2002:a05:6214:5e92:b0:4b4:128:3cb2 with SMTP id mm18-20020a0562145e9200b004b401283cb2mr166790qvb.80.1668637732370;
        Wed, 16 Nov 2022 14:28:52 -0800 (PST)
X-Google-Smtp-Source: AA0mqf76RjrKtkZ6fMY9tZlOEnFl1T1XlGZf1zYhtmOtdHNRH38EER6mAoQ5O8SR1Et9FDXPjqD5rQ==
X-Received: by 2002:a05:6214:5e92:b0:4b4:128:3cb2 with SMTP id mm18-20020a0562145e9200b004b401283cb2mr166759qvb.80.1668637732172;
        Wed, 16 Nov 2022 14:28:52 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id u184-20020a372ec1000000b006f9e103260dsm10617212qkh.91.2022.11.16.14.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 14:28:51 -0800 (PST)
Date:   Wed, 16 Nov 2022 17:28:49 -0500
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 33/47] userfaultfd: add
 UFFD_FEATURE_MINOR_HUGETLBFS_HGM
Message-ID: <Y3VkIdVKRuq+fO0N@x1n>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-34-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221021163703.3218176-34-jthoughton@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 04:36:49PM +0000, James Houghton wrote:
> Userspace must provide this new feature when it calls UFFDIO_API to
> enable HGM. Userspace can check if the feature exists in
> uffdio_api.features, and if it does not exist, the kernel does not
> support and therefore did not enable HGM.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>

It's still slightly a pity that this can only be enabled by an uffd context
plus a minor fault, so generic hugetlb users cannot directly leverage this.

The patch itself looks good.

-- 
Peter Xu

