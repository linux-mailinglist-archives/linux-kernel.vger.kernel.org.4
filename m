Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FDB704932
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjEPJ1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbjEPJ1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:27:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D735FE2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684229166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+o/UCn3L1P/wSUbplutGB2edri0j4YA53Agzrtt+lMk=;
        b=bAioCp5xOKx7LQXlSh8DZa/SK7ggrGpSSEiADP0YNw+a08zQyld8RSFSVoopXmyCnGdJQd
        FI9lhUJS1yy0gNnLi3xD5BZP9hBZKpgmPJ7XtwuR6H8xHn59EQOTIKK/TfsUBpQbbubDKo
        /licI8crC/HoTHykssM4erYEVkdeHLA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-jCAOdciVM4yrZ-Rp4X_mkQ-1; Tue, 16 May 2023 05:11:36 -0400
X-MC-Unique: jCAOdciVM4yrZ-Rp4X_mkQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-751409fae81so1532765185a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684228296; x=1686820296;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+o/UCn3L1P/wSUbplutGB2edri0j4YA53Agzrtt+lMk=;
        b=F+Ya9u4iQEdAWaUihha3rHte9ZcalmibODGVkwJGeAjnpdCl9ITrJzPoUNsifplDzO
         rYWV7R5biDT680gGd8afsG8xRDe9DQ4MFnp6XGosg1LlLM3BVfOG0VCNNkUCVNklHS8t
         T5YMXgCHwerMxmumVWZxDWfHU+iQKvTUTNMicoDw+xIBFhUfKvftUs3YfUzvX+OEMX+/
         Co/o5H4NZyM+G0Ow7hwNkis2x7CknYld499Aq0ml0C2bun30SuQFe57WZNTvoO6j52Ml
         x2ThkXeSeKazNcxyttixkE7Ed6XuzT/ZipDP4R040RXvnt7A7pgmNv/9R1a3mIIdeda2
         TNEA==
X-Gm-Message-State: AC+VfDw92+kaTcbgp63IG0n+7rCliIdUj+8ZDkOmbVAzF8FiPPbBjNfn
        iRgtqDcI7vMnEMj1oT9eSGbG58qfsvBj1YGxpUD/s617mdYkjGiraCyh0eOATvmqNODID8+eoYk
        ALGPShF29OhJGQ7UhoMohgaNC
X-Received: by 2002:a05:6214:29e4:b0:5ef:739a:1c46 with SMTP id jv4-20020a05621429e400b005ef739a1c46mr54133610qvb.1.1684228296190;
        Tue, 16 May 2023 02:11:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ihKd36gGMcTJKTRL1haIaDunvM6wa1GmPVMHdzciLh5kEqzQ78ojI0STMLCa3sbvm6HaSgA==
X-Received: by 2002:a05:6214:29e4:b0:5ef:739a:1c46 with SMTP id jv4-20020a05621429e400b005ef739a1c46mr54133583qvb.1.1684228295813;
        Tue, 16 May 2023 02:11:35 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id k3-20020ac80203000000b003e39106bdb2sm6105296qtg.31.2023.05.16.02.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 02:11:35 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     stable@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, decui@microsoft.com
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: Fix vmbus_wait_for_unload() to
 scan present CPUs
In-Reply-To: <1684172191-17100-1-git-send-email-mikelley@microsoft.com>
References: <1684172191-17100-1-git-send-email-mikelley@microsoft.com>
Date:   Tue, 16 May 2023 11:11:32 +0200
Message-ID: <87pm707i9n.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> vmbus_wait_for_unload() may be called in the panic path after other
> CPUs are stopped. vmbus_wait_for_unload() currently loops through
> online CPUs looking for the UNLOAD response message. But the values of
> CONFIG_KEXEC_CORE and crash_kexec_post_notifiers affect the path used
> to stop the other CPUs, and in one of the paths the stopped CPUs
> are removed from cpu_online_mask. This removal happens in both
> x86/x64 and arm64 architectures. In such a case, vmbus_wait_for_unload()
> only checks the panic'ing CPU, and misses the UNLOAD response message
> except when the panic'ing CPU is CPU 0. vmbus_wait_for_unload()
> eventually times out, but only after waiting 100 seconds.
>
> Fix this by looping through *present* CPUs in vmbus_wait_for_unload().
> The cpu_present_mask is not modified by stopping the other CPUs in the
> panic path, nor should it be.  Furthermore, the synic_message_page
> being checked in vmbus_wait_for_unload() is allocated in
> hv_synic_alloc() for all present CPUs. So looping through the
> present CPUs is more consistent.
>
> For additional safety, also add a check for the message_page being
> NULL before looking for the UNLOAD response message.
>
> Reported-by: John Starks <jostarks@microsoft.com>
> Fixes: cd95aad55793 ("Drivers: hv: vmbus: handle various crash scenarios")

I see you Cc:ed stable@ on the patch, should we also add 

Cc: stable@vger.kernel.org

here explicitly so it gets picked up by various stable backporting
scritps? I guess Wei can do it when picking the patch to the queue...

> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  drivers/hv/channel_mgmt.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 007f26d..df2ba20 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -829,11 +829,14 @@ static void vmbus_wait_for_unload(void)
>  		if (completion_done(&vmbus_connection.unload_event))
>  			goto completed;
>  
> -		for_each_online_cpu(cpu) {
> +		for_each_present_cpu(cpu) {
>  			struct hv_per_cpu_context *hv_cpu
>  				= per_cpu_ptr(hv_context.cpu_context, cpu);
>  
>  			page_addr = hv_cpu->synic_message_page;
> +			if (!page_addr)
> +				continue;
> +

In theory, synic_message_page for all present CPUs is permanently
assigned in hv_synic_alloc() and we fail the whole thing if any of these
allocations fail so page_addr == NULL is likely impossible today
but there's certainly no harm in having this extra check here, this is
not a hotpath.

>  			msg = (struct hv_message *)page_addr
>  				+ VMBUS_MESSAGE_SINT;
>  
> @@ -867,11 +870,14 @@ static void vmbus_wait_for_unload(void)
>  	 * maybe-pending messages on all CPUs to be able to receive new
>  	 * messages after we reconnect.
>  	 */
> -	for_each_online_cpu(cpu) {
> +	for_each_present_cpu(cpu) {
>  		struct hv_per_cpu_context *hv_cpu
>  			= per_cpu_ptr(hv_context.cpu_context, cpu);
>  
>  		page_addr = hv_cpu->synic_message_page;
> +		if (!page_addr)
> +			continue;
> +
>  		msg = (struct hv_message *)page_addr + VMBUS_MESSAGE_SINT;
>  		msg->header.message_type = HVMSG_NONE;
>  	}

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

