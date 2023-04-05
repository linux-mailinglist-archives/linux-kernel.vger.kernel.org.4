Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3C36D7FFB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbjDEOtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237738AbjDEOta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:49:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9895BE60
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 07:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680706121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RCw9jxHLaTR3n66vuo19FqVdqa/TPq12sjoGedpZV/Y=;
        b=gtGHKZWdMUB3dcUXszOCe8UYEJnCGZLPUtz6IA2ymvOFI2CNKa9cESnXwzO9jKy/E9DZs9
        KqIA5y4PV4mNAR3wpDe54nF2C+/1krOLerJyY35vn9EIcqQkBipCiqwALMQawu/DH8wBcd
        K+mNuixdJy6a+V6OXCy2lHLxGeOMiek=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-E0AHbd4UM8W9D9pmaQWv1g-1; Wed, 05 Apr 2023 10:48:40 -0400
X-MC-Unique: E0AHbd4UM8W9D9pmaQWv1g-1
Received: by mail-qt1-f199.google.com with SMTP id p22-20020a05622a00d600b003e38f7f800bso24257384qtw.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 07:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680706120;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RCw9jxHLaTR3n66vuo19FqVdqa/TPq12sjoGedpZV/Y=;
        b=Y86O1uFywfGb6LLW1bVNh8VaLGBH46G77ts9JeOeOXI6jhRE/UhkwKvCY+SS0xv99W
         S4RfiUORCWemjSB/luuINi02kEAHmf1Dvy6AvJqQkcIloJrmTh4TuniLA5W13MOWXGbg
         tyrty4nJtXFWS6YeS3kPxhQtAfhbQbhvLH6HyE6xxkxThjod+l3jtCvCWTgJ9CjBIEcV
         nDet3VaIC1zYSK2bp7egWC88yP2nkSLucXRKRkAcIqfsYuaQuQHX2u3Lm+skjK5C0WtN
         qMn+Gx0Ppww0FfsTYpVf8xNLyzsI9+qKOE6b8jpFKiTDEd15QmXHwBJFceRDGT68OM90
         Cp+A==
X-Gm-Message-State: AAQBX9cE3tUaD2VwM9+SqcSW2lOeOL0WLU+9N1nNx9cAvjj10aaB9g5c
        m5cC7ceyFhle0/9Sz6az8MNUZeO6MIocg+prFfdc2CCVn4dAX9EWz1bBKxXRoLACR3gzAYx9gf6
        1j/9KL8zViRH7KSGUxtFMCuC2
X-Received: by 2002:a05:6214:f05:b0:5c2:d241:9c1d with SMTP id gw5-20020a0562140f0500b005c2d2419c1dmr10198280qvb.27.1680706120124;
        Wed, 05 Apr 2023 07:48:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350YdL4KA/7SlkiMECTM07KbfSyoovgQz5l0MYDi8ZHVnT0N4uJz7y2ZDFRrNG0RVpkI/RzdX3g==
X-Received: by 2002:a05:6214:f05:b0:5c2:d241:9c1d with SMTP id gw5-20020a0562140f0500b005c2d2419c1dmr10198253qvb.27.1680706119863;
        Wed, 05 Apr 2023 07:48:39 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id kr22-20020a0562142b9600b005e45f6cb74bsm1535061qvb.79.2023.04.05.07.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 07:48:39 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Matlack <dmatlack@google.com>
Subject: Re: [PATCH 0/2] KVM: x86: More cleanups for Hyper-V range flushing
In-Reply-To: <20230405003133.419177-1-seanjc@google.com>
References: <20230405003133.419177-1-seanjc@google.com>
Date:   Wed, 05 Apr 2023 16:48:36 +0200
Message-ID: <87lej6gzaz.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> More cleanups of the code related to Hyper-V's range-based TLB flushing.
> David's series got most of the names, but there are a few more that can
> be converted (patch 1).  On top of that, having Hyper-V fill its struct
> provides a decent improvement to code generation, and IMO yields a better
> API (patch 2).
>
> Sean Christopherson (2):
>   KVM: x86: Rename Hyper-V remote TLB hooks to match established scheme
>   KVM: x86/mmu: Move filling of Hyper-V's TLB range struct into Hyper-V
>     code
>

For the series:
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

