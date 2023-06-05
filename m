Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA67A722CEE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjFEQte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjFEQtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:49:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A316AD2
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 09:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685983728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E/OIxezM2uYStzlyu+OjnotSbaNfvFepI69i/E1bObs=;
        b=FB8e9Pm5+LaTsfordi4Gw+/RH8THi3x2yNbx2L/5R2Ma4OacsSKg0arQVwrZcMlpdThA00
        sudVVt66KiSY+ok0r7isTUA4TyoRs3yIXYvv0i4BDuZ28UapokX5zbCLqR+pa0FrSWwqzl
        9GwQmVxjuMoQy/8NqVHUaDcHiDOQR4c=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321---mpz3MmNHahAWnuhwgqzQ-1; Mon, 05 Jun 2023 12:48:47 -0400
X-MC-Unique: --mpz3MmNHahAWnuhwgqzQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b1adee343dso23386031fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 09:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685983726; x=1688575726;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/OIxezM2uYStzlyu+OjnotSbaNfvFepI69i/E1bObs=;
        b=hm4Zeaza2k7Xp1wYW+0PUf7r3NGACtOjSY+Qdebe8OiOy09/NIqjqeh1cLvojjxrDE
         LecWnab/ai+zIYfd6FsH28bpiExEBk2tTU4+Hzbmm9pN9vLq3OIzc8qFSgQiFmRLFJn8
         FHPo7dZ0Xy6jhIJr+tUuXCTK2bCzfeSg2Hc1RBs/FzVI1R6zQwZDNZitrm8NpZm8ib3q
         2F9r1KblEJNSEXIEwmAzDhpf4o4eEkXp9Vw01+gC4UiY3Mc6FiwHnUr3Hg2jGoYgEnW5
         g/jAjRnOc0SDgVfHmlQuJtpSKDIePJ8qfg34OWu1zRMMQtnb6yUnTIenV23LEP9+WzMW
         qnTQ==
X-Gm-Message-State: AC+VfDyK5wU5u6a6ldR3lfseDcIyqDaU1LSYJfqX+tTfPNGslQ1BQz1X
        MrnVaIcUemddqoNztKDMaNa6goEPdz6HcU1KLNSu/kpfTlTUtM+6l3xDJAXRH+jDb6UhO1hZtuD
        ROcKsDTJOHR+8d3dE6Trk3mxS
X-Received: by 2002:a2e:b1d1:0:b0:2a8:a651:8098 with SMTP id e17-20020a2eb1d1000000b002a8a6518098mr4028403lja.38.1685983726251;
        Mon, 05 Jun 2023 09:48:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ78L5uqt81ps8JytggP5F6lBBWC1TXae5N03SPl8+Il1Nomsggk+ISepK5qXMna580T4i/ECQ==
X-Received: by 2002:a2e:b1d1:0:b0:2a8:a651:8098 with SMTP id e17-20020a2eb1d1000000b002a8a6518098mr4028394lja.38.1685983725921;
        Mon, 05 Jun 2023 09:48:45 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id d13-20020aa7c1cd000000b0051425ba4faasm4129750edp.50.2023.06.05.09.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 09:48:45 -0700 (PDT)
Message-ID: <b75c9696-9abb-7a3f-0fb2-56af8ef21bb6@redhat.com>
Date:   Mon, 5 Jun 2023 18:48:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] KVM: MAINTAINERS: note that linux-kvm.org isn't
 current
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20230525153204.27960-1-rdunlap@infradead.org>
 <ZHqSYbYscprsU2qT@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <ZHqSYbYscprsU2qT@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/23 03:07, Sean Christopherson wrote:
> It's definitely stale, though unless Red Hat (presumed hoster) plans on decomissioning
> the site, I'd prefer to keep the reference and instead improve the site.  We (Google)
> are planning on committing resources to update KVM documentation that doesn't belong
> in the kernel itself, and updatingwww.linux-kvm.org  instead of creating something new
> seems like a no-brainer.  I can't promise an updates will happen super quickly, but I
> will do what I can to make 'em happen sooner than later.

We don't plan to decommission the website (especially not the old KVM 
Forum content), though we might move it over to the same 
(container-based) setup as wiki.qemu.org.

What content do you have in mind that doesn't fit in the kernel 
Documentation/ tree?

Paolo

