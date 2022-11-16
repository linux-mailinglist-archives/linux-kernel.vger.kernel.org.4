Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D629462C71D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiKPSBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbiKPSAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:00:40 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB1C61BBD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:00:39 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id k15so18220059pfg.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nZ4ednm6peE6gbmoqpZClMscPku5YJZ1wCBTU6Ikzio=;
        b=WTdulvpvTtll9lziEFDV50ImfoMCVIGbLflaO//uDyLKMCD+NXKNZ28jPPeof7JS/L
         b6QUxEh0GHceWpIqWY/8VM6LGkqwASDX7+axp36Vvd+kha4FZDgmLT6LfN1ZeejIQEp6
         lCThel7lsl3F5Eq0LHZTUlpaSkg1uZrR9fLNnqts3WyUvwFb3tpFV2nuAc+CoQduJbrd
         Ft3i+l4mEMchOWLw/4hyupeES7aGDgWTiTpKqKoI9l7c1wqGRLnU7okFktuqirDsgXpo
         m18yTtuzDY6o/awieSAPFYsaixsAeqZCiqqz5EkWeRgsScVh25AUPKUuaixjw0+1sOoK
         MChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZ4ednm6peE6gbmoqpZClMscPku5YJZ1wCBTU6Ikzio=;
        b=aocklHps8dndDpNQWH5xFG89EUWBZifRjZni6XVHokcgY/tpb4GAwtU1orRB0Qs/vi
         zKG+q5hVCm1EM3ooVGs0NuyGiMY0F4helkZM/JwEITBSsAqgN4hBY96Ph6D7giEzyY1j
         +3YZ4KxeCiBid1X07RyOYpeddll3R0MpiAH3tJlKBliXGGGqGqohGX27EP4hijkW5iaC
         J2NOpIzGnbOq49Rzee0hqgoddBLlnC/UBXdEoHBkL9nkUD+bdev7yXPFkrPMMqSBsVNY
         LfaZsiYApoATuTANx3FqdH2xjmZjfN0jrCJ3qVXM8qI7w1vAraoj7aoqGEATfir3cXW4
         NDIQ==
X-Gm-Message-State: ANoB5pnnAE3pFOtNDNtduy8KL0u3Q9WVy92rScbllSfvieuR89VL2iyK
        tuCfwdMUpTBPvN/HQuTXSvO0Dw==
X-Google-Smtp-Source: AA0mqf6IW9b5cDWoM0bmrA1MVnJz4YY7y6phqjUqJJfwjTXzvzEY3JYpg1jW4Ijnid60/ii3HFAzdw==
X-Received: by 2002:a63:135f:0:b0:476:a62c:b2a6 with SMTP id 31-20020a63135f000000b00476a62cb2a6mr9582900pgt.588.1668621639185;
        Wed, 16 Nov 2022 10:00:39 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id c17-20020a170902d49100b0017a032d7ae4sm12685441plg.104.2022.11.16.10.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 10:00:38 -0800 (PST)
Date:   Wed, 16 Nov 2022 18:00:35 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, bgardon@google.com, oupton@google.com,
        peterx@redhat.com, vkuznets@redhat.com, dmatlack@google.com,
        pgonda@google.com, andrew.jones@linux.dev
Subject: Re: [V4 PATCH 0/3] Minor improvements to the selftest setup logic
Message-ID: <Y3UlQ0xSV9H3S4xz@google.com>
References: <20221115213845.3348210-1-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115213845.3348210-1-vannapurve@google.com>
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

On Tue, Nov 15, 2022, Vishal Annapurve wrote:
> This series is posted in context of the discussion at:
> https://lore.kernel.org/lkml/Ywa9T+jKUpaHLu%2Fl@google.com/
> 
> Major changes:
> 1) Move common startup logic to a single function in kvm_util.c
> 2) Introduce following APIs:
> 	kvm_selftest_arch_init: to perform arch specific common startup.
> 	kvm_arch_vm_post_create: to perform arch specific common setup
> 		after VM creation.

Looks good!  A few uber nits, but nothing that can't be fixed up when applying.
