Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84456D8488
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjDERHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjDERHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:07:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD172C6
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 10:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680714400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+jGMyE/H4z0XX1rbokRrj+UlMMC2RKbOMB2U8991WxU=;
        b=gsytrA3zaQKWI+6qf3PBSvOUnP+vnIwl4te0xeaJtSZDGQfDTLA0vefCZTxyq8qG2ytsZ+
        4jngw6fo7dFaaAmdP0LEVPIHvobNQcLQCcaCxDCYrABBrMW4Goju02PrSUUJTI6SZw2wVV
        UwEzCzx8z1lvF0BA2uEzDc0UxCOizZI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-8PHMBuSfO-Kg5xmuAxR2Yg-1; Wed, 05 Apr 2023 13:06:39 -0400
X-MC-Unique: 8PHMBuSfO-Kg5xmuAxR2Yg-1
Received: by mail-wm1-f69.google.com with SMTP id k25-20020a05600c1c9900b003ef79f2c207so11868658wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 10:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680714398;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+jGMyE/H4z0XX1rbokRrj+UlMMC2RKbOMB2U8991WxU=;
        b=OwwFOS1npMtTtsHhLy8qf5O4rwfi8baKcyHzqQa+14+rchB95OjblAK0DFuwwaQ32H
         itVI1ySkj8laYjFxSqysHWjldHbu9mrztKKCiCtMEzzwoyrodb9MwLWaulPExq5BTFMh
         5gs8PffOGU8afoeyQWMfQc/vo19fiqJQT9jozbkYb891wmdSENX9kG83BS8IqL/KhMiG
         wLvllIyCDIFRn3H8SJd150R8lEpO5O4ZfRO+NUSWkj7bhdvuuoggkmEUML4VK4JXcyQU
         YVXgA34qGIIRmtwZ7AgJjvgUfNPHeQHZipX6mApIE7tceHZIfi2bkfdb65ZvfukOKjva
         GIXw==
X-Gm-Message-State: AAQBX9cioujPENiE0drNFNCC7FI53nIsm+MB72ZjhJby/joEBDW/0ILV
        LQqntZMScAOJ/Pwq/3IEeRKHgCtC/s4QxYer6CviRbs8RFQ2gukiXs1SjXhib9J2phTLbiUpKFN
        EfL4Gnm5N+hnYvCkV2+A1hdls
X-Received: by 2002:a05:600c:3644:b0:3eb:42fa:39d5 with SMTP id y4-20020a05600c364400b003eb42fa39d5mr5247556wmq.29.1680714398418;
        Wed, 05 Apr 2023 10:06:38 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zc3yUUSM0QMVb09Y7+zHVijaxSRVwUv8quFIs59ptAnEOpLeN1hskZOZ5fkbJtamSWNoF0vQ==
X-Received: by 2002:a05:600c:3644:b0:3eb:42fa:39d5 with SMTP id y4-20020a05600c364400b003eb42fa39d5mr5247534wmq.29.1680714398050;
        Wed, 05 Apr 2023 10:06:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:d00:ca74:d9ea:11e0:dfb? (p200300cbc7030d00ca74d9ea11e00dfb.dip0.t-ipconnect.de. [2003:cb:c703:d00:ca74:d9ea:11e0:dfb])
        by smtp.gmail.com with ESMTPSA id k4-20020a5d4284000000b002cefcac0c62sm15631552wrq.9.2023.04.05.10.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 10:06:37 -0700 (PDT)
Message-ID: <d6f6f4a5-2b6d-d3d6-0806-8c41ac5dcdf0@redhat.com>
Date:   Wed, 5 Apr 2023 19:06:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 2/6] module: move finished_loading()
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com
References: <20230405022702.753323-1-mcgrof@kernel.org>
 <20230405022702.753323-3-mcgrof@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230405022702.753323-3-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.04.23 04:26, Luis Chamberlain wrote:
> This has no functional change, just moves a routine earlier
> as we'll make use of it next.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---

I'd simply squash into #3, as that's short enough that the move doesn't 
add significant noise. Anyhow:

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

