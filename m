Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B1B647425
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 17:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiLHQXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 11:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiLHQXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 11:23:33 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2185B60EB9
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 08:23:24 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id gh17so5262557ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 08:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ffOMrqHbGPKnX9DON08suhw00B/x5l9qlgIhBCvn1s=;
        b=GcVbR78qgq1zGKeFap4dpyJP2ETn3kww5rg3v8dPl3tCWN0G6qxnGcbwgcX5MCo3OM
         fKWfEFTBvO7N8XCZBPsxpIZJu/I7SUe3aPGwiRpN/CQgiksUDLrb6z4cKnWd08AfEpdZ
         r94BbeUn5ovd//wzHhKXPJAWTKlrbHK2MlOIz3fbM4mGNb97gj9dHvVIeeiBbVWMUG83
         kIoNpiUMsufVsm/m95AH/BSknL/IIYi4+Au5NXHpzpAF6U9MwGhYl2DJgI8UrQgHnbO0
         7dRNIeeoHyKJg18727lHNV+cCrVrJsiUn1rn7oMXL7Wu9l4f3Ev75gNhks+qShMbBZI8
         WEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ffOMrqHbGPKnX9DON08suhw00B/x5l9qlgIhBCvn1s=;
        b=vBqLgBHOLVLcvbyHM3sW2DlJq88+NLgEQWVStgDhynqoZg3ZBrOSqhWqV5U3b1zCAt
         rEUnxliJEu5YTgMqGWatIt5Ecnv2Wu8KmU6z+RJJDGvzJpFv8Ohi+LZ1CahciFtOAYcY
         Z3CbuZ7ARzf4op57BIJSIUIJ0cdmMyYnZMFMLg5Lwh07a4S6pucAjTVRT37a4+bvpMmf
         fetMDmVLmF7p0Ry9Z6tG8PpFNtJ6vd5pCehU3rK6x88HOYDYl3VoEx/+EVv77X/ptc1p
         +T4LDBWyEL/JM/iSRSTnPWhpSqN2gbQAl9pHc/RvCMHLPcQdT3UbyvRzD9bU9dDPaqXJ
         GmFw==
X-Gm-Message-State: ANoB5pkFwtDyJafeKQ6xEaA5W42AvHwgFnXHvJfX14nL3eJvVR3W3LkM
        AFLfbKOr/U1znLnt84Hwo976OQ==
X-Google-Smtp-Source: AA0mqf7cWc12/11dRI8UuaKffduEO9pgwBnCtENeaj4X4vsk2ZRqNQGH/MayWHmkzyTTju2hui+ZmA==
X-Received: by 2002:a17:907:a426:b0:78d:f456:1ec6 with SMTP id sg38-20020a170907a42600b0078df4561ec6mr3278655ejc.23.1670516602675;
        Thu, 08 Dec 2022 08:23:22 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-748-2a9a-a2a6-1362.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:748:2a9a:a2a6:1362])
        by smtp.gmail.com with ESMTPSA id i9-20020a170906698900b007bff9fb211fsm9884789ejr.57.2022.12.08.08.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:23:22 -0800 (PST)
Date:   Thu, 8 Dec 2022 17:23:21 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Oliver Upton <oliver.upton@linux.dev>, kvm@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.linux.dev,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] KVM: arm64: selftests: Align VA space allocator with
 TTBR0
Message-ID: <20221208162321.d745p2lsedxdf7v6@kamzik>
References: <20221207214809.489070-1-oliver.upton@linux.dev>
 <20221207214809.489070-4-oliver.upton@linux.dev>
 <Y5EtP5z6rxSK1VUe@google.com>
 <Y5EvVtAoDSHvIKie@google.com>
 <Y5E5UixcJQ4+tNYg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5E5UixcJQ4+tNYg@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 01:09:38AM +0000, Sean Christopherson wrote:
...
> Actually, before we do anything, we should get confirmation from the s390 and
> RISC-V folks on whether they have a canonical hole like x86, i.e. maybe x86 is
> the oddball.

riscv splits like x86.

Thanks,
drew
