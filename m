Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F3F7168F6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbjE3QO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjE3QOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:14:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD501BC
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685463124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=elhjqE3fNBnQQxlIlFk7OLjzO9acLMNW6reIgAraQ64=;
        b=Ceh2WZ0FofG0wtkOo7eq6ZGCaIym/J6Eq5XmN+9skgjbeX2Jn4wtpbQcCzHK2xIUNbNCMk
        qX2ZqR6S4N1ZNdgyoTi0Z+mDayi2gtVETvzi5iKH392vK0vxKyfwAy+tKrrvi8FgzaR4Kq
        /2eV5iYJ0AyYpQZZtTP4papmqocPshM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-CZ64rvBZOSeGEeC02aH0DQ-1; Tue, 30 May 2023 12:12:03 -0400
X-MC-Unique: CZ64rvBZOSeGEeC02aH0DQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30af00323b0so798850f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685463122; x=1688055122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elhjqE3fNBnQQxlIlFk7OLjzO9acLMNW6reIgAraQ64=;
        b=FGrRnPG7Nx2J7AGewqkn/TopGjY6yfLqQ9wyOVnMfyeqSvc581Kvxu3XHezbxVi1Qf
         245SB/CHiBJzTJji9O6T5vEJuPFYx1EYUc5RkRtuWL+psxTjauWrhElLYdDvmi/xws1X
         oBBZzm67P59mcBEDV/EtmDZnkmJxONhQ46gI/L63O0Iz57u2vRHFvaaXaXSO6Hak+ueF
         oYskXcyJVydYsiRq5UXgAJ6QLixkKT03hwlSs7sbmLgzivUgqxaRNmo9BoKS5ZtV84t2
         +sHX9haVpIR23tcryAw5TPYL3zYg1QxL8JltryjQ+QPvkOabYaA/YV6q85PxTJ9a48gh
         67eQ==
X-Gm-Message-State: AC+VfDxFM7PBBys1hh6ajxBLQ1qdddiqPU0NzjeHWIDkRUO+zHJs3NR0
        4T1BMzpcAMzJdgvS2VHg4MjzvJHYlxXFXYw6AQXHG2S8FStpLWwNT8daHhX82D32rZrcPIsd6Ry
        X8psAd80GExX+0IMKnixY1xHn
X-Received: by 2002:a5d:5909:0:b0:309:4e64:7a28 with SMTP id v9-20020a5d5909000000b003094e647a28mr2029560wrd.49.1685463122245;
        Tue, 30 May 2023 09:12:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ76yj+cHMYLKtEr2159YgsXI3xWTpZbjGYKy+isWK8mqhybl41e+higOqGxCzQ6/lC2tHLEZQ==
X-Received: by 2002:a5d:5909:0:b0:309:4e64:7a28 with SMTP id v9-20020a5d5909000000b003094e647a28mr2029549wrd.49.1685463121984;
        Tue, 30 May 2023 09:12:01 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it. [87.12.25.16])
        by smtp.gmail.com with ESMTPSA id l9-20020adfe589000000b00307c8d6b4a0sm3781887wrm.26.2023.05.30.09.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 09:12:01 -0700 (PDT)
Date:   Tue, 30 May 2023 18:11:58 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        syzbot <syzbot+d0d442c22fa8db45ff0e@syzkaller.appspotmail.com>,
        jasowang@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org, stefanha@redhat.com
Subject: Re: [syzbot] [kvm?] [net?] [virt?] general protection fault in
 vhost_work_queue
Message-ID: <4opfq7hcowqwmz2hzpfcu3icx3z6ce4vmn6pkaeeqxnclgvjd6@x7lyji2owgae>
References: <0000000000001777f605fce42c5f@google.com>
 <20230530072310-mutt-send-email-mst@kernel.org>
 <CAGxU2F7O7ef3mdvNXtiC0VtWiS2DMnoiGwSR=Z6SWbzqcrBF-g@mail.gmail.com>
 <85836a9b-b30a-bdb6-d058-1f7c17d8e48e@oracle.com>
 <c87f0768-027b-c192-1baf-05273aac382b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c87f0768-027b-c192-1baf-05273aac382b@oracle.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 11:01:11AM -0500, Mike Christie wrote:
>On 5/30/23 10:58 AM, Mike Christie wrote:
>> On 5/30/23 8:44 AM, Stefano Garzarella wrote:
>>>
>>> From a first glance, it looks like an issue when we call vhost_work_queue().
>>> @Mike, does that ring any bells since you recently looked at that code?
>>
>> I see the bug. needed to have set the dev->worker after setting worker->vtsk

Yes, I came to the same conclusion (see my email sent at the same time
:-).

>> like below:
>>
>>
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index a92af08e7864..7bd95984a501 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -564,7 +564,6 @@ static int vhost_worker_create(struct vhost_dev *dev)
>>  	if (!worker)
>>  		return -ENOMEM;
>>
>> -	dev->worker = worker;
>>  	worker->kcov_handle = kcov_common_handle();
>>  	init_llist_head(&worker->work_list);
>>  	snprintf(name, sizeof(name), "vhost-%d", current->pid);
>> @@ -576,6 +575,7 @@ static int vhost_worker_create(struct vhost_dev *dev)
>>  	}
>>
>>  	worker->vtsk = vtsk;
>
>Shoot, oh wait, I think I needed a smp_wmb to always make sure worker->vtask
>is set before dev->worker or vhost_work_queue could still end up seeing
>dev->worker set before worker->vtsk right?

But should we pair smp_wmb() with an smp_rmb() wherever we check 
dev->worker?

Thanks,
Stefano

