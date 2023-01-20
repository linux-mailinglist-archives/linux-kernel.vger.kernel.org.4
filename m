Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B07675C5F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjATSDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjATSDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:03:52 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DCA4F374
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 10:03:45 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id c85so4552853pfc.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 10:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZLEr74jd+tUz0+0f9Cwbp09dUHXroWVszy4owEq+EY=;
        b=YfviymZ4gffu7RyM19IBZOTknY/LB/XJsivInw5h66GhlSILfjudpANYD2fUAUBmzv
         cIYQlVhnuS+wwBFySRnPR0WpqocGnHBiirrqtc8r5FjNJF4gUAmkQI2/Lsxm3ZkdmVir
         N40CEXab5II+pxtamF1fSeHQB1NZuYiho3tnC7YZCgY9/qNOS2+R6r2P0kduEeS3EeuI
         OsAEWrEHd2qtvFxwKVQFmyfX40PbDFPDPlKbjexQTHYqKovwap2a281WXqWa2Jcr8F7X
         V5ALapjrlOH+UQP/J55580pjC6M620Nml7lWGHc/Eo2+LngeQpc7tDzfLYliizh9E2gX
         aIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ZLEr74jd+tUz0+0f9Cwbp09dUHXroWVszy4owEq+EY=;
        b=wBoKQz4ZWoDbsBRvzNJ3H4AoOSLiDDfgWT390Jgs0c/azkYTHn+Qyicrh7oAQ1IJ2P
         AKUTCw+5cAf/g6TYcScLioKttEqPcEltHpLhi/i+0LWyGXvIjIlwAjgQIlt+yvxvlEMx
         GqYlrUsjZh4HwqglyMvDOtwQGrW8fPeArhfPbqpa90bfNl6eE693zpEqR+934dboAw++
         UKloLcRCf0pVjAZoZmK+vMfrWaQj636/AfgQad4Hh3mwZLWi81LY+l7vILu/HgEjmPMu
         dbcMvdmNOsGAnIBeeBQcldHA8llPFD3yoJNGB1psBDusX6G3w0KQ0YEQsHhvhq74Gpvg
         bs2Q==
X-Gm-Message-State: AFqh2krh6w1G8904//684xZoXvLEfgG+SAar7ixPVUZGfke3Totf4SAv
        C/+b9GTC0Bj6qUO0hzrZW2GZCSirUa2M78mf73fE2w==
X-Google-Smtp-Source: AMrXdXtRkmECi6CBrgqcecX9f684KnNS+539ijTpn7AXkNXqRjWNFwvuMUmqIHRaku0lv0eCvUw4BHTgCXyXS3M7Cak=
X-Received: by 2002:a05:6a00:4c14:b0:580:f2b8:213c with SMTP id
 ea20-20020a056a004c1400b00580f2b8213cmr1655596pfb.8.1674237825214; Fri, 20
 Jan 2023 10:03:45 -0800 (PST)
MIME-Version: 1.0
References: <20230111194001.1947849-1-dionnaglaze@google.com>
 <20230111194001.1947849-3-dionnaglaze@google.com> <Y8qgjgPCmnPR4tQL@zn.tnic>
In-Reply-To: <Y8qgjgPCmnPR4tQL@zn.tnic>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Fri, 20 Jan 2023 10:03:33 -0800
Message-ID: <CAAH4kHbDk8d1sqsNaJmGLkpjyXyHBH=9BWSh8XOZCAKu8vvFAQ@mail.gmail.com>
Subject: Re: [PATCH v11 2/7] x86/sev: Change snp_guest_issue_request's fw_err
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Michael Roth <michael.roth@amd.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michael Sterritt <sterritt@google.com>
Content-Type: text/plain; charset="UTF-8"
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

>
> Why not make it a u64 directly and be done with it?
>
> ---

I was operating under the assumption that kvm: sev: patches should
only touch kvm, and virt: coco: sev-guest should only touch sev-guest.
If you're okay with a patch that changes both areas at the same time,
then I could do that.

-- 
-Dionna Glaze, PhD (she/her)
