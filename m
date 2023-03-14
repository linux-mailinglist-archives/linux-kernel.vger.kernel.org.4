Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BEA6B97FC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjCNOaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjCNO3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:29:25 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1691164857
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 07:28:56 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id t11-20020a170902e84b00b0019e399b2efaso8966984plg.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 07:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678804136;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wg2bHPWsIEO7CYgE4wXaTuWy7OUFwkbmpulYgjZ0I7w=;
        b=SLxegaqVCYdNIs/ExQpGO4Rdw3D2Pk5ArCg7ApacmKflf6+7r/uP2rPwyP4Yu1WoDK
         Xu6OzZ04zPbjnJub0FB8N26RhdkbWzvqC2Dkj2Zj0SM2mVGq8NhpCmGNLGb+kn1k3zRR
         ya252JCQQBqbH4USxnwZsvlLBtF+QrlWATNPlLYqvICJZCgfW5pOGrvX6oGCOEBbiSiZ
         joK9UUPcrTwnm2X+Iu12nkZ/ojxUvZ9DSgV/0F67y/HBkI4yUEaECFs7LzFQdveaxMi3
         nrYI6SjHnsGkL3KjMikkatGqXHq2Eu6ZXj1fTRKRWA8fUE/IdCbeW+A7rqZ+3ngbQCiu
         yL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678804136;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wg2bHPWsIEO7CYgE4wXaTuWy7OUFwkbmpulYgjZ0I7w=;
        b=nU/TP5HSf69ujwEmJ8X0y38XSOkruiKvSZpzL7qbvUl3tYOZadViZr3KvCHrw7uWEd
         39iyepTFbrgXdjkPh1gIdTvJXP6vsRX1PZ6OkYU8oaaBzbf7zvxfnMzG2aZnP+UckuwQ
         RjZO+4ABUDQtg7sBBbCCP8TUUqPPKP29Mj61MhQ7HpaGwSzP+ICA4B5CfJF7W0RJc7Gy
         1FtVvrx+qovQ8FNn+VAeaKPHsNBE0fuw5XmlNaLyyKVLvo5pxABizsdmMwVhRMt4w045
         o8aYayrB/TNJJD2ZlUGoJfuJsIesUMqM535WLE8FUVNdG5Id/ekvukH5XTXYO6Ke0Rsr
         IRIQ==
X-Gm-Message-State: AO0yUKWMiy6pvKucoKBB9Ex/LCtiO03WC/8iuGMYb/biwQj7I5pOLwTZ
        2gdFTeWVUX709jk5FdkwSFCIyobh5l0=
X-Google-Smtp-Source: AK7set8CS+WNvK+k7gufa+N61/DxtgteQSI9rbyekXEIFtUrXq9mbCIqxoUIFHIBT62xgeyiVc6EIFOsoe0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:6d97:0:b0:507:3e33:4390 with SMTP id
 bc23-20020a656d97000000b005073e334390mr4989541pgb.6.1678804135903; Tue, 14
 Mar 2023 07:28:55 -0700 (PDT)
Date:   Tue, 14 Mar 2023 07:28:54 -0700
In-Reply-To: <20230314134356.3053443-1-pbonzini@redhat.com>
Mime-Version: 1.0
References: <20230211003534.564198-1-seanjc@google.com> <20230314134356.3053443-1-pbonzini@redhat.com>
Message-ID: <ZBCEphyd205U4gxF@google.com>
Subject: Re: [PATCH v2 0/3] KVM: VMX: Stub out enable_evmcs static key
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023, Paolo Bonzini wrote:
> Queued, thanks.

Paolo,

Are you grabbing this for 6.3 or 6.4?  If it's for 6.4, what is your plan for 6.4?
I assumed we were taking the same approach as we did for 6.3, where you handle the
current cycle (stabilizing 6.3) and I focus on the next cycle (building 6.4).
