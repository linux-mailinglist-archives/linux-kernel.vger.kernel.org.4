Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8908E60C81F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiJYJbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbiJYJap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:30:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7104A82D16
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666690233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N52J9g4cZ+1Mq7ONZQzSB0PW3bqTQoiOPUv/1Ns1UPw=;
        b=S4BZA140zXKNYb51v5ziaQ8EscM/8HHG33v4qihfR2iaXWGMKG/Ohm5IKlzwqIFcyUvDLE
        h8hetB5MqRqZEMNjpKA0ALfNk0OhC84fJPmU7oP8sA4xZGk5nZ+C0PC+2Mo2kq2jpYmLh6
        An5jV3xG+dsbGVxq014mMSnMOEeGpuM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-517-8xKwXdYmNOufc4hWJiPX3w-1; Tue, 25 Oct 2022 05:30:28 -0400
X-MC-Unique: 8xKwXdYmNOufc4hWJiPX3w-1
Received: by mail-wm1-f71.google.com with SMTP id r203-20020a1c44d4000000b003c3a87d8abdso4981627wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N52J9g4cZ+1Mq7ONZQzSB0PW3bqTQoiOPUv/1Ns1UPw=;
        b=PoZd5VDOJMNILvIHNjxTGwD5pdbF0BzFiGVURpxMCIPghYDkZ68QP2iTE3o/8EZCHx
         stxV834gkhSw94kv24s58FKs6gF31eIjSh1HCfD+qD9EKfUK+XKxKhdOOIQSvosFc8o8
         efQm/g/0igHrKRqpxxosse6Hc4s5ZSUlbps1z+xdr7FsH/mqpZSKmrn6/dHMm5wYoGav
         f37pLK1UGbS1WrtiM2nhAoRhgbuNzoqMeZjbBmqZxT5t+oaIB+NyAPB95R+gp/NFIfyb
         i+duciY1KzpqS6q5cbLQGyPNoJnOcb1ajq/GfvSerBujYQdqTIR12XvIaB0ZIOus3wN0
         DHlw==
X-Gm-Message-State: ACrzQf02eIpAseq1k2HEIhs8JgrNuxLDiqfUybgt7hIUghFnsG7Vwadq
        3I1aS70NsLaRDvQ3OH8MPMCnLOzDoZy1pACLbLAUJx7e+yT6kZzwzc8orNNJjdLyIjVOOjCaphm
        T9mydhS8TOl+ysZvvtq+3RXi4
X-Received: by 2002:a5d:6d0d:0:b0:230:1b65:a378 with SMTP id e13-20020a5d6d0d000000b002301b65a378mr25282792wrq.406.1666690227069;
        Tue, 25 Oct 2022 02:30:27 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7N8lway8LYM22bmLrqzEuyTCqW2V+jEHnyQjtJOL0+fVqPU1iWuXxFShng6/h9WrTr8DpxYQ==
X-Received: by 2002:a5d:6d0d:0:b0:230:1b65:a378 with SMTP id e13-20020a5d6d0d000000b002301b65a378mr25282776wrq.406.1666690226815;
        Tue, 25 Oct 2022 02:30:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:4e00:3efc:1c60:bc60:f557? (p200300cbc70b4e003efc1c60bc60f557.dip0.t-ipconnect.de. [2003:cb:c70b:4e00:3efc:1c60:bc60:f557])
        by smtp.gmail.com with ESMTPSA id t189-20020a1c46c6000000b003c701c12a17sm10237937wma.12.2022.10.25.02.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 02:30:26 -0700 (PDT)
Message-ID: <e9a237d7-3a34-11c8-1c5b-1a3c14e8cfb0@redhat.com>
Date:   Tue, 25 Oct 2022 11:30:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 1/1] KVM: s390: vsie: clarifications on setting the
 APCB
Content-Language: en-US
To:     Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, cohuck@redhat.com,
        thuth@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, svens@linux.ibm.com
References: <20221025091319.37110-1-pmorel@linux.ibm.com>
 <20221025091319.37110-2-pmorel@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221025091319.37110-2-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.10.22 11:13, Pierre Morel wrote:
> The APCB is part of the CRYCB.
> The calculation of the APCB origin can be done by adding
> the APCB offset to the CRYCB origin.
> 
> Current code makes confusing transformations, converting
> the CRYCB origin to a pointer to calculate the APCB origin.
> 


While at it, can we rename "crycb_o" to "crycb_gpa" and "apcb_o" to 
"apcb_gpa".

These are not pointers but guest physical addresses.

-- 
Thanks,

David / dhildenb

