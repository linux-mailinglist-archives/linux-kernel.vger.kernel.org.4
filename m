Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8077B63336A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 03:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbiKVCh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 21:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbiKVChy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 21:37:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC72C5B7F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 18:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669084619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xvIIlAJedlMA1IAN6mozxkUlISNRY72m50Y0CwedFi4=;
        b=VW8bLHTbzYFHBWB1nITK9JtOnhoZjtuFHsYMyxjfsZMvV9mwZItLZnZH8BKr1uTVjbBe6R
        QmfuwLaKNuAe3m3AAkbnyMRza832ibEIa/l0ltGWbD+K+352KRVzX6iTf7nYCFldl5xlJD
        42/g1uJvlspHUd4jri/fiPOjzZJgQpg=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-340-BXpH7yR4NkyYWZjUiP4F5A-1; Mon, 21 Nov 2022 21:36:58 -0500
X-MC-Unique: BXpH7yR4NkyYWZjUiP4F5A-1
Received: by mail-pg1-f198.google.com with SMTP id f19-20020a63f113000000b0046fde69a09dso7862198pgi.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 18:36:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvIIlAJedlMA1IAN6mozxkUlISNRY72m50Y0CwedFi4=;
        b=8KXB5L5KhknrwfPWABttJsKcUcu7HEMOWI/dBAY/tCwrooyCi9eJjDQgUNfGmj0mGc
         gkbU7uP4G4ClQ/G+1eC6y/JaNeZNtjAON9XMUMkkKcHPmwq91NA8HqrmzS7z5QP9RdRo
         172G4mVezDX0FcmVAM1YTTy5tWiX2oA46oSE4Eut2gVSGLC8kZHhxFpVkUDagqFOxv1o
         LJvCjUxs6q84yQtbyOedv6kzocJYzA7rW8K+JChCwlcmFQ7lCdcvNvZLoLrUjvzNp3zX
         mN46XXzBV3zgxfkATL8WS4vXbz69gUNdxT/dG+mF2mvQJJQuRN7sfCNUIF8/qgyzyS41
         KyxA==
X-Gm-Message-State: ANoB5pk9XyNUfeKPPvGeU2SLsLfrgxx3LYlN5Zi6cv8t1aK7HLTnpsuc
        ZJ7cEVhfdhyvC2RWHvFaCPQch5w/d6AE1tg1Qb8ayc1QELhfaCELnldXqlNa0JZ5cPqsbs+8jh4
        wGh+0Q9Byxet2K9WHqpnjSq35
X-Received: by 2002:a17:902:bd42:b0:188:ca57:8945 with SMTP id b2-20020a170902bd4200b00188ca578945mr1672923plx.116.1669084617019;
        Mon, 21 Nov 2022 18:36:57 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5u80bNrcNaRgL0fQ5kRBTesC/rxRbN9BLu4B5mZ4iRUSxKXsFzA1wq6uSnG3iu384vaVg/tg==
X-Received: by 2002:a17:902:bd42:b0:188:ca57:8945 with SMTP id b2-20020a170902bd4200b00188ca578945mr1672913plx.116.1669084616745;
        Mon, 21 Nov 2022 18:36:56 -0800 (PST)
Received: from localhost ([240e:3a1:2e3:6280:f5b8:e7c9:62bf:459])
        by smtp.gmail.com with ESMTPSA id k186-20020a6324c3000000b0046fd180640asm8185870pgk.24.2022.11.21.18.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 18:36:56 -0800 (PST)
Date:   Tue, 22 Nov 2022 10:36:06 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     kexec@lists.infradead.org, Matthew Garrett <mjg59@srcf.ucam.org>,
        Jiri Bohac <jbohac@suse.cz>,
        David Howells <dhowells@redhat.com>,
        linux-integrity@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        James Morris <jmorris@namei.org>,
        Matthew Garrett <mjg59@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lockdown: kexec_file: prevent unsigned kernel image when
 KEXEC_SIG not enabled
Message-ID: <20221122023606.nrifkrng5nbfmkka@Rk>
References: <20221121072947.836672-1-coxu@redhat.com>
 <5d98172d77a8a0f1e3daab44ad51bf38978cc053.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5d98172d77a8a0f1e3daab44ad51bf38978cc053.camel@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mimi,

On Mon, Nov 21, 2022 at 01:23:57PM -0500, Mimi Zohar wrote:
>Hi Coiby,
>
>On Mon, 2022-11-21 at 15:29 +0800, Coiby Xu wrote:
>> A kernel builder may not enable KEXEC_SIG and some architectures like
>> ppc64 simply don't have KEXEC_SIG. In these cases, unless both
>> IMA_ARCH_POLICY and secure boot also enabled, lockdown doesn't prevent
>> unsigned kernel image from being kexec'ed via the kexec_file_load
>> syscall whereas it could prevent one via the kexec_load syscall. Mandate
>> signature verification for those cases.
>>
>> Fixes: 155bdd30af17 ("kexec_file: Restrict at runtime if the kernel is locked down")
>> Cc: Matthew Garrett <mjg59@srcf.ucam.org>
>> Cc: Jiri Bohac <jbohac@suse.cz>
>> Cc: David Howells <dhowells@redhat.com>
>> Cc: kexec@lists.infradead.org
>> Cc: linux-integrity@vger.kernel.org
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>
>Other than correcting the function name to mandate_signature_verificati
>on(),

Applied to v2, thanks for correcting me! Btw, I realize I overwrote the
return code of kexec_image_verify_sig with
mandate_signature_verification's. v2 has fixed this issue as well.

>
>Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

And thanks for the review!

-- 
Best regards,
Coiby

-- 
Best regards,
Coiby

