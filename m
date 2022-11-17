Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76B162DDD0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240351AbiKQOTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240327AbiKQOTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:19:31 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954D91007C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 06:19:30 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id g7so3030031lfv.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 06:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D3x133dVtwVv7jvx8g97kW4FBOvvKkB/v2oc16Tf4lc=;
        b=HrVH8yqh59n941IfjY8F2X3AvLLvdAiPmJ+LjuOQJSHpEVGtdgWDTTcoEKtqXZjfcH
         BJYvIAQKdWMlCETZNgkGvK2ciql3SNLG9lNHBolWfrYQlE1P534aKrS/+HPFui6P5pnu
         +2OW6S+9MkUOpfawuNT4zCy+QFH/k7z27DPt2l8ozLtQ1sEjJcQE+t/YYzx0J3XW1VR1
         26P7roYiX5qFLu//qxeLGFlXXH/0B/JYGVMXtNsmJekqdxNjeq9hIGghT+h3LNaxKFrA
         oA48gB3qhT6DzyyqhzUmjAOKTkQJSu2AwoieLsRXVR3gzJv8IOtsNUuO8cFjA+yU+Vrk
         Ph9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D3x133dVtwVv7jvx8g97kW4FBOvvKkB/v2oc16Tf4lc=;
        b=pyOPl4kui1eF21QM2ccJZdwEqsIZYOHKzDfxRc1F8gCn8RgwfU3YFDmU1KVOwckI8A
         jw9Xz14dVTSgpGQ9CzY+M0zTS14AD8RIM6Ek4H96cdvkae7Z2vlbVZy9IjAzv7MtwhJg
         5SgtAKyxBE4y2PuR/t/UChtvxV+ophodADD/me2myjff+6ONCr2Of1vt19jmkXGrzXyE
         3WH7Q3Tj0J8IG8+uoVoT79lDMSa+ab7RtQmofy28EmsLQ5w6Sfz1sziXRW3xt1CVgRKC
         i3cd080n5RLO12z4u37YkSKiTV9HARCyGFy5v2k7mKaABaS5FncjHQ4+foDUZLfiEish
         O6eQ==
X-Gm-Message-State: ANoB5pk6MjG9ldsPUpMzLB4TJNvEQgknlESWNKRyuxQ6gobjtSk6P5pk
        cK0KP+IqwBfAslRyoS4c4zxqDbgIGnsfyQI6AmeJsA==
X-Google-Smtp-Source: AA0mqf5kzXHbPe7bzUd65hhZ3QFU51HYKZ9rSJYlc9u1KutxM95JyTZBnpvd7beNyf60khWyXGnqT9IfKSkQ9ixHWIo=
X-Received: by 2002:a05:6512:3a3:b0:4b1:11a3:d1b with SMTP id
 v3-20020a05651203a300b004b111a30d1bmr1092769lfp.291.1668694768789; Thu, 17
 Nov 2022 06:19:28 -0800 (PST)
MIME-Version: 1.0
References: <20221116175558.2373112-1-pgonda@google.com> <3e50c258-8732-088c-d9d8-dfaae82213f0@amd.com>
In-Reply-To: <3e50c258-8732-088c-d9d8-dfaae82213f0@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Thu, 17 Nov 2022 07:19:17 -0700
Message-ID: <CAMkAt6ppvVUHRCyOjba=_HmYPp_cZaQB1J=HLvFf8yRD1dXPPQ@mail.gmail.com>
Subject: Re: [PATCH V5] virt: sev: Prevent IV reuse in SNP guest driver
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Borislav Petkov <bp@suse.de>, Michael Roth <michael.roth@amd.com>,
        Haowen Bai <baihaowen@meizu.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Marc Orr <marcorr@google.com>,
        David Rientjes <rientjes@google.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Ashish Kalra <Ashish.Kalra@amd.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 12:02 PM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 11/16/22 11:55, Peter Gonda wrote:
> > The AMD Secure Processor (ASP) and an SNP guest use a series of
> > AES-GCM keys called VMPCKs to communicate securely with each other.
> > The IV to this scheme is a sequence number that both the ASP and the
> > guest track. Currently this sequence number in a guest request must
> > exactly match the sequence number tracked by the ASP. This means that
> > if the guest sees an error from the host during a request it can only
> > retry that exact request or disable the VMPCK to prevent an IV reuse.
> > AES-GCM cannot tolerate IV reuse see: "Authentication Failures in NIST
> > version of GCM" - Antoine Joux et al.
> >
> > In order to address this make handle_guest_request() delete the VMPCK
> > on any non successful return. To allow userspace querying the cert_data
> > length make handle_guest_request() safe the number of pages required by
>
> s/safe/save/
>
> > the host, then handle_guest_request() retry the request without
>
> ... then have handle_guest_request() ...
>
> > requesting the extended data, then return the number of pages required
> > back to userspace.
> >
> > Fixes: fce96cf044308 ("virt: Add SEV-SNP guest driver")
> > Signed-off-by: Peter Gonda <pgonda@google.com>
> > Reported-by: Peter Gonda <pgonda@google.com>
>
> Just some nits on the commit message and comments below, otherwise
>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

Thanks Tom. I'll update with all the feedback after Boris chimes in.
