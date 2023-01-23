Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DE767767F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 09:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjAWIlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 03:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjAWIk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 03:40:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C4F1E9C6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674463206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nqqh+6wcrZgNfi9oBoWIZkT3PBbdYb+AX7XH+0YaTHM=;
        b=PFqBzdmKCNiFmUoqf35sU8ZixDairGiMFdAf9LfjbBXbQfqkqgZXHqyuvyk5e+A/sbw6KA
        hLCf/9pz1a+Gn4SkZY2SuNwuQWsEI/cW+fmA/CQLFkDXQCec/qIIJEyjaQxqXfK81jRF6T
        8RQn/qp4xkzhByq5obw6cSziDfpH1Zw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-414-8fZgNWm2PhelCllWwGwcKA-1; Mon, 23 Jan 2023 03:40:04 -0500
X-MC-Unique: 8fZgNWm2PhelCllWwGwcKA-1
Received: by mail-wm1-f72.google.com with SMTP id o2-20020a05600c378200b003daf780e783so2580214wmr.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:40:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqqh+6wcrZgNfi9oBoWIZkT3PBbdYb+AX7XH+0YaTHM=;
        b=w5HNw5IhmEZy6wdp4Q+UQmlA4c75ULbQ05QNER99hXSXSWODADP0vfhbJ8krfHm5Ja
         aWhFX4L6AbOmJsTcZl4QQf+9Y0JLzyGB3PB0/dZ8QeeSbVgDaKHzFq99gq4EZPvRLE3O
         JnVGEvCkCigUvWGpJ4U0Q36sqQnU9RmKlND+SW3D4hedSgKCHZFCCC+qHaR4/0+u1Zg1
         hh4AUQxHKDvKhKba8CK9B1joA4cxE0V+pzIf0JfgPqMQdzHNnLXKzUmAYbnRENRQ3EUZ
         YjCZ4qRZU5aCUgsnw2z9RZcodJcUB1SBkTbbUOM5eyqekS/+deA/qSHKJXCLtidzvODh
         B/8Q==
X-Gm-Message-State: AFqh2kp/jOUWTaO2jv0NlD6aCBPuUmzQQ7IH0jQAxaX7xk/yBK6wqhOc
        Cqh6qyM+vEgbSAwShEN/M1KKrvwBgqh3dSDHa31SEveZpIa18gEWtyNTSjkYFCaGyyDnYGzCizK
        wwKqP6kMJZg47lbz9qODfIqjh
X-Received: by 2002:a5d:6d46:0:b0:2bd:f367:40bc with SMTP id k6-20020a5d6d46000000b002bdf36740bcmr19883399wri.13.1674463203149;
        Mon, 23 Jan 2023 00:40:03 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtvOWDAnP9VzDTrZ2s7AJpI4uIFlU7JM7vBzCDCRGYyvk2q60gi9iLvedJnasl6v73OyqeAkQ==
X-Received: by 2002:a5d:6d46:0:b0:2bd:f367:40bc with SMTP id k6-20020a5d6d46000000b002bdf36740bcmr19883380wri.13.1674463202794;
        Mon, 23 Jan 2023 00:40:02 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:1100:65a0:c03a:142a:f914? (p200300cbc704110065a0c03a142af914.dip0.t-ipconnect.de. [2003:cb:c704:1100:65a0:c03a:142a:f914])
        by smtp.gmail.com with ESMTPSA id bu9-20020a056000078900b002be1dcb6efbsm18051548wrb.9.2023.01.23.00.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 00:40:02 -0800 (PST)
Message-ID: <53e30e21-3ada-9a54-d0ee-5ecfa0e8afa8@redhat.com>
Date:   Mon, 23 Jan 2023 09:40:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] drivers/base/memory: Fix comments for
 phys_index_show()
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, osalvador@suse.de,
        gregkh@linuxfoundation.org, rafael@kernel.org, shan.gavin@gmail.com
References: <20230120055727.355483-1-gshan@redhat.com>
 <20230120055727.355483-2-gshan@redhat.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230120055727.355483-2-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.01.23 06:57, Gavin Shan wrote:
> According to 'admin-guide/mm/memory-hotplug.rst', the memory block ID,
> instead of the section index, is shown by '/sys/devices/system/memory/
> memoryX/phys_index'.
> 
> Fix the comments to match with 'admin-guide/mm/memory-hotplug.rst'.
> Besides, use the existing helper memory_block_id() to convert the section
> index to the memory block index.
> 
> No functional change intended.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

