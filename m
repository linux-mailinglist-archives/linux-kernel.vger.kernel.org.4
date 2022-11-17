Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF82D62E505
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 20:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240580AbiKQTLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 14:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240595AbiKQTL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 14:11:27 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D2D88F99
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 11:11:26 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id a13-20020a9d6e8d000000b00668d65fc44fso1665175otr.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 11:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F9vuYWBj3VCQLnX7XxCflhcGLLAxSYr1p1Ei/JoEgZA=;
        b=C19iRH75P+VwDatXUteorkTX6aQD2I4RLWXzK2wrX5IGOMmiEO4MOe2D9Uyio1ZunN
         9xaIeK3uO74oI9XKNjuG2HIPmeUYvNNFYjmUJ9RWMa4nAa8a3fK/PXmQQsoE+ysIfMdO
         /9LCfKGtooen6cHxe/a516m0pNHJm9/4qUzwFsHgRuYdYSr+ROS0UETXzkYpflP/8nh7
         J58WXq6HPb1GZgfhu2ovKl6Gy5TyG2U6+zwu4h/8Dzkvx1jez2RVnju8HmVF2nZ95VMb
         r5mpsEp7X/I/Gl/rmYEru+UEWYRJlpwGECnK+CaNsiMAbHbrD6m+8+mO8lxlNPVOVtto
         8qdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9vuYWBj3VCQLnX7XxCflhcGLLAxSYr1p1Ei/JoEgZA=;
        b=QoaGnanpG2HJ3UumdW1FA8Ak7yHSOJI5iaX6ayTRsyeitK+VIHExkzpx02UFPAQncW
         jnMjQPbQ326ovJfMruU0I7qxDonxRVjUmJ9MCSzB1JQzvHBj/t7C/wfr204KWidaBgtm
         J+gx4HjZ62MvWVgvCFq5DrwvzoWsyvcDUG9sdbo6O5G7dueoOWp4DZYVL1wL5KXuLmUl
         iUh+0E26Zkr+j2IO6RAnN1nFria5X2Enmk6KjTzByaZSGwHZfWy1gOwHng71a4u5GN18
         WyQZW0HfJoEH3XV26SraqUTYvRViSoiNwOJs/MIlAEwLT6Pf29zqXfIiGwKprPm15K2D
         6lPg==
X-Gm-Message-State: ANoB5pkuzDjOl9/ke34CzfZCYgt5slmLf6bDZOad06rJsyrFh88dYtA7
        0TezsoyRYrwCdNEFxA7SU9pXUMpCGqxgqW0mYbr3LHAbPWU=
X-Google-Smtp-Source: AA0mqf6rOu6uBCRXlS+5KALNPNi+oEVuFeuHINeh2EQOlP6Nw7xTr3GMACXXEpt74SoOoXEzxyjKEIaAuibzmSgfKNU=
X-Received: by 2002:a05:6830:1510:b0:655:bd84:a806 with SMTP id
 k16-20020a056830151000b00655bd84a806mr2137311otp.108.1668712285541; Thu, 17
 Nov 2022 11:11:25 -0800 (PST)
MIME-Version: 1.0
References: <20221117181127.1859634-1-dionnaglaze@google.com> <20221117181127.1859634-3-dionnaglaze@google.com>
In-Reply-To: <20221117181127.1859634-3-dionnaglaze@google.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Thu, 17 Nov 2022 11:11:14 -0800
Message-ID: <CAAH4kHY-Es7T-qBoP0-ai-s3Rzoi0p+2wW5HZv8u3SSe-9prGw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kvm: sev: If ccp is busy, report throttled to guest
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirsky <luto@kernel.org>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Gonda <pgonda@google.com>,
        "open list:X86 KVM CPUs" <kvm@vger.kernel.org>
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

Adding kvm

-- 
-Dionna Glaze, PhD (she/her)
