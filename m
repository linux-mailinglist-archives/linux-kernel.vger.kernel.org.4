Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6005B634BD6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 01:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbiKWA4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 19:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbiKWA4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 19:56:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E277C696C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 16:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669164918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aF7/2foVpEFS7EtJrtidG83b2asU3hWjYsy4BUecKfU=;
        b=FIHw5TaGr6oQp7joJdwp3Y4GrgorfdwUZ9yUSwXYAyKRYcdEn7ZRw2g90DLz0kNqFIGMGx
        5QSUekeFNnGtIb+61EGp4CD/Fx2AKaNXzrHyJQEeRwyjhgPcumEmB7ZX2swfinvFPZKPwI
        6HbGs6GjDImOE8I50SwO8ZZQ0iK3TvM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-179-TGwvRW7ANoWgOno-Ebbesg-1; Tue, 22 Nov 2022 19:55:16 -0500
X-MC-Unique: TGwvRW7ANoWgOno-Ebbesg-1
Received: by mail-pl1-f198.google.com with SMTP id k9-20020a170902c40900b0018734e872a9so12784013plk.21
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 16:55:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aF7/2foVpEFS7EtJrtidG83b2asU3hWjYsy4BUecKfU=;
        b=PSaWHBcOZkcuoIuDXQCQenI+Q/fTaVm2dAbqZri5WWwGpkPqWD08QhwrmI6d4Z8lj/
         KoHLkVnnT1TXaRWCVBAZno8k27GPFaqyKbWKp6+1shFKGls61/bseh07yry3dildlYtR
         0q3BkSj3uBEA14GfQyAqV+4cABa/4Z+fu7FZa30wFPHGXeYgn8CdOaKaZnLzKXRJh3ko
         wkI5BpZriw4hsBMKAqUvlNMB7psLS6tNwm3HCREPjENW20EwPq1Uta4tHe7QWmmvJgVo
         uCdApkWsD3qBWcUzMf6VUovLAgLKgWZDwXSjJXeE+CjLpbJdQDPsteUpR/cWt3RcFqU3
         ExOQ==
X-Gm-Message-State: ANoB5pmGaGSvpvwCp+nqWztNlZASVOovmRR3IRhX4pNFZIEXU67EoIE3
        CxfNWPtbiiepTDTTit8+0y9Jdljq3MF5RBwofKiIuI/oOHxFpEXV+qkdNKqwHDXR3pY0Qu7QXgD
        +5Xnmkmyy8CR0mwr5FM2VjJnb
X-Received: by 2002:a63:565e:0:b0:46e:bcc1:a28f with SMTP id g30-20020a63565e000000b0046ebcc1a28fmr5986148pgm.408.1669164915691;
        Tue, 22 Nov 2022 16:55:15 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6SY5uzfyZkQfox6l1AVbBTdoWvAzzF3EYm8zF40IS7nL6i4eU6Gl7YQvDisX2vPoUAGKlnHw==
X-Received: by 2002:a63:565e:0:b0:46e:bcc1:a28f with SMTP id g30-20020a63565e000000b0046ebcc1a28fmr5986133pgm.408.1669164915365;
        Tue, 22 Nov 2022 16:55:15 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090a67c400b00212735c8898sm155313pjm.30.2022.11.22.16.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 16:55:14 -0800 (PST)
Date:   Wed, 23 Nov 2022 08:52:51 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     kexec@lists.infradead.org, Matthew Garrett <mjg59@srcf.ucam.org>,
        Jiri Bohac <jbohac@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Philipp Rudo <prudo@redhat.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        Matthew Garrett <mjg59@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: Re: [PATCH] lockdown: s390: kexec_file: don't skip signature
 verification when not secure IPLed
Message-ID: <20221123005251.h4t2t2lv6tqb5nrp@Rk>
References: <20221121072715.836323-1-coxu@redhat.com>
 <your-ad-here.call-01669130104-ext-3635@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <your-ad-here.call-01669130104-ext-3635@work.hours>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 04:15:04PM +0100, Vasily Gorbik wrote:
>On Mon, Nov 21, 2022 at 03:27:15PM +0800, Coiby Xu wrote:
>> --- a/arch/s390/kernel/machine_kexec_file.c
>> +++ b/arch/s390/kernel/machine_kexec_file.c
>> @@ -33,10 +33,6 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
>>  	unsigned long sig_len;
>>  	int ret;
>>
>> -	/* Skip signature verification when not secure IPLed. */
>> -	if (!ipl_secure_flag)
>> -		return 0;
>
>Looking at s390_verify_sig() especially before commit 0828c4a39be5
>("kexec, KEYS, s390: Make use of built-in and secondary keyring for
>signature verification") I think this condition actually expresses
>2 things:
>1. the firmware is secure IPL capable and secure IPL keys are
>   provided and present in platform keyring.
>2. secure IPL is enabled.
>
>Wouldn't this change have implications for machines with older firmware
>which doesn't support secure IPL? In this case platform keyring won't
>have any secure IPL keys (since firmware doesn't provide them)
>and any properly signed kernels will be rejected for kexec in this
>function. Unless secure IPL keys are also present in built-in or secondary
>keyring (which is possible after commit 0828c4a39be5) - is that what
>distributions normally do?

Thanks for pointing me to the above commit and reminding me older
firmware doesn't support secure IPL! But I don't think this change will
break machines with older firmwares which doesn't support secure IPL.
Distributions like Fedora/RHEL have downstream-only patch that enable
lockdown automatically when secure boot is enabled. Since there is no
secure IPL, lockdown won't be enabled which means
kimage_validate_signature (kernel/kexec_file.c) doesn't enforce
signature verification (sorry I should change the commit subject which
is misleading). For the case where users manually enables lockdown, I
assume they know what lockdown means and expect signature verification
to be enforced instead to be silently bypassed.

-- 
Best regards,
Coiby

