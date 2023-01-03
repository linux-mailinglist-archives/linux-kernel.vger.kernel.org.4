Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F15D65CA4B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 00:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjACXZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 18:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjACXZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 18:25:38 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9FC13EA8
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 15:25:38 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id p24so11747023plw.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 15:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oJdZ+J7Q8KWKWPunv5pQ083zrhJlpySiS/Z5nJCql3s=;
        b=TomHTIpNL1i5WvQou4X4cwJi8V5klPfG+QZaCFuAuUUccdPR3xPYTv4/aABgbfIRE8
         YXIHK7uB0NZQrrfE9mIVUzPsqdxt5cJ8H4BPrTooqx8uRUMAkasFrisCVQ4owtnFfWpw
         35quBzTDv3NHMr22lxbGPdYp458eKnbkjzcWKWbI3CR2CGoDMb3sW3eK5ueZV0vUq9xi
         /rwME83VT8GSbg8n5BdV4XuXuFsGsOQmQ6ndTqsxy9Lkkq7yvC0i5yizhVA9ffyEtZSU
         0nYNOe9TCBdfTdTC8PbE9tzXGXKBFYOyml6m14jDiNP0x2hXHpBIvbCsm80LdVFVNZIF
         T99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oJdZ+J7Q8KWKWPunv5pQ083zrhJlpySiS/Z5nJCql3s=;
        b=HCwhY0W2wnnZuPyn8a+zCE4ukXDV3MvuPpcGjstOC5qJ1dyA9sBILfJ7lLaDalBbIF
         f3JeJIVXCuXHfYf5/KeaMBzcp5jYl6y6VvQiAdTYUdUGcy00hvb5/yTtSV6C4LkaMc8t
         Ik5yKTcZvT2khwRx8Oi+lc1vCDzNyOQE+ebGmQ0VVWztAItWKNyscgGHnOLmFTHSIJA3
         FgEDstu3d+E2QuiRnTIKJe9QP5TqWuoJffWNBnBInpZT1ZiA0XUYNmHG6nWXIHvh6gBI
         sFJiL+oYd/0ACZNpCegNnBMEbqRRBj+nPhNqyiea2BZxEYDjeE/XWau0HzvFRTlFJzaI
         +kiQ==
X-Gm-Message-State: AFqh2kr7riqy8FhXZ0eLXdUy0RhSCLCtKx3E4XOv/EyzbSlGqYSjF7fj
        BVRi7xXJz+T8yWgC7e6o+uXLyg==
X-Google-Smtp-Source: AMrXdXu79uqiVmvsSPJ3t7dF7kpjl/V8i5Vj+8cyrQNjlp7WsrQwNbLPf8BsNqf+6zsvl8E0jfdAKg==
X-Received: by 2002:a17:902:ce90:b0:192:8a1e:9bc7 with SMTP id f16-20020a170902ce9000b001928a1e9bc7mr2204368plg.0.1672788337612;
        Tue, 03 Jan 2023 15:25:37 -0800 (PST)
Received: from [2620:15c:29:203:3ac1:84a4:2f59:c43f] ([2620:15c:29:203:3ac1:84a4:2f59:c43f])
        by smtp.gmail.com with ESMTPSA id a13-20020a1709027e4d00b00183c6784704sm22630248pln.291.2023.01.03.15.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 15:25:36 -0800 (PST)
Date:   Tue, 3 Jan 2023 15:25:36 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Borislav Petkov <bp@alien8.de>
cc:     "Nikunj A. Dadhania" <nikunj@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com,
        seanjc@google.com, pbonzini@redhat.com, thomas.lendacky@amd.com,
        michael.roth@amd.com, stable@kernel.org
Subject: Re: [PATCH v3] x86/sev: Add SEV-SNP guest feature negotiation
 support
In-Reply-To: <Y7QRkzxg1HW9wMCp@zn.tnic>
Message-ID: <05171aad-bcef-a731-970f-726b393e3ad3@google.com>
References: <20230102083810.71178-1-nikunj@amd.com> <3169b54b-d990-7707-5ec4-cde7261318fe@google.com> <45487a87-764a-7ff3-292b-4a55fe29f7ba@amd.com> <Y7M4IzNYBtfEJe6Z@zn.tnic> <02a2e641-6b6d-e1c5-2c43-8815306d92a0@amd.com> <Y7QRkzxg1HW9wMCp@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue, 3 Jan 2023, Borislav Petkov wrote:

> On Tue, Jan 03, 2023 at 09:07:14AM +0530, Nikunj A. Dadhania wrote:
> > Currently, GHCBData[24:63] is unused. If we intend to use the bit range(40bits), GHCB spec 
> > will need to be updated. And probably would not be enough.
> 
> My fear too...
> 
> > As the termination request is done using GHCB MSR protocol, exit codes cannot be used.
> 
> We need to figure out some other way of communicating to the guest owner because
> of which feature the guest refused booting.
> 

Yeah, this was exactly the thought.  If the guest terminates because 
SNP_FEAT_NOT_IMPLEMENTED, it seems necessary to provide information on 
which feature(s) the guest is lacking an implementation for that the 
hypervisor has enabled.  Otherwise this becomes a frustrating trial and 
error for the customer.
