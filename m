Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B7A65C3EE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 17:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbjACQbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 11:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbjACQbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 11:31:08 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49054FD2
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 08:31:02 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so31655148pjd.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 08:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HuXJyRgtnlne85q3+aPwkSR/XYTZCRo5Z2w1+rQP9ao=;
        b=COSMKscwkWtMhthuZAUrWwSumX4QHSdink89cmgYtdZ54m0ePB1EGKwl0STLVEQWW6
         NgZNRIxcjfnvcXeDn5ccFCpgjrgUl5TFg0e++IiG39fXXne/c+SVcyHwAIKhU7OlO9By
         MJmG0DGPkOsz3Kb/qvsVAXIfJckymJOugHCTttGDrPkRyN7/3RA02aqnZSMTF3VvqGJy
         7jQaX92dO8yS65MFqfQjMY6ySf1i7zrUS+L0cTtTsDAb1EenLR8xw8+WPzFwp+qIrvQM
         GgpbYRmfjO5SOw4jMO7qhaNdm7Shd21GkTq7NhgMie/k/++P6BKVRpVMDeAD1qWR9Z7o
         h6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HuXJyRgtnlne85q3+aPwkSR/XYTZCRo5Z2w1+rQP9ao=;
        b=5EZ6A/KtlfSrypzbV4cuDDUtZfWo3WmVmNPPMa+8tiuutTHA9ewMZ0VwSEKvu5Y0f+
         QmBuVMdf/Z9H37GrkrLg49Mu2NwJhrXyuL6BSiocjLmWNkf3/yHNhZDN/16kut8/28Cb
         gcoKkCnS2+D0e4e1WoCf+xvo3a1Qb0jEmG5rCSZDIErqLP/lvAJBLtGuKjsT0zswOQPr
         DwjOgl9rRIR0Z24scjSZhtjkaXx1VrdcnJtvYwAUu5umHfmdsIGleDrG2pCud060OGMj
         AsnQaHzl7tQ8s1w+nI+32Ms7neX6KJ+7yJ5Q3F3Nycz1fxu7IitOIMVIcOvft66/C0ig
         v3hg==
X-Gm-Message-State: AFqh2krOkpFTqCCEf1aSpu76UeJVPYWuiUDbnKfd1M+1Q2/CTwDmLfqj
        UtoZuh1bxmgx1Y3upaDSklQ2fw==
X-Google-Smtp-Source: AMrXdXuWZN8/EEkW2DrzxGb9ocfW7DG+NJAEwqhQ3RLSkXwbYYD1VKcvpbO8nNWgHWjX/j7lfk6lUQ==
X-Received: by 2002:a05:6a21:3942:b0:9d:b8e6:d8e5 with SMTP id ac2-20020a056a21394200b0009db8e6d8e5mr3865007pzc.2.1672763461683;
        Tue, 03 Jan 2023 08:31:01 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id cp12-20020a170902e78c00b00187022627d7sm22451092plb.36.2023.01.03.08.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 08:31:01 -0800 (PST)
Date:   Tue, 3 Jan 2023 16:30:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Li RongQing <lirongqing@baidu.com>
Subject: Re: [PATCH v4 11/32] KVM: x86: Inhibit APIC memslot if x2APIC and
 AVIC are enabled
Message-ID: <Y7RYQS83wMeyN92k@google.com>
References: <20221001005915.2041642-1-seanjc@google.com>
 <20221001005915.2041642-12-seanjc@google.com>
 <90d4a2a1733cdb21e7c00843ddafee78ce52bbdc.camel@redhat.com>
 <Y5zBH+2VuPJi4yYV@google.com>
 <Y5zJraa0ddooauXB@google.com>
 <f37873fe-0340-e50c-a168-1b9ee12de890@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f37873fe-0340-e50c-a168-1b9ee12de890@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022, Paolo Bonzini wrote:
> On 12/16/22 20:40, Sean Christopherson wrote:
> > I was hoping to have a name that communicate_why_  the memslot needs to be
> > inhibited, but it's turning out to be really hard to come up with a name that's
> > descriptive without being ridiculously verbose.  The best I've come up with is:
> > 
> > 	allow_apicv_in_x2apic_without_x2apic_virtualization
> > 
> > It's heinous, but I'm inclined to go with it unless someone has a better idea.
> 
> Can any of you provide a patch to squash on top of this one (or on top of
> kvm/queue, as you prefer)?

I'll send patches, though it might take a day or three.  I had a reworked version
of this series prepped and tested before vacation kicked in, but lost power before
I could send my traditional pre-vacation patch bomb :-/
