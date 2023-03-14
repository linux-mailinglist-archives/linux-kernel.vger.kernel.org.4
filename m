Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E866BA2AB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 23:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjCNWol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 18:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjCNWoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:44:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E082822CA3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 15:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678833826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nHo/YNV6RCtVFeo660OXEQBt9GzPcSGMqLy290S1DfY=;
        b=iHq5gXm0JJqJhk9AtGff9GsrXu7x3RtfnHx3SVXytIl/vXeKrzNXxSA+Q8R68sjov5ABVV
        9WDFrHHNAnQHZWF9//XR/y2304TKbxtkizESXGhak5YdFX8JSfghJW+dT8wHTBeIS/NRZI
        x9NYah12LnEyKPdnpXyynjfyk58zMkU=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-yGncggN-PpO51QgA-TZ8Sw-1; Tue, 14 Mar 2023 18:43:43 -0400
X-MC-Unique: yGncggN-PpO51QgA-TZ8Sw-1
Received: by mail-vs1-f71.google.com with SMTP id v2-20020a67c002000000b0041f41eaafefso5422465vsi.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 15:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678833823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nHo/YNV6RCtVFeo660OXEQBt9GzPcSGMqLy290S1DfY=;
        b=OO2v8lWP6A4lbsopqN4Ey5SiHHwzwZ8Mw5w7rVJwUcZqQ5CIX51NKWJOkoCKrURD7S
         qjCbo0/ggDmROaQA9RGfwkXGPxFDjUzUhpEZIo/dAriLW++WjGpe4/Qmr20p1Y1jXPXl
         XHRfUSTkit9tXn+efbMKoMtIQLNj6y+TJh7eR/iwaZMnpIBMxel4hN7JQX+ULH3XfuDw
         3BluR4NrsGjDzp8DcpbU6jvN3/hUGGbFG0j0jOm0NYq3vIuFYe3IscasvO9pN9/Ik8em
         Zb5zhyX34x5gIlxeFCrpNM9BQN7Zb+GeWeT65uPYaMVODqYO6LvJ2ZS8upTgc9AOTfS/
         bwyg==
X-Gm-Message-State: AO0yUKWIDcddqCCnppDrvQR+EOkKJsh+D9zKLqSS0G0IjUvP/AJAYNLI
        2oM+g8M/zK/J2Z97MoQd4sO88PGFqbBNL0TP17rNt17HTyv2MEu88ZXFYXy5QyK5vblTuFCiinT
        cyJLCE0BXcMSI4AgOKdm9dfzkl1muhlalzyN1U1/C
X-Received: by 2002:a9f:3149:0:b0:68b:9eed:1c7d with SMTP id n9-20020a9f3149000000b0068b9eed1c7dmr24409516uab.0.1678833822691;
        Tue, 14 Mar 2023 15:43:42 -0700 (PDT)
X-Google-Smtp-Source: AK7set9/A++8n7MyHFqV21Qt1JAMsKJ3IBkeMZaZUquJVCzT9ql9AX6/8jWlF683ZJvDJg3NRIP4jvkGyKxRNp9LdWM=
X-Received: by 2002:a9f:3149:0:b0:68b:9eed:1c7d with SMTP id
 n9-20020a9f3149000000b0068b9eed1c7dmr24409507uab.0.1678833822437; Tue, 14 Mar
 2023 15:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230211003534.564198-1-seanjc@google.com> <20230314134356.3053443-1-pbonzini@redhat.com>
 <ZBCEphyd205U4gxF@google.com>
In-Reply-To: <ZBCEphyd205U4gxF@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Tue, 14 Mar 2023 23:43:30 +0100
Message-ID: <CABgObfZoQAis56NaVO0Pi6U_BsY3_Ue41mOJGQtXTWex2D2Wpg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] KVM: VMX: Stub out enable_evmcs static key
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm <kvm@vger.kernel.org>,
        "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il mar 14 mar 2023, 15:29 Sean Christopherson <seanjc@google.com> ha scritto:
>
> On Tue, Mar 14, 2023, Paolo Bonzini wrote:
> > Queued, thanks.
>
> Paolo,
>
> Are you grabbing this for 6.3 or 6.4?  If it's for 6.4, what is your plan for 6.4?
> I assumed we were taking the same approach as we did for 6.3, where you handle the
> current cycle (stabilizing 6.3) and I focus on the next cycle (building 6.4).


This one is for 6.4. What we did for 6.3 included me merging a handful
of series that were not included in the previous merge window; so
that's what I did today. If that's okay for you, once the -rc3 pull
request is sent (probably tomorrow) I will push to kvm/next and that
will be it.

I do plan to review a few other outstanding series of yours,
especially the MSRs and the reboot ones.

Paolo

