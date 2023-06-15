Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97E97318FE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239458AbjFOMaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjFOM37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:29:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E45D95
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686832153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=miKGhTsa1C617Jf+rAPO8YcjvbVy2XjmmKexewlCMig=;
        b=W/XBmv3Wk6hK09pMVSS+wFwC2riPJNm0W2KnoCGOXonTrrJhaV/jERTDFHaGwZ/sRwiSSj
        gPBVAECcSD7BlShFqSYOj8Pekipg5T7cnyR+GS5gn8aaJ2rkHZj5o6LMjkwaMcfWDkEKAt
        5QuIT5BIvI11dAbJq7nYFhiBm/V/Bv4=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-8GqbNtmGMKKCZIzGySFbMQ-1; Thu, 15 Jun 2023 08:29:10 -0400
X-MC-Unique: 8GqbNtmGMKKCZIzGySFbMQ-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1b51e91dc6aso2249935ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686832149; x=1689424149;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=miKGhTsa1C617Jf+rAPO8YcjvbVy2XjmmKexewlCMig=;
        b=bx0K2dfwBAUT7Qz8I/Dya7o22boBmrmsrrOdZXfTQ29N2BThzOiGA+fSxC4dsDcUFj
         YOz9fGnbxISm+8Sbg8eZiPO2D+QrvKUQTsLjyzqvtbe1hvLNpiUDzG3XqDY5ZZwEMIlN
         aIsBCq628BSjDJiwTOxRzUMo3EQaqP4jxvORTTGHNNwsIIJwexQosirXd8Z96DUvdsdH
         /CTnjJ1KuXUL0cZ4ZjctR6eDD2bh8hIHEDYeifaoIUbNALl5oWPC7IliCDkYCQQLAzNW
         s/fQHYWfbVaFQC0CT5xDSNp0Y+EjtxqSjoth/nFE/QA0s2ISiCERCJSvFvCsPPQmBisR
         QYAA==
X-Gm-Message-State: AC+VfDykmIV4Sx4ujMDF/5XZrVRPUF0KS7aPMmCt9CY13eyICloqlsGh
        k5Q4bf9hVwoc6R5JxItlAwP1bD5hhExM3kWUU2AzKL4ETHQ3TZrw2Bp5icDpN44xDGwNmVMecDL
        3dmHPkmgk70VtJmbgLSV8S3/a
X-Received: by 2002:a17:902:ecc9:b0:1b0:fe9:e57e with SMTP id a9-20020a170902ecc900b001b00fe9e57emr16332662plh.0.1686832149260;
        Thu, 15 Jun 2023 05:29:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ47UwUMIaeKjeei4hpwO38mx1dbD0wAapGYqH6wtjkzhQTmhZv/MA3mxt0UYN8TaPs+w9oB1A==
X-Received: by 2002:a17:902:ecc9:b0:1b0:fe9:e57e with SMTP id a9-20020a170902ecc900b001b00fe9e57emr16332648plh.0.1686832149003;
        Thu, 15 Jun 2023 05:29:09 -0700 (PDT)
Received: from [10.72.12.155] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w5-20020a1709029a8500b001ab0a30c895sm13953037plp.202.2023.06.15.05.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 05:29:08 -0700 (PDT)
Message-ID: <bb20aebe-e598-9212-1533-c777ea89948a@redhat.com>
Date:   Thu, 15 Jun 2023 20:29:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 00/14] ceph: support idmapped mounts
Content-Language: en-US
From:   Xiubo Li <xiubli@redhat.com>
To:     Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     Gregory Farnum <gfarnum@redhat.com>,
        Christian Brauner <brauner@kernel.org>, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
 <f3864ed6-8c97-8a7a-f268-dab29eb2fb21@redhat.com>
 <CAEivzxcRsHveuW3nrPnSBK6_2-eT4XPvza3kN2oogvnbVXBKvQ@mail.gmail.com>
 <20230609-alufolie-gezaubert-f18ef17cda12@brauner>
 <CAEivzxc_LW6mTKjk46WivrisnnmVQs0UnRrh6p0KxhqyXrErBQ@mail.gmail.com>
 <ac1c6817-9838-fcf3-edc8-224ff85691e0@redhat.com>
 <CAJ4mKGby71qfb3gd696XH3AazeR0Qc_VGYupMznRH3Piky+VGA@mail.gmail.com>
 <977d8133-a55f-0667-dc12-aa6fd7d8c3e4@redhat.com>
 <CAEivzxcr99sERxZX17rZ5jW9YSzAWYvAjOOhBH+FqRoso2=yng@mail.gmail.com>
 <626175e2-ee91-0f1a-9e5d-e506aea366fa@redhat.com>
In-Reply-To: <626175e2-ee91-0f1a-9e5d-e506aea366fa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

 > > >
 > > > I thought about this too and came to the same conclusion, that 
UID/GID
 > > > based
 > > > restriction can be applied dynamically, so detecting it on mount-time
 > > > helps not so much.
 > > >
 > > For this you please raise one PR to ceph first to support this, and in
 > > the PR we can discuss more for the MDS auth caps. And after the PR
 > > getting merged then in this patch series you need to check the
 > > corresponding option or flag to determine whether could the idmap
 > > mounting succeed.
 >
 > I'm sorry but I don't understand what we want to support here. Do we 
want to
 > add some new ceph request that allows to check if UID/GID-based
 > permissions are applied for
 > a particular ceph client user?

IMO we should prevent users to set UID/GID-based MDS auth caps from ceph 
side. And users should know what has happened.

Once users want to support the idmap mounts they should know that the 
MDS auth caps won't work anymore.

Thanks

- Xiubo

