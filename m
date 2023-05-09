Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866306FD054
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 22:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbjEIUzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 16:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbjEIUyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 16:54:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EC34EF8
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 13:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683665466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PNiIZHyonT4Lc3v22Wd8EHVvgd0ES2GAsHIl3w6taTA=;
        b=SAeTk2ThdripM3HdxcC30tK7PwUcp+Rw8rfp994YqkwTknrFGGy55qc+B6CDulQxBBraq7
        JMCAcMLt50Dw+KYBqcYFv3bYl8ae5KxJOs1LHFBhLuzJjfz4Wf9VacYVYam/jt4kJNdEw2
        vVmWTvO2TrtQLmxXsFuILzflnu9kbBw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-sqXfZKIbOwaTG7s_0DQe2g-1; Tue, 09 May 2023 16:51:04 -0400
X-MC-Unique: sqXfZKIbOwaTG7s_0DQe2g-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-50a0a814498so5879693a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 13:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683665463; x=1686257463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNiIZHyonT4Lc3v22Wd8EHVvgd0ES2GAsHIl3w6taTA=;
        b=Nz7X+efEwHSXt1TIhuVhz2DALHPADkpU+9Ry7cuWPA2uCshxAC8Zm4KJpZXBK7K9RT
         K2cNv0I6/QvrbWhna1eEDYr/2//PN0n/53CdzWEO3pjBnwTCsCt/MI95RX7mLQjv4VC2
         ncMDCCJhcTQ3jthP4jzUWqgliU1ek0HaAkuZzfnc/akuHuXDnRALD0uhILbSl0DKrFHQ
         3aI8VA5H2qDjTD28VMYucXaI0x+gBsdg2M9O1f/KOKs51/P9Ao7FfjydHEQH7ySJrVyT
         bYx6DE4+KlgBRqGrG2b9O2pTtrY61HAYnINn5W9EUEtszspXb3m6lyJ0c3SrEeozew+3
         FsJA==
X-Gm-Message-State: AC+VfDz/ZaxRoW9h/UrmKSSXwx+FesM9hvk4A/yibz1ZBpcg1th8kChw
        xmqP9C4q6ypBAAmDTm06K6zWMAYwnEp+KgGvg0Fnr+ktVItcPyzXRW+GFdvqu5SgWDclwhVmnCN
        EkYUKRs1sEXX3ndHKnFDfU9Sn
X-Received: by 2002:a17:906:4fd1:b0:94f:21f3:b5f8 with SMTP id i17-20020a1709064fd100b0094f21f3b5f8mr12867366ejw.21.1683665463518;
        Tue, 09 May 2023 13:51:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ64Z2n6Cyo1Ac1tIrysTfZgGptf8iyw8BdvNxTLiJKqxc+sT/Z3BRYol16b0K6FWwTa13f0sg==
X-Received: by 2002:a17:906:4fd1:b0:94f:21f3:b5f8 with SMTP id i17-20020a1709064fd100b0094f21f3b5f8mr12867347ejw.21.1683665463199;
        Tue, 09 May 2023 13:51:03 -0700 (PDT)
Received: from redhat.com ([82.180.150.238])
        by smtp.gmail.com with ESMTPSA id h9-20020a170906584900b0094e597f0e4dsm1735890ejs.121.2023.05.09.13.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 13:51:02 -0700 (PDT)
Date:   Tue, 9 May 2023 16:50:53 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yuanchu Xie <yuanchu@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Sudarshan Rajagopalan (QUIC)" <quic_sudaraja@quicinc.com>,
        kai.huang@intel.com, hch@lst.de, jon@nutanix.com,
        SeongJae Park <sj@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Yu Zhao <yuzhao@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        talumbau <talumbau@google.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] virtio-balloon: Add Working Set reporting
Message-ID: <20230509164528-mutt-send-email-mst@kernel.org>
References: <20230509185419.1088297-1-yuanchu@google.com>
 <20230509185419.1088297-3-yuanchu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509185419.1088297-3-yuanchu@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 02:54:19AM +0800, Yuanchu Xie wrote:
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> index ddaa45e723c4..06d0683d8d8c 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h

Any changes to this have to be documented in the virtio spec
and be sent to virtio TC.

> @@ -37,6 +37,7 @@
>  #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
>  #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
>  #define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
> +#define VIRTIO_BALLOON_F_WS_REPORTING 6 /* Working Set Size reporting */
>  
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12
> @@ -59,6 +60,8 @@ struct virtio_balloon_config {
>  	};
>  	/* Stores PAGE_POISON if page poisoning is in use */
>  	__le32 poison_val;
> +	/* Number of bins for Working Set report if in use. */
> +	__le32 ws_num_bins;

working_set_ pls. eschew abbreviation.
Really __le32? Is 4G bins reasonable? what if it's 0?

>  };
>  
>  #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
> @@ -116,4 +119,22 @@ struct virtio_balloon_stat {
>  	__virtio64 val;
>  } __attribute__((packed));
>  
> +enum virtio_balloon_ws_op {
> +	VIRTIO_BALLOON_WS_REQUEST = 1,
> +	VIRTIO_BALLOON_WS_CONFIG = 2,
> +};


what's this?

> +
> +struct virtio_balloon_ws {

document fields.

> +#define VIRTIO_BALLOON_WS_RECLAIMABLE 0
> +#define VIRTIO_BALLOON_WS_DISCARDABLE 1

what are these?

> +	/* TODO: Provide additional detail on memory, e.g. reclaimable. */

Well? If we don't now hypervisors will come to depend on
this being broken.

> +	__virtio16 tag;
> +	/* TODO: Support per-NUMA node reports. */

Same. This is ABI we can't merge with unaddressed TODO items.

> +	__virtio16 node_id;
> +	uint8_t reserved[4];
> +	__virtio64 idle_age_ms;
> +	/* Track separately for ANON_AND_FILE. */

What does this mean?

> +	__virtio64 memory_size_bytes[2];




> +};
> +
>  #endif /* _LINUX_VIRTIO_BALLOON_H */

Use LE for new features please.

-- 
MST

