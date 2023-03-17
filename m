Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CB46BF552
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 23:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjCQWpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 18:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjCQWph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 18:45:37 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FAAC4E91
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 15:45:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3-20020a250b03000000b00b5f1fab9897so5765584ybl.19
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 15:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679093135;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AqXgfygPxY7mlBkz79u7U4DZ9eg5UFKA4PQmqAP4PgA=;
        b=FS9j79UgbkR5WomZl1V+D/BZ18ux3cKkPrPE1xL79TJdXfSc6OJgU40eeuVyAKJ3Tj
         +Lpy2cAqJGS6KxS6u2jG8S2wXPlE7zhJr+BfQKFoYXxXbaUCIxHWF0cEQHYJyokA5vxn
         5nVfHr/0IHzTV6XHM0zCYxe7JyIzTYv6aEjYIaNOA5kCg5+vsAzbG/Rt1jxtg+9DSX+P
         egWsAzef+3K/hz4zEFZsvaTybnC8scu1PqLSI4MHyBWuORiAdkAyfKGqW34FD9S+NnQ+
         fHMrN4EJ0/BhvvFqw9sIFVx8KBni/HRsD02Bp27qrd9sXDKrDZIbxeKKhbI8g9aO5Cx2
         X5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679093135;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AqXgfygPxY7mlBkz79u7U4DZ9eg5UFKA4PQmqAP4PgA=;
        b=I4o2DnoMEAIU6XOLojMf+yMzNXC/AMxJc38OYCysovLOSOHy7a8l655wmq05wrM+cy
         zWCL3zO7BEpc7X1QgSBINg2AMEQSir/w0Zp8/lvgnYq0La40UiKpzEuek1GR2HIE0VCC
         LC91lgZf4LDeDePqt6pCnpq0bjYOTXhxGmy2Nl7xN9dgvf9qdkVhuGoxzVtVCOfPYBzs
         7uOKRXlPHgp2Ns7euUM32WdlONuK6M3NugBBXPDmK58mQCBvsLh+fatE/29SAjUqslbc
         qX41VhOm1UUi+9M+d+Tp8kXOoCejtCnjNqWGCjvEDDJCUTRMMdd2Ngxeh1jLql2zyn2Q
         zt5g==
X-Gm-Message-State: AO0yUKXflnPCxzg6q0CAFAXRg515ioOfaxfJzMDxP/mN7KM6MRi2NtkU
        VKdWQlRrtALmeHbIXD2GhCWSVxO8Ze4=
X-Google-Smtp-Source: AK7set9jKryMTfEz0aawEcOiBhZ6L+WdPDV54k6PbMiRGY8l6TCBteaEhikFo/LyZLfGVBpL9Spv4wSGraI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:9786:0:b0:a58:af0b:5150 with SMTP id
 i6-20020a259786000000b00a58af0b5150mr94019ybo.3.1679093135255; Fri, 17 Mar
 2023 15:45:35 -0700 (PDT)
Date:   Fri, 17 Mar 2023 15:45:33 -0700
In-Reply-To: <20230217193336.15278-3-minipli@grsecurity.net>
Mime-Version: 1.0
References: <20230217193336.15278-1-minipli@grsecurity.net> <20230217193336.15278-3-minipli@grsecurity.net>
Message-ID: <ZBTtjTFPCRtK0Cy8@google.com>
Subject: Re: [PATCH v2 2/2] KVM: Shrink struct kvm_mmu_memory_cache
From:   Sean Christopherson <seanjc@google.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023, Mathias Krause wrote:
> Move the 'capacity' member around to make use of the padding hole on 64

Nit, 'nobjs' is the field that gets moved in this version.  No need for another
version, I can fix up when applying.

If no one objects, I'll plan on taking this through kvm-x86/generic.
