Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6027220FB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 10:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjFEI1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 04:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjFEI1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 04:27:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E844B0
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 01:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685953619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J8at3jyLYspjW7I0pCXUj/ZCT3YmM7eGZSNtKBL6MtI=;
        b=bGhOxUg0VJgchxJBdQEul7aVE3Gv5vM0TeFCm5W6cXFtGWvfboLkbx0AEm5HgzOPbtnQHf
        GNckHUTRQoSmWK3bgHC2AVvGikJc6wqtRiA5qgPIzBajMbU+N9MWMqPf6vYI4JiHEPVopC
        KkP62djVAYlC7c2LFMo8uyQDiyoH/M8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-g0HP4XIfMnOR2TrvUjwBaQ-1; Mon, 05 Jun 2023 04:26:58 -0400
X-MC-Unique: g0HP4XIfMnOR2TrvUjwBaQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f736116989so6440425e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 01:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685953617; x=1688545617;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J8at3jyLYspjW7I0pCXUj/ZCT3YmM7eGZSNtKBL6MtI=;
        b=BqN0+lHwWlIr8n5yUrEmrcFcMAKIfh6tzOkeamSThOh61StVd3KG8s7+DqNCMF7C33
         GGrULsrwBs/iX9kIT0Vii96mrB1KnNyc8NvSz7GIksIO7B5yLb2rtt3goYmdGUTc1uUn
         MLamgFoQke5yEFnNmgd+b6EnNumArzx9BugxzcktL0NbYJGZcxJXO/OAs1OW6JEnG6I5
         xMWvKXY9EOQgHvwKUL8epHviT5o5LGdSbzZhZr0vy8p0IhJJ85MlEkP10YP2nEddyrc7
         GXwa2RzJE/PKAK6UiGmvV3J/QM95f1S28HmoeJs/JQlA5dmKmQPnjs4a/LJDtvGftC2Z
         vpUA==
X-Gm-Message-State: AC+VfDzi662IcUcch/IkWziHZ2IHywlECSw0nHpn0huwDopvBgP+Frmr
        +ruLe8LO0Hf3lvnjbwaUIqwfBr1ymSJ5JbsIYsPC0jPWpD1529Wwyspn6pUiIq6uJ4Ou7baL/lc
        KXlvJ85nQa/iybdKU+Up71XG2
X-Received: by 2002:a05:600c:1d98:b0:3f7:367a:38cb with SMTP id p24-20020a05600c1d9800b003f7367a38cbmr3232789wms.2.1685953617682;
        Mon, 05 Jun 2023 01:26:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7VE8iVjNCuqsNoEIKvM2en0FHwV2THTF/MEveUKF9yun03XpX+3wMK7X0sxFjbHVuiakb1jg==
X-Received: by 2002:a05:600c:1d98:b0:3f7:367a:38cb with SMTP id p24-20020a05600c1d9800b003f7367a38cbmr3232772wms.2.1685953617428;
        Mon, 05 Jun 2023 01:26:57 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.94.106])
        by smtp.gmail.com with ESMTPSA id y5-20020adfd085000000b003095bd71159sm9123063wrh.7.2023.06.05.01.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 01:26:56 -0700 (PDT)
Date:   Mon, 5 Jun 2023 10:26:54 +0200
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
Message-ID: <4rqrebfglyif4d7i4ufdnj2uqnubvljkeciqmelvotti5iu5ja@fryxznjicgn6>
References: <CAGxU2F7O7ef3mdvNXtiC0VtWiS2DMnoiGwSR=Z6SWbzqcrBF-g@mail.gmail.com>
 <CAGxU2F7HK5KRggiY7xnKHeXFRXJmqcKbjf3JnXC3mbmn9xqRtw@mail.gmail.com>
 <e4589879-1139-22cc-854f-fed22cc18693@oracle.com>
 <6p7pi6mf3db3gp3xqarap4uzrgwlzqiz7wgg5kn2ep7hvrw5pg@wxowhbw4e7w7>
 <035e3423-c003-3de9-0805-2091b9efb45d@oracle.com>
 <CAGxU2F5oTLY_weLixRKMQVqmjpDG_09yL6tS2rF8mwJ7K+xP0Q@mail.gmail.com>
 <43f67549-fe4d-e3ca-fbb0-33bea6e2b534@oracle.com>
 <bbe697b6-dd9e-5a8d-21c5-315ab59f0456@oracle.com>
 <7vk2uizpmf4fi54tmmopnbwwb7fs2xg6vae6ynrcvs26hjmshb@hpjzu4jfj35i>
 <b5a845e9-1fa0-ea36-98c4-b5da989c44c6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5a845e9-1fa0-ea36-98c4-b5da989c44c6@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 11:33:09AM -0500, Mike Christie wrote:
>On 6/1/23 2:47 AM, Stefano Garzarella wrote:
>>>
>>> static void vhost_worker_free(struct vhost_dev *dev)
>>> {
>>> -��� struct vhost_worker *worker = dev->worker;
>>> +��� struct vhost_task *vtsk = READ_ONCE(dev->worker.vtsk);
>>>
>>> -��� if (!worker)
>>> +��� if (!vtsk)
>>> ������� return;
>>>
>>> -��� dev->worker = NULL;
>>> -��� WARN_ON(!llist_empty(&worker->work_list));
>>> -��� vhost_task_stop(worker->vtsk);
>>> -��� kfree(worker);
>>> +��� vhost_task_stop(vtsk);
>>> +��� WARN_ON(!llist_empty(&dev->worker.work_list));
>>> +��� WRITE_ONCE(dev->worker.vtsk, NULL);
>>
>> The patch LGTM, I just wonder if we should set dev->worker to zero here,
>
>We might want to just set kcov_handle to zero for now.
>
>In 6.3 and older, I think we could do:
>
>1. vhost_dev_set_owner could successfully set dev->worker.
>2. vhost_transport_send_pkt runs vhost_work_queue and sees worker
>is set and adds the vhost_work to the work_list.
>3. vhost_dev_set_owner fails in vhost_attach_cgroups, so we stop
>the worker before the work can be run and set worker to NULL.
>4. We clear kcov_handle and return.
>
>We leave the work on the work_list.
>
>5. Userspace can then retry vhost_dev_set_owner. If that works, then the
>work gets executed ok eventually.
>
>OR
>
>Userspace can just close the device. vhost_vsock_dev_release would
>eventually call vhost_dev_cleanup (vhost_dev_flush won't see a worker
>so will just return), and that will hit the WARN_ON but we would
>proceed ok.
>
>If I do a memset of the worker, then if userspace were to retry
>VHOST_SET_OWNER, we would lose the queued work since the work_list would
>get zero'd. I think it's unlikely this ever happens, but you know best
>so let me know if this a real issue.
>

I don't think it's a problem, though, you're right, we could hide the 
warning and thus future bugs, better as you proposed.

Thanks,
Stefano

